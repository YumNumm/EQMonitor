# ファイルから追加する通知音の設計案

ユーザーが選んだ音声ファイルをアプリの領域へ保存して通知音として使えるようにする。通知用の仕様と異なる音声は取り込み時に変換する。添付された「通知音と通知の優先度」の既存画面を拡張する。

状態: 計画のみ。以下の製品仕様は提案であり、実装・実機検証は未着手。

## 対象と前提

- 初回は iOS を対象とする案。OS の対象範囲は確認中で、Android も必要なら通知チャンネルと配信契約を別途設計する。
- 緊急地震速報の予報・地震情報の既定音と、両者の震度別オーバーライドで同じ追加音一覧を使う。
- 既存の Pro 利用条件に従う。EEW 警報の固定音、津波、揺れ検知、Live Activity の音は初回の変更対象に含めない。
- 音声の取り込み・変換・保存は端末内で完結し、サーバーには通知音のファイル名だけを同期する。端末間の音声同期は扱わない。

## 確認した現行コード

アプリの基準は `origin/develop` の `4e853b5b1`。backend は同 commit が指す `079a49b3fbe3ff1d16afee4cdbf7a575d098b79e` のファイルを読み取りで確認した。本番配信の現行バージョンは未確認。

| 箇所 | 現状と変更理由 |
| --- | --- |
| `notification_settings/data/model/notification_sound.dart` | 4種類の enum。未知の API 値をデフォルトへ置き換えるため、追加音と欠損音を表現する型が必要 |
| `notification_settings/ui/page/sound_interruption_settings_page.dart` | 予報と地震情報の `defaultSound` を既存 API へ保存 |
| `notification_settings/ui/page/override_edit_page.dart` | 震度別の編集も同じ固定 enum を利用 |
| `notification_settings/ui/page/notification_settings_page.dart` | 通知音の導線は iOS の Pro 向け |
| `app/pubspec.yaml` / `pubspec.lock` | `file_picker` 13.1.0 を導入済み。対応する Darwin 実装 2.1.2 の audio 選択は Files の document picker を開く |
| `app/ios/Runner/Runner.entitlements` / `FcmServiceExtension.entitlements` | `group.net.yumnumm.eqmonitor` を共有済み |
| backend `api/api/src/features/device/model/requests.ts` | `default_sound` は文字列を受け入れる |
| backend `packages/notification-message/src/platform/apns.ts` | 通常通知の `aps.sound` に指定文字列を渡す。passive では sound を省略 |

上表の `notification_settings/` は `app/lib/feature/settings/features/notification_settings/` を指す。API 入力から resolver の音選択、sender の最終 APNs payload までの実動作は実装開始時に確認する。

## 方式の比較

| 方式 | 利点 | 制約 |
| --- | --- | --- |
| iOS 標準の音声処理で変換し、App Group に保存する案を採用 | MP3・M4A などを通知用へ変換できる。既存 API と共有領域を使える | OS が復号できる入力に限定される |
| 通知用 WAV・CAF・AIFF のコピーだけに限定 | 実装が小さい | ユーザーが事前に形式を変換する必要がある |
| 汎用の音声変換ライブラリを同梱 | 入力形式を増やせる | 依存・配布容量・保守対象が増える。必要な入力形式が標準処理で扱えない場合に再検討 |

## 利用者の操作

1. 既存の選択欄に、標準4種類と追加済みの音を表示する。その近くに「ファイルから追加」「追加した通知音を管理」を置く。
2. Files から音声を1件選ぶ。キャンセルは設定を変えず終了する。
3. 元ファイル名から作る表示名、利用する長さ、試聴を表示する。
4. 29.9秒より長い場合は「通知音に使える長さは30秒未満です。先頭29.9秒を使用します」と表示し、確認後に切り出す。無断で短縮しない。
5. 変換した音を試聴し、「追加」で保存する。追加だけでは通知設定を切り替えず、保存後に元の欄で選択できるようにする。
6. 管理画面で表示名変更・試聴・未使用音の削除を行える。選択状態は保存に成功した API の値を表示する。

長さ29.9秒、先頭からの切り出し、初回 iOS 対応は提案値。任意の範囲を選ぶトリミング UI は初回には追加しない。

## 入力と出力

