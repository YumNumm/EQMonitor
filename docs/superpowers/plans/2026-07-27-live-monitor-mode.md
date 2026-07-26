# LiveMonitor Mode Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 強震モニタを常時表示し、EEW・未結合揺れ検知・VXSE51/52/53/61/62・推計震度へ安全にフォーカスする LiveMonitor モードを、自動切り替えと永続化可能な画面分割の両方式で追加する。

**Architecture:** `feature/live_monitor` に、正規化済みイベントの検出、純粋な遷移ポリシー、期限スケジューラ、永続設定、地図フォーカス計算、画面構成を分離して配置する。既存の EEW・揺れ検知・地震履歴・強震モニタ・MapLibre レイヤーを再利用し、イベント受信によるルート操作は行わない。推計震度の Realtime 識別値は重複排除だけに使用し、地図表示には詳細 API が返す完全な `Earthquake.estimatedIntensityTileUrl` を使う。

**Tech Stack:** Flutter 3.44、Dart 3.11、Riverpod 3、flutter_hooks、Freezed、go_router_builder、MapLibre、SharedPreferences、wakelock_plus、fake_async。

**Design:** `docs/superpowers/specs/2026-07-27-live-monitor-mode-design.md`

## Global Constraints

- 表示名は必ず「LiveMonitor モード」とする。
- 自動切り替えの通常状態は強震モニタ、地震情報の通常表示時間は初期値 10 秒・入力範囲 3〜300 秒、最低表示時間は固定 3 秒とする。
- 新規 EEW eventId は最低 3 秒を無視して即時割り込みし、既存 EEW 更新と未結合揺れ検知は最低期限まで待つ。
- 対象地震情報は VXSE51・VXSE52・VXSE53・VXSE61・VXSE62・推計震度とする。
- 画面分割は縦画面で上下、横画面で左右。リアルタイム Pane 比率は 0.2〜0.8、初期値 0.5、縦横別に保存する。
- MapLibre は自動切り替えで 1 枚、画面分割で安定した key を持つ 2 枚とし、Divider ドラッグ中に再生成しない。
- LiveMonitor モード中は既存 EEW overlay の描画だけを抑止し、振動処理は止めない。
- 画面点灯維持は初期値有効、LiveMonitor セッションかつ foreground の間だけ有効にする。
- TTS・効果音そのものは実装しないが、検出済みイベントは UI と独立した Provider から購読可能にする。
- 新規 Widget テストは作らない。純粋ロジック・Provider・platform service の単体テストと実機・Simulator 確認で保証する。
- 例外文字列を UI へ直接表示せず、固定値・ランダム値・推計震度 URL の独自生成で欠損値を補わない。
- `dynamic`、`Object`、`!`、`print()`、新規 StatefulWidget、クラス内 private method を追加しない。
- SharedPreferences のキーは `SharedPreferencesKey` に追加し、生成ファイルは直接編集しない。
- Flutter/Dart コマンドは常に `mise exec --` 経由で実行する。

## Specification Coverage

| Approved behavior | Implemented and verified in |
| --- | --- |
| 専用 route、Home 入口、タップ式コントロールパネル、終了確認 | Tasks 10–11 |
| 自動切り替え、10 秒初期値、3 秒最低表示、新規 EEW 即時割り込み | Tasks 1, 3, 4, 6 |
| 上下・左右分割、20–80% Divider、縦横別の割合永続化 | Tasks 1, 10 |
| EEW、未結合揺れ検知、VXSE51/52/53/61/62、推計震度 | Tasks 2, 3, 5, 6, 9 |
| 強震モニタと Card の実測高を考慮した自動フォーカス | Tasks 7–10 |
| EEW overlay の表示だけ抑止し、振動は維持 | Task 12 |
| foreground 中だけ画面点灯を維持 | Task 13 |
| TTS・効果音が後から購読できる UI 非依存イベント境界 | Task 6 |
| エラー、再接続、回転、fold、Light/Dark、text scale | Tasks 8, 10, 14 |

## Test Fixture Contract

各テストファイルは、その対象だけに必要な deterministic fixture を同じファイル内に定義する。fixture は既存 model の必須フィールドを明示的に埋め、時刻は注入した `Clock`、Realtime は同期的な `StreamController`、REST state は override 可能な notifier fake を使う。ランダム値、現在時刻、固定 eventId への production fallback は使わない。

- `eew({required String eventId, required int serialNo, DateTime? originTime})` は `EewTelegramItem` を返す。
- `snapshot({required int revision})` と `shakeBounds({required double minLat, required double maxLat, required double minLng, required double maxLng})`
- `earthquake({required String eventId, EarthquakeTelegramType type = .vxse53, String? estimatedIntensityTileUrl})`
- `createLiveMonitorContainer({List<EewTelegramItem> eews = const [], ShakeDetectionSnapshot? shakeSnapshot, List<Earthquake> earthquakes = const [], Earthquake? detail})`
- `createCoordinatorContainer({required LiveMonitorSettings settings, required DateTime now})`
- `emitRealtimeEarthquake`、`emitEstimated`、`updateRestEarthquake`、`completeDetailRefresh` は、上記 controller/fake の public API だけを呼ぶ。

fixture の具体的な import と必須フィールドは実装開始時点の既存 model constructor を source of truth とし、型を弱める adapter や `dynamic` は追加しない。

## File Structure

### Domain and orchestration

- `app/lib/feature/live_monitor/data/model/live_monitor_settings.dart`: 表示方式、秒数、点灯維持、縦横比率。
- `app/lib/feature/live_monitor/data/model/live_monitor_event.dart`: UI 非依存の検出済みイベントと地震トリガー。
- `app/lib/feature/live_monitor/data/model/live_monitor_display_state.dart`: `realtime` / `earthquake` 表示状態。
- `app/lib/feature/live_monitor/data/model/live_monitor_map_focus.dart`: MapLibre に依存しない bounds と padding。
- `app/lib/feature/live_monitor/data/logic/live_monitor_duration_validator.dart`: 3〜300 秒の入力検証。
- `app/lib/feature/live_monitor/data/logic/live_monitor_event_detector.dart`: EEW、揺れ検知、電文 metadata、推計震度識別値の差分検出。
- `app/lib/feature/live_monitor/data/logic/live_monitor_transition_policy.dart`: イベント優先度、最低期限、通常期限の純粋計算。
- `app/lib/feature/live_monitor/data/logic/live_monitor_map_focus_builder.dart`: Home/EEW/揺れ検知/地震から表示範囲を構築。
- `app/lib/feature/live_monitor/data/logic/live_monitor_split_ratio.dart`: Divider 位置を 0.2〜0.8 に変換。
- `app/lib/feature/live_monitor/data/logic/live_monitor_tap_tracker.dart`: map gesture と単純タップの判定。
- `app/lib/feature/live_monitor/data/service/live_monitor_scheduler.dart`: 世代番号付き単一 deadline timer。
- `app/lib/feature/live_monitor/data/provider/live_monitor_scheduler_provider.dart`: scheduler の生成・破棄とテスト差し替え。
- `app/lib/feature/live_monitor/data/service/live_monitor_wake_lock_platform.dart`: wakelock_plus の差し替え可能な境界。
- `app/lib/feature/live_monitor/data/notifier/live_monitor_settings_notifier.dart`: JSON 設定の永続化。
- `app/lib/feature/live_monitor/data/notifier/live_monitor_detected_event_notifier.dart`: 正規化 state と Realtime を同じ検出入口へ集約。
- `app/lib/feature/live_monitor/data/notifier/live_monitor_coordinator.dart`: 自動表示状態と timer を管理。
- `app/lib/feature/live_monitor/data/notifier/live_monitor_control_panel_notifier.dart`: パネル開閉。
- `app/lib/feature/live_monitor/data/notifier/live_monitor_session_notifier.dart`: モード active 状態。
- `app/lib/feature/live_monitor/data/provider/live_monitor_latest_earthquake_provider.dart`: 全国 eventId 降順の先頭を full `Earthquake` へ解決。
- `app/lib/feature/live_monitor/data/provider/live_monitor_wake_lock_controller.dart`: session・lifecycle・設定から点灯状態を適用。

### UI

- `app/lib/feature/live_monitor/ui/page/live_monitor_page.dart`: SafeArea、戻る確認、session lifecycle、全体 Stack。
- `app/lib/feature/live_monitor/ui/action/live_monitor_exit_action.dart`: 終了確認 Dialog。
- `app/lib/feature/live_monitor/ui/components/live_monitor_map_host.dart`: MapLibre host、controller identity、camera 適用。
- `app/lib/feature/live_monitor/ui/components/live_monitor_realtime_layers.dart`: 既存強震モニタ・EEW・揺れ検知レイヤーの合成。
- `app/lib/feature/live_monitor/ui/components/live_monitor_earthquake_layers.dart`: 既存地震・長周期・推計震度レイヤーの合成。
- `app/lib/feature/live_monitor/ui/components/live_monitor_realtime_cards.dart`: EEW 優先、未結合揺れ検知後続の Card stack。
- `app/lib/feature/live_monitor/ui/components/live_monitor_earthquake_card.dart`: compact/full の地震 Card。
- `app/lib/feature/live_monitor/ui/components/live_monitor_realtime_pane.dart`: realtime map と Card。
- `app/lib/feature/live_monitor/ui/components/live_monitor_earthquake_pane.dart`: latest earthquake map、cache/error/empty state、Card。
- `app/lib/feature/live_monitor/ui/components/live_monitor_automatic_view.dart`: 1 枚の map host で layer と Card を切り替える。
- `app/lib/feature/live_monitor/ui/components/live_monitor_split_view.dart`: 縦横別 Pane と Divider。
- `app/lib/feature/live_monitor/ui/components/live_monitor_control_panel.dart`: 表示方式、秒数、点灯、閉じる、終了。
- `app/lib/feature/live_monitor/ui/components/live_monitor_connection_banner.dart`: WebSocket 接続中・再接続中表示。
- `app/lib/feature/live_monitor/ui/components/live_monitor_measured_card_overlay.dart`: Card 実測高を camera padding へ通知。
- `app/lib/feature/live_monitor/ui/components/live_monitor_entry_card.dart`: HomeSheet 入口。

### Existing files touched

- `app/lib/core/realtime/model/realtime_event.dart` と mapper: 推計震度の `createdAt` を `generatedAt` として保持。
- `app/lib/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart`: 推計震度イベントで詳細を再検証。
- `app/lib/feature/earthquake_history/ui/components/earthquake_hypocenter_information_card.dart`: LiveMonitor と共有する summary header を抽出。
- `app/lib/feature/home/ui/component/shake_detection/shake_detection_card.dart`: 外側 padding を任意指定可能にする。
- `app/lib/feature/eew/ui/components/eew_warning_overlay_host.dart`: session active 中の描画抑止。
- `app/lib/page/home_page.dart`, `app/lib/core/router/router.dart`, `app/lib/app.dart`: 入口、専用 route、wake-lock controller の起動。
- `app/lib/core/data/preferences/shared/shared_preferences_key.dart`, `app/pubspec.yaml`, `pubspec.lock`: 設定キーと wakelock_plus。

---

### Task 1: Persisted settings and validation

**Files:**
- Create: `app/lib/feature/live_monitor/data/model/live_monitor_settings.dart`
- Create: `app/lib/feature/live_monitor/data/model/live_monitor_settings.freezed.dart` (generated)
- Create: `app/lib/feature/live_monitor/data/model/live_monitor_settings.g.dart` (generated)
- Create: `app/lib/feature/live_monitor/data/logic/live_monitor_duration_validator.dart`
- Create: `app/lib/feature/live_monitor/data/notifier/live_monitor_settings_notifier.dart`
- Create: `app/lib/feature/live_monitor/data/notifier/live_monitor_settings_notifier.g.dart` (generated)
- Modify: `app/lib/core/data/preferences/shared/shared_preferences_key.dart`
- Test: `app/test/feature/live_monitor/data/live_monitor_settings_test.dart`
- Test: `app/test/feature/live_monitor/data/live_monitor_duration_validator_test.dart`

