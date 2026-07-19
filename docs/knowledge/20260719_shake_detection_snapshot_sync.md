# 揺れ検知 canonical snapshot 同期

## 契約

- REST `GET /v2/shake-detection/active` と WebSocket `type: shake_detection` は、どちらも revision 時点の active event 全件を含む完全 snapshot として扱う。
- `events` は upsert 差分ではない。採用した snapshot の一覧全体で state を置換し、空配列は active event 全削除として適用する。
- 初回 snapshot は revision 0 でも採用する。以後は incoming revision が現在値より厳密に大きい場合だけ採用し、同一 revision は冪等に無視し、小さい revision で巻き戻さない。

## 接続・再接続

1. WebSocket の `ready` を待つ。
2. `GET /v2/shake-detection/active` を取得する。
3. REST 取得中も WebSocket snapshot を受理する。
4. 両経路を同じ revision reducer に渡し、最大 revision を採用する。

REST は `Cache-Control: public, max-age=1, s-maxage=1` のため、WebSocket の方が新しい場合がある。REST の完了順で state を上書きしてはいけない。WebSocket 受理では REST 同期世代を失効させず、REST 完了時にも reducer で revision を比較する。

REST 同期には世代番号を持たせ、後から開始した同期だけが結果を適用する。

- repeated `ready` では新しい同期世代を開始し、先行 request の成功・失敗を無視する。
- disconnect では `ready` 済み状態を解除し、接続世代の request を失効させる。reconnect 後の新しい `ready` で再取得する。
- time-shift 移行時は同期世代を失効させて live snapshot を消去する。ready 済み接続で realtime に復帰した場合は、新しい世代で再取得する。
- provider の dispose 時も同期世代を失効させ、完了が遅れた request から state やログを更新しない。

## 表示判定と所有境界

- 有効期限はサーバーが決めた event の `expiresAt` を使う。`createdAt + 固定 TTL` を作らない。
- EEW 相関はサーバーが決めた `correlatedEew.eventId` を `correlatedEewEventId` として使う。アプリで走時表相関を再実装しない。
- 未知 level を `Weaker` などの弱い値へフォールバックしない。`FormatException` として扱い、REST では typed failure に変換して契約違反を記録する。

## 検証コマンド

canonical snapshot migration の通常 gate は次を repository root から実行する。

```bash
mise exec -- dart test packages/eqmonitor_websocket/test/ws_message_test.dart
(cd packages/eqmonitor_api && mise exec -- dart test --exclude-tags integration)
mise exec -- flutter test app/test/core/realtime
mise exec -- flutter test app/test/feature/shake_detection
mise exec -- dart analyze packages/eqmonitor_websocket packages/eqmonitor_api app/lib/core/realtime app/lib/feature/shake_detection
git --no-pager diff --check
git --no-pager status --short
```

全体 suite には migration 外の既知の前提・失敗がある。

- `mise exec -- dart test packages/eqmonitor_websocket/test` は、legacy earthquake fixture に必須の `datasources` がない2件で失敗する。canonical parser は上記の focused test で検証する。
- API test は fixture path が package cwd 基準なので repository root から実行しない。integration test は起動中の api-stub（`STUB_BASE_URL`、既定 `http://localhost:8790`）が必要で、通常 gate では除外する。

生成物を更新した場合は生成コマンドの前後で差分を確認する。

```bash
git --no-pager status --short
(cd packages/eqmonitor_websocket && mise exec -- dart run build_runner build)
(cd app && mise exec -- dart run build_runner build)
git --no-pager diff --check
git --no-pager status --short
```

generator version による migration 外の hash・asset・空白差分を混ぜず、意図した package の生成物だけを review する。
