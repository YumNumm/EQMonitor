# Headless Device Location Sync Design

## 背景と目的

現在は Flutter Engine が生存している場合だけ、バックグラウンド位置更新から Device
Location API への送信まで完了する。プロセス終了中は座標を保存するだけで、API送信は
次回起動まで遅延する。またpending座標を読出し時に削除するため、後続処理の失敗で更新を
失う。

プロセス終了中もOSから位置更新を受けたら、端末内で `region`、`city`、
`tsunamiForecastRegion` を解決し、最後の送信成功値から変化した場合だけAPIへ送信する。
緯度経度はAPIや外部ログへ送らない。

対象外は、OSがイベントを配信しない状況での即時同期保証、位置更新頻度の変更、
バックエンドAPIの変更である。

## アーキテクチャ

RiverpodやUIに依存しない `DeviceLocationSyncService` をDart側に設け、通常起動とheadless
workerから共有する。このサービスはpending位置の読出し、端末内での地域解決、前回成功
payloadとの比較、API送信、成功後の永続化だけを担う。通常起動側だけがRiverpod再読込、
App Group、Widget、デバッグ通知を追加する。

ネイティブ層は最新の未処理位置を1件、update ID・緯度・経度・測位時刻・精度とともに
アプリ専用ストレージへ保存する。読出しでは削除せず、Dart側が処理後にupdate IDと利用者
（Device Locationまたは通常アプリ反映）を指定してacknowledgeする。両利用者の完了後だけ
削除し、ID不一致なら新しい位置を誤って削除しない。最後の送信成功payloadもPreferences
キーenumを使って永続化する。
現在地通知スロットの有効状態もローカルへ同期し、headless workerはこの値で送信可否を
判断する。揺れ検知だけが現在地を利用する場合は監視を継続するが、このAPIは送信しない。

headless Dart workerは必要な機能だけを初期化する。

- Flutter bindingと必要なプラグイン
- Asset Pack内の市区町村・津波予報区地図と地震パラメータ
- Secure Storageの既存Bearer token
- 通常アプリと同じAPI URLおよび必須ヘッダー
- `DeviceLocationSyncService`

デバイス再登録、WebSocket、FCM、広告、UI、Widgetは初期化しない。

### iOS

Significant Location Changeによる再起動時に位置を永続化し、headless Flutter Engineを
起動する。処理中はbackground taskを要求し、Dartの完了後にEngineとtaskを終了する。
期限切れ時はpendingを残す。Always位置情報権限とBackground App Refreshが必要で、配信
時刻はOS判断となる。

### Android

`LocationUpdateReceiver` が位置を永続化し、unique WorkManager taskをenqueueする。
Workerがheadless Flutter Engineを起動してDartの完了を待ち、成功・再試行を返す。同時
実行は端末ごとに1件とし、BroadcastReceiverの短い寿命だけに依存しない。

## データフローと変化判定

1. OS位置イベントをネイティブ層がupdate ID付きで永続化する。
2. headless workerがpendingを読み、端末内で3地域コードを解決する。
3. 最後の成功payloadと3項目すべてが同じなら、APIを呼ばずDevice Location分を
   acknowledgeする。
4. いずれかが異なる、または成功payloadが未保存なら、認証付きで
   `PUT /v2/device/me/location` を呼ぶ。
5. 2xx応答後に成功payloadを保存し、Device Location分をacknowledgeする。
6. 失敗時はpendingを残し、後続のheadless実行または通常起動で再送する。

現在地通知スロットが無効ならDevice Location APIを送信しない。揺れ検知も現在地を
使わない場合は位置監視自体を停止する。通常起動時は同じ位置を使って揺れ検知、App Group、
Widgetを反映してから通常アプリ反映分をacknowledgeする。

## エラー処理

- 地域解決失敗、ネットワーク失敗、timeout、5xxではpendingを残す。
- 401/403ではheadless内で再登録せず、通常起動側の既存認証回復へ委ねる。
- 不正payloadの4xxは無限再試行せず、緯度経度を含まない診断結果を保存する。
- 新しい位置は古い未処理位置を置き換え、常に最新地域の同期を優先する。

## テストと検証

Dart単体テストで各地域コード単独の変化、同値時の抑止、成功後だけの保存・acknowledge、
失敗後の再送、古いIDによる誤削除防止、現在地機能無効時の抑止を検証する。Dart結合
テストではheadless bootstrapがローカルAsset PackとSecure Storageを読み、fake APIへ
正しいpayloadを送ること、および通常起動と同じサービスを使うことを検証する。

iOSは位置保存、Engine完了、期限切れを、AndroidはReceiverからunique work登録と
success/retryをネイティブテストで確認する。最後に両OSの実機でプロセスを終了して位置を
変化させ、端末診断とbackendログをupdate IDで照合する。オフライン後の再送も確認する。

## セキュリティと完了条件

Bearer tokenはSecure Storageから直接読み、SharedPreferencesやネイティブ設定へ複製
しない。緯度経度はアプリ専用ストレージのpending処理にのみ使用し、処理後に削除する。

Flutter Engine生存中とOSによるプロセス終了中の両方で、3地域コードの変化時にAPI送信が
試行され、成功までpendingが失われず、通常起動とheadless実行の判定が一致すれば完了と
する。OSが位置イベントを配信する時刻そのものは保証対象外とする。