**Interfaces:**
- Consumes: `SharedPreferencesDataSource`, `SharedPreferencesKey`。
- Produces: `LiveMonitorSettings`, `LiveMonitorDisplayMode`, `validateLiveMonitorDuration(String)`, `liveMonitorSettingsProvider`。

- [ ] **Step 1: Write failing defaults, persistence, and validation tests**

```dart
test('未設定なら承認済み既定値を返す', () async {
  SharedPreferences.setMockInitialValues({});
  final container = ProviderContainer();
  addTearDown(container.dispose);

  expect(
    await container.read(liveMonitorSettingsProvider.future),
    const LiveMonitorSettings(),
  );
});

test('縦横比率と表示方式を一つの設定として復元する', () async {
  SharedPreferences.setMockInitialValues({
    SharedPreferencesKey.liveMonitorSettings.key: jsonEncode({
      'display_mode': 'split',
      'earthquake_display_seconds': 24,
      'keep_screen_awake': false,
      'portrait_realtime_ratio': 0.35,
      'landscape_realtime_ratio': 0.7,
    }),
  });
  final container = ProviderContainer();
  addTearDown(container.dispose);

  final value = await container.read(liveMonitorSettingsProvider.future);
  expect(value.displayMode, LiveMonitorDisplayMode.split);
  expect(value.earthquakeDisplaySeconds, 24);
  expect(value.portraitRealtimeRatio, 0.35);
  expect(value.landscapeRealtimeRatio, 0.7);
});

test('整数3〜300だけを受理する', () {
  expect(validateLiveMonitorDuration('3').seconds, 3);
  expect(validateLiveMonitorDuration('300').seconds, 300);
  expect(validateLiveMonitorDuration('').error, .empty);
  expect(validateLiveMonitorDuration('3.5').error, .notInteger);
  expect(validateLiveMonitorDuration('301').error, .outOfRange);
});
```

Add a persisted-corruption case: seconds `301` restores to the approved default `10`, portrait ratio `0.1` restores as `0.2`, and landscape ratio `0.9` restores as `0.8`.

- [ ] **Step 2: Run tests and verify they fail because the feature types do not exist**

Run: `mise exec -- flutter test app/test/feature/live_monitor/data/live_monitor_settings_test.dart app/test/feature/live_monitor/data/live_monitor_duration_validator_test.dart`

Expected: FAIL with missing `LiveMonitorSettings` / provider / validator symbols.

- [ ] **Step 3: Implement the model, validator, key, and notifier**

```dart
enum LiveMonitorDisplayMode { automatic, split }

@freezed
abstract class LiveMonitorSettings with _$LiveMonitorSettings {
  const factory LiveMonitorSettings({
    @Default(LiveMonitorDisplayMode.automatic)
    LiveMonitorDisplayMode displayMode,
    @Default(10) int earthquakeDisplaySeconds,
    @Default(true) bool keepScreenAwake,
    @Default(0.5) double portraitRealtimeRatio,
    @Default(0.5) double landscapeRealtimeRatio,
  }) = _LiveMonitorSettings;

  factory LiveMonitorSettings.fromJson(Map<String, dynamic> json) =>
      _$LiveMonitorSettingsFromJson(json);
}
```

```dart
enum LiveMonitorDurationValidationError { empty, notInteger, outOfRange }

typedef LiveMonitorDurationValidation = ({
  int? seconds,
  LiveMonitorDurationValidationError? error,
});

LiveMonitorDurationValidation validateLiveMonitorDuration(String raw) {
  if (raw.isEmpty) return (seconds: null, error: .empty);
  final seconds = int.tryParse(raw);
  if (seconds == null) return (seconds: null, error: .notInteger);
  if (seconds < 3 || seconds > 300) {
    return (seconds: null, error: .outOfRange);
  }
  return (seconds: seconds, error: null);
}
```

Add `liveMonitorSettings('live_monitor_settings')` to `SharedPreferencesKey`. Implement `LiveMonitorSettingsNotifier` like `HomeConfigurationNotifier`: decode only `Map<String, dynamic>`, fall back to `const LiveMonitorSettings()` on absent/corrupt data while logging through talker, expose `static final saveMutation = Mutation<void>()`, and persist every update as JSON. A public `normalizeLiveMonitorSettings` clamps loaded/saved ratios to `0.2..0.8`; an out-of-range persisted duration restores to the approved default 10. UI changes never clamp seconds silently—only a validated value reaches `save`.

- [ ] **Step 4: Generate checked-in code**

Run from `app/`: `mise exec -- dart run build_runner build --delete-conflicting-outputs --build-filter="lib/feature/live_monitor/data/**"`

Expected: Freezed/JSON/Riverpod files are created with no conflicting output.

- [ ] **Step 5: Run tests and verify persistence and validation pass**

Run: `mise exec -- flutter test app/test/feature/live_monitor/data/live_monitor_settings_test.dart app/test/feature/live_monitor/data/live_monitor_duration_validator_test.dart`

Expected: PASS.

- [ ] **Step 6: Commit the settings slice**

```bash
git add app/lib/core/data/preferences/shared/shared_preferences_key.dart app/lib/feature/live_monitor/data app/test/feature/live_monitor/data
git commit -m "feat: LiveMonitor設定を永続化"
```

### Task 2: Preserve estimated-intensity generation time in normalized Realtime events

**Files:**
- Modify: `app/lib/core/realtime/model/realtime_event.dart`
- Modify: `app/lib/core/realtime/model/realtime_event.freezed.dart` (generated)
- Modify: `app/lib/core/realtime/model/realtime_event.g.dart` (generated)
- Modify: `app/lib/core/realtime/data_source/eqmonitor/eqmonitor_realtime_event_mapper.dart`
- Test: `app/test/core/realtime/eqmonitor_realtime_event_mapper_test.dart`

**Interfaces:**
- Consumes: API `EstimatedIntensityEvent.createdAt` string.
- Produces: `RealtimeEstimatedIntensityUpsertEvent.generatedAt: DateTime?` for detector and Card display.

- [ ] **Step 1: Add a failing mapper test for a valid and invalid generation timestamp**

```dart
test('推計震度の生成時刻と識別値を正規化する', () {
  final envelope = api.RealtimeEventEnvelope.fromJson({
    'type': 'estimated_intensity',
    'operation': 'upsert',
    'event_id': '202607270001',
    'record': {
      'eventId': '202607270001',
      'estimatedIntensityKey': 'estimated/key.pmtiles',
      'createdAt': '2026-07-27T01:02:03Z',
    },
  });
  final events = const EqMonitorRealtimeEventMapper().map(
    WsMessage.realtime(data: envelope),
  );

  expect(
    events.single,
    RealtimeEvent.estimatedIntensityUpsert(
      eventId: '202607270001',
      estimatedIntensityTile: 'estimated/key.pmtiles',
      generatedAt: DateTime.utc(2026, 7, 27, 1, 2, 3),
      source: RealtimeSource.eqmonitor,
    ),
  );
});
```

Add a second case whose `createdAt` is invalid and expect `generatedAt == null`; do not substitute the receive time.

- [ ] **Step 2: Run the mapper test and verify the missing field failure**

Run: `mise exec -- flutter test app/test/core/realtime/eqmonitor_realtime_event_mapper_test.dart`

Expected: FAIL because `generatedAt` is not defined.

- [ ] **Step 3: Add the nullable field and parse without inventing a fallback**

```dart
const factory RealtimeEvent.estimatedIntensityUpsert({
  required String eventId,
  required String estimatedIntensityTile,
  required DateTime? generatedAt,
  required RealtimeSource source,
}) = RealtimeEstimatedIntensityUpsertEvent;
```

Mapper assignment:

```dart
generatedAt: DateTime.tryParse(payload.record.createdAt)?.toUtc(),
```

- [ ] **Step 4: Regenerate the Realtime union and rerun the mapper test**

Run from `app/`: `mise exec -- dart run build_runner build --delete-conflicting-outputs --build-filter="lib/core/realtime/model/**"`

Run: `mise exec -- flutter test app/test/core/realtime/eqmonitor_realtime_event_mapper_test.dart`

Expected: PASS for valid timestamp, invalid timestamp, eventId, and identifier.

- [ ] **Step 5: Commit the canonical event contract**

```bash
git add app/lib/core/realtime app/test/core/realtime/eqmonitor_realtime_event_mapper_test.dart
git commit -m "feat: 推計震度の生成時刻を保持"
```

### Task 3: Detected event model and duplicate detector

**Files:**
- Create: `app/lib/feature/live_monitor/data/model/live_monitor_event.dart`
- Create: `app/lib/feature/live_monitor/data/model/live_monitor_event.freezed.dart` (generated)
- Create: `app/lib/feature/live_monitor/data/logic/live_monitor_event_detector.dart`
- Test: `app/test/feature/live_monitor/data/live_monitor_event_detector_test.dart`

**Interfaces:**
- Consumes: `EewTelegramItem`, `ShakeDetectionSnapshot`, full `Earthquake`, estimated-intensity event fields.
- Produces: `LiveMonitorDetectedEvent`, `LiveMonitorEventEnvelope`, `LiveMonitorEarthquakeTrigger`.

- [ ] **Step 1: Write failing detector tests for baseline, updates, supported telegrams, and deduplication**

Cover these exact cases:

```dart
test('初回EEWは基準化し新eventIdとserial増加だけを返す', () {
  final detector = LiveMonitorEventDetector();
  expect(detector.detectEews([eew(eventId: 'A', serialNo: 1)]), isEmpty);
  expect(detector.detectEews([eew(eventId: 'A', serialNo: 2)]).single,
      isA<LiveMonitorEewUpdatedEvent>());
  expect(detector.detectEews([
    eew(eventId: 'A', serialNo: 2),
    eew(eventId: 'B', serialNo: 1),
  ]).single, isA<LiveMonitorEewStartedEvent>());
});

test('snapshot revisionとevent serialの両方で未結合揺れ検知を重複排除する', () {
  final detector = LiveMonitorEventDetector();
  expect(detector.detectShakeSnapshot(snapshot(revision: 10, serialNo: 1)),
      isEmpty);
  expect(detector.detectShakeSnapshot(snapshot(revision: 10, serialNo: 1)),
      isEmpty);
  expect(detector.detectShakeSnapshot(snapshot(revision: 11, serialNo: 2))
      .single, isA<LiveMonitorShakeDetectedEvent>());
});

test('VXSE51/52/53/61/62だけをreportedAt単位で検出する', () {
  final detector = LiveMonitorEventDetector();
  detector.seedEarthquake(earthquakeWithAllSupportedTelegrams());
  final events = detector.detectEarthquake(
    earthquakeWithAdditionalMetadata(.vxse62, DateTime.utc(2026, 7, 27)),
  );
  expect(events.single.trigger.kind, .vxse62);
});

test('推計震度はeventId・識別値・full URLで重複排除する', () {
  final detector = LiveMonitorEventDetector()
    ..seedEarthquake(earthquake(eventId: 'A', tileUrl: 'https://tiles/1'));
  expect(detector.acceptEstimatedIdentifier(
    eventId: 'A', identifier: 'tile-1'), isTrue);
  expect(detector.detectEstimatedIntensity(
    eventId: 'A', identifier: 'tile-1', generatedAt: null,
    earthquake: earthquake(eventId: 'A', tileUrl: 'https://tiles/1')),
    isNull);
  expect(detector.acceptEstimatedIdentifier(
    eventId: 'A', identifier: 'tile-2'), isTrue);
  expect(detector.detectEstimatedIntensity(
    eventId: 'A', identifier: 'tile-2',
    generatedAt: DateTime.utc(2026, 7, 27),
    earthquake: earthquake(eventId: 'A', tileUrl: 'https://tiles/2'))
    ?.trigger.kind,
    .estimatedIntensity,
  );
  expect(detector.acceptEstimatedIdentifier(
    eventId: 'A', identifier: 'tile-2'), isFalse);
});
```

