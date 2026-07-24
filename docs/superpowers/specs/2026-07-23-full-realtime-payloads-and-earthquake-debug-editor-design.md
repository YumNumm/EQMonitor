# Full realtime payloads and earthquake debug editor design

## Goal

WebSocket の地震情報更新を受信しても地震履歴詳細画面が更新されない問題を、REST 再取得ではなく受信 payload によるメモリ状態更新で解消する。

同時に、Earthquake・EEW・揺れ検知の realtime payload を REST API と同じ完全な read model に統一し、OpenAPI から生成した Dart 型で parse する。地震履歴詳細画面には、現在の地震情報を基準に VXSE51・VXSE52・VXSE53・VXSE61・VXSE62 をローカル適用できるデバッグ editor を追加する。

## Confirmed constraints

- 旧 WebSocket payload との後方互換性は持たない。
- REST は `ready` 後の初期同期と再接続時の欠落補完にのみ使う。受信イベントの適用時には REST を再取得しない。
- realtime payload の型は backend の Valibot schema を正本とし、OpenAPI から Dart 型を生成する。
- 不完全な payload へのフォールバックや固定値による本番データ補完は行わない。
- デバッグ editor の変更は現在開いている詳細画面のメモリ上だけに適用し、サーバーや永続ストレージへ書き込まない。
- デバッグ用の不足値はランダム生成せず、現在値を優先し、残りだけを型ごとの決定的なサンプル値で補完する。
- VXSE56 と VXSE60 は backend では Feed に保存され、地震詳細 read model を更新しないため editor の対象外とする。

## Root cause

backend の `earthquake/upsert.record` は `EarthquakePartial` であり、地震詳細に必要な震度ツリー、観測点、電文コメント、カタログを含まない。アプリの地震履歴一覧は partial record を upsert できる一方、詳細 provider は matching realtime event を完全な詳細状態として適用できない。

さらに、EEW は backend ですでに `EewItemWithRelations` を配信しているが envelope が地震情報と統一されていない。揺れ検知は backend の単発 `shake_detected` payload とアプリが期待する active snapshot の契約が一致せず、アプリの中間 mapper でも points、merged events、correlated EEW などが失われる。

## Realtime contract

### Earthquake

Upsert:

```json
{
  "type": "earthquake",
  "operation": "upsert",
  "event_id": "20260723123456",
  "record": {}
}
```

`record` は `GET /v2/earthquake/:eventId` の `Earthquake` と同一 schema とする。upsert では必須であり、完全な read model を構築できない場合は publish しない。

Delete:

```json
{
  "type": "earthquake",
  "operation": "delete",
  "event_id": "20260723123456"
}
```

### EEW

```json
{
  "type": "eew",
  "operation": "upsert",
  "event_id": "20260723123456",
  "record": {}
}
```

`record` は REST の `EewItemWithRelations` と同一 schema とする。現在の uppercase `EEW` と `item` の組み合わせは削除する。取消報も、取消状態を含む完全な record の upsert として扱う。

### Shake detection

```json
{
  "type": "shake_detection",
  "operation": "snapshot",
  "record": {
    "type": "shake_detection",
    "revision": 1,
    "responseAt": "2026-07-23T12:34:56Z",
    "events": []
  }
}
```

`record` は `GET /v2/shake-detection/active` と同一 schema とし、revision、serial number、created/updated/expires timestamps、change reasons、merged events、region、points、test target、correlated EEW を保持する。DB 保存・統合後に active snapshot を再構築して publish する。snapshot 全体を置換することで、期限切れ、統合、消滅をクライアント側で推測しない。

## Backend architecture

### Shared read models

REST route と realtime publisher が別々の query・transformer を持たないよう、完全な Earthquake、EEW、shake detection snapshot の取得と変換を共有境界へ置く。

- Earthquake の詳細 query と transformer は API route と `telegram-db-writer` publisher の双方から利用する。
- EEW は既存の `EewRepository` と `toEewItemWithRelations` を利用する。
- 揺れ検知は active snapshot builder を REST route と realtime publisher で共有する。pinned backend に active route が不足している場合は同じ read model で追加する。

publisher は DB write の完了後に共有 read model を取得する。取得・schema validation に失敗した場合は不完全なイベントを送らず、構造化ログと既存 telemetry に失敗を記録する。

### OpenAPI

Valibot で次の component schemas を定義する。

- `RealtimeEarthquakeUpsertPayload`
- `RealtimeEarthquakeDeletePayload`
- `RealtimeEewUpsertPayload`
- `RealtimeShakeDetectionSnapshotPayload`
- discriminator 付き `RealtimeEventEnvelope`

`generate-openapi.ts` は HTTP route から生成した document の `components.schemas` に realtime schemas を追加する。schema を露出するためだけのダミー HTTP endpoint は作らない。生成された `backend/api/api/openapi.json` を `packages/eqmonitor_api/bin/generate.dart` の既存フローへ渡す。

full payload は切り詰めない。既存の WebSocket backpressure、payload byte metrics、broadcast logging を継続して使用する。

## App architecture

### Parsing

`packages/eqmonitor_api` に OpenAPI component 由来の Dart model と enum/union を生成する。`packages/eqmonitor_websocket` の手書き domain payload model は削除し、外側の WebSocket message と discriminator の処理だけを残す。各 payload の内部は生成型の `fromJson` で parse する。

不正 JSON、未知の discriminator、upsert の record 欠落はイベント単位で破棄して talker に記録する。partial model への変換、REST 再取得、前回値での補完は行わない。

### In-memory updates

