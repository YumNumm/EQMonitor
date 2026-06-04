# OpenAPI App Implementation Audit

対象: `backend/api/api/openapi.json`

調査日: 2026-06-04

対象セクション: `start`, `changelog`, `earthquake`, `eew`, `telegram`, `user`, `realtime`, `device`, `parameters`, `websocket`

## 結論

アプリ側の生成クライアントは対象 HTTP endpoint をおおむね保持している。ただし、アプリ実装としては次の修正が必要。

- `telegram`: 次ページ取得時に `cursor` を渡していないため、2ページ目以降が同じ先頭ページを再取得する。
- `earthquake`: `earthquake_search_notifier.dart` の次ページ取得でも `cursor` を渡していないため、地域/都道府県/市区町村/観測点検索の追加取得が壊れる。
- `earthquake`: `EarthquakeHistoryParameter.statuses` は UI/モデルに存在するが Repository 呼び出しへ伝播していないため、訓練/試験電文を含める検索意図が API に届かない。
- `parameters`: OpenAPI に `/v2/parameters/manifest` と `/v2/parameters/{type}` があるが、アプリの `ParameterRepository.refresh()` は常に `false` を返し、リモート更新を利用していない。
- `realtime` / `websocket`: `expiresAt - 30秒` が負になる可能性を考慮せず `Timer` を作っている。短命または期限切れチケットで接続更新が壊れる可能性がある。
- `websocket`: WebSocket パッケージ側に津波 realtime event 型があるが、アプリ側 `RealtimeEvent` へマップされず破棄される。現時点では `record` が `Map<String, dynamic>?` で型安全なアプリモデルに直結しないため、アプリ未対応として明示的に drop する。
- `device`: `AppCheckInterceptor` / `DeviceIdInterceptor` が旧 `PUT /v2/device/{id}` 登録を想定しており、現 OpenAPI の `POST /v2/device` とコメント・条件が一致していない。
- `device`: `DeviceRegisterResponse` の `deviceToken` をアプリ側で保存・利用していない。サーバー側で device JWT 検証を厳格化した場合に通知設定や token sync が 401 になるリスクがある。
- `device`: `/v2/device/me/apns/{kind}` の生成クライアント引数が `dynamic` になっており、アプリ側も文字列直書きで呼んでいる。OpenAPI の `notification | liveActivityStart` と型が一致していない。
- `start` / `changelog`: SharedPreferences キーがローカル const 直書きで、プロジェクトの Preferences キー管理規約から外れている。
- `user`: 生成クライアントはあるが、アプリ側利用は見つからない。現時点でユーザー管理画面を提供しない方針なら問題ではないが、実装済み API とアプリ機能の差分として明示しておくべき。

## Section Review

### start

OpenAPI:

- `GET /v1/start`
- `if-none-match` 対応
- `200`, `304`, `500`

アプリ実装:

- `packages/eqmonitor_api/lib/src/clients/start_api_client.dart`
- `app/lib/feature/start/data/repository/start_repository.dart`
- `app/lib/feature/start/data/notifier/start_notifier.dart`
- `app/lib/feature/start/ui/component/forced_update_dialog.dart`
- `app/lib/feature/start/ui/component/maintenance_banner.dart`
- `app/lib/feature/start/ui/component/whats_new_banner.dart`

評価:

- ETag と 304 キャッシュは実装済み。
- 起動時の `fetchInBackground()`、メンテナンス表示、強制アップデート、What's New 表示は契約の用途に沿っている。

懸念:

- キャッシュキー `start_etag`, `start_body`, `whats_new_seen_version` がローカル const 直書き。`SharedPreferencesKey` enum に移すべき。
- `ForcedUpdateWrapper` が `ConsumerStatefulWidget` とプライベート state method を持ち、現行 Flutter ルールの Hook/ConsumerWidget 方針から外れている。今回の API 対応としては低優先。

### changelog

OpenAPI:

- `GET /v1/changelog`
- query: `since`, `limit`
- header: `if-none-match`
- `200`, `304`, `400`

アプリ実装:

- `packages/eqmonitor_api/lib/src/clients/changelog_api_client.dart`
- `app/lib/feature/changelog/data/repository/changelog_repository.dart`
- `app/lib/feature/changelog/data/notifier/changelog_notifier.dart`
- `app/lib/feature/changelog/ui/page/changelog_page.dart`

評価:

- ETag と 304 キャッシュ、設定画面からの表示導線はある。
- UI 表示用途としては十分。

懸念:

- `since` と `limit` はアプリ側 Repository から利用していない。全履歴表示で問題ないなら許容。
- キャッシュキー `changelog_etag`, `changelog_body` がローカル const 直書き。

### earthquake

OpenAPI:

- `GET /v2/earthquake`
- `GET /v2/earthquake/{eventId}`
- `GET /v2/earthquake/intensity/region/{code}`
- `GET /v2/earthquake/intensity/prefecture/{code}`
- `GET /v2/earthquake/intensity/city/{code}`
- `GET /v2/earthquake/intensity/station/{code}`
- `GET /v2/earthquake/epicenter/{code}`

アプリ実装:

- `packages/eqmonitor_api/lib/src/clients/earthquake_api_client.dart`
- `app/lib/feature/earthquake_history/data/repository/earthquake_history_repository.dart`
- `app/lib/feature/earthquake_history/data/notifier/earthquake_history_notifier.dart`
- `app/lib/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart`
- `app/lib/feature/earthquake_history/data/model/earthquake_history_parameter.dart`
- `app/lib/feature/earthquake_search/data/notifier/earthquake_search_notifier.dart`

評価:

- 一覧、詳細、地域/都道府県/市区町村/観測点/震央検索は Repository 経由で利用されている。
- `earthquake_history_notifier.dart` のページングは `nextToken` を `cursor` として渡している。
- WebSocket の earthquake upsert/delete と REST fallback があり、リアルタイム性の補完もある。

修正必要:

- `earthquake_search_notifier.dart` の `fetchNextData()` は `currentState.nextToken` を `_fetchData()` に渡しておらず、地域/都道府県/市区町村/観測点検索の次ページ取得で先頭ページを再取得する。
- `EarthquakeHistoryParameter.statuses` が Repository API 呼び出しに渡っていない。OpenAPI の `statuses` query を使えるようにし、通常/訓練/試験の検索意図を反映する必要がある。

懸念:

- `EarthquakeHistoryRepository` に private helper が多く、現行ルール上は専用 class への分離対象。ただし API 契約不整合ではないため本レポートでは低優先。
- search API 呼び出しでは magnitude/depth/intensity/originTime/sortBy/sortOrder filter を UI から利用していない箇所がある。現 UI の仕様次第で許容。

### eew

OpenAPI:

- `GET /v2/eew`
- `GET /v2/eew/latest`
- `GET /v2/eew/{eventId}`
- `GET /v2/eew/{eventId}/{serialNo}`

アプリ実装:

- `packages/eqmonitor_api/lib/src/clients/eew_api_client.dart`
- `app/lib/feature/eew/data/eew.dart`
- `app/lib/feature/eew/data/eew_by_event_id.dart`

評価:

- ホーム/ライブ用途では `/v2/eew/latest` と WebSocket snapshot/upsert を併用している。
- eventId ごとの履歴は `/v2/eew/{eventId}` を利用している。

懸念:

- `/v2/eew` の一覧検索、`/v2/eew/{eventId}/{serialNo}` の単報詳細はアプリ側利用が見つからない。UI 要件がないなら許容。
- cancel 発生直後の UI 表現は `status != normal` に寄っており、`isCanceled: true` 専用の明示的な表示は弱い。
- `EewsByEventId` は WebSocket から同一 eventId の新報を足すが、現在値のスナップショットをループ内で更新しないため、同時に複数報が流れた場合に取りこぼす可能性がある。別途検証推奨。

### telegram

OpenAPI:

- `GET /v2/telegram`
- `GET /v2/telegram/type/{type}`
- `GET /v2/telegram/eventId/{eventId}`
- `GET /v2/telegram/{id}`

アプリ実装:

- `packages/eqmonitor_api/lib/src/clients/telegram_api_client.dart`
- `app/lib/feature/telegram_list/data/notifier/telegram_list_by_event_id_notifier.dart`
- `app/lib/feature/telegram_list/data/model/telegram_item.dart`

評価:

- eventId 別の電文一覧は利用されている。

修正必要:

- `fetchNextData()` が `currentState.nextToken` を `cursor` に渡していないため、ページングが壊れている。
- `statuses` を明示指定しておらず API デフォルト `[NORMAL]` に依存している。訓練/試験電文の表示が必要な導線では引数化が必要。
- `/v2/telegram`, `/v2/telegram/type/{type}`, `/v2/telegram/{id}` はアプリ側利用が見つからない。電文一覧/詳細 UI を出さない方針なら許容。

### user

OpenAPI:

- `GET /v2/user/me`
- `PATCH /v2/user/me`
- `DELETE /v2/user/me`
- `GET /v2/user/me/devices`
- `GET /v2/user/me/sessions`
- `DELETE /v2/user/me/sessions/{token}`

アプリ実装:

- `packages/eqmonitor_api/lib/src/clients/user_api_client.dart`
- `app/lib` での利用は見つからない。

評価:

- 生成クライアントは存在するが、アプリ機能としては未実装。

懸念:

- `PATCH /v2/user/me` は OpenAPI 上も requestBody が見当たらず、生成クライアントにも body がない。プロフィール更新をアプリで実装する前に API schema を修正する必要がある可能性が高い。

### realtime

OpenAPI:

- `GET /v2/realtime/ticket`
- `x-eqmonitor-device-id` header 必須

アプリ実装:

- `packages/eqmonitor_api/lib/src/clients/realtime_api_client.dart`
- `app/lib/core/realtime/data_source/eqmonitor/eqmonitor_ws_provider.dart`
- `app/lib/core/realtime/data_source/eqmonitor/eqmonitor_ws_data_source.dart`
- `app/lib/core/realtime/realtime_event_provider.dart`
- `app/lib/core/realtime/model/realtime_event.dart`
- `app/lib/core/provider/dio_provider.dart`
- `app/lib/core/provider/interceptor/device_id_interceptor.dart`

評価:

- Ticket endpoint を呼び、返却 URL に WebSocket 接続している。
- `DeviceIdInterceptor` により `x-eqmonitor-device-id` は付与される。

修正必要:

- `Timer(diff - buffer, ...)` が負の duration になる可能性がある。期限切れまたは残り 30 秒未満の ticket で再取得制御が不安定になる。

### device

OpenAPI:

- `POST /v2/device/challenge`
- `POST /v2/device`
- `GET/DELETE /v2/device/me`
- `PATCH /v2/device/me/fcm`
- `PATCH /v2/device/me/apns/{kind}`
- notification / earthquake / eew / shake-detection / live-activity / notification history / notification test 系

アプリ実装:

- `packages/eqmonitor_api/lib/src/clients/device_api_client.dart`
- `packages/eqmonitor_api/lib/src/clients/notification_api_client.dart`
- `app/lib/feature/devices/data/repository/device_repository.dart`
- `app/lib/feature/settings/features/notification_settings/data/repository/device_notification_settings_repository.dart`
- `app/lib/feature/notification/data/repository/push_notification_repository.dart`
- `app/lib/feature/devices/data/notifier/push_token_sync_notifier.dart`
- `app/lib/feature/live_activity/data/repository/live_activity_token_sync_service.dart`
- `app/lib/core/provider/interceptor/app_check_interceptor.dart`
- `app/lib/core/provider/interceptor/device_id_interceptor.dart`

評価:

- device 登録、取得、削除、FCM/APNs token 同期、通知設定、地域設定、揺れ検知設定、Live Activity token、通知履歴、テスト通知は実装済み。
- `POST /v2/device/challenge` は利用していないが、App Check を使う前提なら必須ではない。

修正必要:

- `AppCheckInterceptor` が `PUT /v2/device/{id}` を device upsert として扱っており、現 OpenAPI の `POST /v2/device` では App Check limited-use token が付与されない可能性がある。
- `DeviceIdInterceptor` のコメントと登録除外条件も `PUT /v2/device/{id}` 前提で、現 OpenAPI と一致していない。
- `DeviceRepository.registerDevice()` が `DeviceRegisterResponse` を捨てている。`deviceToken` / `expiresAt` をどう保存・利用するか確認し、Authorization header へ反映する設計が必要。
- APNs kind の生成型が `dynamic` で、アプリ実装も `'notification'`, `'liveActivityStart'` を文字列直書きしている。OpenAPI の許容値と Dart 型を一致させるべき。

懸念:

- `push_token_sync_notifier` のリトライ上限到達後、通知 token 未同期状態がユーザーに十分伝わらない可能性がある。
- `live_activity_token_sync_service` の token sync が fire-and-forget で、失敗検知が弱い。
- `DeviceRepository.migrateFromLegacy()` のコメントは削除済み migrate endpoint 前提の名残があり、現実装は success 扱い。API 契約不整合というより移行コードの整理対象。

### parameters

OpenAPI:

- `GET /v2/parameters/manifest`
- `GET /v2/parameters/{type}`
- ETag と `304` 相当の利用が想定される。

アプリ実装:

- `packages/eqmonitor_api/lib/src/clients/parameters_api_client.dart`
- `app/lib/feature/parameter/data/repository/parameter_repository.dart`
- `app/lib/feature/parameter/data/notifier/parameter_set_notifier.dart`
- `app/lib/feature/parameter/data/data_source/parameter_asset_data_source.dart`
- `app/lib/feature/parameter/data/data_source/parameter_local_data_source.dart`

評価:

- ローカル保存済みデータ優先、なければ bundled asset を読む構造はある。

修正必要:

- `ParameterRepository.refresh()` が常に `false` を返しており、OpenAPI の parameters endpoint を利用していない。
- 生成クライアントの `getV2ParametersType()` は `Map<String, Object?>` を返す。プロジェクト規約では `Map<String, dynamic>` 以外の `Object` 利用を避けるため、スキーマまたは生成器側の調整も検討が必要。

### websocket

OpenAPI:

- `websocket` path は `backend/api/api/openapi.json` の `paths` には存在しない。
- REST としては `GET /v2/realtime/ticket` のみ。

関連実装:

- backend 側の説明では WebSocket server は `/v2/realtime/ws`。
- アプリは ticket response の `url` に直接接続するため、WebSocket endpoint 自体を OpenAPI に持たない構成と整合している。

評価:

- OpenAPI にないこと自体は設計上自然。
- アプリ側は WebSocket payload を `RealtimeEvent` に変換して earthquake/eew へ流している。

懸念:

- WebSocket payload schema は OpenAPI では検証できない。`docs/websocket-realtime-spec.md` や backend websocket package との契約テストで担保する必要がある。
- `eqmonitor_websocket` 側に津波 event 型がある一方、アプリ側 `RealtimeEvent` sealed class には tsunami variant がない。今回の対応では wildcard ではなく `WsTsunamiRealtimeEvent` branch で明示的に空配列へ変換し、津波 realtime 表示は別スコープとして扱う。
- WebSocket close 時の再接続に指数バックオフがなく、サーバー障害時に即時再接続を繰り返す可能性がある。

## Recommended Fix Order

1. `telegram` の cursor bug を修正する。
2. `earthquake_search` の cursor bug を修正する。
3. `earthquake` の `statuses` を Repository/API 呼び出しへ伝播する。
4. `device` 登録時の App Check 付与条件と device id header 除外条件を現 OpenAPI に合わせる。
5. `realtime` ticket expiry timer を安全化する。
6. `parameters` の remote refresh を実装する。
7. `websocket` の津波 event は現状アプリ未対応として明示的に drop し、将来アプリ側で扱う場合は型安全な payload/model を整備する。
8. `device` APNs kind を型安全化する。
9. `start/changelog` の SharedPreferences キーを enum 管理へ移す。
10. `user` は仕様確認後、アプリ機能として実装するか未提供として明文化する。
