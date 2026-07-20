# Shake Detection Canonical Snapshot Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** backend PR #869 の canonical 揺れ検知 snapshot をアプリが初回接続・再接続・通常更新のすべてで欠落や巻き戻りなく受信し、サーバーと同じ active event 一覧を表示する。

**Architecture:** `packages/eqmonitor_websocket` は WebSocket wire contract、`packages/eqmonitor_api` は OpenAPI 生成 REST contract を所有し、アプリの `core/realtime` で transport 非依存の snapshot event に正規化する。揺れ検知 feature は REST repository と WebSocket event の双方を同じ `ShakeDetectionSnapshotReducer` に入力し、最大 `revision` の完全 snapshot だけを採用する。EEW 相関と失効判定はサーバーの `correlatedEew` / `expiresAt` を正とし、クライアント独自の走時表相関と固定 TTL は廃止する。

**Tech Stack:** Dart 3.11, Flutter 3.44, Freezed, json_serializable, Retrofit/Dio, Riverpod 3, flutter_hooks, `mise exec --`, Flutter test, Dart test

## Global Constraints

- Flutter / Dart コマンドは常に `mise exec --` 経由で実行する。
- backend contract は PR #869 merge commit `3de810ef2d9887d87093dbd4ddfff3f943709238` を使用する。
- 公開 WebSocket contract は旧 `type: "shake_detected"` と互換にせず、`type: "shake_detection"` の完全 snapshot のみを受理する。
- snapshot は `revision` が現在値より大きい場合だけ採用し、同値は冪等に無視し、小さい値では状態を巻き戻さない。
- `ready` 後に REST `GET /v2/shake-detection/active` を取得し、取得中に到着した WebSocket snapshot と REST snapshot の最大 revision を採用する。
- active event は snapshot の `events` 全体で置換する。空配列は全 active event の削除として適用する。
- 揺れ検知の失効は固定 3 分 / 5 分ではなく `expiresAt` を使う。
- EEW 相関は `correlatedEew.eventId` を正とし、アプリ内で走時表を使った再相関を行わない。
- 未知の揺れレベルを `Weaker` 等へ固定フォールバックしない。契約違反として `FormatException` にする。
- API 通信は repository を経由し、`Future<Result<T, ShakeDetectionApiException>>` を返す。
- `dynamic` / `Object` は既存の JSON 境界 `Map<String, dynamic>` 以外で追加しない。`!` 演算子を追加しない。
- Widget / UI の見た目、通知設定 API、iOS Live Activity ContentState は本変更の対象外とする。
- 生成物は手編集せず、backend submodule の OpenAPI から `packages/eqmonitor_api/bin/generate.dart`、Freezed / Riverpod は build_runner で生成する。
- コミットメッセージは英語1単語 prefix + 日本語説明とし、各 task の差分を独立コミットする。各コミット後に push する。

---

## File Structure

### Transport contracts

- `backend` — PR #869 merge commit を指す submodule pin。
- `packages/eqmonitor_api/lib/src/clients/shake_detection_api_client.dart` — OpenAPI 生成 REST client。
- `packages/eqmonitor_api/lib/src/models/get_v2_shake_detection_active_response*.dart` — OpenAPI 生成 snapshot / event / nested DTO 群。
- `packages/eqmonitor_websocket/lib/src/ws_shake_detection_snapshot.dart` — WebSocket canonical snapshot と event DTO。
- `packages/eqmonitor_websocket/lib/src/realtime_event_envelope.dart` — `shake_detection` union case。

### Core realtime normalization

- `app/lib/core/realtime/model/realtime_shake_snapshot.dart` — transport 非依存の realtime snapshot DTO。
- `app/lib/core/realtime/model/realtime_event.dart` — `RealtimeShakeSnapshotEvent`。
- `app/lib/core/realtime/data_source/eqmonitor/eqmonitor_realtime_event_mapper.dart` — WebSocket DTO から core realtime DTO への変換。

### Shake detection feature

- `app/lib/feature/shake_detection/data/model/shake_detection_event.dart` — UI/domain event。`serialNo`, `updatedAt`, `expiresAt`, `correlatedEewEventId` を保持。
- `app/lib/feature/shake_detection/data/model/shake_detection_snapshot.dart` — revision 付き domain snapshot。
- `app/lib/feature/shake_detection/data/model/shake_detection_level_parser.dart` — level 文字列の厳密変換。
- `app/lib/feature/shake_detection/data/repository/shake_detection_repository.dart` — REST active snapshot 取得と API DTO 変換。
- `app/lib/feature/shake_detection/data/notifier/shake_detection_snapshot_reducer.dart` — revision 比較だけを担う純粋 reducer。
- `app/lib/feature/shake_detection/data/provider/shake_detection_provider.dart` — ready/REST と WebSocket snapshot の合流、完全置換。
- `app/lib/feature/shake_detection/data/provider/shake_detection_merge_provider.dart` — `correlatedEewEventId` と `expiresAt` による表示用 computed provider。

### Tests and documentation

- `packages/eqmonitor_websocket/test/ws_message_test.dart` — wire contract parser regression。
- `app/test/core/realtime/eqmonitor_realtime_event_mapper_test.dart` — core mapping regression。
- `app/test/feature/shake_detection/data/shake_detection_level_parser_test.dart` — level strictness。
- `app/test/feature/shake_detection/data/shake_detection_repository_test.dart` — REST conversion / 503 failure。
- `app/test/feature/shake_detection/data/shake_detection_snapshot_reducer_test.dart` — revision ordering。
- `app/test/feature/shake_detection/data/shake_detection_provider_test.dart` — ready/REST/WS race と完全置換。
- `app/test/feature/shake_detection/data/shake_detection_visible_test.dart` — canonical correlation / expiry 表示判定。
- `docs/knowledge/20260719_shake_detection_snapshot_sync.md` — 今後の realtime snapshot 同期ルール。

---

### Task 1: Pin backend contract and regenerate the REST client

**Files:**
- Modify: `backend`
- Regenerate: `packages/eqmonitor_api/lib/src/api_client.dart`
- Regenerate: `packages/eqmonitor_api/lib/src/export.dart`
- Create (generated): `packages/eqmonitor_api/lib/src/clients/shake_detection_api_client.dart`
- Create (generated): `packages/eqmonitor_api/lib/src/clients/shake_detection_api_client.g.dart`
- Create (generated): `packages/eqmonitor_api/lib/src/models/get_v2_shake_detection_active_response.dart`
- Create (generated): `packages/eqmonitor_api/lib/src/models/get_v2_shake_detection_active_response.freezed.dart`
- Create (generated): `packages/eqmonitor_api/lib/src/models/get_v2_shake_detection_active_response.g.dart`
- Create (generated): `packages/eqmonitor_api/lib/src/models/get_v2_shake_detection_active_response_events_inner.dart` and its generated parts
- Create (generated): nested response model files emitted for `region`, `location`, `mergedEvents`, `test`, and `correlatedEew`
- Modify (generated): `packages/eqmonitor_api/test/fixtures/contract/index.json`

**Interfaces:**
- Consumes: backend OpenAPI operation `GET /v2/shake-detection/active`, operationId `getV2ShakeDetectionActive`.
- Produces: `ApiClient.shakeDetection`, `ShakeDetectionApiClient.getV2ShakeDetectionActive()`, and generated response properties `revision`, `responseAt`, `events`.

- [ ] **Step 1: Verify the endpoint is absent before regeneration**

Run:

```bash
rg -n "getV2ShakeDetectionActive|/v2/shake-detection/active" packages/eqmonitor_api/lib
```

Expected: exit code 1 and no matches.

- [ ] **Step 2: Initialize and pin the backend submodule**

Run:

```bash
git submodule update --init backend
git -C backend fetch origin main
git -C backend checkout 3de810ef2d9887d87093dbd4ddfff3f943709238
git -C backend rev-parse HEAD
```

Expected final output:

```text
3de810ef2d9887d87093dbd4ddfff3f943709238
```

- [ ] **Step 3: Regenerate the Dart API client**

Run:

```bash
cd packages/eqmonitor_api
mise exec -- dart run bin/generate.dart
```

Expected: command exits 0, prints `✅ コード生成が完了しました`, and generates a `ShakeDetectionApiClient` with `getV2ShakeDetectionActive()`.

- [ ] **Step 4: Verify the generated public API**

Run:

```bash
rg -n "class ShakeDetectionApiClient|Future<HttpResponse<.*>> getV2ShakeDetectionActive|ShakeDetectionApiClient get shakeDetection" packages/eqmonitor_api/lib/src
rg -n "required int revision|required DateTime responseAt|required List<.*> events" packages/eqmonitor_api/lib/src/models/get_v2_shake_detection_active_response.dart
rg -n "required int serialNo|required DateTime expiresAt|correlatedEew" packages/eqmonitor_api/lib/src/models/get_v2_shake_detection_active_response_events_inner.dart
```

Expected: every pattern has at least one match. Generated files must retain the deterministic names emitted by swagger_parser and must not be renamed manually.

- [ ] **Step 5: Run generated-client tests and analysis**

Run:

```bash
cd packages/eqmonitor_api
mise exec -- dart test
mise exec -- dart analyze
```

Expected: both commands exit 0.

- [ ] **Step 6: Commit and push the contract update**

```bash
git add backend packages/eqmonitor_api
git commit -m "chore: 揺れ検知snapshot API契約を更新"
git push
```

Expected: commit succeeds and the current branch is pushed.

---

### Task 2: Parse the canonical WebSocket snapshot contract

**Files:**
- Create: `packages/eqmonitor_websocket/lib/src/ws_shake_detection_snapshot.dart`
- Modify: `packages/eqmonitor_websocket/lib/src/realtime_event_envelope.dart:1-65`
- Modify: `packages/eqmonitor_websocket/lib/eqmonitor_websocket.dart`
- Regenerate: `packages/eqmonitor_websocket/lib/src/ws_shake_detection_snapshot.freezed.dart`
- Regenerate: `packages/eqmonitor_websocket/lib/src/ws_shake_detection_snapshot.g.dart`
- Regenerate: `packages/eqmonitor_websocket/lib/src/realtime_event_envelope.freezed.dart`
- Regenerate: `packages/eqmonitor_websocket/lib/src/realtime_event_envelope.g.dart`
- Test: `packages/eqmonitor_websocket/test/ws_message_test.dart`

**Interfaces:**
- Consumes: `{type: "realtime", data: {type: "shake_detection", revision, responseAt, events}}`.
- Produces: `WsShakeDetectionRealtimeEvent`, `WsShakeDetectionEvent`, `WsShakeMergedEvent`, `WsShakeCorrelatedEew`, and existing region/point DTO reuse.

- [ ] **Step 1: Replace the old parser fixture with a canonical snapshot fixture**

Add this test to `WsMessage.fromJson` and remove tests that assert acceptance of `shake_detected`:

```dart
test('realtime/shake_detection の完全snapshotをパースできること', () {
  final result = WsMessage.fromJson({
    'type': 'realtime',
    'data': {
      'type': 'shake_detection',
      'revision': 42,
      'responseAt': '2026-07-18T12:34:56.789Z',
      'events': [
        {
          'type': 'shake_detection',
          'eventId': 'shake-canonical',
          'serialNo': 7,
          'createdAt': '2026-07-18T12:34:30.000Z',
          'updatedAt': '2026-07-18T12:34:55.000Z',
          'expiresAt': '2026-07-18T12:35:35.000Z',
          'level': 'Strong',
          'changeReasons': ['level_up'],
          'mergedEvents': [
            {
              'eventId': 'shake-absorbed',
              'mergedAt': '2026-07-18T12:34:50.000Z',
            },
          ],
          'pointCount': 1,
          'region': {
            'topLeft': {'latitude': 36.0, 'longitude': 139.0},
            'bottomRight': {'latitude': 35.0, 'longitude': 140.0},
          },
          'points': [
            {
              'code': 'POINT-1',
              'name': 'Point 1',
              'region': 'Tokyo',
              'type': 'K-NET',
              'location': {'latitude': 35.5, 'longitude': 139.5},
              'intensity': 3.2,
              'intensityDiff': 0.4,
            },
          ],
          'correlatedEew': {'eventId': 'eew-1', 'score': 0.9},
        },
      ],
    },
  });

  final message = result as WsRealtimeMessage;
  final snapshot = message.data as WsShakeDetectionRealtimeEvent;
  expect(snapshot.revision, 42);
  expect(snapshot.responseAt, DateTime.parse('2026-07-18T12:34:56.789Z'));
  expect(snapshot.events.single.eventId, 'shake-canonical');
  expect(snapshot.events.single.serialNo, 7);
  expect(snapshot.events.single.expiresAt, DateTime.parse('2026-07-18T12:35:35.000Z'));
  expect(snapshot.events.single.mergedEvents.single.eventId, 'shake-absorbed');
  expect(snapshot.events.single.correlatedEew?.eventId, 'eew-1');
});
```

- [ ] **Step 2: Run the parser test and verify it fails**

Run:

```bash
mise exec -- dart test packages/eqmonitor_websocket/test/ws_message_test.dart
```

Expected: FAIL because `shake_detection` is not a known `RealtimeEventEnvelope` union value.

- [ ] **Step 3: Add the complete WebSocket DTO file**

Create `ws_shake_detection_snapshot.dart`:

```dart
import 'package:eqmonitor_websocket/src/ws_shake_observation_point.dart';
import 'package:eqmonitor_websocket/src/ws_shake_payload.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ws_shake_detection_snapshot.freezed.dart';
part 'ws_shake_detection_snapshot.g.dart';

@freezed
abstract class WsShakeMergedEvent with _$WsShakeMergedEvent {
  const factory WsShakeMergedEvent({
    required String eventId,
    required DateTime mergedAt,
  }) = _WsShakeMergedEvent;

  factory WsShakeMergedEvent.fromJson(Map<String, dynamic> json) =>
      _$WsShakeMergedEventFromJson(json);
}

@freezed
abstract class WsShakeCorrelatedEew with _$WsShakeCorrelatedEew {
  const factory WsShakeCorrelatedEew({
    required String eventId,
    required double score,
  }) = _WsShakeCorrelatedEew;

  factory WsShakeCorrelatedEew.fromJson(Map<String, dynamic> json) =>
      _$WsShakeCorrelatedEewFromJson(json);
}

@freezed
abstract class WsShakeDetectionEvent with _$WsShakeDetectionEvent {
  const factory WsShakeDetectionEvent({
    required String type,
    required String eventId,
    required int serialNo,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime expiresAt,
    required String level,
    required List<String> changeReasons,
    required List<WsShakeMergedEvent> mergedEvents,
    required int pointCount,
    required WsShakeRegionPayload region,
    required List<WsShakeObservationPoint> points,
    WsShakeCorrelatedEew? correlatedEew,
  }) = _WsShakeDetectionEvent;

  factory WsShakeDetectionEvent.fromJson(Map<String, dynamic> json) =>
      _$WsShakeDetectionEventFromJson(json);
}
```

Do not model `test.targetDeviceId` in the public app DTO: it is a server-side test-routing field and is not consumed by any app behavior; json_serializable safely ignores extra JSON keys.

- [ ] **Step 4: Replace the realtime union case**

Import the new file, delete the `shake_detected` factory, and add:

```dart
@FreezedUnionValue('shake_detection')
const factory RealtimeEventEnvelope.shakeDetection({
  required int revision,
  required DateTime responseAt,
  @Default([]) List<WsShakeDetectionEvent> events,
}) = WsShakeDetectionRealtimeEvent;
```

Export `ws_shake_detection_snapshot.dart` from `packages/eqmonitor_websocket/lib/eqmonitor_websocket.dart`.