- Earthquake 一覧は full `Earthquake` から一覧表示モデルを導出して event ID で upsert する。
- 開いている地震詳細 provider は matching event ID の full `Earthquake` で state を置換する。別 event ID は無視する。
- Earthquake delete は一覧から削除し、同じ詳細を開いている場合は削除済み状態を表示する。
- EEW provider は event ID と serial number により完全な generated record を upsert し、古い serial number を無視する。
- 揺れ検知 provider は受信 active snapshot を revision reducer に渡し、より新しい snapshot 全体で state を置換する。
- 中間 realtime model は full generated record を保持し、points や relations を落とす独自 DTO を作らない。

`ready` 後の REST 同期は WebSocket 購読開始前の欠落を埋めるため維持する。通常の event 受信はネットワークアクセスなしで完結する。

## Earthquake debug editor

### Entry and layout

地震履歴詳細画面の既存の虫アイコンからタブ付き bottom sheet を開く。

- `地震情報`: 新しい VXSE editor
- `マップレイヤー`: 既存のレイヤーパラメータ editor

editor はデバッグモードまたは debug build でのみ利用できる。

### Typed form and JSON

`地震情報` タブでは VXSE51、VXSE52、VXSE53、VXSE61、VXSE62 を選択する。現在表示中の full `Earthquake` から選択型の入力を構築し、現在値がない必須項目だけ決定的なサンプル値で補完する。

型付きフォームは選択した VXSE が変更し得るフィールドをすべて表示する。大きな region、prefecture、city、station、intensity tree の配列は JSON editor からも編集できる。フォーム変更時は backend 互換 patch JSON を再生成し、JSON は手動編集可能とする。

JSON は選択型の OpenAPI generated model で検証する。不正 JSON、選択型と異なる discriminator、event ID 不一致は適用不可とし、画面内に収まるエラー表示を行う。

### Apply modes

適用方式は次の2種類とする。

- `マージ`: 現在値を維持し、payload が所有するフィールドを上書きまたは upsert する。
- `変更対象を消去して適用`: 選択 VXSE が所有するフィールドを null または空配列へ戻してから payload を適用する。

field ownership は backend の transformer/writer と一致させる。

| Type | Owned fields |
| --- | --- |
| VXSE51 | status、last reported time、max intensity、region/prefecture intensities、comment |
| VXSE52 | status、arrival/origin time、hypocenter、magnitude/depth、comment |
| VXSE53 | VXSE52 fields、earthquake type、max intensity、region/prefecture/city/station intensities、comment |
| VXSE61 | updated hypocenter fields、comment |
| VXSE62 | hypocenter fields、max intensity、max LPGM intensity、region/prefecture/station intensity and LPGM data、comment |

たとえば VXSE51 だけの現在状態へ VXSE52 を `マージ` すると、最大震度と既存震度明細を維持したまま震源情報と VXSE52 telegram/comment が追加される。

適用結果は WebSocket の full Earthquake upsert と同じ詳細 provider 更新入口へ渡す。リセットは editor を開いた時点の API/WebSocket state へ戻し、永続化やサーバー送信は行わない。

現在誤っている app の VXSE61/62 表示名は backend の実際の意味である「顕著な地震の震源要素更新のお知らせ」「長周期地震動に関する観測情報」へ直す。

## Error handling

- backend read model の取得または validation が失敗した場合、不完全な realtime event は publish しない。
- app parser が payload を拒否した場合、現在の表示状態を維持してエラーをログへ記録する。
- debug JSON validation error は editor 内に表示し、適用ボタンを無効にする。
- full payload を任意に縮小する fallback は設けない。
- REST 初期同期の失敗は既存の cached/error UI を使用し、WebSocket event 処理とは分離する。

## Test strategy

### Backend

- realtime schema が full payload を受理し、旧 partial payload と record 欠落を拒否する。
- Earthquake publisher の record が REST と同じ shared transformer の結果になる。
- EEW record が warning relations を保持する。
- shake detection snapshot が points、merged events、correlated EEW、revision、expiry を保持する。
- OpenAPI に realtime component schemas と discriminator が存在する。
- publisher の read/validation failure が partial event を publish しない。

### Generated Dart and WebSocket package

- backend fixture を OpenAPI generated realtime types で parse できる。
- Earthquake full intensity trees、telegrams、comments、catalog が保持される。
- EEW warning relations と shake detection full event fields が保持される。
- 旧 envelope と不完全な upsert が拒否される。

### App

- matching earthquake upsert が詳細 state を受信 record だけで置換する。
- 別 event ID は詳細 state を変更しない。
- 一覧は full Earthquake から導出した表示モデルを upsert する。
- EEW は新しい serial number だけを適用する。
- shake detection は新しい revision の snapshot 全体を適用する。
- event 適用中に REST repository が呼ばれない。
- VXSE51 状態へ VXSE52 を merge すると最大震度を維持して震源を追加する。
- clear-and-apply が選択型の owned fields だけを消去し、対象外フィールドを維持する。
- JSON validation、event ID validation、reset を保証する。
- editor Widget が型選択、mode 選択、validation error、適用、reset を表示・実行できる。

## Delivery boundaries

変更は backend submodule と EQMonitor 親リポジトリの両方にまたがる。backend では schema、shared read models、publishers、OpenAPI、仕様書、契約テストを変更する。親側では生成 OpenAPI/Dart model、WebSocket package、app providers、debug editor、テストを変更し、backend gitlink を更新する。

backend と親リポジトリはそれぞれ focused tests、type checks、format checks、`git diff --check` を通す。生成ファイルは正規の generation command から更新し、手編集しない。