Also verify correlated or expired shake events are absent before reaching the detector by passing only the accepted snapshot and applying the same filter predicate as `shakeDetectionVisibleProvider` in the event source task.

- [ ] **Step 2: Run the detector test and verify missing types**

Run: `mise exec -- flutter test app/test/feature/live_monitor/data/live_monitor_event_detector_test.dart`

Expected: FAIL with missing detector/model symbols.

- [ ] **Step 3: Implement event and trigger unions**

```dart
enum LiveMonitorEarthquakeTriggerKind {
  vxse51, vxse52, vxse53, vxse61, vxse62, estimatedIntensity,
}

@freezed
sealed class LiveMonitorEarthquakeTrigger with _$LiveMonitorEarthquakeTrigger {
  const factory LiveMonitorEarthquakeTrigger.telegram({
    required LiveMonitorEarthquakeTriggerKind kind,
    required DateTime reportedAt,
  }) = LiveMonitorTelegramTrigger;
  const factory LiveMonitorEarthquakeTrigger.estimatedIntensity({
    required DateTime? generatedAt,
  }) = LiveMonitorEstimatedIntensityTrigger;
}

@freezed
sealed class LiveMonitorDetectedEvent with _$LiveMonitorDetectedEvent {
  const factory LiveMonitorDetectedEvent.eewStarted({
    required String eventId, required int serialNo,
  }) = LiveMonitorEewStartedEvent;
  const factory LiveMonitorDetectedEvent.eewUpdated({
    required String eventId, required int serialNo,
  }) = LiveMonitorEewUpdatedEvent;
  const factory LiveMonitorDetectedEvent.shakeDetected({
    required String eventId, required int serialNo,
  }) = LiveMonitorShakeDetectedEvent;
  const factory LiveMonitorDetectedEvent.earthquakeUpsert({
    required String eventId,
    required LiveMonitorEarthquakeTrigger trigger,
    required Earthquake earthquake,
  }) = LiveMonitorEarthquakeUpsertEvent;
  const factory LiveMonitorDetectedEvent.earthquakeDeleted({
    required String eventId,
  }) = LiveMonitorEarthquakeDeletedEvent;
}

@freezed
abstract class LiveMonitorEventEnvelope with _$LiveMonitorEventEnvelope {
  const factory LiveMonitorEventEnvelope({
    required int sequence,
    required LiveMonitorDetectedEvent event,
  }) = _LiveMonitorEventEnvelope;
}
```

Implement `LiveMonitorEventDetector` with public `detectEews`, `detectShakeSnapshot`, `seedEarthquake`, `detectEarthquake`, `acceptEstimatedIdentifier`, and `detectEstimatedIntensity`. The first EEW list and shake snapshot seed their families and return no event; initial REST earthquakes are seeded explicitly before live detection begins. Sort newly discovered telegram metadata by `reportedAt`; map only the five supported telegram types. Retain `eventId -> max serialNo`, last accepted snapshot revision, `Set<(String, EarthquakeTelegramType, DateTime)>`, raw `Set<(String, String)>`, and `eventId -> last full estimatedIntensityTileUrl`. `acceptEstimatedIdentifier` rejects repeated raw delivery. `detectEstimatedIntensity` publishes only when the full URL differs from its baseline, then updates that baseline; `detectEarthquake` applies the same full-URL comparison so a REST-only change is detected, while WebSocket followed by REST is emitted once.

- [ ] **Step 4: Generate the event union and rerun tests**

Run from `app/`: `mise exec -- dart run build_runner build --delete-conflicting-outputs --build-filter="lib/feature/live_monitor/data/model/**"`

Run: `mise exec -- flutter test app/test/feature/live_monitor/data/live_monitor_event_detector_test.dart`

Expected: PASS for initial baselines, old serials, duplicate REST/WebSocket data, all five telegram types, and estimated identifiers.

- [ ] **Step 5: Commit detector slice**

```bash
git add app/lib/feature/live_monitor/data/model/live_monitor_event* app/lib/feature/live_monitor/data/logic/live_monitor_event_detector.dart app/test/feature/live_monitor/data/live_monitor_event_detector_test.dart
git commit -m "feat: LiveMonitorイベントを検出"
```

### Task 4: Display transition policy and generation-safe scheduler

**Files:**
- Create: `app/lib/feature/live_monitor/data/model/live_monitor_display_state.dart`
- Create: `app/lib/feature/live_monitor/data/model/live_monitor_display_state.freezed.dart` (generated)
- Create: `app/lib/feature/live_monitor/data/logic/live_monitor_transition_policy.dart`
- Create: `app/lib/feature/live_monitor/data/service/live_monitor_scheduler.dart`
- Create: `app/lib/feature/live_monitor/data/provider/live_monitor_scheduler_provider.dart`
- Create: `app/lib/feature/live_monitor/data/provider/live_monitor_scheduler_provider.g.dart` (generated)
- Test: `app/test/feature/live_monitor/data/live_monitor_transition_policy_test.dart`
- Test: `app/test/feature/live_monitor/data/live_monitor_scheduler_test.dart`

**Interfaces:**
- Consumes: `LiveMonitorDetectedEvent`, current state, `DateTime now`, configured display seconds.
- Produces: `LiveMonitorDisplayState`, `LiveMonitorTransitionDecision`, one active scheduler deadline.

- [ ] **Step 1: Write the transition matrix as failing tests**

```dart
test('地震情報は3秒の最低期限と設定期限を持つ', () {
  final decision = const LiveMonitorTransitionPolicy().resolve(
    current: const LiveMonitorDisplayState.realtime(),
    event: earthquakeEvent('A'),
    now: DateTime.utc(2026, 7, 27),
    displaySeconds: 10,
  );
  final next = decision.next as LiveMonitorEarthquakeDisplayState;
  expect(next.minimumUntil, DateTime.utc(2026, 7, 27, 0, 0, 3));
  expect(next.expiresAt, DateTime.utc(2026, 7, 27, 0, 0, 10));
  expect(decision.deadline, next.expiresAt);
});

test('新規EEWは最低期限中でも即時realtimeへ戻す', () {
  final decision = policy.resolve(
    current: earthquakeState(minimumUntil: now.add(const Duration(seconds: 2))),
    event: const LiveMonitorDetectedEvent.eewStarted(eventId: 'E', serialNo: 1),
    now: now,
    displaySeconds: 10,
  );
  expect(decision.next, const LiveMonitorDisplayState.realtime());
  expect(decision.closeControlPanel, isTrue);
});

test('既存EEW更新と揺れ検知は最低期限まで待つ', () {
  final state = earthquakeState(minimumUntil: now.add(const Duration(seconds: 2)));
  for (final event in [
    const LiveMonitorDetectedEvent.eewUpdated(eventId: 'E', serialNo: 2),
    const LiveMonitorDetectedEvent.shakeDetected(eventId: 'S', serialNo: 2),
  ]) {
    final decision = policy.resolve(
      current: state, event: event, now: now, displaySeconds: 10);
    expect(
      (decision.next as LiveMonitorEarthquakeDisplayState).returnToRealtimeAt,
      state.minimumUntil,
    );
    expect(decision.deadline, state.minimumUntil);
  }
});
```

Add cases for same/different earthquake update resetting both deadlines, expiry, matching delete, nonmatching delete, post-minimum existing EEW/shake immediate return, and settings duration affecting only the next earthquake event.

- [ ] **Step 2: Write a failing fake_async test for stale timer cancellation**

```dart
fakeAsync((async) {
  final fired = <String>[];
  final scheduler = LiveMonitorScheduler();
  final now = DateTime.utc(2026, 7, 27);
  scheduler.schedule(
    now: now,
    deadline: now.add(const Duration(seconds: 10)),
    onElapsed: () => fired.add('old'),
  );
  scheduler.schedule(
    now: now,
    deadline: now.add(const Duration(seconds: 3)),
    onElapsed: () => fired.add('new'),
  );
  async.elapse(const Duration(seconds: 10));
  expect(fired, ['new']);
});
```

- [ ] **Step 3: Run both tests and verify missing policy/scheduler failures**

Run: `mise exec -- flutter test app/test/feature/live_monitor/data/live_monitor_transition_policy_test.dart app/test/feature/live_monitor/data/live_monitor_scheduler_test.dart`

Expected: FAIL with missing state, policy, and scheduler symbols.

- [ ] **Step 4: Implement state, decision, policy, and one-deadline scheduler**

```dart
@freezed
sealed class LiveMonitorDisplayState with _$LiveMonitorDisplayState {
  const factory LiveMonitorDisplayState.realtime() =
      LiveMonitorRealtimeDisplayState;
  const factory LiveMonitorDisplayState.earthquake({
    required String eventId,
    required LiveMonitorEarthquakeTrigger trigger,
    required Earthquake earthquake,
    required DateTime shownAt,
    required DateTime minimumUntil,
    required DateTime expiresAt,
    DateTime? returnToRealtimeAt,
  }) = LiveMonitorEarthquakeDisplayState;
}

final class LiveMonitorTransitionDecision {
  const LiveMonitorTransitionDecision({
    required this.next,
    required this.deadline,
    required this.closeControlPanel,
  });
  final LiveMonitorDisplayState next;
  final DateTime? deadline;
  final bool closeControlPanel;
}
```

`LiveMonitorTransitionPolicy.resolve` must be a pure switch over `(current, event)`. A new earthquake always replaces the current earthquake, restarts both deadlines, and clears `returnToRealtimeAt`. An existing EEW update or shake before `minimumUntil` keeps the displayed earthquake but sets `returnToRealtimeAt = minimumUntil`; repeated triggers retain that single deadline. After the minimum it returns realtime immediately. A new EEW always returns realtime and sets `closeControlPanel = true`. A timer callback invokes `resolveDeadline(current: state, now: clock.now())`; it returns realtime when `returnToRealtimeAt != null && now >= returnToRealtimeAt` or when `now >= expiresAt`, otherwise it returns the unchanged state and its next effective deadline. Same/different earthquake replacement clears the pending realtime return so an older trigger cannot interrupt the replacement.

`LiveMonitorScheduler.schedule` increments a generation, cancels the previous `Timer`, schedules `max(Duration.zero, deadline - now)`, and executes the callback only when its captured generation is still current. `cancel()` increments generation and cancels the timer.

Provide it through Riverpod for coordinator tests and disposal:

```dart
@riverpod
LiveMonitorScheduler liveMonitorScheduler(Ref ref) {
  final scheduler = LiveMonitorScheduler();
  ref.onDispose(scheduler.cancel);
  return scheduler;
}
```

- [ ] **Step 5: Generate state code and rerun tests**

Run from `app/`: `mise exec -- dart run build_runner build --delete-conflicting-outputs --build-filter="lib/feature/live_monitor/data/model/**" --build-filter="lib/feature/live_monitor/data/provider/live_monitor_scheduler_provider.g.dart"`

Run: `mise exec -- flutter test app/test/feature/live_monitor/data/live_monitor_transition_policy_test.dart app/test/feature/live_monitor/data/live_monitor_scheduler_test.dart`

Expected: PASS for every matrix row and stale timer test.

- [ ] **Step 6: Commit the transition core**