- [ ] **Step 5: Regenerate Freezed/json_serializable code**

Run:

```bash
cd packages/eqmonitor_websocket
mise exec -- dart run build_runner build --delete-conflicting-outputs
```

Expected: command exits 0 and generates the new DTO/union parts.

- [ ] **Step 6: Run package tests and analysis**

Run:

```bash
mise exec -- dart test packages/eqmonitor_websocket/test/ws_message_test.dart
mise exec -- dart analyze packages/eqmonitor_websocket
```

Expected: both commands exit 0.

- [ ] **Step 7: Commit and push the WebSocket contract**

```bash
git add packages/eqmonitor_websocket
git commit -m "feat: 揺れ検知snapshotのWebSocket契約を追加"
git push
```

---

### Task 3: Normalize canonical snapshots into core realtime events

**Files:**
- Create: `app/lib/core/realtime/model/realtime_shake_snapshot.dart`
- Modify: `app/lib/core/realtime/model/realtime_event.dart:1-52`
- Modify: `app/lib/core/realtime/data_source/eqmonitor/eqmonitor_realtime_event_mapper.dart:17-109`
- Regenerate: `app/lib/core/realtime/model/realtime_shake_snapshot.freezed.dart`
- Regenerate: `app/lib/core/realtime/model/realtime_shake_snapshot.g.dart`
- Regenerate: `app/lib/core/realtime/model/realtime_event.freezed.dart`
- Regenerate: `app/lib/core/realtime/model/realtime_event.g.dart`
- Test: `app/test/core/realtime/eqmonitor_realtime_event_mapper_test.dart`

**Interfaces:**
- Consumes: Task 2 `WsShakeDetectionRealtimeEvent`.
- Produces: `RealtimeEvent.shakeSnapshot(data: RealtimeShakeSnapshot, source: RealtimeSource)`.

- [ ] **Step 1: Write the mapper regression test**

Replace the stale `WsMessage.snapshot` test with:

```dart
test('shake_detection をrevision付き完全snapshotへ変換できること', () {
  final result = mapper.map(
    WsMessage.realtime(
      data: RealtimeEventEnvelope.shakeDetection(
        revision: 42,
        responseAt: DateTime.utc(2026, 7, 18, 12, 34, 56),
        events: [
          WsShakeDetectionEvent(
            type: 'shake_detection',
            eventId: 'shake-1',
            serialNo: 3,
            createdAt: DateTime.utc(2026, 7, 18, 12, 34, 30),
            updatedAt: DateTime.utc(2026, 7, 18, 12, 34, 55),
            expiresAt: DateTime.utc(2026, 7, 18, 12, 35, 35),
            level: 'Strong',
            changeReasons: const ['level_up'],
            mergedEvents: const [],
            pointCount: 12,
            region: const WsShakeRegionPayload(
              topLeft: WsShakeLocationPayload(latitude: 36, longitude: 139),
              bottomRight: WsShakeLocationPayload(latitude: 35, longitude: 140),
            ),
            points: const [],
            correlatedEew: const WsShakeCorrelatedEew(
              eventId: 'eew-1',
              score: 0.8,
            ),
          ),
        ],
      ),
    ),
  );

  final event = result.single as RealtimeShakeSnapshotEvent;
  expect(event.data.revision, 42);
  expect(event.data.events.single.serialNo, 3);
  expect(event.data.events.single.correlatedEewEventId, 'eew-1');
  expect(event.data.events.single.minLat, 35);
  expect(event.data.events.single.maxLng, 140);
});
```

Also correct the existing tsunami test to assert `RealtimeTsunamiUpsertEvent`, matching the already implemented mapper behavior, so the focused suite has no unrelated red baseline.

- [ ] **Step 2: Run the mapper test and verify it fails**

Run:

```bash
mise exec -- flutter test app/test/core/realtime/eqmonitor_realtime_event_mapper_test.dart
```

Expected: FAIL because `RealtimeShakeSnapshotEvent` and `RealtimeShakeSnapshot` do not exist.

- [ ] **Step 3: Create the transport-independent core model**

Create `realtime_shake_snapshot.dart`:

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'realtime_shake_snapshot.freezed.dart';
part 'realtime_shake_snapshot.g.dart';

@freezed
abstract class RealtimeShakeEventData with _$RealtimeShakeEventData {
  const factory RealtimeShakeEventData({
    required String eventId,
    required int serialNo,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime expiresAt,
    required String level,
    required int pointCount,
    required double minLat,
    required double maxLat,
    required double minLng,
    required double maxLng,
    required List<String> changeReasons,
    String? correlatedEewEventId,
  }) = _RealtimeShakeEventData;

  factory RealtimeShakeEventData.fromJson(Map<String, dynamic> json) =>
      _$RealtimeShakeEventDataFromJson(json);
}

@freezed
abstract class RealtimeShakeSnapshot with _$RealtimeShakeSnapshot {
  const factory RealtimeShakeSnapshot({
    required int revision,
    required DateTime responseAt,
    required List<RealtimeShakeEventData> events,
  }) = _RealtimeShakeSnapshot;

  factory RealtimeShakeSnapshot.fromJson(Map<String, dynamic> json) =>
      _$RealtimeShakeSnapshotFromJson(json);
}
```

- [ ] **Step 4: Replace the core realtime union case**

In `realtime_event.dart`, replace `shakeDetected` with:

```dart
const factory RealtimeEvent.shakeSnapshot({
  required RealtimeShakeSnapshot data,
  required RealtimeSource source,
}) = RealtimeShakeSnapshotEvent;
```

- [ ] **Step 5: Map the full snapshot in one mapper branch**

Replace the old `WsShakeDetectedRealtimeEvent` branch with:

```dart
WsShakeDetectionRealtimeEvent(
  :final revision,
  :final responseAt,
  :final events,
) =>
  [
    RealtimeEvent.shakeSnapshot(
      data: RealtimeShakeSnapshot(
        revision: revision,
        responseAt: responseAt,
        events: events
            .map(
              (event) => RealtimeShakeEventData(
                eventId: event.eventId,
                serialNo: event.serialNo,
                createdAt: event.createdAt,
                updatedAt: event.updatedAt,
                expiresAt: event.expiresAt,
                level: event.level,
                pointCount: event.pointCount,
                minLat: event.region.bottomRight.latitude,
                maxLat: event.region.topLeft.latitude,
                minLng: event.region.topLeft.longitude,
                maxLng: event.region.bottomRight.longitude,
                changeReasons: event.changeReasons,
                correlatedEewEventId: event.correlatedEew?.eventId,
              ),
            )
            .toList(growable: false),
      ),
      source: RealtimeSource.eqmonitor,
    ),
  ],