- 入力は OS がデコードできる音声。MP3、AAC を含む M4A、WAV、AIFF、CAF を優先確認する。拡張子だけで成功と判定せず、音声トラック・実デコードを確認する。
- DRM 音声、破損ファイル、音声のないファイル、読み取り不能なクラウドファイルは理由を表示し、既存設定を維持する。
- 出力は WAV / Linear PCM / signed 16-bit little-endian / 44,100 Hz / mono / 最長29.9秒。すでにこの仕様なら検証後にコピーし、それ以外は AVFoundation / AVFAudio で変換する。
- 音声のデコードと変換は native 側で分割処理する。入力全体を Dart のメモリへ読み込まない。切り出し終了は `floor(44,100 × 29.9)` frame 以下にし、保存後の長さ・音声形式を再検証する。
- 初回は音量の正規化・増幅を行わない。試聴は保存する最終ファイルを使う。

Apple は通知音について、Linear PCM 等を格納する WAV / AIFF / CAF、30秒未満、および bundle またはコンテナの `Library/Sounds` を指定している。[UNNotificationSound](https://developer.apple.com/documentation/usernotifications/unnotificationsound)

## 保存と識別

- 保存先は App Group の `Library/Sounds/`。音声名は `eqm_custom_<UUIDのハイフンなし小文字32桁>.wav` とする。表示名と識別子を分離し、表示名変更では API 値を変えない。
- カタログは同じ App Group の `Library/Application Support/NotificationSounds/catalog.json`。schema version、ID、表示名、ファイル名、長さのミリ秒、作成日時を保存する。絶対パスや元ファイルへのアクセス権を永続化しない。
- native storage がカタログと音声ファイルを所有する。変換中の一時出力 → 検証 → 音声の rename → カタログの atomic replace の順で保存し、完了後だけ一覧へ追加する。
- 保存領域の解決・書き込みに失敗したら一時領域を正式な保存先として扱わない。失敗で生じた未登録ファイルは回収し、正常な追加音を削除しない。
- ロック中の通知を考慮した file protection を設定する。再起動後の初回 unlock 前を含む再生条件は実機確認の結果を記録する。
- 元ファイルを移動・削除しても、追加済み音は使える。再インストールや端末移行で音声が失われた場合は「ファイルが見つかりません」と表示し、再選択・再追加へ案内する。

## 設定と通知の接続

追加音の API 値には生成したファイル名を使い、既存の `default_sound` / override の `sound` に保存する。ローカル保存が完了するまで API へ送らない。API 保存失敗時も追加音自体は一覧に残し、選択は以前の値を維持して再試行できるようにする。

通知時には既存の backend の音選択を通ったファイル名を APNs の `aps.sound` に載せ、OS に再生を任せる。Flutter の起動、通知到着後の変換、音声のダウンロードを再生の前提にしない。既存 Notification Service Extension での音名置換も必須にしない。

passive の無音、通知の優先度、critical の権限・音の扱い、続報の上書き条件は既存契約を保持する。追加音の欠損時は OS による既定音への fallback を実機確認する。音のない payload に音を追加しない。

## 削除と復元

- 削除前に EEW・地震の既定音、全 slot の override、カスタムプリセット snapshot、保存処理中の選択から参照を確認する。取得失敗時は未使用と判断しない。
- 使用中は「通知設定で使用中です。別の通知音に変更してから削除してください」と案内する。複数の API 設定を削除操作で一括書き換える方式は採らない。
- 未使用音はカタログから外してからファイルを回収する。途中終了しても、次の読込でカタログ外の自前ファイルだけを回収できるようにする。
- API や snapshot に未知の名前がある場合は名前を保持し、欠損として表示する。画面表示・プリセット切替だけを理由にデフォルトへ書き換えない。

## 完了条件

Files からの追加、必要な変換、試聴、再起動後の一覧・選択、表示名変更、使用中削除の防止が動く。実際の EEW 予報・地震情報と震度別 override の通知で、バックグラウンド・アプリ終了・画面ロック中に選択音が再生される。追加失敗・設定同期失敗・欠損音で通知設定が壊れない。

Android を対象に広げる場合は、安定した content URI、OS による読み取り権限、変更できない既存 channel の sound、FCM の channel 選択を設計する。単に iOS 用ファイル名を FCM の sound へ送って完了としない。[NotificationChannel](https://developer.android.com/reference/android/app/NotificationChannel)、[FCM AndroidNotification](https://firebase.google.com/docs/reference/admin/node/firebase-admin.messaging.androidnotification)