```bash
git add app/lib/feature/live_monitor/data/model/live_monitor_display_state* app/lib/feature/live_monitor/data/logic/live_monitor_transition_policy.dart app/lib/feature/live_monitor/data/service/live_monitor_scheduler.dart app/lib/feature/live_monitor/data/provider/live_monitor_scheduler_provider* app/test/feature/live_monitor/data/live_monitor_transition_policy_test.dart app/test/feature/live_monitor/data/live_monitor_scheduler_test.dart
git commit -m "feat: LiveMonitor表示優先度を実装"
```

### Task 5: Canonical latest-earthquake and estimated-intensity refresh path

**Files:**
- Modify: `app/lib/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart`
- Create: `app/lib/feature/live_monitor/data/provider/live_monitor_latest_earthquake_provider.dart`
- Create: `app/lib/feature/live_monitor/data/provider/live_monitor_latest_earthquake_provider.g.dart` (generated)
- Test: `app/test/feature/earthquake_history/earthquake_history_realtime_details_test.dart`
- Test: `app/test/feature/live_monitor/data/live_monitor_latest_earthquake_provider_test.dart`

**Interfaces:**
- Consumes: `earthquakeHistoryProvider` using nationwide eventId descending order, `earthquakeHistoryDetailsProvider(eventId)`, `RealtimeEstimatedIntensityUpsertEvent`.
- Produces: `liveMonitorLatestEarthquakeProvider`, `selectLiveMonitorLatestEventId`.

- [ ] **Step 1: Add a failing detail-provider test for estimated-intensity refresh**

Extend the existing realtime details test with a repository fake whose first detail has no estimated tile and whose refreshed detail has `https://example.test/estimated.pmtiles`:

```dart
test('推計震度upsertで同じeventIdの詳細を再検証する', () async {
  final container = createContainer(detailResponses: [withoutTile, withTile]);
  addTearDown(container.dispose);
  await container.read(earthquakeHistoryDetailsProvider(eventId).future);

  emitRealtime(
    container,
    RealtimeEvent.estimatedIntensityUpsert(
      eventId: eventId,
      estimatedIntensityTile: 'estimated/key.pmtiles',
      generatedAt: DateTime.utc(2026, 7, 27),
      source: RealtimeSource.eqmonitor,
    ),
  );

  final refreshed = await container.read(
    earthquakeHistoryDetailsProvider(eventId).future,
  );
  expect(refreshed.estimatedIntensityTileUrl,
      'https://example.test/estimated.pmtiles');
});
```

Also assert a different eventId does not refetch this detail.

- [ ] **Step 2: Add failing latest-selection tests**

```dart
test('全国一覧のeventId降順先頭を選ぶ', () {
  expect(
    selectLiveMonitorLatestEventId([
      partial(eventId: '202607270002'),
      partial(eventId: '202607270001'),
    ]),
    '202607270002',
  );
});

test('古いeventIdの内容更新は最新eventIdを押しのけない', () {
  expect(
    selectLiveMonitorLatestEventId([
      partial(eventId: '202607270002'),
      updatedPartial(eventId: '202607270001'),
    ]),
    '202607270002',
  );
});
```

- [ ] **Step 3: Run the tests and verify the refresh/provider failures**

Run: `mise exec -- flutter test app/test/feature/earthquake_history/earthquake_history_realtime_details_test.dart app/test/feature/live_monitor/data/live_monitor_latest_earthquake_provider_test.dart`

Expected: the estimated event leaves stale detail and the latest provider symbols are missing.

- [ ] **Step 4: Refresh only the matching detail and implement latest provider**

Add a `RealtimeEstimatedIntensityUpsertEvent` switch case in `EarthquakeHistoryDetailsNotifier.build` guarded by matching eventId. Call `advanceCachedAuthority()` and `ref.invalidateSelf()`; preserve the previous `AsyncData` through loading so map/Card do not disappear while REST catches up. Do not assign `estimatedIntensityTile` to `estimatedIntensityTileUrl`.

```dart
const liveMonitorLatestParameter = EarthquakeHistoryParameter.all(
  sortBy: EarthquakeSortBy.eventId,
  sortOrder: SortOrder.desc,
);

String? selectLiveMonitorLatestEventId(List<EarthquakePartial> items) =>
    items.map((item) => item.earthquake.eventId).firstOrNull;

@riverpod
Future<Earthquake?> liveMonitorLatestEarthquake(Ref ref) async {
  final page = await ref.watch(
    earthquakeHistoryProvider(liveMonitorLatestParameter).future,
  );
  final eventId = selectLiveMonitorLatestEventId(page.items);
  if (eventId == null) return null;
  return ref.watch(earthquakeHistoryDetailsProvider(eventId).future);
}
```

- [ ] **Step 5: Generate the provider and rerun tests**

Run from `app/`: `mise exec -- dart run build_runner build --delete-conflicting-outputs --build-filter="lib/feature/live_monitor/data/provider/**"`

Run: `mise exec -- flutter test app/test/feature/earthquake_history/earthquake_history_realtime_details_test.dart app/test/feature/live_monitor/data/live_monitor_latest_earthquake_provider_test.dart`

Expected: PASS; cached detail remains visible during refresh and only the newest eventId is selected.

- [ ] **Step 6: Commit canonical earthquake refresh**

```bash
git add app/lib/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart app/lib/feature/live_monitor/data/provider app/test/feature/earthquake_history/earthquake_history_realtime_details_test.dart app/test/feature/live_monitor/data/live_monitor_latest_earthquake_provider_test.dart
git commit -m "feat: 推計震度で地震詳細を更新"
```

### Task 6: UI-independent event stream and display coordinator

**Files:**
- Create: `app/lib/feature/live_monitor/data/notifier/live_monitor_detected_event_notifier.dart`
- Create: `app/lib/feature/live_monitor/data/notifier/live_monitor_detected_event_notifier.g.dart` (generated)
- Create: `app/lib/feature/live_monitor/data/notifier/live_monitor_control_panel_notifier.dart`
- Create: `app/lib/feature/live_monitor/data/notifier/live_monitor_control_panel_notifier.g.dart` (generated)
- Create: `app/lib/feature/live_monitor/data/notifier/live_monitor_coordinator.dart`
- Create: `app/lib/feature/live_monitor/data/notifier/live_monitor_coordinator.g.dart` (generated)
- Test: `app/test/feature/live_monitor/data/live_monitor_detected_event_notifier_test.dart`
- Test: `app/test/feature/live_monitor/data/live_monitor_coordinator_test.dart`

**Interfaces:**
- Consumes: canonical EEW list, accepted shake snapshot, nationwide first-page earthquakes, raw `realtimeEventsProvider`, lifecycle, clock, settings, transition policy.
- Produces: `liveMonitorDetectedEventProvider` (future TTS/audio subscription boundary), `liveMonitorCoordinatorProvider`, `liveMonitorControlPanelProvider`.

- [ ] **Step 1: Write failing event-source tests around initial seed, Realtime, and REST resync**

Use Provider overrides/fakes to assert:

```dart
test('初期REST stateは基準値になりイベントを発行しない', () async {
  final container = createLiveMonitorContainer(
    eews: [eew(eventId: 'E', serialNo: 1)],
    shakeSnapshot: snapshot(revision: 1),
    earthquakes: [earthquake(eventId: 'Q')],
  );
  addTearDown(container.dispose);
  await container.read(liveMonitorDetectedEventProvider.future);
  expect(container.read(liveMonitorDetectedEventProvider).value, isNull);
});

test('RealtimeとRESTの同一VXSE更新を一度だけ発行する', () async {
  final container = createLiveMonitorContainer(
    eews: const [],
    shakeSnapshot: null,
    earthquakes: [earthquake(eventId: 'Q')],
    detail: earthquake(eventId: 'Q'),
  );
  final emitted = collectDetectedEvents(container);
  emitRealtimeEarthquake(container, vxse62Record);
  updateRestEarthquake(container, vxse62Earthquake);
  await pumpEventQueue();
  expect(emitted.where((e) => e.event is LiveMonitorEarthquakeUpsertEvent),
      hasLength(1));
});

test('推計震度はfull detail取得後だけ発行する', () async {
  final container = createLiveMonitorContainer(detail: withoutTile);
  emitEstimated(container, identifier: 'tile-2');
  await pumpEventQueue();
  expect(container.read(liveMonitorDetectedEventProvider).value, isNull);
  completeDetailRefresh(container, withTile);
  await pumpEventQueue();
  expect(container.read(liveMonitorDetectedEventProvider).value?.event,
      isA<LiveMonitorEarthquakeUpsertEvent>());
});
```

The source must keep unresolved estimated events pending and retry them on `RealtimeReadyEvent` or foreground resync; a failed detail fetch logs and does not synthesize a Card.

- [ ] **Step 2: Write failing coordinator tests for mode changes, panel close, and deadlines**

```dart
test('split中は地震イベントでPaneを入れ替えずtimerも持たない', () async {
  final container = createCoordinatorContainer(
    settings: const LiveMonitorSettings(displayMode: .split),
    now: DateTime.utc(2026, 7, 27),
  );
  emitDetected(container, earthquakeEnvelope(sequence: 1));
  expect(container.read(liveMonitorCoordinatorProvider),
      const LiveMonitorDisplayState.realtime());
  expect(fakeScheduler.hasScheduledTask, isFalse);
});

test('automatic中の新規EEWはパネルを閉じて即時realtimeへ戻す', () {
  openControlPanel(container);
  emitDetected(container, newEewEnvelope(sequence: 2));
  expect(container.read(liveMonitorControlPanelProvider), isFalse);
  expect(container.read(liveMonitorCoordinatorProvider),
      const LiveMonitorDisplayState.realtime());
});

test('automaticからsplitへの変更は古いdeadlineを取消す', () async {
  emitDetected(container, earthquakeEnvelope(sequence: 1));
  await setDisplayMode(container, .split);
  fakeAsync.elapse(const Duration(seconds: 30));
  expect(fakeScheduler.hasScheduledTask, isFalse);
});
```

- [ ] **Step 3: Run both test files and verify missing notifier failures**

Run: `mise exec -- flutter test app/test/feature/live_monitor/data/live_monitor_detected_event_notifier_test.dart app/test/feature/live_monitor/data/live_monitor_coordinator_test.dart`

Expected: FAIL with missing generated providers.

- [ ] **Step 4: Implement the detected-event notifier**

Use an autoDispose AsyncNotifier with nullable envelope value and monotonically increasing sequence. The LiveMonitor coordinator keeps it alive while the page is open; a future app-wide TTS/audio subscriber can keep the same UI-independent provider alive without coupling to the page:

```dart
@riverpod
class LiveMonitorDetectedEventNotifier
    extends _$LiveMonitorDetectedEventNotifier {
  final detector = LiveMonitorEventDetector();
  final pendingRealtimeEvents = <RealtimeEvent>[];
  var sequence = 0;
  var initialized = false;

  @override
  Future<LiveMonitorEventEnvelope?> build() async {
    ref.listen(realtimeEventsProvider, (_, next) async {
      final event = next.value;
      if (event == null) return;
      if (!initialized) {
        pendingRealtimeEvents.add(event);
        return;
      }
      await acceptRealtimeEvent(event);
    });
    await initializeBaselines();
    if (!ref.mounted) return null;
    while (pendingRealtimeEvents.isNotEmpty) {
      final event = pendingRealtimeEvents.removeAt(0);
      await acceptRealtimeEvent(event);
      if (!ref.mounted) return null;
    }
    initialized = true;
    ref
      ..listen(eewAliveTelegramProvider,
          (_, next) => acceptEewState(next ?? const []))
      ..listen(shakeDetectionAcceptedSnapshotProvider,
          (_, next) => acceptShakeSnapshot(next));
    return null;
  }

  void publish(LiveMonitorDetectedEvent event) {
    state = AsyncData(
      LiveMonitorEventEnvelope(sequence: ++sequence, event: event),
    );
  }
}
```

