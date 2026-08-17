# eventId別の派生画面でリアルタイム更新を接続する規約

## 画面のwatchだけではWebSocket更新にならない

ページの`ref.watch(telegramListByEventIdProvider(eventId))`は、Providerの状態変更を
画面へ反映するための購読であり、WebSocketイベントからREST再取得を起動するものではない。
派生画面をリアルタイム更新する場合は、状態を所有するfamily Notifierが
`realtimeEventsProvider`を直接購読し、対象イベントだけで自身を再取得する。

```dart
ref.listen(realtimeEventsProvider, (_, next) {
  if (next case AsyncData(
    value: RealtimeEarthquakeUpsertEvent(:final record),
  ) when record.eventId == eventId) {
    ref.invalidateSelf();
  }
});
```

`eventId`を比較せず全familyをinvalidateすると、別の地震の更新でも不要なREST通信が発生する。
イベント種別と`record.eventId`の両方を絞ること。固定値や推測値へフォールバックしてはならない。

## 一覧と詳細は個別に更新する

電文画面では、一覧を持つ`TelegramListByEventId`と、電文詳細Mapを持つ
`TelegramDetails`の双方が同じ条件で`realtimeEventsProvider`を購読する。
画面が一覧Providerをwatchしているだけでは、別Providerで管理する詳細キャッシュは更新されない。
一覧・詳細それぞれのNotifierで`ref.invalidateSelf()`し、各Providerの既存取得経路を再実行する。

この規約を別のeventId別派生画面へ適用するときも、次を守る。

- WebSocket購読はPresentation層ではなく、状態を所有するNotifierに置く。
- family引数の`eventId`と受信レコードの`eventId`が一致する場合だけinvalidateする。
- 一覧、詳細、派生キャッシュなど状態の所有者ごとに再取得を接続する。
- 外部イベントが不要な既存テストでは`realtimeEventsProvider`を空streamでoverrideする。
- 一致イベントで再取得され、不一致イベントでは取得回数が増えないことをテストする。

## Riverpod 3.3.2の非同期テスト待機

Riverpod 3.3.2の`ProviderContainer.pump()`は、イベントによるrefresh schedulingまでは待つが、
AsyncNotifierの最初の`await`より後に続くREST取得完了までは待たない。
したがって、イベント送出直後の`pump()`だけでリクエスト回数を検証すると、実装が正しくても
再取得前の回数を観測することがある。

一致イベントのテストでは、次の順序で対象family Providerの完了まで待つ。

```dart
controller.add(matchingEvent);
await container.pump();
await container.read(provider.future);
expect(adapter.requests, hasLength(2));
```

不一致イベントは再取得されない契約なので、イベント送出後の`pump()`で通知処理を消化してから
取得回数が増えていないことを確認する。

## 検証コマンド

Flutter / Dartコマンドは必ず`app`ディレクトリで`mise exec --`経由で実行する。

```bash
cd app
mise exec -- dart format lib/feature/telegram_list test/feature/telegram_list
mise exec -- flutter test test/feature/telegram_list
mise exec -- flutter analyze lib/feature/telegram_list test/feature/telegram_list
cd ..
git --no-pager diff --check HEAD
```