```

Keep `WsSnapshotMessage() => []`: PR #869 explicitly says connection-time snapshot messages are not sent; the shake snapshot arrives inside `realtime`.

- [ ] **Step 6: Regenerate app models**

Run:

```bash
cd app
mise exec -- dart run build_runner build --delete-conflicting-outputs
```

Expected: command exits 0.

- [ ] **Step 7: Run focused tests and analysis**

Run:

```bash
mise exec -- flutter test app/test/core/realtime/eqmonitor_realtime_event_mapper_test.dart
mise exec -- dart analyze app/lib/core/realtime
```

Expected: both commands exit 0.

- [ ] **Step 8: Commit and push core normalization**

```bash
git add app/lib/core/realtime app/test/core/realtime/eqmonitor_realtime_event_mapper_test.dart
git commit -m "refactor: 揺れ検知を完全snapshotイベントへ正規化"
git push
```

---

### Task 4: Add strict domain models and the active-snapshot repository

**Files:**
- Create: `app/lib/feature/shake_detection/data/model/shake_detection_snapshot.dart`
- Create: `app/lib/feature/shake_detection/data/model/shake_detection_level_parser.dart`
- Create: `app/lib/feature/shake_detection/data/repository/shake_detection_repository.dart`
- Modify: `app/lib/feature/shake_detection/data/model/shake_detection_event.dart:1-23`
- Regenerate: `app/lib/feature/shake_detection/data/model/shake_detection_snapshot.freezed.dart`
- Regenerate: `app/lib/feature/shake_detection/data/repository/shake_detection_repository.g.dart`
- Modify test helpers in: `app/test/feature/shake_detection/data/shake_detection_event_test.dart`
- Test: `app/test/feature/shake_detection/data/shake_detection_level_parser_test.dart`
- Test: `app/test/feature/shake_detection/data/shake_detection_repository_test.dart`

**Interfaces:**
- Consumes: Task 1 `ShakeDetectionApiClient.getV2ShakeDetectionActive()`.
- Produces: `ShakeDetectionSnapshot`, `ShakeDetectionEvent`, `String.toShakeDetectionLevel()`, abstract `ShakeDetectionRepository.fetchActive()`, and `ApiShakeDetectionRepository`.

- [ ] **Step 1: Write strict level parser tests**

Create `shake_detection_level_parser_test.dart`:

```dart
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level_parser.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('5段階のcanonical levelを厳密に変換すること', () {
    expect('Weaker'.toShakeDetectionLevel(), ShakeDetectionLevel.weaker);
    expect('Weak'.toShakeDetectionLevel(), ShakeDetectionLevel.weak);
    expect('Medium'.toShakeDetectionLevel(), ShakeDetectionLevel.medium);
    expect('Strong'.toShakeDetectionLevel(), ShakeDetectionLevel.strong);
    expect('Stronger'.toShakeDetectionLevel(), ShakeDetectionLevel.stronger);
  });

  test('未知levelを固定値へフォールバックしないこと', () {
    expect(
      () => 'Unknown'.toShakeDetectionLevel(),
      throwsA(isA<FormatException>()),
    );
  });
}
```

- [ ] **Step 2: Run the parser test and verify it fails**

Run:

```bash
mise exec -- flutter test app/test/feature/shake_detection/data/shake_detection_level_parser_test.dart
```

Expected: FAIL because the extension does not exist.

- [ ] **Step 3: Implement strict parsing**

Create `shake_detection_level_parser.dart`:

```dart
import 'package:eqmonitor_api/eqmonitor_api.dart';

extension ShakeDetectionLevelParser on String {
  ShakeDetectionLevel toShakeDetectionLevel() => switch (this) {
    'Weaker' => ShakeDetectionLevel.weaker,
    'Weak' => ShakeDetectionLevel.weak,
    'Medium' => ShakeDetectionLevel.medium,
    'Strong' => ShakeDetectionLevel.strong,
    'Stronger' => ShakeDetectionLevel.stronger,
    final value => throw FormatException(
      'Unknown shake detection level: $value',
    ),
  };
}
```

- [ ] **Step 4: Expand the domain event and add the snapshot model**

Replace the event factory fields with:

```dart
const factory ShakeDetectionEvent({
  required String eventId,
  required int serialNo,
  required DateTime createdAt,
  required DateTime updatedAt,
  required DateTime expiresAt,
  required ShakeDetectionLevel level,
  required int pointCount,
  required double minLat,
  required double maxLat,
  required double minLng,
  required double maxLng,
  required List<String> changeReasons,
  String? correlatedEewEventId,
}) = _ShakeDetectionEvent;
```

Remove `isReplay` and `mergedEewEventId`; neither exists in the new canonical contract.

Create `shake_detection_snapshot.dart`:

```dart
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shake_detection_snapshot.freezed.dart';

@Freezed()
abstract class ShakeDetectionSnapshot with _$ShakeDetectionSnapshot {
  const factory ShakeDetectionSnapshot({
    required int revision,
    required DateTime responseAt,
    required List<ShakeDetectionEvent> events,
  }) = _ShakeDetectionSnapshot;
}
```

- [ ] **Step 5: Write repository success and failure tests**

Create the test with a deterministic Dio adapter. Add imports for `dart:convert`, `dart:typed_data`, Dio, `Result`, the shake detection model/repository, `eqmonitor_api as api`, and `flutter_test`. The adapter must be:

```dart
final class _ShakeDetectionAdapter implements HttpClientAdapter {
  _ShakeDetectionAdapter({required this.statusCode});