Keep all event handlers public (`initializeBaselines`, `acceptEewState`, `acceptShakeSnapshot`, `acceptRealtimeEvent`, `synchronizeEarthquakes`, `resolvePendingEstimatedIntensity`) to follow the no-private-method rule. `initializeBaselines` awaits the current EEW state, accepted shake snapshot, nationwide eventId-desc first page (10 items), and those items' existing detail providers before setting `initialized`; raw events received during that await are queued and replayed in arrival order. Filter shake events with the canonical uncorrelated/not-expired predicate before detector input. Convert `RealtimeEarthquakeUpsertEvent.record` through the existing `earthquakeFromRealtimeRecord` plus `earthquakeHistoryRepositoryProvider`; do not duplicate conversion. Initial full details seed metadata without publishing; `RealtimeReadyEvent` and foreground resync invalidate and compare the same first-page details, publishing only differences. Raw earthquake events outside the first page are still handled immediately.

For estimated intensity, record `(eventId, identifier)` first, invalidate/read the matching details provider, and publish only when the resulting full `Earthquake.estimatedIntensityTileUrl` is non-null. Update the detector's full-URL baseline so a subsequent REST refresh of the same value does not duplicate the event.

- [ ] **Step 5: Implement panel state and coordinator**

```dart
@riverpod
class LiveMonitorControlPanelNotifier
    extends _$LiveMonitorControlPanelNotifier {
  @override
  bool build() => false;
  void open() => state = true;
  void close() => state = false;
}
```

`LiveMonitorCoordinator` owns one `LiveMonitorScheduler` from an overridable provider, starts at `realtime`, listens to `AsyncData` event envelopes by sequence, and applies `LiveMonitorTransitionPolicy`. It reads `earthquakeDisplaySeconds` only when applying an earthquake event. When a decision supplies a deadline, schedule one callback that re-evaluates the current state using `appClockProvider`; when mode becomes split, cancel and reset to realtime; when split becomes automatic, start from realtime. Any `eewStarted` closes the panel even in split mode.

```dart
@riverpod
class LiveMonitorCoordinator extends _$LiveMonitorCoordinator {
  var lastSequence = 0;

  @override
  LiveMonitorDisplayState build() {
    final scheduler = ref.watch(liveMonitorSchedulerProvider);
    ref
      ..listen(liveMonitorDetectedEventProvider, (_, next) {
        final envelope = next.value;
        if (envelope != null) acceptEnvelope(envelope);
      })
      ..listen(
        liveMonitorSettingsProvider.select(
          (value) => value.value?.displayMode,
        ),
        (_, next) => acceptDisplayMode(next),
      );
    ref.onDispose(scheduler.cancel);
    return const LiveMonitorDisplayState.realtime();
  }

  void acceptEnvelope(LiveMonitorEventEnvelope envelope) {
    if (envelope.sequence <= lastSequence) return;
    lastSequence = envelope.sequence;
    final settings =
        ref.read(liveMonitorSettingsProvider).value ??
        const LiveMonitorSettings();
    final decision = const LiveMonitorTransitionPolicy().resolve(
      current: state,
      event: envelope.event,
      now: ref.read(appClockProvider.notifier).now().toUtc(),
      displaySeconds: settings.earthquakeDisplaySeconds,
    );
    applyDecision(decision);
  }
}
```

Implement public `applyDecision`, `acceptDisplayMode`, and `handleDeadline` methods in the same file. `applyDecision` updates state, closes the panel when requested, cancels when `deadline == null`, or schedules `handleDeadline` otherwise. `acceptDisplayMode` cancels and resets to realtime whenever the mode changes in either direction. `handleDeadline` calls `policy.resolveDeadline(current: state, now: clock.now().toUtc())` and applies that result. The settings default above is used only while settings are genuinely loading; `LiveMonitorPage` does not mount this coordinator until settings have resolved.

- [ ] **Step 6: Generate providers and rerun tests**

Run from `app/`: `mise exec -- dart run build_runner build --delete-conflicting-outputs --build-filter="lib/feature/live_monitor/data/notifier/**"`

Run: `mise exec -- flutter test app/test/feature/live_monitor/data/live_monitor_detected_event_notifier_test.dart app/test/feature/live_monitor/data/live_monitor_coordinator_test.dart`

Expected: PASS for baseline, WebSocket/REST dedupe, pending estimated detail, mode changes, timer cancellation, and new EEW panel close.

- [ ] **Step 7: Commit orchestration slice**

```bash
git add app/lib/feature/live_monitor/data/notifier app/test/feature/live_monitor/data/live_monitor_detected_event_notifier_test.dart app/test/feature/live_monitor/data/live_monitor_coordinator_test.dart
git commit -m "feat: LiveMonitor表示を協調制御"
```

### Task 7: Pure map focus calculation

**Files:**
- Create: `app/lib/feature/live_monitor/data/model/live_monitor_map_focus.dart`
- Create: `app/lib/feature/live_monitor/data/model/live_monitor_map_focus.freezed.dart` (generated)
- Create: `app/lib/feature/live_monitor/data/logic/live_monitor_map_focus_builder.dart`
- Test: `app/test/feature/live_monitor/data/live_monitor_map_focus_builder_test.dart`

**Interfaces:**
- Consumes: Home bounds, active EEWs, visible uncorrelated shakes, optional Earthquake, measured Card obstruction.
- Produces: MapLibre-independent `LiveMonitorMapFocus` converted by the UI host.

- [ ] **Step 1: Write failing focus tests**

```dart
test('複数EEW点と揺れ検知矩形を一つのboundsへ含める', () {
  final focus = const LiveMonitorMapFocusBuilder().forRealtime(
    homeBounds: homeBounds,
    eews: [eewAt(lat: 35, lng: 135), eewAt(lat: 40, lng: 142)],
    shakes: [shakeBounds(minLat: 33, maxLat: 34, minLng: 130, maxLng: 132)],
    obscuredBottom: 180,
  );
  expect(focus.bounds.minLat, lessThanOrEqualTo(33));
  expect(focus.bounds.maxLat, greaterThanOrEqualTo(40));
  expect(focus.bounds.minLng, lessThanOrEqualTo(130));
  expect(focus.bounds.maxLng, greaterThanOrEqualTo(142));
  expect(focus.padding.bottom, 180);
});

test('有効座標がない場合だけHome boundsへ戻る', () {
  final focus = builder.forRealtime(
    homeBounds: homeBounds, eews: [eewWithoutCoordinate()],
    shakes: const [], obscuredBottom: 0);
  expect(focus.bounds, homeBounds);
});

test('地震は震源と取得済み観測点を含み欠損を固定値で補わない', () {
  final focus = builder.forEarthquake(
    earthquake: earthquakeWithHypocenterAndStations(),
    fallbackBounds: homeBounds,
    obscuredBottom: 120,
  );
  expect(focus.bounds.contains(latitude: stationLat, longitude: stationLng),
      isTrue);
});
```

- [ ] **Step 2: Run the focus test and verify missing model/builder failures**

Run: `mise exec -- flutter test app/test/feature/live_monitor/data/live_monitor_map_focus_builder_test.dart`

Expected: FAIL with missing focus classes.

- [ ] **Step 3: Implement Flutter/MapLibre-independent focus records and builder**

```dart
@freezed
abstract class LiveMonitorGeoBounds with _$LiveMonitorGeoBounds {
  const factory LiveMonitorGeoBounds({
    required double minLat,
    required double maxLat,
    required double minLng,
    required double maxLng,
  }) = _LiveMonitorGeoBounds;
}

extension LiveMonitorGeoBoundsX on LiveMonitorGeoBounds {
  bool contains({required double latitude, required double longitude}) =>
      minLat <= latitude && latitude <= maxLat &&
      minLng <= longitude && longitude <= maxLng;
}

@freezed
abstract class LiveMonitorMapPadding with _$LiveMonitorMapPadding {
  const factory LiveMonitorMapPadding({
    @Default(8) double top,
    @Default(8) double right,
    @Default(8) double bottom,
    @Default(8) double left,
  }) = _LiveMonitorMapPadding;
}

@freezed
abstract class LiveMonitorMapFocus with _$LiveMonitorMapFocus {
  const factory LiveMonitorMapFocus({
    required LiveMonitorGeoBounds bounds,
    required LiveMonitorMapPadding padding,
  }) = _LiveMonitorMapFocus;
}
```

Builder rules: ignore each missing coordinate independently; include shake min/max rectangles; include earthquake hypocenter and station coordinates from `intensityTree`; use caller-provided fallback only when no valid target exists; apply a small geographic margin only around valid targets; set bottom padding to measured Card pixels plus normal safe spacing.

- [ ] **Step 4: Generate the focus model and rerun tests**

Run from `app/`: `mise exec -- dart run build_runner build --delete-conflicting-outputs --build-filter="lib/feature/live_monitor/data/model/**"`

Run: `mise exec -- flutter test app/test/feature/live_monitor/data/live_monitor_map_focus_builder_test.dart`

Expected: PASS for Home fallback, multi-event union, missing coordinates, earthquake stations, and padding.

- [ ] **Step 5: Commit focus logic**

```bash
git add app/lib/feature/live_monitor/data/model/live_monitor_map_focus* app/lib/feature/live_monitor/data/logic/live_monitor_map_focus_builder.dart app/test/feature/live_monitor/data/live_monitor_map_focus_builder_test.dart
git commit -m "feat: LiveMonitor地図範囲を計算"
```

### Task 8: Shared MapLibre host and reusable layer groups

**Files:**
- Create: `app/lib/feature/live_monitor/ui/components/live_monitor_map_host.dart`
- Create: `app/lib/feature/live_monitor/ui/components/live_monitor_realtime_layers.dart`
- Create: `app/lib/feature/live_monitor/ui/components/live_monitor_earthquake_layers.dart`
- Modify: `app/lib/feature/earthquake_history/ui/layer/earthquake_history_details_estimated_intensity_layer.dart`
- Test: `app/test/feature/earthquake_history/ui/layer/earthquake_history_map_layer_mode_test.dart` (existing regression)
- Test: `app/test/feature/earthquake_history/ui/layer/earthquake_history_hypocenter_layer_lifecycle_test.dart` (existing regression)
- Test: `app/test/feature/earthquake_history/ui/layer/earthquake_history_station_intensity_layer_lifecycle_test.dart` (existing regression)

**Interfaces:**
- Consumes: `LiveMonitorMapFocus`, map style/config, Home map settings, existing layer widgets.
- Produces: one reusable host and two layer compositions; host key is owned by caller.

- [ ] **Step 1: Harden the estimated-intensity layer cleanup before reusing it**

Replace direct add/remove calls with the repository's existing `replaceMapStyleLayers` / `removeMapStyleResources` pattern so style reload or a rapid estimated→JMA switch cannot leave duplicate fixed IDs. Keep `tileUrl` as the full URL supplied by `Earthquake.estimatedIntensityTileUrl` and continue passing `pmtiles://$tileUrl` only at this established layer boundary.

- [ ] **Step 2: Implement `LiveMonitorMapHost` with stable controller identity**

The host is a `HookConsumerWidget`. It watches `mapConfigurationProvider` and `homeConfigurationProvider`, wraps `MapLibreMap` in `MapOperationQueueScope` and `MapLibreEventProvider`, and receives:

```dart
const LiveMonitorMapHost({
  required this.slotId,
  required this.focus,
  required this.layers,
  super.key,
});

final String slotId;
final LiveMonitorMapFocus focus;
final List<Widget> layers;
```

