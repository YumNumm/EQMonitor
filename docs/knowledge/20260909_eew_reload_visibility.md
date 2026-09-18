# EEW再取得時の表示消失を調査する際のルール

## 修正前の原因とデータフロー

- `app/lib/feature/eew/data/eew.dart` の `Eew.build()` は
  `ref.watch(eewRestProvider).whenData(reconcileRestItems)` を返す。
- 使用中のRiverpod 3.4.2では `invalidate(..., asReload: true)` により、
  前回値付きの `AsyncLoading` になる。`whenData` のLoading分岐は
  新しい `AsyncLoading` を返すため、前回値が失われる。Error分岐も同様。
- 結果としてREST providerの `value` にEEWがあっても、Eew providerの
  `value` はnullになる。`EewAliveTelegram.build()` はnullを返し、
  `HomePage` の `_SheetBody` は `?? []` によりEEWカードを除去する。
- 再取得が完了すると再表示される。同じREST結果でも発生するため、
  サーバーの空レスポンスやWebSocketのEEW更新との競合は必須条件ではない。
- マップのEEW参照先や警報オーバーレイ候補も同じalive providerに依存する。
  実際の描画・警報モードへの影響は別途Widget/実機検証が必要。

## 再取得のトリガー

1. `Eew.build` のライフサイクルlistener: `resumed` でRESTをinvalidate。
2. 同じbuildのリアルタイムlistener: `RealtimeReadyEvent` でRESTをinvalidate。
3. 接続状態がconnected以外の場合、10秒タイマーでRESTをinvalidate。
4. RESTがwatchするAPI clientの依存変更でも再取得しうる。

WebSocketイベントstreamも `resumed` でticketと接続をinvalidateする。
したがって復帰時のREST再取得完了後、再接続のreadyが到着すると、
もう一度Loadingを挟める。二度の点滅を説明できるが、実際の端末で
どのトリガーが何回発火したかはログ未取得のため断定しない。
初期ライフサイクル値のresumed自体はlistenの即時通知ではない。

## 検証・修正時のルール

- 最終値だけでなく、RESTが未完了の間のprovider値を検証する。
- `app/test/feature/eew/data/eew_realtime_test.dart` は再取得中も表示値を保持する
  回帰テストに変更済み。readyと実際のライフサイクル復帰通知を検証する。
- 同一EEWを返すCompleterを待機させ、取得中の値を検証する。
  RESTの前回値保持とEewのnull化を分けて確認する。
- 既存のREST/Realtime整合テストは完了後のserialを確認するが、
  Loading中の表示継続を保証しない。デフォルトinvalidateとasReloadも区別する。
- EEW状態管理層では取得状態と表示用の最新データを分離し、
  Loading/Error中も最新の受信済みデータを保持する。
  RESTの古い前回値で新しいRealtimeデータを巻き戻さないこと。
- 正常な空結果、失効、キャンセル、再生モード切替の扱いは別途検証する。
- 実機ログにはresumed/ready/REST開始・終了、loading/hasValue、eventId/serialを
  同一時系列で残す。既存CustomProviderObserverはEew更新を除外している。

```bash
mise exec -- flutter test --no-pub app/test/feature/eew/data/eew_realtime_test.dart
mise exec -- dart analyze app/lib/feature/eew/data/eew.dart app/test/feature/eew/data/eew_realtime_test.dart
```

## 初回調査時の検証結果

- Riverpod 3.4.2のみの最小再現で、REST=[1]を保持したまま
  Eew相当の同期Notifierがnullになり、完了後[1]に戻ることを2回確認。
- アプリ側の既存テスト・追加した特性化テストは、flutter_sceneの
  StaticInstanceTopology等のAPI不整合によりコンパイルできず未実行。
  依存を変更して調査範囲を拡大せず、最小再現と静的追跡で切り分けた。

## 修正後の状態管理

- RESTはwatchでEew全体を再構築せず、listenで正常完了のみ整合処理へ渡す。
- 受信済みデータがある間、Loading/ErrorはEewの表示状態を変更しない。
  通信状態はeewRestProviderに保持され、初回未取得時はEewにも伝わる。
- 初期化時にRESTが前回値を持っていれば、その値から表示を構築する。
- 正常な空結果は既存のRealtime整合ルールに従って反映する。
  有効期限判定はtimeTickerにより継続し、再生モード切替でライブ値を破棄する。
- 再取得でEew.buildを再実行しないため、10秒の再取得タイマーも張り直さない。
- 初回調査のコンパイル失敗は、元の作業環境のサブモジュール状態で発生した。
  独立worktreeでコミット指定のflutter_sceneを取得すると既存5テストは成功した。
  調査時に他の作業のサブモジュールを変更せず、独立環境で切り分けること。

```bash
git submodule update --init third_party/flutter_scene
mise exec -- flutter test --no-pub app/test/feature/eew/data app/test/feature/home/ui/home_eew_card_test.dart
```

## 対象を絞ったコード生成の注意

- 新しいworktreeで `build_runner build --delete-conflicting-outputs --build-filter=...`
  を使うと、対象外の追跡済み生成ファイルも削除される場合がある。
- 実行前後の差分を確認する。今回のように開始時点で未変更だった対象外の
  生成ファイルは復元し、対象の生成結果のみ残してテスト・解析を実行する。
- 既存の作業変更がある生成ファイルを一括復元しないこと。

## 修正の検証結果

- 修正前に表示保持の回帰テストがnullで失敗することを確認。
- 修正後はEEWデータ層とホームEEWカードの146テストが成功。
- 実機の起動・復帰については `docs/todo/500_eew_reload_device_verification.md` に記録。