  final int statusCode;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    expect(options.path, '/v2/shake-detection/active');
    final body = statusCode == 200
        ? _activeSnapshotBody
        : jsonEncode({
            'code': 'SERVICE_UNAVAILABLE',
            'message': 'Shake detection state is not available.',
          });
    return ResponseBody.fromString(
      body,
      statusCode,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
```

Define `_activeSnapshotBody` with this exact body:

```dart
final _activeSnapshotBody = jsonEncode({
  'type': 'shake_detection',
  'revision': 42,
  'responseAt': '2026-07-18T12:34:56.789Z',
  'events': [
    {
      'type': 'shake_detection',
      'eventId': 'shake-1',
      'serialNo': 3,
      'createdAt': '2026-07-18T12:34:30.000Z',
      'updatedAt': '2026-07-18T12:34:55.000Z',
      'expiresAt': '2026-07-18T12:35:35.000Z',
      'level': 'Strong',
      'changeReasons': ['level_up'],
      'mergedEvents': [],
      'pointCount': 1,
      'region': {
        'topLeft': {'latitude': 36.0, 'longitude': 139.0},
        'bottomRight': {'latitude': 35.0, 'longitude': 140.0},
      },
      'points': [],
      'correlatedEew': {'eventId': 'eew-1', 'score': 0.8},
    },
  ],
})
```

Add this repository factory and the two tests:

```dart
ApiShakeDetectionRepository repositoryFor(int statusCode) {
  final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
    ..httpClientAdapter = _ShakeDetectionAdapter(statusCode: statusCode);
  return ApiShakeDetectionRepository(
    client: api.ShakeDetectionApiClient(dio),
  );
}

void main() {
  test('active snapshotをdomain modelへ変換すること', () async {
    final result = await repositoryFor(200).fetchActive();
    final snapshot = (result as Success<
      ShakeDetectionSnapshot,
      ShakeDetectionApiException
    >).value;

    expect(snapshot.revision, 42);
    expect(snapshot.events.single.level, api.ShakeDetectionLevel.strong);
    expect(snapshot.events.single.correlatedEewEventId, 'eew-1');
    expect(
      snapshot.events.single.expiresAt,
      DateTime.parse('2026-07-18T12:35:35.000Z'),
    );
  });

  test('503をtyped failureとして返すこと', () async {
    final result = await repositoryFor(503).fetchActive();
    final failure = result as Failure<
      ShakeDetectionSnapshot,
      ShakeDetectionApiException
    >;

    expect(failure.exception.statusCode, 503);
  });
}
```

- [ ] **Step 6: Run repository tests and verify they fail**

Run:

```bash
mise exec -- flutter test app/test/feature/shake_detection/data/shake_detection_repository_test.dart
```

Expected: FAIL because `ShakeDetectionRepository` does not exist.

- [ ] **Step 7: Implement the repository and typed exception**

Create `shake_detection_repository.dart` with this public interface and conversion:

```dart
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level_parser.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_snapshot.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_repository.g.dart';

final class ShakeDetectionApiException implements Exception {
  const ShakeDetectionApiException({
    required this.message,
    this.statusCode,
  });

  final String message;
  final int? statusCode;
}

@Riverpod(keepAlive: true)
Future<ShakeDetectionRepository> shakeDetectionRepository(Ref ref) async {
  final client = await ref.watch(apiClientProvider.future);
  return ApiShakeDetectionRepository(client: client.shakeDetection);
}

abstract interface class ShakeDetectionRepository {
  Future<Result<ShakeDetectionSnapshot, ShakeDetectionApiException>>
  fetchActive();
}

final class ApiShakeDetectionRepository implements ShakeDetectionRepository {
  const ApiShakeDetectionRepository({
    required api.ShakeDetectionApiClient client,
  })
    : _client = client;

  final api.ShakeDetectionApiClient _client;

  Future<Result<ShakeDetectionSnapshot, ShakeDetectionApiException>>
  fetchActive() async {
    try {
      final data = (await _client.getV2ShakeDetectionActive()).data;
      return Success(
        ShakeDetectionSnapshot(
          revision: data.revision,
          responseAt: data.responseAt,
          events: data.events
              .map(
                (event) => ShakeDetectionEvent(
                  eventId: event.eventId,
                  serialNo: event.serialNo,
                  createdAt: event.createdAt,
                  updatedAt: event.updatedAt,
                  expiresAt: event.expiresAt,
                  level: event.level.json.toShakeDetectionLevel(),
                  pointCount: event.pointCount,
                  minLat: event.region.bottomRight.latitude,
                  maxLat: event.region.topLeft.latitude,
                  minLng: event.region.topLeft.longitude,
                  maxLng: event.region.bottomRight.longitude,
                  changeReasons: event.changeReasons
                      .map((reason) => reason.json)
                      .toList(growable: false),
                  correlatedEewEventId: event.correlatedEew?.eventId,
                ),
              )
              .toList(growable: false),
        ),
      );
    } on DioException catch (error) {
      return Failure(
        ShakeDetectionApiException(
          message: error.message ?? 'Shake detection API request failed',
          statusCode: error.response?.statusCode,
        ),
      );
    } on FormatException catch (error) {
      return Failure(ShakeDetectionApiException(message: error.message));
    }
  }
}
```

The generated enum extension property is `json`, matching the existing generated `ShakeDetectionLevel`. Do not call `.name`, because backend wire values are PascalCase / snake_case rather than Dart member names.

- [ ] **Step 8: Regenerate and update the domain model test**

Run:

```bash
cd app
mise exec -- dart run build_runner build --delete-conflicting-outputs
```

In `shake_detection_event_test.dart`, replace repeated constructors with this helper:

```dart
final _createdAt = DateTime.utc(2026, 7, 19, 12);

ShakeDetectionEvent event({String? correlatedEewEventId}) =>
    ShakeDetectionEvent(
      eventId: 'e1',
      serialNo: 1,
      createdAt: _createdAt,
      updatedAt: _createdAt,
      expiresAt: _createdAt.add(const Duration(minutes: 1)),
      level: ShakeDetectionLevel.medium,
      pointCount: 3,
      minLat: 34,
      maxLat: 36,
      minLng: 138,
      maxLng: 140,
      changeReasons: const ['new_event'],
      correlatedEewEventId: correlatedEewEventId,
    );
```

Replace the old replay/merge tests with:

```dart
test('同一フィールドの2インスタンスは等価であること', () {
  expect(event(), event());
  expect(event().hashCode, event().hashCode);
});

test('copyWithでcorrelatedEewEventIdを設定できること', () {
  final correlated = event().copyWith(correlatedEewEventId: 'EEW-1');
  expect(correlated.correlatedEewEventId, 'EEW-1');
  expect(correlated.eventId, 'e1');
  expect(correlated, isNot(event()));
});
```

- [ ] **Step 9: Run model/repository tests and analysis**

Run:

```bash
mise exec -- flutter test \
  app/test/feature/shake_detection/data/shake_detection_level_parser_test.dart \
  app/test/feature/shake_detection/data/shake_detection_repository_test.dart \
  app/test/feature/shake_detection/data/shake_detection_event_test.dart
mise exec -- dart analyze app/lib/feature/shake_detection/data/model app/lib/feature/shake_detection/data/repository
```

Expected: both commands exit 0.

- [ ] **Step 10: Commit and push the domain/repository layer**

```bash
git add app/lib/feature/shake_detection/data app/test/feature/shake_detection/data
git commit -m "feat: 揺れ検知active snapshotリポジトリを追加"
git push
```

---

### Task 5: Reduce REST and WebSocket snapshots by revision

**Files:**
- Create: `app/lib/feature/shake_detection/data/notifier/shake_detection_snapshot_reducer.dart`
- Modify: `app/lib/feature/shake_detection/data/provider/shake_detection_provider.dart:1-80`
- Regenerate: `app/lib/feature/shake_detection/data/notifier/shake_detection_snapshot_reducer.g.dart`
- Test: `app/test/feature/shake_detection/data/shake_detection_snapshot_reducer_test.dart`
- Test: `app/test/feature/shake_detection/data/shake_detection_provider_test.dart`

**Interfaces:**
- Consumes: Task 3 `RealtimeShakeSnapshotEvent`; Task 4 `ShakeDetectionRepository.fetchActive()` and `ShakeDetectionSnapshot`.
- Produces: `ShakeDetectionSnapshotReducer.selectNewer({current, incoming})`; `shakeDetectionProvider` remains `List<ShakeDetectionEvent>` for existing UI consumers.

- [ ] **Step 1: Write reducer ordering tests**

Create `shake_detection_snapshot_reducer_test.dart` with one helper and four assertions:

```dart
ShakeDetectionSnapshot snapshot(int revision, List<ShakeDetectionEvent> events) =>
    ShakeDetectionSnapshot(
      revision: revision,
      responseAt: DateTime.utc(2026, 7, 19),
      events: events,
    );

void main() {
  const reducer = ShakeDetectionSnapshotReducer();

  test('currentがnullならrevision 0の空snapshotも採用すること', () {
    final incoming = snapshot(0, []);
    expect(reducer.selectNewer(current: null, incoming: incoming), incoming);
  });

  test('大きいrevisionだけを採用すること', () {
    final current = snapshot(10, []);
    final incoming = snapshot(11, []);
    expect(reducer.selectNewer(current: current, incoming: incoming), incoming);
  });

  test('同一revisionを冪等に無視すること', () {
    final current = snapshot(10, []);
    expect(reducer.selectNewer(current: current, incoming: snapshot(10, [])), current);
  });

  test('古いrevisionで巻き戻さないこと', () {
    final current = snapshot(10, []);
    expect(reducer.selectNewer(current: current, incoming: snapshot(9, [])), current);
  });
}
```

- [ ] **Step 2: Run reducer tests and verify they fail**

Run:

```bash
mise exec -- flutter test app/test/feature/shake_detection/data/shake_detection_snapshot_reducer_test.dart
```

Expected: FAIL because `ShakeDetectionSnapshotReducer` does not exist.

- [ ] **Step 3: Implement the pure reducer and provider**

Create:

```dart
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_snapshot.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_snapshot_reducer.g.dart';

@Riverpod(keepAlive: true)
ShakeDetectionSnapshotReducer shakeDetectionSnapshotReducer(Ref ref) =>
    const ShakeDetectionSnapshotReducer();

class ShakeDetectionSnapshotReducer {
  const ShakeDetectionSnapshotReducer();

  ShakeDetectionSnapshot selectNewer({
    required ShakeDetectionSnapshot? current,
    required ShakeDetectionSnapshot incoming,
  }) {
    if (current == null || incoming.revision > current.revision) {
      return incoming;
    }
    return current;
  }
}
```

- [ ] **Step 4: Write provider race and replacement tests**

Replace old upsert/TTL tests. Keep the existing `_StubRealtimeEvents`, and add these complete helpers before `main()`:

```dart
final _baseTime = DateTime.utc(2026, 7, 19, 12);

ShakeDetectionEvent domainEvent(String eventId) => ShakeDetectionEvent(
  eventId: eventId,
  serialNo: 1,
  createdAt: _baseTime,
  updatedAt: _baseTime,
  expiresAt: _baseTime.add(const Duration(minutes: 1)),
  level: api.ShakeDetectionLevel.medium,
  pointCount: 1,
  minLat: 35,
  maxLat: 36,
  minLng: 139,
  maxLng: 140,
  changeReasons: const ['new_event'],
);

ShakeDetectionSnapshot domainSnapshot({
  required int revision,
  required List<String> eventIds,
}) => ShakeDetectionSnapshot(
  revision: revision,
  responseAt: _baseTime,
  events: eventIds.map(domainEvent).toList(growable: false),
);

RealtimeShakeSnapshot realtimeSnapshot({
  required int revision,
  required List<String> eventIds,
}) => RealtimeShakeSnapshot(
  revision: revision,
  responseAt: _baseTime,
  events: eventIds
      .map(
        (eventId) => RealtimeShakeEventData(
          eventId: eventId,
          serialNo: 1,
          createdAt: _baseTime,
          updatedAt: _baseTime,
          expiresAt: _baseTime.add(const Duration(minutes: 1)),
          level: 'Medium',
          pointCount: 1,
          minLat: 35,
          maxLat: 36,
          minLng: 139,
          maxLng: 140,
          changeReasons: const ['new_event'],
        ),
      )
      .toList(growable: false),
);

RealtimeEvent shakeRealtime({
  required int revision,
  required List<String> eventIds,
}) => RealtimeEvent.shakeSnapshot(
  data: realtimeSnapshot(revision: revision, eventIds: eventIds),
  source: RealtimeSource.eqmonitor,
);

final class _StubShakeDetectionRepository
    implements ShakeDetectionRepository {
  _StubShakeDetectionRepository(this.result);

  final Future<Result<ShakeDetectionSnapshot, ShakeDetectionApiException>>
  result;

  @override
  Future<Result<ShakeDetectionSnapshot, ShakeDetectionApiException>>
  fetchActive() => result;
}

final class _StubEqMonitorWsStatus extends EqMonitorWsStatus {
  @override
  EqMonitorWsStatusState build() =>
      const EqMonitorWsStatusState(phase: WsPhase.connected);
}
```

Inside the test group, initialize the stream, repository completer, provider overrides, and listener for each test:

```dart
late StreamController<RealtimeEvent> controller;
late Completer<Result<ShakeDetectionSnapshot, ShakeDetectionApiException>>
    restCompleter;
late ProviderContainer container;
late ProviderSubscription<List<ShakeDetectionEvent>> subscription;

setUp(() async {
  controller = StreamController<RealtimeEvent>.broadcast(sync: true);
  restCompleter = Completer();
  container = ProviderContainer(
    overrides: [
      realtimeEventsProvider.overrideWith(() => _StubRealtimeEvents(controller.stream)),
      shakeDetectionRepositoryProvider.overrideWith(
        (ref) async => _StubShakeDetectionRepository(restCompleter.future),
      ),
      eqMonitorWsStatusProvider.overrideWith(_StubEqMonitorWsStatus.new),
    ],
  );
  subscription = container.listen(shakeDetectionProvider, (_, _) {});
  await pumpEventQueue();
});

tearDown(() async {
  subscription.close();
  container.dispose();
  await controller.close();
});
```

Add these scenarios:

```dart
test('ready後のREST中に新しいWebSocket revisionが来ても巻き戻さないこと', () async {
  controller.add(const RealtimeEvent.ready(source: RealtimeSource.eqmonitor));
  await pumpEventQueue();

  controller.add(
    RealtimeEvent.shakeSnapshot(
      data: realtimeSnapshot(revision: 12, eventIds: ['ws-new']),
      source: RealtimeSource.eqmonitor,
    ),
  );
  await pumpEventQueue();

  restCompleter.complete(Success(domainSnapshot(revision: 11, eventIds: ['rest-old'])));
  await pumpEventQueue();

  expect(subscription.read().map((event) => event.eventId), ['ws-new']);
});

test('新しいsnapshotのevents全体で置換すること', () async {
  controller.add(shakeRealtime(revision: 1, eventIds: ['a', 'b']));
  controller.add(shakeRealtime(revision: 2, eventIds: ['b', 'c']));
  await pumpEventQueue();
  expect(subscription.read().map((event) => event.eventId), ['b', 'c']);
});

test('空snapshotでactive eventを全件削除すること', () async {
  controller.add(shakeRealtime(revision: 1, eventIds: ['a']));
  controller.add(shakeRealtime(revision: 2, eventIds: []));
  await pumpEventQueue();
  expect(subscription.read(), isEmpty);
});

test('同一・古いrevisionを無視すること', () async {
  controller.add(shakeRealtime(revision: 5, eventIds: ['current']));
  controller.add(shakeRealtime(revision: 5, eventIds: ['same-revision']));
  controller.add(shakeRealtime(revision: 4, eventIds: ['older']));
  await pumpEventQueue();
  expect(subscription.read().single.eventId, 'current');
});

test('REST 503で現在stateを固定値へ置換しないこと', () async {
  controller.add(shakeRealtime(revision: 5, eventIds: ['current']));
  controller.add(const RealtimeEvent.ready(source: RealtimeSource.eqmonitor));
  restCompleter.complete(
    const Failure(
      ShakeDetectionApiException(
        message: 'Shake detection state is not available.',
        statusCode: 503,
      ),
    ),
  );
  await pumpEventQueue();

  expect(subscription.read().single.eventId, 'current');
});

test('タイムシフト復帰時にready済み接続のREST snapshotを再同期すること', () async {
  controller.add(const RealtimeEvent.ready(source: RealtimeSource.eqmonitor));
  await pumpEventQueue();

  container
      .read(appClockProvider.notifier)
      .enterTimeShift(const Duration(minutes: -3));
  restCompleter.complete(
    Success(domainSnapshot(revision: 7, eventIds: ['restored'])),
  );
  await pumpEventQueue();
  expect(subscription.read(), isEmpty);

  container.read(appClockProvider.notifier).returnToRealtime();
  await pumpEventQueue();
  expect(subscription.read().single.eventId, 'restored');
});
```

- [ ] **Step 5: Run provider tests and verify they fail**

Run:

```bash
mise exec -- flutter test app/test/feature/shake_detection/data/shake_detection_provider_test.dart
```

Expected: FAIL because the provider still consumes `RealtimeShakeDetectedEvent` and upserts by eventId.

- [ ] **Step 6: Implement snapshot application and ready-triggered REST sync**

Add imports for `result.dart`, `talker.dart`, `eqmonitor_ws_status_notifier.dart`, `eqmonitor_ws_status_state.dart`, `realtime_shake_snapshot.dart`, the new domain model/parser/repository/reducer, and keep the existing clock/realtime imports. Refactor the notifier to keep a private nullable snapshot and expose its event list:

```dart
@Riverpod(keepAlive: true)
class ShakeDetection extends _$ShakeDetection {
  ShakeDetectionSnapshot? _snapshot;
  bool _readySeen = false;

  @override
  List<ShakeDetectionEvent> build() {
    ref.listen(
      eqMonitorWsStatusProvider.select((status) => status.phase),
      (_, phase) {
        if (phase != WsPhase.connected) {
          _readySeen = false;
        }
      },
    );

    ref.listen(isRealtimeModeProvider, (previous, next) async {
      if (next && previous == false && _readySeen) {
        await synchronizeFromRest();
      }
    });

    ref.listen(realtimeEventsProvider, (_, next) async {
      final event = next.value;
      if (event == null) {
        return;
      }
      switch (event) {
        case RealtimeReadyEvent():
          _readySeen = true;
          if (ref.read(isRealtimeModeProvider)) {
            await synchronizeFromRest();
          }
        case RealtimeShakeSnapshotEvent(:final data):
          if (!ref.read(isRealtimeModeProvider)) {
            return;
          }
          applySnapshot(
            ShakeDetectionSnapshot(
              revision: data.revision,
              responseAt: data.responseAt,
              events: data.events
                  .map(
                    (event) => ShakeDetectionEvent(
                      eventId: event.eventId,
                      serialNo: event.serialNo,
                      createdAt: event.createdAt,
                      updatedAt: event.updatedAt,
                      expiresAt: event.expiresAt,
                      level: event.level.toShakeDetectionLevel(),
                      pointCount: event.pointCount,
                      minLat: event.minLat,
                      maxLat: event.maxLat,
                      minLng: event.minLng,
                      maxLng: event.maxLng,
                      changeReasons: event.changeReasons,
                      correlatedEewEventId: event.correlatedEewEventId,
                    ),
                  )
                  .toList(growable: false),
            ),
          );
        default:
          return;
      }
    });

    if (!ref.watch(isRealtimeModeProvider)) {
      _snapshot = null;
      return [];
    }
    return _snapshot?.events ?? [];
  }

  Future<void> synchronizeFromRest() async {
    final repository = await ref.read(shakeDetectionRepositoryProvider.future);
    final result = await repository.fetchActive();
    if (!ref.read(isRealtimeModeProvider)) {
      return;
    }
    switch (result) {
      case Success(:final value):
        applySnapshot(value);
      case Failure(:final exception, :final stackTrace):
        talker.error(
          'Failed to synchronize active shake detection snapshot',
          exception,
          stackTrace,
        );
    }
  }

  void applySnapshot(ShakeDetectionSnapshot incoming) {
    final reducer = ref.read(shakeDetectionSnapshotReducerProvider);
    final selected = reducer.selectNewer(
      current: _snapshot,
      incoming: incoming,
    );
    if (identical(selected, _snapshot)) {
      return;
    }
    _snapshot = selected;
    state = selected.events;
  }
}
```

Immediate application of WebSocket snapshots while REST is in flight is the buffer: the later REST response passes through the same reducer and cannot overwrite a newer revision.

- [ ] **Step 7: Regenerate and run reducer/provider/history tests**

Before running generation, update the `_ev` helper in `shake_detection_history_test.dart` to the canonical constructor:

```dart
final _baseTime = DateTime.utc(2026, 7, 19, 12);

ShakeDetectionEvent _ev(
  String eventId, {
  api.ShakeDetectionLevel level = api.ShakeDetectionLevel.weak,
  int pointCount = 3,
}) => ShakeDetectionEvent(
  eventId: eventId,
  serialNo: 1,
  createdAt: _baseTime,
  updatedAt: _baseTime,
  expiresAt: _baseTime.add(const Duration(minutes: 1)),
  level: level,
  pointCount: pointCount,
  minLat: 34,
  maxLat: 36,
  minLng: 138,
  maxLng: 140,
  changeReasons: const ['new_event'],
);
```

Run:

```bash
cd app
mise exec -- dart run build_runner build --delete-conflicting-outputs
cd ..
mise exec -- flutter test \
  app/test/feature/shake_detection/data/shake_detection_snapshot_reducer_test.dart \
  app/test/feature/shake_detection/data/shake_detection_provider_test.dart \
  app/test/feature/shake_detection/data/shake_detection_history_test.dart
```

Expected: all tests pass. History retains previously observed events even when the active snapshot later shrinks.

- [ ] **Step 8: Commit and push revision-based state synchronization**

```bash
git add app/lib/feature/shake_detection/data app/test/feature/shake_detection/data
git commit -m "feat: RESTとWebSocketの揺れ検知snapshotを同期"
git push
```

---

### Task 6: Use server correlation and expiresAt for visibility

**Files:**
- Modify: `app/lib/feature/shake_detection/data/provider/shake_detection_merge_provider.dart:1-99`
- Delete: `app/test/feature/shake_detection/data/shake_detection_merge_test.dart`
- Modify: `app/test/feature/shake_detection/data/shake_detection_visible_test.dart`
- Modify: `app/test/feature/shake_detection/data/shake_detection_event_test.dart`
- Modify: `app/lib/feature/shake_detection/ui/shake_detection_history_page.dart:120-145`
- Modify: `app/lib/feature/shake_detection/ui/shake_detection_history_details_page.dart:300-315`
- Modify: `app/lib/feature/settings/children/config/debug/shake_detection/debug_shake_detection_card_page.dart:17-38`
- Modify: `app/lib/feature/settings/children/config/debug/shake_detection/debug_shake_detection_card_page.dart:174-190`

**Interfaces:**
- Consumes: Task 4 `ShakeDetectionEvent.correlatedEewEventId` and `.expiresAt`.
- Produces: `shakeDetectionVisibleProvider` containing only uncorrelated and not-yet-expired canonical events.

- [ ] **Step 1: Replace client-correlation tests with canonical visibility tests**

Rewrite `shake_detection_visible_test.dart` to override `shakeDetectionProvider` directly. Add these helpers:

```dart
final _now = DateTime.utc(2026, 7, 19, 12);

ShakeDetectionEvent event(
  String eventId, {
  DateTime? createdAt,
  required DateTime expiresAt,
  String? correlatedEewEventId,
}) => ShakeDetectionEvent(
  eventId: eventId,
  serialNo: 1,
  createdAt: createdAt ?? _now,
  updatedAt: _now,
  expiresAt: expiresAt,
  level: ShakeDetectionLevel.medium,
  pointCount: 1,
  minLat: 35,
  maxLat: 36,
  minLng: 139,
  maxLng: 140,
  changeReasons: const ['new_event'],
  correlatedEewEventId: correlatedEewEventId,
);

ProviderContainer containerWith(List<ShakeDetectionEvent> events) {
  final container = ProviderContainer(
    overrides: [shakeDetectionProvider.overrideWithValue(events)],
  );
  addTearDown(container.dispose);
  return container;
}
```

Then assert:

```dart
test('server correlatedEewがあるeventを表示しないこと', () {
  withClock(Clock.fixed(_now), () {
    final container = containerWith([
      event('visible', expiresAt: _now.add(const Duration(seconds: 1))),
      event(
        'correlated',
        expiresAt: _now.add(const Duration(seconds: 1)),
        correlatedEewEventId: 'eew-1',
      ),
    ]);
    expect(
      container.read(shakeDetectionVisibleProvider).map((event) => event.eventId),
      ['visible'],
    );
  });
});

test('expiresAt以前だけを表示すること', () {
  withClock(Clock.fixed(_now), () {
    final container = containerWith([
      event('expired', expiresAt: _now),
      event('active', expiresAt: _now.add(const Duration(milliseconds: 1))),
    ]);
    expect(
      container.read(shakeDetectionVisibleProvider).map((event) => event.eventId),
      ['active'],
    );
  });
});

test('createdAtから3分経過していてもexpiresAtが未来なら表示すること', () {
  withClock(Clock.fixed(_now), () {
    final container = containerWith([
      event(
        'server-active',
        createdAt: _now.subtract(const Duration(minutes: 4)),
        expiresAt: _now.add(const Duration(seconds: 1)),
      ),
    ]);
    expect(container.read(shakeDetectionVisibleProvider), hasLength(1));
  });
});
```

- [ ] **Step 2: Run visibility tests and verify they fail**

Run:

```bash
mise exec -- flutter test app/test/feature/shake_detection/data/shake_detection_visible_test.dart
```

Expected: FAIL because the implementation still computes correlation from EEW/travel time and uses a fixed 3-minute TTL.

- [ ] **Step 3: Replace the merge provider with a single canonical computed provider**

Delete all imports and code related to `travelTimeDepthMapProvider`, `eewAliveTelegramProvider`, `latlong2`, `_findMergedEew`, and `_shakeDisplayTtl`. Keep the existing provider name used by UI, with this implementation:

```dart
import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/time_ticker.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_merge_provider.g.dart';

@Riverpod(keepAlive: true)
List<ShakeDetectionEvent> shakeDetectionVisible(Ref ref) {
  final tickerTime = ref.watch(timeTickerProvider());
  final now = (tickerTime.value ?? ref.read(appClockProvider.notifier).now())
      .toUtc();

  return ref
      .watch(shakeDetectionProvider)
      .where(
        (event) =>
            event.correlatedEewEventId == null &&
            event.expiresAt.toUtc().isAfter(now),
      )
      .toList(growable: false);
}
```

Do not keep `shakeDetectionMergedProvider`: there is no client-side merge phase after PR #869.

- [ ] **Step 4: Remove replay-only UI and rename correlation labels**

The canonical source contract has no `isReplay`, so remove both replay-only tag blocks from `shake_detection_history_page.dart` and `shake_detection_history_details_page.dart`.

In the history list, replace the EEW chip branch with:

```dart
if (event.correlatedEewEventId != null) ...[
  const SizedBox(width: 6),
  _TagChip(
    label: 'EEW相関済',
    color: designSystem.colorTheme.secondaryContainer,
  ),
],
```

In the detail page, bind the nullable ID through pattern matching so no `!` is needed:

```dart
if (event.correlatedEewEventId case final correlatedEewEventId?)
  _InfoRow(
    label: '相関EEW',
    value: correlatedEewEventId,
    mono: true,
    designSystem: designSystem,
  ),
```

Update both debug-page sample constructors with canonical metadata. For the interactive `buildEvent()` constructor use:

```dart
serialNo: 1,
createdAt: createdAt.value,
updatedAt: createdAt.value,
expiresAt: createdAt.value.add(const Duration(minutes: 1)),
level: level.value,
pointCount: 42,
minLat: minLat.value,
maxLat: maxLat.value,
minLng: minLng.value,
maxLng: maxLng.value,
changeReasons: const ['new_event'],
```

Replace `_kSampleEvents` with:

```dart
final List<ShakeDetectionEvent> _kSampleEvents = ShakeDetectionLevel.values
    .map((level) {
      final createdAt = DateTime(2024, 1, 1, 12);
      return ShakeDetectionEvent(
        eventId: 'sample-${level.name}',
        serialNo: 1,
        createdAt: createdAt,
        updatedAt: createdAt,
        expiresAt: createdAt.add(const Duration(minutes: 1)),
        level: level,
        pointCount: 30,
        minLat: 38.9,
        maxLat: 40.5,
        minLng: 140.5,
        maxLng: 141.8,
        changeReasons: const ['new_event'],
      );
    })
    .toList();
```

- [ ] **Step 5: Delete obsolete client-correlation tests and regenerate**

Delete `shake_detection_merge_test.dart`; its travel-time matching behavior is now owned and tested by backend PR #869. Then run:

```bash
cd app
mise exec -- dart run build_runner build --delete-conflicting-outputs
```

Expected: generated provider no longer depends on travel-time or EEW providers.

- [ ] **Step 6: Run all shake detection tests**

Run:

```bash
mise exec -- flutter test app/test/feature/shake_detection
mise exec -- dart analyze app/lib/feature/shake_detection
```

Expected: both commands exit 0.

- [ ] **Step 7: Commit and push canonical visibility behavior**

```bash
git add app/lib/feature/shake_detection app/test/feature/shake_detection
git commit -m "fix: 揺れ検知表示をサーバー相関と期限に統一"
git push
```

---

### Task 7: Document the synchronization rule and run final verification

**Files:**
- Create: `docs/knowledge/20260719_shake_detection_snapshot_sync.md`
- Verify: all files changed in Tasks 1-6

**Interfaces:**
- Consumes: all prior tasks.
- Produces: durable operational rule and a verified PR-ready branch.

- [ ] **Step 1: Create the knowledge document**

Create:

````markdown
# 揺れ検知 canonical snapshot 同期

## 契約

- WebSocket の揺れ検知は `type: shake_detection` の完全 snapshot。
- `events` は upsert 差分ではなく、その revision 時点の active event 全件。
- `revision` が現在値より大きい場合だけ一覧全体を置換する。
- 同一 revision は無視し、小さい revision で巻き戻さない。
- 空の `events` は active event 全削除として適用する。

## 接続・再接続

1. WebSocket の `ready` を待つ。
2. `GET /v2/shake-detection/active` を取得する。
3. REST 取得中も WebSocket snapshot を受理する。
4. 両経路を同じ revision reducer に渡し、最大 revision を採用する。

REST は `Cache-Control: public, max-age=1, s-maxage=1` のため、WebSocket の方が新しい場合がある。REST の完了順で state を上書きしてはいけない。

## 表示判定

- 有効期限は event の `expiresAt` を使う。`createdAt + 固定TTL` を作らない。
- EEW 相関は `correlatedEew.eventId` を使う。アプリで走時表相関を再実装しない。
- 未知 level を弱い値へフォールバックせず、契約違反として記録する。

## 検証コマンド

```bash
mise exec -- dart test packages/eqmonitor_websocket/test
mise exec -- flutter test app/test/core/realtime
mise exec -- flutter test app/test/feature/shake_detection
mise exec -- dart analyze packages/eqmonitor_websocket packages/eqmonitor_api app/lib/core/realtime app/lib/feature/shake_detection
git --no-pager diff --check
```
````

- [ ] **Step 2: Run formatters**

Run:

```bash
mise exec -- dart format packages/eqmonitor_websocket/lib packages/eqmonitor_websocket/test app/lib/core/realtime app/lib/feature/shake_detection app/test/core/realtime app/test/feature/shake_detection
```

Expected: formatter exits 0.

- [ ] **Step 3: Run focused package and app tests**

Run:

```bash
mise exec -- dart test packages/eqmonitor_websocket/test
mise exec -- dart test packages/eqmonitor_api/test
mise exec -- flutter test app/test/core/realtime
mise exec -- flutter test app/test/feature/shake_detection
```

Expected: all four commands exit 0.

- [ ] **Step 4: Run focused analysis and generated-diff checks**

Run:

```bash
mise exec -- dart analyze packages/eqmonitor_websocket packages/eqmonitor_api app/lib/core/realtime app/lib/feature/shake_detection
git --no-pager diff --check
git --no-pager status --short
```

Expected: analyze and diff check exit 0. Status contains only intended backend pin, generated API/WebSocket/app files, tests, and the knowledge document.

- [ ] **Step 5: Review the final diff against the server contract**

Run:

```bash
git --no-pager diff --stat
git --no-pager diff -- packages/eqmonitor_websocket app/lib/core/realtime app/lib/feature/shake_detection docs/knowledge/20260719_shake_detection_snapshot_sync.md
```

Verify all of these exact invariants in the diff:

```text
wire type = shake_detection
state update = full replacement
revision comparison = strictly greater
ready triggers GET /v2/shake-detection/active
visibility uses expiresAt and correlatedEewEventId
no ShakeDetectionLevel.weaker fallback
no client travel-time correlation
```

- [ ] **Step 6: Commit, push, and prepare PR**

```bash
git add docs/knowledge/20260719_shake_detection_snapshot_sync.md
git commit -m "docs: 揺れ検知snapshot同期ルールを記録"
git push
```

Expected: the branch is pushed with no unstaged or uncommitted intended changes. Open a draft PR summarizing the wire-contract migration, REST/WS revision race handling, removal of client correlation, and focused test commands.

---

## Self-Review Results

- **Spec coverage:** WebSocket type change is Task 2; transport normalization is Task 3; REST initial state is Task 4; ready/revision/race/full replacement is Task 5; `expiresAt`/`correlatedEew` is Task 6; operational knowledge and full verification are Task 7. `mergedEvents` needs no app mutation because complete replacement removes absorbed active IDs automatically. Notification settings and native Live Activity fields are unchanged by PR #869 and intentionally remain out of scope.
- **Placeholder scan:** The plan contains no deferred implementation markers. Every behavior-changing step includes concrete code or exact invariants and commands.
- **Type consistency:** `WsShakeDetectionRealtimeEvent` → `RealtimeShakeSnapshotEvent` → `ShakeDetectionSnapshot` is used consistently. Both REST and WebSocket inputs end at `ShakeDetectionSnapshotReducer.selectNewer`; UI continues consuming `List<ShakeDetectionEvent>` from `shakeDetectionProvider`.