Use `useState<MapController?>`, `useRef<int>(0)` generation, and the following awaited camera operation:

```dart
final cameraOperation = useMemoized(() async {
  final captured = controller.value;
  if (captured == null) return;
  final capturedGeneration = ++generation.value;
  await captured.fitBounds(
    bounds: focus.bounds.toLngLatBounds(),
    padding: focus.padding.toEdgeInsets(),
  );
  if (!identical(captured, controller.value) ||
      capturedGeneration != generation.value) return;
}, [controller.value, focus]);
useFuture(cameraOperation);
```

Convert `LiveMonitorGeoBounds` to `LngLatBounds` and `LiveMonitorMapPadding` to `EdgeInsets` through public extensions in the host file. The internal `MapLibreMap` の `ValueKey` は style/map settings と `slotId` を含めるが、Pane ratio と Card height は含めない。Task 10 は安定した `automatic` / `realtimeSplit` / `earthquakeSplit` slot ID を渡し、Widget 自体の identity は通常どおり caller-provided `key` に従う。

On map-style error, show a concise retry Card for only that host; loading shows `地図を準備しています`. Do not expose exception text.

- [ ] **Step 3: Compose existing realtime layers**

```dart
class LiveMonitorRealtimeLayers extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eews = ref.watch(eewAliveTelegramProvider) ?? const [];
    final shakes = ref.watch(shakeDetectionVisibleProvider);
    return Stack(children: [
      EewEstimatedIntensityLayer(
        eewRegions: eews
            .map((eew) => eew.forecastIntensity?.regions)
            .nonNulls
            .flattened
            .toList(),
      ),
      const KyoshinMonitorObservationLayer(),
      EewPsWaveLayer(eews: eews),
      ShakeDetectionLayer(events: shakes),
      EewHypocenterLayer(eews: eews),
      const HomeMapLabelLayer(),
    ]);
  }
}
```

Honor the existing Home EEW fill mode exactly as `HomeMapView` does; the abbreviated snippet above is expanded to the same `.intensity/.warning/.none` switch in implementation.

- [ ] **Step 4: Compose earthquake layers by trigger-preferred mode**

`LiveMonitorEarthquakeLayers` takes full `Earthquake` and `IntensityDisplayMode`. Always show the existing hypocenter layer when coordinates exist. For `.estimated`, add `EarthquakeHistoryDetailsEstimatedIntensityLayer` only when the full URL exists. For `.jma`/`.lpgm`, add the existing fill and station layers with the current `EarthquakeHistoryMapLayerParameter`; set `showingLpgmIntensity` only for `.lpgm`. Never import `eqmonitor_api` into this UI file.

- [ ] **Step 5: Run focused existing layer lifecycle tests**

Run: `mise exec -- flutter test app/test/feature/earthquake_history/ui/layer/earthquake_history_map_layer_mode_test.dart app/test/feature/earthquake_history/ui/layer/earthquake_history_hypocenter_layer_lifecycle_test.dart app/test/feature/earthquake_history/ui/layer/earthquake_history_station_intensity_layer_lifecycle_test.dart`

Expected: PASS with no duplicate source/layer IDs and correct cleanup ordering.

- [ ] **Step 6: Commit the reusable map layer slice**

```bash
git add app/lib/feature/live_monitor/ui/components/live_monitor_map_host.dart app/lib/feature/live_monitor/ui/components/live_monitor_realtime_layers.dart app/lib/feature/live_monitor/ui/components/live_monitor_earthquake_layers.dart app/lib/feature/earthquake_history/ui/layer/earthquake_history_details_estimated_intensity_layer.dart
git commit -m "feat: LiveMonitor地図レイヤーを構成"
```

### Task 9: Reusable information Cards

**Files:**
- Create: `app/lib/feature/earthquake_history/ui/components/earthquake_summary_header.dart`
- Modify: `app/lib/feature/earthquake_history/ui/components/earthquake_hypocenter_information_card.dart`
- Modify: `app/lib/feature/home/ui/component/shake_detection/shake_detection_card.dart`
- Create: `app/lib/feature/live_monitor/data/logic/live_monitor_earthquake_card_presenter.dart`
- Create: `app/lib/feature/live_monitor/ui/components/live_monitor_realtime_cards.dart`
- Create: `app/lib/feature/live_monitor/ui/components/live_monitor_earthquake_card.dart`
- Test: `app/test/feature/live_monitor/data/live_monitor_earthquake_card_presenter_test.dart`

**Interfaces:**
- Consumes: existing `EewCard`, `ShakeDetectionCard`, current-location intensity, Earthquake summary/intensity components, trigger.
- Produces: realtime Card stack and compact/full earthquake Card without duplicating core earthquake formatting.

- [ ] **Step 1: Write failing presenter tests for trigger mode and region selection**

```dart
test('VXSE62は長周期、推計震度はestimatedを優先する', () {
  expect(preferredIntensityMode(vxse62Trigger), IntensityDisplayMode.lpgm);
  expect(preferredIntensityMode(estimatedTrigger),
      IntensityDisplayMode.estimated);
  expect(preferredIntensityMode(vxse53Trigger), IntensityDisplayMode.jma);
});

test('compact表示は最大震度階級の地域だけを元の順序で返す', () {
  final regions = maximumIntensityRegions(earthquakeWithRegions({
    JmaIntensity.four: ['A'],
    JmaIntensity.fiveLower: ['B', 'C'],
  }));
  expect(regions.map((region) => region.region.name.ja), ['B', 'C']);
});
```

Add cases where preferred LPGM/estimated data is absent; fall back to JMA instead of displaying an empty mode. Verify `latestSupportedTelegramTrigger(earthquake)` selects the greatest `reportedAt` among VXSE51/52/53/61/62 for a split-pane Card whose trigger is null. Also verify `orderedIntensityRegions` sorts intensity groups descending while preserving the API/model order inside each group.

- [ ] **Step 2: Run the presenter test and verify missing functions**

Run: `mise exec -- flutter test app/test/feature/live_monitor/data/live_monitor_earthquake_card_presenter_test.dart`

Expected: FAIL with missing presenter functions.

- [ ] **Step 3: Extract the existing earthquake summary header**

Move the max-intensity icon, magnitude/depth, hypocenter, occurrence/detection time, and status watermark widgets from `earthquake_hypocenter_information_card.dart` into public `EarthquakeSummaryHeader(item: earthquake)`. Keep the current detail-page Card's visual output by making `EarthquakeHypocenterInformationCard` a thin Card wrapper around that header. LiveMonitor imports the new public component, not private classes and not copied formatting code.

- [ ] **Step 4: Make shake Card outer padding configurable without changing Home defaults**

```dart
class ShakeDetectionCard extends ConsumerWidget {
  const ShakeDetectionCard({
    required this.event,
    this.outerPadding = const EdgeInsets.symmetric(horizontal: 16),
    super.key,
  });
  final ShakeDetectionEvent event;
  final EdgeInsetsGeometry outerPadding;
}
```

Home remains visually unchanged; LiveMonitor passes `EdgeInsets.zero`.

- [ ] **Step 5: Implement presenter and Card stacks**

`LiveMonitorRealtimeCards` sorts EEWs by `(reportTime, serialNo)` descending, then shakes by `(updatedAt, serialNo)` descending. Render all EEWs first with `EewCard`, then all shakes with `ShakeDetectionCard(outerPadding: EdgeInsets.zero)`. Constrain the overlay to 50% of its Pane and use `ListView` only when content exceeds it; do not set a fixed text-containing height.

`LiveMonitorEarthquakeCard` signature:

```dart
const LiveMonitorEarthquakeCard({
  required Earthquake earthquake,
  required LiveMonitorEarthquakeTrigger? trigger,
  required bool compact,
  required DateTime now,
});
```

Both variants use `EarthquakeSummaryHeader` and `CurrentLocationIntensityCard`. Compact adds telegram label/report time, maximum-intensity region names, and at most 50% Pane height. VXSE62 adds `EarthquakeLpgmIntensityCard`; estimated adds a short `推計震度分布` label and the real nullable `generatedAt` (omit when absent) without opening the notice dialog. When `trigger == null`, use `latestSupportedTelegramTrigger` for the label/time but do not invent an estimated-intensity generation time. Full mode is scrollable and renders every `Earthquake.intensity.regions` group returned by `orderedIntensityRegions` with the existing intensity icons; it does not expand city/station details. Show the latest earthquake's publication time and elapsed age using `timeTickerProvider`; never hide an old event.

- [ ] **Step 6: Run presenter and focused existing component tests**

Run: `mise exec -- flutter test app/test/feature/live_monitor/data/live_monitor_earthquake_card_presenter_test.dart app/test/feature/earthquake_history/ui/components/magnitude_text_test.dart app/test/feature/earthquake_history/ui/components/depth_text_test.dart`

Expected: PASS and existing detail formatting remains intact.

- [ ] **Step 7: Commit shared Card slice**

```bash
git add app/lib/feature/earthquake_history/ui/components/earthquake_summary_header.dart app/lib/feature/earthquake_history/ui/components/earthquake_hypocenter_information_card.dart app/lib/feature/home/ui/component/shake_detection/shake_detection_card.dart app/lib/feature/live_monitor/data/logic/live_monitor_earthquake_card_presenter.dart app/lib/feature/live_monitor/ui/components/live_monitor_realtime_cards.dart app/lib/feature/live_monitor/ui/components/live_monitor_earthquake_card.dart app/test/feature/live_monitor/data/live_monitor_earthquake_card_presenter_test.dart
git commit -m "refactor: 地震概要Cardを共通化"
```

### Task 10: Automatic and resizable split Pane layouts

**Files:**
- Create: `app/lib/feature/live_monitor/data/logic/live_monitor_split_ratio.dart`
- Create: `app/lib/feature/live_monitor/ui/components/live_monitor_realtime_pane.dart`
- Create: `app/lib/feature/live_monitor/ui/components/live_monitor_earthquake_pane.dart`
- Create: `app/lib/feature/live_monitor/ui/components/live_monitor_automatic_view.dart`
- Create: `app/lib/feature/live_monitor/ui/components/live_monitor_split_view.dart`
- Create: `app/lib/feature/live_monitor/ui/components/live_monitor_connection_banner.dart`
- Create: `app/lib/feature/live_monitor/ui/components/live_monitor_measured_card_overlay.dart`
- Test: `app/test/feature/live_monitor/data/live_monitor_split_ratio_test.dart`

**Interfaces:**
- Consumes: settings, coordinator state, latest earthquake AsyncValue, focus builder, map host, Cards.
- Produces: automatic one-map view and portrait/landscape two-map split view.

- [ ] **Step 1: Write a failing ratio calculation test**

```dart
test('drag deltaをPane比率へ変換し0.2〜0.8でclampする', () {
  expect(updateLiveMonitorSplitRatio(
    current: 0.5, primaryDelta: 100, availableExtent: 1000), 0.6);
  expect(updateLiveMonitorSplitRatio(
    current: 0.75, primaryDelta: 200, availableExtent: 1000), 0.8);
  expect(updateLiveMonitorSplitRatio(
    current: 0.25, primaryDelta: -200, availableExtent: 1000), 0.2);
});
```

Also verify zero/negative extent returns the current clamped ratio.

- [ ] **Step 2: Run the ratio test and verify the missing function**

Run: `mise exec -- flutter test app/test/feature/live_monitor/data/live_monitor_split_ratio_test.dart`

Expected: FAIL with missing function.

- [ ] **Step 3: Implement ratio calculation and Pane widgets**

```dart
double updateLiveMonitorSplitRatio({
  required double current,
  required double primaryDelta,
  required double availableExtent,
}) {
  if (availableExtent <= 0) return current.clamp(0.2, 0.8);
  return (current + primaryDelta / availableExtent).clamp(0.2, 0.8);
}
```

`LiveMonitorRealtimePane` watches active EEWs/shakes, builds focus with measured Card obstruction, and passes `slotId: 'realtimeSplit'`. `LiveMonitorEarthquakePane` passes `slotId: 'earthquakeSplit'` and watches `liveMonitorLatestEarthquakeProvider`; while refreshing, use `AsyncValueX.valueOrPrevious` to retain the previous map/Card. If the current AsyncValue is error and a previous value exists, overlay `更新に失敗しました`; without cache, show a concise empty/error state and a retry button that invalidates the latest provider. One Pane's error must not replace the other.

`LiveMonitorConnectionBanner` returns `SizedBox.shrink()` for `WsPhase.connected`, `リアルタイム情報へ接続中` for connecting, and `リアルタイム情報へ再接続中` for disconnected. Place it at the top SafeArea without covering controls.

`LiveMonitorMeasuredCardOverlay` wraps the Card with `SizeChangedLayoutNotifier` and a `GlobalKey`. On each size notification, read `key.currentContext?.size?.height` in the next frame and call `ValueChanged<double>` only when the height changed. The owning Pane stores that value in a hook state, caps the Card container at half the current Pane constraints, and rebuilds `LiveMonitorMapFocus` with the measured bottom obstruction. This is measurement only; it must not be part of a MapLibre key.

- [ ] **Step 4: Implement the one-host automatic view**

Keep a single `LiveMonitorMapHost` with `slotId: 'automatic'`. Switch only its `layers` and Card overlay from coordinator state:

```dart
final (layers, card, focus) = switch (state) {
  LiveMonitorRealtimeDisplayState() => (
    const [LiveMonitorRealtimeLayers()],
    const LiveMonitorRealtimeCards(),
    realtimeFocus,
  ),
  LiveMonitorEarthquakeDisplayState(:final earthquake, :final trigger) => (
    [LiveMonitorEarthquakeLayers(
      earthquake: earthquake,
      displayMode: preferredIntensityMode(trigger),
    )],
    LiveMonitorEarthquakeCard(
      earthquake: earthquake, trigger: trigger, compact: true, now: now),
    earthquakeFocus,
  ),
};
```

The map host itself must remain mounted across this switch.

- [ ] **Step 5: Implement orientation-aware split layout with stable map keys**

Use `MediaQuery.orientationOf(context)`. Portrait is `Column(realtime, divider, latest)` and landscape is `Row(realtime, divider, latest)`. Maintain a local drag ratio during `onPanUpdate`; call `LiveMonitorSettingsNotifier.saveMutation` only in `onPanEnd`/`onPanCancel`, selecting the portrait or landscape field. Use a 1-pixel visual divider inside a 24 logical-pixel hit target. Pane widgets have stable `ValueKey('live-monitor-realtime-map')` and `ValueKey('live-monitor-earthquake-map')`; do not include ratio or orientation in those map keys.

- [ ] **Step 6: Run ratio and focused map regressions**

Run: `mise exec -- flutter test app/test/feature/live_monitor/data/live_monitor_split_ratio_test.dart app/test/feature/home/data/provider/map_camera_state_provider_test.dart app/test/feature/earthquake_history/earthquake_history_realtime_details_test.dart`

Expected: PASS.

- [ ] **Step 7: Commit Pane layouts**

```bash
git add app/lib/feature/live_monitor/data/logic/live_monitor_split_ratio.dart app/lib/feature/live_monitor/ui/components/live_monitor_realtime_pane.dart app/lib/feature/live_monitor/ui/components/live_monitor_earthquake_pane.dart app/lib/feature/live_monitor/ui/components/live_monitor_automatic_view.dart app/lib/feature/live_monitor/ui/components/live_monitor_split_view.dart app/lib/feature/live_monitor/ui/components/live_monitor_connection_banner.dart app/lib/feature/live_monitor/ui/components/live_monitor_measured_card_overlay.dart app/test/feature/live_monitor/data/live_monitor_split_ratio_test.dart
git commit -m "feat: LiveMonitor画面を分割表示"
```

### Task 11: Tap-only control panel, exit confirmation, route, and Home entry

**Files:**
- Create: `app/lib/feature/live_monitor/data/logic/live_monitor_tap_tracker.dart`
- Create: `app/lib/feature/live_monitor/ui/action/live_monitor_exit_action.dart`
- Create: `app/lib/feature/live_monitor/ui/components/live_monitor_control_panel.dart`
- Create: `app/lib/feature/live_monitor/ui/components/live_monitor_entry_card.dart`
- Create: `app/lib/feature/live_monitor/ui/page/live_monitor_page.dart`
- Modify: `app/lib/page/home_page.dart`
- Modify: `app/lib/core/router/router.dart`
- Modify: `app/lib/core/router/router.g.dart` (generated)
- Test: `app/test/feature/live_monitor/data/live_monitor_tap_tracker_test.dart`

**Interfaces:**
- Consumes: settings notifier/mutation, panel notifier, automatic/split views.
- Produces: `LiveMonitorRoute` at `/live-monitor`, tap-to-open in-page panel, confirmed exit.

- [ ] **Step 1: Write failing raw-pointer tap tracker tests**

```dart
test('単一pointerの移動なしupだけをtapと判定する', () {
  final tracker = LiveMonitorTapTracker(touchSlop: 18);
  tracker.pointerDown(pointer: 1, position: const Offset(10, 10));
  expect(tracker.pointerUp(pointer: 1, position: const Offset(12, 12)), isTrue);
});

test('pan、pinch、Divider dragはtapにしない', () {
  final tracker = LiveMonitorTapTracker(touchSlop: 18);
  tracker.pointerDown(pointer: 1, position: Offset.zero);
  tracker.pointerMove(pointer: 1, position: const Offset(30, 0));
  expect(tracker.pointerUp(pointer: 1, position: const Offset(30, 0)), isFalse);

  tracker.pointerDown(pointer: 1, position: Offset.zero);
  tracker.pointerDown(pointer: 2, position: const Offset(20, 20));
  expect(tracker.pointerUp(pointer: 1, position: Offset.zero), isFalse);
});
```

- [ ] **Step 2: Run tracker test and verify missing class**

Run: `mise exec -- flutter test app/test/feature/live_monitor/data/live_monitor_tap_tracker_test.dart`

Expected: FAIL with missing tracker.

- [ ] **Step 3: Implement pointer tracker and in-page panel**

`LiveMonitorTapTracker` stores active pointer, start position, and a cancelled flag. Any second pointer, pointer cancel, or distance above touch slop cancels the tap. The page wraps its content with `Listener`, feeds raw pointer events to the tracker, and opens the panel only on a true `pointerUp`; this observes map gestures without competing in Flutter's gesture arena.

Render the panel inside the page Stack, not as a router transition:

```dart
if (panelOpen) ...[
  const ModalBarrier(dismissible: false),
  Align(
    alignment: Alignment.bottomCenter,
    child: LiveMonitorControlPanel(onExit: requestExit),
  ),
]
```

The panel has `ConstrainedBox(maxWidth: 560)`, SafeArea, segmented display-mode control, integer TextField, wake-lock Switch, explicit `閉じる`, and `LiveMonitor モードを終了`. Validate on change, show a fixed Japanese error message near the field, and save only a valid submitted/focus-lost integer through `saveMutation`. Barrier taps do nothing and the panel never auto-closes.

- [ ] **Step 4: Implement one shared exit confirmation flow**

`LiveMonitorExitAction.confirm` is a provider-injected Action method receiving `WidgetRef ref`, `BuildContext context`, and `VoidCallback onConfirmed`. It shows `LiveMonitor モードを終了しますか？` with cancel/exit. `PopScope(canPop: allowExit.value)` routes both system back and panel exit through this action; on confirmation set `allowExit`, wait for the next frame, then `context.pop()`. Do not define context/ref-holding constructors.

- [ ] **Step 5: Add page mode switch, route, and HomeSheet Card**

`LiveMonitorPage` watches settings and `liveMonitorCoordinatorProvider` regardless of display mode, so split mode still detects a new EEW and closes the panel. While settings load, show a concise preparation state; then choose `LiveMonitorAutomaticView` or `LiveMonitorSplitView`, with `LiveMonitorConnectionBanner` and the panel above them. Add:

```dart
@TypedGoRoute<LiveMonitorRoute>(path: '/live-monitor')
class LiveMonitorRoute extends GoRouteData with $LiveMonitorRoute {
  const LiveMonitorRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const LiveMonitorPage();
}
```

Wrap the page in `SafeArea`. Place the control panel inside `DisplayFeatureSubScreen` so a hinge/fold does not bisect its actions, and keep Pane Cards inside each Pane's SafeArea rather than the full-window padding.

`LiveMonitorEntryCard` is an outlined Material 3 Card labelled `LiveMonitor モード`, explains `地震情報を常時表示`, and pushes `const LiveMonitorRoute()`. Insert it in `_SheetBody` after active EEW/shake Cards and before `HomeEarthquakeHistorySheet`.

- [ ] **Step 6: Generate router and provider output**

Run from `app/`: `mise exec -- dart run build_runner build --delete-conflicting-outputs --build-filter="lib/core/router/router.g.dart" --build-filter="lib/feature/live_monitor/**"`

Expected: `router.g.dart` contains `/live-monitor`; no hand-edited generated output.

- [ ] **Step 7: Run tap test and route analyze**

Run: `mise exec -- flutter test app/test/feature/live_monitor/data/live_monitor_tap_tracker_test.dart`

Run from `app/`: `mise exec -- dart analyze lib/feature/live_monitor lib/core/router/router.dart lib/page/home_page.dart`

Expected: PASS and no analyzer issues.

- [ ] **Step 8: Commit navigation and controls**

```bash
git add app/lib/feature/live_monitor app/lib/page/home_page.dart app/lib/core/router/router.dart app/lib/core/router/router.g.dart app/test/feature/live_monitor/data/live_monitor_tap_tracker_test.dart
git commit -m "feat: LiveMonitor画面を追加"
```

### Task 12: Session-aware EEW overlay suppression

**Files:**
- Create: `app/lib/feature/live_monitor/data/notifier/live_monitor_session_notifier.dart`
- Create: `app/lib/feature/live_monitor/data/notifier/live_monitor_session_notifier.g.dart` (generated)
- Modify: `app/lib/feature/live_monitor/ui/page/live_monitor_page.dart`
- Modify: `app/lib/feature/eew/ui/components/eew_warning_overlay_host.dart`
- Test: `app/test/feature/live_monitor/data/live_monitor_session_notifier_test.dart`
- Test: `app/test/feature/eew/data/eew_warning_overlay_render_policy_test.dart`

**Interfaces:**
- Consumes: LiveMonitor page mount/dispose and existing overlay state.
- Produces: app-wide `liveMonitorSessionProvider`, pure overlay render policy.

- [ ] **Step 1: Write failing session and render-policy tests**

```dart
test('activate/deactivateでsession状態を公開する', () {
  final container = ProviderContainer();
  addTearDown(container.dispose);
  container.read(liveMonitorSessionProvider.notifier).activate();
  expect(container.read(liveMonitorSessionProvider), isTrue);
  container.read(liveMonitorSessionProvider.notifier).deactivate();
  expect(container.read(liveMonitorSessionProvider), isFalse);
});

test('LiveMonitor active中だけoverlay描画を抑止する', () {
  expect(shouldRenderEewWarningOverlay(
    lifecycle: AppLifecycleState.resumed,
    mode: EewWarningOverlayMode.fullscreen,
    hasDisplayModel: true,
    liveMonitorActive: true,
  ), isFalse);
  expect(shouldRenderEewWarningOverlay(
    lifecycle: AppLifecycleState.resumed,
    mode: EewWarningOverlayMode.fullscreen,
    hasDisplayModel: true,
    liveMonitorActive: false,
  ), isTrue);
});
```

- [ ] **Step 2: Run tests and verify missing provider/policy failures**

Run: `mise exec -- flutter test app/test/feature/live_monitor/data/live_monitor_session_notifier_test.dart app/test/feature/eew/data/eew_warning_overlay_render_policy_test.dart`

Expected: FAIL with missing symbols.

- [ ] **Step 3: Implement session state and use it only in the overlay host's rendering gate**

`LiveMonitorSessionNotifier` is keepAlive and starts false. The page activates it in a `useEffect` and deactivates it in cleanup. Extract the host's existing lifecycle/mode/model condition to `shouldRenderEewWarningOverlay(...)`, add `liveMonitorActive`, and return `child` when false. Do not alter `eewWarningOverlayNotifierProvider`, candidate selection, scheduler, or vibration service; those continue running.

- [ ] **Step 4: Generate provider and rerun tests**

Run from `app/`: `mise exec -- dart run build_runner build --delete-conflicting-outputs --build-filter="lib/feature/live_monitor/data/notifier/live_monitor_session_notifier.g.dart"`

Run: `mise exec -- flutter test app/test/feature/live_monitor/data/live_monitor_session_notifier_test.dart app/test/feature/eew/data/eew_warning_overlay_render_policy_test.dart app/test/feature/eew/data/service/eew_warning_overlay_vibration_service_test.dart`

Expected: PASS; vibration regression remains green.

- [ ] **Step 5: Commit overlay integration**

```bash
git add app/lib/feature/live_monitor/data/notifier/live_monitor_session_notifier* app/lib/feature/live_monitor/ui/page/live_monitor_page.dart app/lib/feature/eew/ui/components/eew_warning_overlay_host.dart app/test/feature/live_monitor/data/live_monitor_session_notifier_test.dart app/test/feature/eew/data/eew_warning_overlay_render_policy_test.dart
git commit -m "feat: LiveMonitor中のEEW表示を統合"
```

### Task 13: Foreground-only screen wake lock

**Files:**
- Modify: `app/pubspec.yaml` via `flutter pub add`
- Modify: `pubspec.lock`
- Create: `app/lib/feature/live_monitor/data/service/live_monitor_wake_lock_platform.dart`
- Create: `app/lib/feature/live_monitor/data/service/live_monitor_wake_lock_platform.g.dart` (generated)
- Create: `app/lib/feature/live_monitor/data/provider/live_monitor_wake_lock_controller.dart`
- Create: `app/lib/feature/live_monitor/data/provider/live_monitor_wake_lock_controller.g.dart` (generated)
- Modify: `app/lib/app.dart`
- Test: `app/test/feature/live_monitor/data/live_monitor_wake_lock_controller_test.dart`
- Create: `docs/knowledge/20260727_live_monitor_wake_lock.md`

**Interfaces:**
- Consumes: session active, `LiveMonitorSettings.keepScreenAwake`, `appLifecycleProvider`.
- Produces: idempotent enable/disable calls through an overridable platform adapter.

- [ ] **Step 1: Add wakelock_plus using the required dependency command**

Run from `app/`: `mise exec -- flutter pub add wakelock_plus`

Expected: `app/pubspec.yaml` and root workspace lockfile update; do not hand-edit the dependency.

- [ ] **Step 2: Write failing controller tests with a fake platform**

```dart
test('activeかつ設定有効かつresumedだけenableする', () async {
  final fake = FakeLiveMonitorWakeLockPlatform();
  final container = createWakeLockContainer(platform: fake);
  addTearDown(container.dispose);

  setSession(container, true);
  setSettings(container, keepScreenAwake: true);
  setLifecycle(container, AppLifecycleState.resumed);
  await container.read(liveMonitorWakeLockControllerProvider.future);
  expect(fake.calls, [true]);

  setLifecycle(container, AppLifecycleState.paused);
  await container.read(liveMonitorWakeLockControllerProvider.future);
  expect(fake.calls.last, isFalse);
});
```

Add cases for setting off, session exit, foreground resume, duplicate desired state (no duplicate platform call), and platform exception being logged without changing the visible mode.

- [ ] **Step 3: Run the controller test and verify missing service/provider failures**

Run: `mise exec -- flutter test app/test/feature/live_monitor/data/live_monitor_wake_lock_controller_test.dart`

Expected: FAIL with missing adapter/controller.

- [ ] **Step 4: Implement adapter and controller Provider**

```dart
abstract interface class LiveMonitorWakeLockPlatform {
  Future<void> setEnabled({required bool enabled});
}

final class WakelockPlusLiveMonitorWakeLockPlatform
    implements LiveMonitorWakeLockPlatform {
  @override
  Future<void> setEnabled({required bool enabled}) async {
    if (enabled) {
      await WakelockPlus.enable();
    } else {
      await WakelockPlus.disable();
    }
  }
}
```

Provide it with Riverpod. The keepAlive async controller watches all three inputs, calculates `active && keepScreenAwake && lifecycle == resumed`, skips a platform call when the desired value is unchanged, awaits `setEnabled`, and catches/logs exceptions through talker. Watch the controller once from `App.build` so it remains alive while the LiveMonitor page deactivates its session and can await the final disable.

```dart
@Riverpod(keepAlive: true)
class LiveMonitorWakeLockController
    extends _$LiveMonitorWakeLockController {
  bool? appliedEnabled;

  @override
  Future<void> build() async {
    final sessionActive = ref.watch(liveMonitorSessionProvider);
    final lifecycle = ref.watch(appLifecycleProvider);
    final settings = await ref.watch(liveMonitorSettingsProvider.future);
    final desired = sessionActive &&
        settings.keepScreenAwake &&
        lifecycle == AppLifecycleState.resumed;
    if (desired == appliedEnabled) return;
    try {
      await ref
          .read(liveMonitorWakeLockPlatformProvider)
          .setEnabled(enabled: desired);
      appliedEnabled = desired;
    } on Exception catch (error, stackTrace) {
      talker.error('Failed to update LiveMonitor wake lock', error, stackTrace);
    }
  }
}
```

- [ ] **Step 5: Document the lifecycle invariant**

`docs/knowledge/20260727_live_monitor_wake_lock.md` must state: only the session/lifecycle controller calls wakelock_plus; background, exit, and setting-off resolve to disable; plugin errors must not replace seismic information UI; iOS and Android need manual foreground/background verification. Include the dependency and focused test commands.

- [ ] **Step 6: Generate providers and rerun tests**

Run from `app/`: `mise exec -- dart run build_runner build --delete-conflicting-outputs --build-filter="lib/feature/live_monitor/data/service/**" --build-filter="lib/feature/live_monitor/data/provider/**"`

Run: `mise exec -- flutter test app/test/feature/live_monitor/data/live_monitor_wake_lock_controller_test.dart`

Expected: PASS for every lifecycle/setting/session transition and failure containment.

- [ ] **Step 7: Commit wake-lock support and knowledge**

```bash
git add app/pubspec.yaml pubspec.lock app/lib/app.dart app/lib/feature/live_monitor/data/service app/lib/feature/live_monitor/data/provider app/test/feature/live_monitor/data/live_monitor_wake_lock_controller_test.dart docs/knowledge/20260727_live_monitor_wake_lock.md
git commit -m "feat: LiveMonitor中の画面点灯を維持"
```

### Task 14: Full integration verification and manual QA

**Files:**
- Modify only if verification exposes a scoped defect; do not add unrelated cleanup.

**Interfaces:**
- Consumes: all previous tasks.
- Produces: verified, reviewable LiveMonitor implementation branch.

- [ ] **Step 1: Regenerate all app outputs once and inspect generated scope**

Run from `app/`: `mise exec -- dart run build_runner build --delete-conflicting-outputs`

Run: `git status --short`

Expected: only intended LiveMonitor, Realtime, router, and generated files are modified. Investigate any unrelated generated churn before staging it.

- [ ] **Step 2: Run all new unit tests**

Run: `mise exec -- flutter test app/test/feature/live_monitor app/test/core/realtime/eqmonitor_realtime_event_mapper_test.dart`

Expected: PASS; no Widget test was added.

- [ ] **Step 3: Run focused existing regressions**

Run:

```bash
mise exec -- flutter test \
  app/test/feature/eew/data/eew_realtime_test.dart \
  app/test/feature/eew/data/service/eew_warning_overlay_vibration_service_test.dart \
  app/test/feature/shake_detection/data/shake_detection_visible_test.dart \
  app/test/feature/shake_detection/data/shake_detection_snapshot_reducer_test.dart \
  app/test/feature/earthquake_history/earthquake_history_realtime_details_test.dart \
  app/test/feature/earthquake_history/earthquake_history_realtime_list_test.dart \
  app/test/feature/home/data/provider/map_camera_state_provider_test.dart \
  app/test/feature/earthquake_history/ui/layer/earthquake_history_map_layer_mode_test.dart
```

Expected: PASS.

- [ ] **Step 4: Run focused analyze and whitespace verification**

Run from `app/`: `mise exec -- dart analyze lib/feature/live_monitor lib/core/realtime lib/feature/eew/ui/components/eew_warning_overlay_host.dart lib/feature/earthquake_history lib/page/home_page.dart lib/core/router/router.dart`

Run from repository root: `git diff --check`

Expected: zero analyzer diagnostics and zero whitespace errors.

- [ ] **Step 5: Perform the approved manual QA matrix**

On iOS Simulator/device and Android emulator/device verify:

- phone and tablet; portrait and landscape; Light and Dark; enlarged text; available fold/hinge emulator profile;
- automatic mode starts with strong-motion monitor and uses one map instance;
- split mode shows two working maps, divider drags continuously 20–80%, and portrait/landscape ratios restore independently after relaunch;
- map pan/pinch/rotate and divider drag do not open the panel; a simple tap does;
- barrier does not close panel, explicit close does, back/exit share confirmation;
- multiple EEWs and shakes stack/scroll and all are included in camera focus;
- VXSE51/52/53/61/62 and estimated intensity choose the correct Card/map mode;
- same/different earthquake updates restart display time; existing EEW/shake waits to 3 seconds; new EEW interrupts and closes panel immediately;
- interrupted earthquake is not resumed; switching modes cancels old deadlines;
- latest split earthquake remains visible when old, reports age, and an older event update does not replace it;
- disconnect/reconnect, background/resume, cached detail error, empty detail, and independent map error states;
- EEW fullscreen/banner is hidden only during LiveMonitor while vibration remains;
- keep-awake enables only in foreground and disables on background, setting off, and exit;
- no disappearing map, duplicate layer/source ID, controller leak, or map recreation during Divider drag.

Record device/OS and pass/fail counts in the implementation handoff; do not create a Widget test as a substitute for this matrix.

- [ ] **Step 6: Request code review and fix all in-scope findings**

Use `superpowers:requesting-code-review`. Re-run the smallest affected unit/regression set after each fix, then repeat Step 4.

- [ ] **Step 7: Commit any verification-only fixes in reviewable slices**

Inspect `git status --short`, stage each verified fix path explicitly (never `git add .`), then run `git commit -m "fix: LiveMonitor検証結果を反映"`.

Skip this commit when verification required no changes.

- [ ] **Step 8: Final branch check before publication**

Run:

```bash
git status --short --branch
git --no-pager log --oneline origin/develop..HEAD
git --no-pager diff --stat origin/develop...HEAD
```

Expected: clean worktree, intentional commits only, no unrelated main-worktree changes. Then use `superpowers:finishing-a-development-branch` for the user-selected publish/merge flow; project instructions require pushing completed commits.
