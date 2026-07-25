# EEW Warning Overlay Domain Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement the persisted enable setting, real EEW candidate selection and display modeling, live dual-JMA-area provider wiring, and fixed simulation source consumed by the overlay state/UI plan.

**Architecture:** Keep safety-critical selection and ordering in pure, dependency-free classes under `feature/eew/data/logic`, with Riverpod providers limited to wiring existing EEW, clock, location, and JMA-map inputs. Produce one nullable effective display model: a real eligible warning always wins, while the fixed simulation is independent of live providers and is permanently cleared when preempted by a real warning.

**Tech Stack:** Flutter, Dart 3, Riverpod 3 code generation, Freezed, SharedPreferences, `flutter_test` unit/provider tests

## Global Constraints

- The approved behavior is defined by `docs/superpowers/specs/2026-07-25-eew-warning-overlay-design.md`.
- This plan implements domain, provider, preference, and simulation logic only; root overlay state, lifecycle, timer, vibration, UI, and settings-page widgets belong to Plan 2.
- Real candidates require realtime mode, the enabled setting, a live non-canceled warning, resolved `areaForecastLocalEew`, and a matching `warning.regions` entry with `hadWarning == true`.
- Resolve `areaForecastLocalEew` for warning eligibility and `areaForecastLocalE` separately for `forecastIntensity.regions` local intensity and arrival lookup.
- Loading, error, missing position, missing warning-map item, or missing
  warning-map property must never reuse a stale warning area or introduce a
  nationwide/fixed fallback. An unresolved forecast area does not suppress an
  otherwise eligible warning; local intensity and arrival become unknown.
- Do not use `eewAliveNormalTelegramProvider`; PLUM warnings remain eligible, but their hypocenter is not emphasized.
- Do not use `eewEstimatedRegionIntensityProvider` as a local intensity or arrival fallback.
- `isCanceled == true` is rejected immediately even though `eewAliveTelegramProvider` retains cancellations temporarily.
- The setting defaults to enabled; simulation remains available while the setting is disabled.
- Simulation must not mutate `eewProvider`, location providers, or their test overrides.
- A real display preempts and clears simulation; simulation must not return after the real display ends.
- Do not add Widget tests in this plan.
- Run every Flutter/Dart command through `mise exec --`.
- Do not hand-edit generated `.g.dart` or `.freezed.dart` files; generate them with `mise exec -- dart run build_runner build --delete-conflicting-outputs`.
- Follow TDD: observe the focused test fail before implementing each task, then rerun it to green.
- Preserve the existing dirty `backend` submodule and unrelated untracked plan files.

## File Structure

- `app/lib/core/data/preferences/shared/shared_preferences_key.dart` — adds the single persisted overlay enable key.
- `app/lib/feature/eew/data/notifier/eew_warning_overlay_enabled_notifier.dart` — owns the default-true persisted setting.
- `app/lib/feature/eew/data/model/eew_warning_overlay_candidate.dart` — represents one live warning eligible at the current warning area, plus optional local forecast data.
- `app/lib/feature/eew/data/model/eew_warning_overlay_display_model.dart` — stable public contract consumed by Plan 2.
- `app/lib/feature/eew/data/logic/eew_warning_candidate_selector.dart` — filters live EEWs against the current warning area and attaches the local forecast region.
- `app/lib/feature/eew/data/logic/eew_warning_arrival_classifier.dart` — classifies local main-motion arrival without treating unknown as arrived.
- `app/lib/feature/eew/data/logic/eew_warning_representative_selector.dart` — applies the approved deterministic representative ordering.
- `app/lib/feature/eew/data/logic/eew_warning_display_model_builder.dart` — builds backend-compatible headlines and the aggregated real display model.
- `app/lib/feature/eew/data/provider/eew_warning_overlay_candidate_provider.dart` — wires realtime, setting, alive EEWs, location, and both JMA areas.
- `app/lib/feature/eew/data/provider/eew_warning_overlay_display_provider.dart` — rebuilds the real display model as candidates and current time change.
- `app/lib/feature/eew/data/notifier/eew_warning_overlay_simulation_notifier.dart` — owns only the fixed training request and clears it on real preemption.
- `app/lib/feature/eew/data/provider/eew_warning_overlay_effective_display_provider.dart` — exposes the single real-first model watched by Plan 2.

## Public Contract for Plan 2

Plan 2 must consume these exact generated providers and methods without reaching back into `eewProvider` or location providers:

```dart
enum EewWarningOverlaySource { real, simulation }

enum EewWarningArrivalState { unarrived, unknown, arrived }

@Freezed(toJson: false)
abstract class EewWarningOverlayDisplayModel
    with _$EewWarningOverlayDisplayModel {
  const factory EewWarningOverlayDisplayModel({
    required EewWarningOverlaySource source,
    required List<String> eventIds,
    required String representativeEventId,
    required int serialNo,
    required int alertCount,
    required String reportLabel,
    required String? hypocenterHeadline,
    required String strongMotionHeadline,
    required String currentRegionName,
    required JmaIntensity localIntensity,
    required bool localIntensityIsOver,
    required EewWarningArrivalState arrivalState,
    required int? secondsUntilArrival,
    required String? hypocenterName,
    required double? magnitude,
    required int? depth,
  }) = _EewWarningOverlayDisplayModel;
}

// Real-only candidates. Plan 2 may inspect IDs for state transitions.
List<EewWarningOverlayCandidate> eewWarningOverlayCandidates(Ref ref);

// Real-only model; null means no currently eligible real warning.
EewWarningOverlayDisplayModel? eewWarningOverlayDisplay(Ref ref);

// Real-first model used to render and drive Plan 2's state machine.
EewWarningOverlayDisplayModel? eewWarningOverlayEffectiveDisplay(Ref ref);

@riverpod
class EewWarningOverlaySimulation
    extends _$EewWarningOverlaySimulation {
  EewWarningOverlayDisplayModel? build();
  void start();
  void stop();
}

@Riverpod(keepAlive: true)
class EewWarningOverlayEnabled
    extends _$EewWarningOverlayEnabled {
  Future<bool> build();
  Future<void> set({required bool value});
}
```

Plan 2 should watch `eewWarningOverlayEffectiveDisplayProvider` and compare its
`source` and `eventIds` set with the in-memory seen set. A non-null model is not
by itself a new-event signal because later reports replace content without
retriggering the same `eventId`.

---

### Task 1: Persist the Default-Enabled Overlay Setting

**Files:**
- Modify: `app/lib/core/data/preferences/shared/shared_preferences_key.dart`
- Create: `app/lib/feature/eew/data/notifier/eew_warning_overlay_enabled_notifier.dart`
- Create: `app/lib/feature/eew/data/notifier/eew_warning_overlay_enabled_notifier.g.dart` (generated)
- Test: `app/test/feature/eew/data/notifier/eew_warning_overlay_enabled_notifier_test.dart`

**Interfaces:**
- Consumes: `SharedPreferencesKey`, `sharedPreferencesDataSourceProvider`
- Produces: `SharedPreferencesKey.eewWarningOverlayEnabled`, `eewWarningOverlayEnabledProvider`, `EewWarningOverlayEnabled.set({required bool value})`

- [ ] **Step 1: Write the failing preference tests**

Create `app/test/feature/eew/data/notifier/eew_warning_overlay_enabled_notifier_test.dart` with binding initialization and these three tests:

```dart
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/feature/eew/data/notifier/eew_warning_overlay_enabled_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('EewWarningOverlayEnabled', () {
    test('未設定ならtrueを返す', () async {
      SharedPreferences.setMockInitialValues({});
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(
        await container.read(eewWarningOverlayEnabledProvider.future),
        isTrue,
      );
    });

    test('保存済みfalseを復元する', () async {
      SharedPreferences.setMockInitialValues({
        SharedPreferencesKey.eewWarningOverlayEnabled.key: false,
      });
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(
        await container.read(eewWarningOverlayEnabledProvider.future),
        isFalse,
      );
    });

    test('setは状態とSharedPreferencesを更新する', () async {
      SharedPreferences.setMockInitialValues({});
      final container = ProviderContainer();
      addTearDown(container.dispose);
      await container.read(eewWarningOverlayEnabledProvider.future);

      await container
          .read(eewWarningOverlayEnabledProvider.notifier)
          .set(value: false);

      expect(container.read(eewWarningOverlayEnabledProvider).value, isFalse);
      final preferences = await SharedPreferences.getInstance();
      expect(
        preferences.getBool(
          SharedPreferencesKey.eewWarningOverlayEnabled.key,
        ),
        isFalse,
      );
    });
  });
}
```

- [ ] **Step 2: Run the focused test and confirm the missing symbols fail**

Run:

```bash
cd app
mise exec -- flutter test test/feature/eew/data/notifier/eew_warning_overlay_enabled_notifier_test.dart
```

Expected: FAIL because the enum value, notifier file, and generated provider do not exist.

- [ ] **Step 3: Add the enum key and notifier implementation**

Add this enum entry before the terminating semicolon in `shared_preferences_key.dart`:

```dart
eewWarningOverlayEnabled('eew_warning_overlay_enabled'),
```

Create `eew_warning_overlay_enabled_notifier.dart`:

```dart
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_warning_overlay_enabled_notifier.g.dart';

@Riverpod(keepAlive: true)
class EewWarningOverlayEnabled extends _$EewWarningOverlayEnabled {
  @override
  Future<bool> build() async {
    final dataSource = await ref.watch(
      sharedPreferencesDataSourceProvider.future,
    );
    return await dataSource.getBool(
          key: SharedPreferencesKey.eewWarningOverlayEnabled,
        ) ??
        true;
  }

  Future<void> set({required bool value}) async {
    final dataSource = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    await dataSource.setBool(
      key: SharedPreferencesKey.eewWarningOverlayEnabled,
      value: value,
    );
    state = AsyncData(value);
  }
}
```

- [ ] **Step 4: Generate Riverpod code and rerun the test**

Run:

```bash
cd app
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- flutter test test/feature/eew/data/notifier/eew_warning_overlay_enabled_notifier_test.dart
```

Expected: generation succeeds and all 3 tests PASS.

- [ ] **Step 5: Commit the setting slice**

```bash
git add app/lib/core/data/preferences/shared/shared_preferences_key.dart app/lib/feature/eew/data/notifier/eew_warning_overlay_enabled_notifier.dart app/lib/feature/eew/data/notifier/eew_warning_overlay_enabled_notifier.g.dart app/test/feature/eew/data/notifier/eew_warning_overlay_enabled_notifier_test.dart
git commit -m "feat: EEW警報overlayの有効設定を追加"
```

### Task 2: Build Pure Candidate, Arrival, Representative, and Display Logic

**Files:**
- Create: `app/lib/feature/eew/data/model/eew_warning_overlay_candidate.dart`
- Create: `app/lib/feature/eew/data/model/eew_warning_overlay_candidate.freezed.dart` (generated)
- Create: `app/lib/feature/eew/data/model/eew_warning_overlay_display_model.dart`
- Create: `app/lib/feature/eew/data/model/eew_warning_overlay_display_model.freezed.dart` (generated)
- Create: `app/lib/feature/eew/data/logic/eew_warning_candidate_selector.dart`
- Create: `app/lib/feature/eew/data/logic/eew_warning_arrival_classifier.dart`
- Create: `app/lib/feature/eew/data/logic/eew_warning_representative_selector.dart`
- Create: `app/lib/feature/eew/data/logic/eew_warning_display_model_builder.dart`
- Test: `app/test/feature/eew/data/logic/eew_warning_candidate_selector_test.dart`
- Test: `app/test/feature/eew/data/logic/eew_warning_display_model_builder_test.dart`

**Interfaces:**
- Consumes: `EewTelegramItem`, `EewForecastRegionInfo`, `JmaIntensity`
- Produces: `EewWarningOverlayCandidate`, `EewWarningOverlayDisplayModel`, `EewWarningArrivalState`, `EewWarningOverlaySource`, and the four public logic classes described below

- [ ] **Step 1: Define model-facing test fixtures and failing candidate tests**

In `eew_warning_candidate_selector_test.dart`, define a fixture builder accepting `eventId`, `isWarning`, `isCanceled`, `warningRegionCode`, `hadWarning`, `forecastRegionCode`, `intensity`, `arrivalTime`, and `isArrived`. Write these assertions using warning area code `100` and forecast area code `100`:

```dart
final selector = EewWarningCandidateSelector();

test('現在のwarning regionにhadWarningがある警報だけを返す', () {
  final result = selector.select(
    aliveEews: [
      warningEew(eventId: 'eligible', warningRegionCode: '100'),
      warningEew(eventId: 'other', warningRegionCode: '200'),
      warningEew(
        eventId: 'previous-only',
        warningRegionCode: '100',
        hadWarning: false,
      ),
      warningEew(
        eventId: 'forecast',
        warningRegionCode: '100',
        isWarning: false,
      ),
      warningEew(
        eventId: 'canceled',
        warningRegionCode: '100',
        isCanceled: true,
      ),
    ],
    warningAreaCode: '100',
    warningAreaName: '石狩地方北部',
    forecastAreaCode: '100',
    forecastAreaName: '石狩地方北部',
  );

  expect(result.map((candidate) => candidate.event.eventId), ['eligible']);
});

test('forecast area codeで現在地震度と到達情報を関連付ける', () {
  final arrival = DateTime.utc(2026, 7, 25, 12, 0, 10);
  final result = selector.select(
    aliveEews: [
      warningEew(
        eventId: 'event',
        warningRegionCode: '100',
        forecastRegionCode: '100',
        intensity: JmaIntensity.sixLower,
        arrivalTime: arrival,
      ),
    ],
    warningAreaCode: '100',
    warningAreaName: '石狩地方北部',
    forecastAreaCode: '100',
    forecastAreaName: '石狩地方北部',
  ).single;

  expect(result.localForecastRegion?.intensity, JmaIntensity.sixLower);
  expect(result.localForecastRegion?.arrivalTime, arrival);
});

test('forecast area未解決でも対象警報は候補に残す', () {
  final result = selector.select(
    aliveEews: [warningEew(eventId: 'event', warningRegionCode: '100')],
    warningAreaCode: '100',
    warningAreaName: '石狩地方北部',
    forecastAreaCode: null,
    forecastAreaName: null,
  ).single;

  expect(result.localForecastRegion, isNull);
});
```

The fixture must populate `warning.regions` for eligibility, `warning.zones` for headlines, and `forecastIntensity.regions` for local values. It must not use event-level `arrivalTime` as local arrival.

- [ ] **Step 2: Write failing arrival, ordering, and display-builder tests**

In `eew_warning_display_model_builder_test.dart`, use a fixed `now = DateTime.utc(2026, 7, 25, 12)` and candidates produced by the candidate selector. Cover the exact ordering with a table:

```dart
test('到達区分を未到達 不明 到達済みの順に分類する', () {
  final classifier = EewWarningArrivalClassifier();
  expect(
    classifier.classify(
      candidate: candidate(arrivalTime: now.add(const Duration(seconds: 5))),
      now: now,
    ),
    EewWarningArrivalState.unarrived,
  );
  expect(
    classifier.classify(candidate: candidate(), now: now),
    EewWarningArrivalState.unknown,
  );
  expect(
    classifier.classify(candidate: candidate(isArrived: true), now: now),
    EewWarningArrivalState.arrived,
  );
  expect(
    classifier.classify(candidate: candidate(arrivalTime: now), now: now),
    EewWarningArrivalState.arrived,
  );
});

test('代表は到達区分 震度 reportTime eventIdの辞書順で決まる', () {
  final selected = EewWarningRepresentativeSelector().select(
    candidates: [
      candidate(eventId: 'd', intensity: JmaIntensity.seven, isArrived: true),
      candidate(eventId: 'c', intensity: JmaIntensity.fiveLower),
      candidate(
        eventId: 'b',
        intensity: JmaIntensity.sixLower,
        arrivalTime: now.add(const Duration(seconds: 10)),
        reportTime: now,
      ),
      candidate(
        eventId: 'a',
        intensity: JmaIntensity.sixLower,
        arrivalTime: now.add(const Duration(seconds: 10)),
        reportTime: now,
      ),
    ],
    now: now,
  );

  expect(selected?.event.eventId, 'a');
});

test('実警報表示を構造化データから集約する', () {
  final model = EewWarningDisplayModelBuilder().build(
    candidates: [
      candidate(
        eventId: 'b',
        serialNo: 3,
        detailedHypocenterName: 'テスト震源詳細',
        warningZones: const [('9920', '東北'), ('9910', '北海道')],
        intensity: JmaIntensity.sixLower,
        arrivalTime: now.add(const Duration(seconds: 10)),
      ),
      candidate(
        eventId: 'c',
        warningZones: const [('9920', '東北'), ('9931', '関東')],
        intensity: JmaIntensity.fiveUpper,
      ),
    ],
    now: now,
  );

  expect(model?.source, EewWarningOverlaySource.real);
  expect(model?.representativeEventId, 'b');
  expect(model?.eventIds, ['b', 'c']);
  expect(model?.alertCount, 2);
  expect(model?.reportLabel, '緊急地震速報（警報） 第3報');
  expect(model?.hypocenterHeadline, 'テスト震源詳細で地震');
  expect(model?.strongMotionHeadline, '北海道 東北 関東で強い揺れ');
  expect(model?.localIntensity, JmaIntensity.sixLower);
  expect(model?.arrivalState, EewWarningArrivalState.unarrived);
  expect(model?.secondsUntilArrival, 10);
});
```

Add explicit tests asserting:

```dart
expect(
  builder.build(candidates: [plumCandidate], now: now)?.hypocenterHeadline,
  isNull,
);
expect(
  builder.build(candidates: [levelCandidate], now: now)?.hypocenterHeadline,
  isNull,
);
expect(
  builder.build(candidates: [noZoneCandidate], now: now)
      ?.strongMotionHeadline,
  '強い揺れに警戒',
);
expect(
  builder.build(candidates: const [], now: now),
  isNull,
);
```

`levelCandidate` must have `accuracy.epicenter == 1` and `originTime == null`. Also assert that unknown local forecast produces `JmaIntensity.unknown`, `EewWarningArrivalState.unknown`, and `secondsUntilArrival == null`.

- [ ] **Step 3: Run both focused tests and confirm missing implementation failures**

Run:

```bash
cd app
mise exec -- flutter test test/feature/eew/data/logic/eew_warning_candidate_selector_test.dart test/feature/eew/data/logic/eew_warning_display_model_builder_test.dart
```

Expected: FAIL because the models and logic classes do not exist.

- [ ] **Step 4: Implement the two Freezed models**

Create `eew_warning_overlay_candidate.dart`:

```dart
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_warning_overlay_candidate.freezed.dart';

@Freezed(toJson: false)
abstract class EewWarningOverlayCandidate
    with _$EewWarningOverlayCandidate {
  const factory EewWarningOverlayCandidate({
    required EewTelegramItem event,
    required String warningAreaCode,
    required String warningAreaName,
    required String? forecastAreaName,
    required EewForecastRegionInfo? localForecastRegion,
  }) = _EewWarningOverlayCandidate;
}
```

Create `eew_warning_overlay_display_model.dart` with the exact contract from this plan's public-contract section. Import `jma_intensity.dart` and annotate it with `@Freezed(toJson: false)`.

- [ ] **Step 5: Implement candidate and arrival logic**

`EewWarningCandidateSelector.select` must have this exact signature:

```dart
List<EewWarningOverlayCandidate> select({
  required List<EewTelegramItem> aliveEews,
  required String warningAreaCode,
  required String warningAreaName,
  required String? forecastAreaCode,
  required String? forecastAreaName,
})
```

Filter with `event.isWarning == true`, `!event.isCanceled`, and a matching current warning region with `hadWarning`. Attach the first `forecastIntensity.regions` item matching `forecastAreaCode`, or `null`.

`EewWarningArrivalClassifier.classify` must have this signature:

```dart
EewWarningArrivalState classify({
  required EewWarningOverlayCandidate candidate,
  required DateTime now,
})
```

Return `arrived` when `isArrived` is true or local `arrivalTime` is not after `now`, `unarrived` only when the local arrival is after `now`, otherwise `unknown`.

- [ ] **Step 6: Implement representative selection and display construction**

`EewWarningRepresentativeSelector.select` must return `null` for an empty list and otherwise compare in this exact order:

1. arrival enum order `unarrived`, `unknown`, `arrived`
2. `localForecastRegion?.intensity.orderIndex ?? JmaIntensity.unknown.orderIndex`, descending
3. `event.reportTime`, descending
4. `event.eventId`, ascending

Use this signature:

```dart
EewWarningOverlayCandidate? select({
  required List<EewWarningOverlayCandidate> candidates,
  required DateTime now,
})
```

`EewWarningDisplayModelBuilder.build` must use this signature:

```dart
EewWarningOverlayDisplayModel? build({
  required List<EewWarningOverlayCandidate> candidates,
  required DateTime now,
})
```

Build the model as follows:

- Sort event IDs by the same representative comparator.
- Deduplicate `warning.zones.where(hadWarning)` by code and sort by code before joining names with one half-width space.
- Use `hypocenter?.detailedName ?? hypocenter?.name` only when non-empty and the event is neither PLUM nor level-method.
- Derive level-method as `accuracy?.epicenter == 1 && originTime == null`.
- Append `で地震` only to a valid hypocenter name.
- Append `で強い揺れ` once to the combined zone names, or use `強い揺れに警戒` when none exist.
- Use the representative candidate's `forecastAreaName` for `currentRegionName`,
  falling back to `warningAreaName` only when the forecast area is unresolved.
- Use `JmaIntensity.unknown` and `localIntensityIsOver == false` when no local forecast exists.
- For an unarrived event, use `arrivalTime.difference(now).inSeconds`; all other states use `null`.
- Copy representative serial, hypocenter name, magnitude, and depth into the public model.

- [ ] **Step 7: Generate Freezed code and run the pure tests**

Run:

```bash
cd app
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- flutter test test/feature/eew/data/logic/eew_warning_candidate_selector_test.dart test/feature/eew/data/logic/eew_warning_display_model_builder_test.dart
```

Expected: generation succeeds and both test files PASS.

- [ ] **Step 8: Commit the pure domain slice**

```bash
git add app/lib/feature/eew/data/model/eew_warning_overlay_candidate.dart app/lib/feature/eew/data/model/eew_warning_overlay_candidate.freezed.dart app/lib/feature/eew/data/model/eew_warning_overlay_display_model.dart app/lib/feature/eew/data/model/eew_warning_overlay_display_model.freezed.dart app/lib/feature/eew/data/logic/eew_warning_candidate_selector.dart app/lib/feature/eew/data/logic/eew_warning_arrival_classifier.dart app/lib/feature/eew/data/logic/eew_warning_representative_selector.dart app/lib/feature/eew/data/logic/eew_warning_display_model_builder.dart app/test/feature/eew/data/logic/eew_warning_candidate_selector_test.dart app/test/feature/eew/data/logic/eew_warning_display_model_builder_test.dart
git commit -m "feat: EEW警報overlayの表示モデルを追加"
```

### Task 3: Wire Live Candidates Through Both JMA Area Providers

**Files:**
- Create: `app/lib/feature/eew/data/provider/eew_warning_overlay_candidate_provider.dart`
- Create: `app/lib/feature/eew/data/provider/eew_warning_overlay_candidate_provider.g.dart` (generated)
- Create: `app/lib/feature/eew/data/provider/eew_warning_overlay_display_provider.dart`
- Create: `app/lib/feature/eew/data/provider/eew_warning_overlay_display_provider.g.dart` (generated)
- Test: `app/test/feature/eew/data/provider/eew_warning_overlay_candidate_provider_test.dart`
- Test: `app/test/feature/eew/data/provider/eew_warning_overlay_display_provider_test.dart`

**Interfaces:**
- Consumes: `isRealtimeModeProvider`, `eewWarningOverlayEnabledProvider`, `eewAliveTelegramProvider`, `locationStreamProvider`, both JMA area family providers, `timeTickerProvider()`, and Task 2 logic classes
- Produces: `eewWarningOverlayCandidatesProvider`, `eewWarningOverlayDisplayProvider`

- [ ] **Step 1: Write failing provider-wiring tests**

Create a mutable `EewAliveTelegram` test subclass and an enabled-setting subclass. Override location with `Stream.value(Position(...))` and both family providers independently, following `home_earthquake_history_parameter_provider_test.dart`.

Use warning area `100` and forecast area `200` in the first test so an accidental single-map implementation cannot pass:

```dart
test('LocalEewで対象判定しLocalEで現在地予想を引く', () async {
  final container = providerContainer(
    alive: [
      warningEew(
        warningRegionCode: '100',
        forecastRegionCode: '200',
        intensity: JmaIntensity.sixUpper,
      ),
    ],
    warningArea: mapItem(code: '100', name: '警報判定区域'),
    forecastArea: mapItem(code: '200', name: '震度予報区域'),
  );

  final value = await waitForCandidates(container);
  expect(value, hasLength(1));
  expect(value.single.warningAreaName, '警報判定区域');
  expect(value.single.localForecastRegion?.intensity, JmaIntensity.sixUpper);
});
```

Add explicit provider cases using separate fresh containers:

```dart
expect(await candidatesFor(realtime: false), isEmpty);
expect(await candidatesFor(enabled: false), isEmpty);
expect(await candidatesFor(alive: null), isEmpty);
expect(await candidatesFor(position: null), isEmpty);
expect(await candidatesFor(warningArea: null), isEmpty);
expect(await candidatesFor(warningAreaProperty: null), isEmpty);
expect(await candidatesFor(canceled: true), isEmpty);
expect(await candidatesFor(isWarning: false), isEmpty);
expect(await candidatesFor(hadWarning: false), isEmpty);
```

For location and warning-area loading/error, use controllable
`StreamController<Position>` / `Completer<MapDataItem?>`. First publish an
eligible area, then move the provider to unresolved state and assert the output
becomes empty rather than retaining the prior candidate. Separately assert that
an unresolved forecast-area provider keeps the candidate but sets
`localForecastRegion` and `forecastAreaName` to null.

- [ ] **Step 2: Write the failing real display-provider test**

Override `eewWarningOverlayCandidatesProvider` with fixed candidates and override `timeTickerProvider()` with a stream containing the fixed time:

```dart
test('ticker更新で到達秒数と代表を再計算する', () async {
  final ticker = StreamController<DateTime>.broadcast();
  addTearDown(ticker.close);
  final container = ProviderContainer(
    overrides: [
      eewWarningOverlayCandidatesProvider.overrideWithValue(candidates),
      timeTickerProvider().overrideWith((ref) => ticker.stream),
    ],
  );
  addTearDown(container.dispose);
  final subscription = container.listen(
    eewWarningOverlayDisplayProvider,
    (_, _) {},
  );
  addTearDown(subscription.close);

  ticker.add(DateTime.utc(2026, 7, 25, 12));
  await container.pump();
  expect(
    container.read(eewWarningOverlayDisplayProvider)?.secondsUntilArrival,
    10,
  );

  ticker.add(DateTime.utc(2026, 7, 25, 12, 0, 10));
  await container.pump();
  expect(
    container.read(eewWarningOverlayDisplayProvider)?.arrivalState,
    EewWarningArrivalState.arrived,
  );
});
```

Also assert an empty candidate list returns `null`.

- [ ] **Step 3: Run both provider tests and confirm missing provider failures**

Run:

```bash
cd app
mise exec -- flutter test test/feature/eew/data/provider/eew_warning_overlay_candidate_provider_test.dart test/feature/eew/data/provider/eew_warning_overlay_display_provider_test.dart
```

Expected: FAIL because the generated providers do not exist.

- [ ] **Step 4: Implement the live candidate provider**

Create injectable providers for the three pure classes in their respective logic files:

```dart
@riverpod
EewWarningCandidateSelector eewWarningCandidateSelector(Ref ref) =>
    EewWarningCandidateSelector();

@riverpod
EewWarningRepresentativeSelector eewWarningRepresentativeSelector(Ref ref) =>
    EewWarningRepresentativeSelector(
      arrivalClassifier: ref.watch(eewWarningArrivalClassifierProvider),
    );

@riverpod
EewWarningDisplayModelBuilder eewWarningDisplayModelBuilder(Ref ref) =>
    EewWarningDisplayModelBuilder(
      arrivalClassifier: ref.watch(eewWarningArrivalClassifierProvider),
      representativeSelector: ref.watch(
        eewWarningRepresentativeSelectorProvider,
      ),
    );
```

Give `EewWarningArrivalClassifier` its own `@riverpod` constructor provider. Add the required `part '*.g.dart'` directives and generated files to Task 2's logic paths.

Implement `eewWarningOverlayCandidates(Ref ref)` as a synchronous computed
provider. Accept only exact `AsyncData` cases for setting, location, and the
warning-area family provider. Return `[]` immediately for non-realtime mode,
disabled/unresolved setting, null alive state, unresolved location, or
unresolved warning-area property. Read the forecast-area family only when it is
`AsyncData`; otherwise pass null code/name to the selector without removing an
otherwise eligible warning.

Use the rounded `Position` directly from `locationStreamProvider`:

```dart
final latLng = LatLng(position.latitude, position.longitude);
```

Pass both the nullable forecast-area code and name to the selector. Do not await
`.future` in this provider, because an `AsyncLoading` state must synchronously
invalidate the prior area.

- [ ] **Step 5: Implement the real display provider**

Implement `eewWarningOverlayDisplay(Ref ref)` as a synchronous computed provider:

```dart
@riverpod
EewWarningOverlayDisplayModel? eewWarningOverlayDisplay(Ref ref) {
  final candidates = ref.watch(eewWarningOverlayCandidatesProvider);
  if (candidates.isEmpty) {
    return null;
  }
  final ticker = ref.watch(timeTickerProvider());
  final now = ticker.value ?? ref.read(appClockProvider.notifier).now();
  return ref.watch(eewWarningDisplayModelBuilderProvider).build(
    candidates: candidates,
    now: now.toUtc(),
  );
}
```

This uses the app clock only for the ticker's initial loading frame; it does not use event-level arrival or a fixed time.

- [ ] **Step 6: Generate code and run the provider tests**

Run:

```bash
cd app
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- flutter test test/feature/eew/data/provider/eew_warning_overlay_candidate_provider_test.dart test/feature/eew/data/provider/eew_warning_overlay_display_provider_test.dart
```

Expected: generation succeeds and both provider test files PASS.

- [ ] **Step 7: Commit the live provider slice**

```bash
git add app/lib/feature/eew/data/logic app/lib/feature/eew/data/provider/eew_warning_overlay_candidate_provider.dart app/lib/feature/eew/data/provider/eew_warning_overlay_candidate_provider.g.dart app/lib/feature/eew/data/provider/eew_warning_overlay_display_provider.dart app/lib/feature/eew/data/provider/eew_warning_overlay_display_provider.g.dart app/test/feature/eew/data/provider/eew_warning_overlay_candidate_provider_test.dart app/test/feature/eew/data/provider/eew_warning_overlay_display_provider_test.dart
git commit -m "feat: 現在地向けEEW警報候補を配信"
```

### Task 4: Add the Fixed Simulation and Real-First Effective Source

**Files:**
- Create: `app/lib/feature/eew/data/notifier/eew_warning_overlay_simulation_notifier.dart`
- Create: `app/lib/feature/eew/data/notifier/eew_warning_overlay_simulation_notifier.g.dart` (generated)
- Create: `app/lib/feature/eew/data/provider/eew_warning_overlay_effective_display_provider.dart`
- Create: `app/lib/feature/eew/data/provider/eew_warning_overlay_effective_display_provider.g.dart` (generated)
- Test: `app/test/feature/eew/data/notifier/eew_warning_overlay_simulation_notifier_test.dart`

**Interfaces:**
- Consumes: `eewWarningOverlayDisplayProvider`, `EewWarningOverlayDisplayModel`
- Produces: `eewWarningOverlaySimulationProvider`, `EewWarningOverlaySimulation.start()`, `EewWarningOverlaySimulation.stop()`, `eewWarningOverlayEffectiveDisplayProvider`

- [ ] **Step 1: Write failing fixed-simulation tests**

Override the real display provider with a mutable test provider so the same container can move from no real warning to a real warning. Assert the exact fixed model:

```dart
test('startは設定に依存しない固定訓練モデルを公開する', () {
  final container = simulationContainer(real: null);
  addTearDown(container.dispose);

  container.read(eewWarningOverlaySimulationProvider.notifier).start();
  final model = container.read(eewWarningOverlaySimulationProvider);

  expect(model?.source, EewWarningOverlaySource.simulation);
  expect(model?.eventIds, ['eew-warning-overlay-simulation']);
  expect(model?.reportLabel, '訓練／シミュレーション');
  expect(model?.hypocenterHeadline, 'テスト震源で地震');
  expect(model?.strongMotionHeadline, 'テスト地域で強い揺れ');
  expect(model?.currentRegionName, 'テスト地域');
  expect(model?.localIntensity, JmaIntensity.sixLower);
  expect(model?.arrivalState, EewWarningArrivalState.unarrived);
  expect(model?.secondsUntilArrival, 10);
});

test('stopは訓練モデルを消す', () {
  final container = simulationContainer(real: null);
  addTearDown(container.dispose);
  final notifier = container.read(
    eewWarningOverlaySimulationProvider.notifier,
  );

  notifier.start();
  notifier.stop();

  expect(container.read(eewWarningOverlaySimulationProvider), isNull);
});
```

Do not override or read `eewProvider` and `locationStreamProvider` in these tests; this proves simulation has no dependency on them.

- [ ] **Step 2: Write failing real-preemption and non-restoration tests**

Use a mutable real-display override and keep both simulation and effective providers listened:

```dart
test('実警報が訓練を破棄し終了後も訓練へ戻らない', () async {
  final real = MutableRealDisplay();
  final container = simulationContainer(realNotifier: real);
  addTearDown(container.dispose);
  final effectiveSubscription = container.listen(
    eewWarningOverlayEffectiveDisplayProvider,
    (_, _) {},
  );
  addTearDown(effectiveSubscription.close);

  container.read(eewWarningOverlaySimulationProvider.notifier).start();
  expect(
    container.read(eewWarningOverlayEffectiveDisplayProvider)?.source,
    EewWarningOverlaySource.simulation,
  );

  real.publish(realDisplayModel(eventId: 'real-event'));
  await container.pump();
  expect(
    container.read(eewWarningOverlayEffectiveDisplayProvider)?.source,
    EewWarningOverlaySource.real,
  );
  expect(container.read(eewWarningOverlaySimulationProvider), isNull);

  real.publish(null);
  await container.pump();
  expect(container.read(eewWarningOverlayEffectiveDisplayProvider), isNull);
});

test('実警報中のstartは訓練を開始しない', () {
  final container = simulationContainer(
    real: realDisplayModel(eventId: 'real-event'),
  );
  addTearDown(container.dispose);

  container.read(eewWarningOverlaySimulationProvider.notifier).start();

  expect(container.read(eewWarningOverlaySimulationProvider), isNull);
  expect(
    container.read(eewWarningOverlayEffectiveDisplayProvider)?.source,
    EewWarningOverlaySource.real,
  );
});
```

- [ ] **Step 3: Run the focused test and confirm missing-provider failures**

Run:

```bash
cd app
mise exec -- flutter test test/feature/eew/data/notifier/eew_warning_overlay_simulation_notifier_test.dart
```

Expected: FAIL because the simulation and effective display providers do not exist.

- [ ] **Step 4: Implement the simulation notifier**

Create `EewWarningOverlaySimulation` with nullable display-model state. Its
`build()` returns `null` and listens to `eewWarningOverlayDisplayProvider`;
whenever a later real model is non-null, set simulation state to `null`.
`start()` performs the immediate active-real check described below, so the
listener does not mutate state during `build()`.

`start()` must first read `eewWarningOverlayDisplayProvider` and return without changing state when real data exists. Otherwise assign exactly:

```dart
const EewWarningOverlayDisplayModel(
  source: EewWarningOverlaySource.simulation,
  eventIds: ['eew-warning-overlay-simulation'],
  representativeEventId: 'eew-warning-overlay-simulation',
  serialNo: 1,
  alertCount: 1,
  reportLabel: '訓練／シミュレーション',
  hypocenterHeadline: 'テスト震源で地震',
  strongMotionHeadline: 'テスト地域で強い揺れ',
  currentRegionName: 'テスト地域',
  localIntensity: JmaIntensity.sixLower,
  localIntensityIsOver: false,
  arrivalState: EewWarningArrivalState.unarrived,
  secondsUntilArrival: 10,
  hypocenterName: 'テスト震源',
  magnitude: null,
  depth: null,
)
```

`stop()` sets state to `null`. Do not import `eew.dart`, `location.dart`, or either map provider.

- [ ] **Step 5: Implement the effective source provider**

Always watch both providers so the simulation notifier remains alive long enough to observe preemption:

```dart
@riverpod
EewWarningOverlayDisplayModel? eewWarningOverlayEffectiveDisplay(Ref ref) {
  final real = ref.watch(eewWarningOverlayDisplayProvider);
  final simulation = ref.watch(eewWarningOverlaySimulationProvider);
  return real ?? simulation;
}
```

- [ ] **Step 6: Generate code and run the simulation tests**

Run:

```bash
cd app
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- flutter test test/feature/eew/data/notifier/eew_warning_overlay_simulation_notifier_test.dart
```

Expected: generation succeeds and all simulation/preemption tests PASS.

- [ ] **Step 7: Run the complete Plan 1 regression set and static analysis**

Run:

```bash
cd app
mise exec -- flutter test test/feature/eew/data/notifier/eew_warning_overlay_enabled_notifier_test.dart test/feature/eew/data/logic/eew_warning_candidate_selector_test.dart test/feature/eew/data/logic/eew_warning_display_model_builder_test.dart test/feature/eew/data/provider/eew_warning_overlay_candidate_provider_test.dart test/feature/eew/data/provider/eew_warning_overlay_display_provider_test.dart test/feature/eew/data/notifier/eew_warning_overlay_simulation_notifier_test.dart
mise exec -- dart analyze lib/feature/eew/data lib/core/data/preferences/shared/shared_preferences_key.dart
```

Expected: all focused tests PASS and analysis reports no issues.

- [ ] **Step 8: Commit the simulation/source slice**

```bash
git add app/lib/feature/eew/data/notifier/eew_warning_overlay_simulation_notifier.dart app/lib/feature/eew/data/notifier/eew_warning_overlay_simulation_notifier.g.dart app/lib/feature/eew/data/provider/eew_warning_overlay_effective_display_provider.dart app/lib/feature/eew/data/provider/eew_warning_overlay_effective_display_provider.g.dart app/test/feature/eew/data/notifier/eew_warning_overlay_simulation_notifier_test.dart
git commit -m "feat: EEW警報overlayの訓練表示を追加"
```

## Plan 1 Completion Gate

Before handing off to Plan 2, verify:

```bash
git --no-pager diff --check HEAD~4..HEAD
git --no-pager status --short
```

The only remaining work for Plan 2 is overlay visibility/handled-ID state, lifecycle and 10-second timer behavior, vibration, root UI, settings-page controls, and manual visual/platform verification. Plan 2 must not duplicate candidate selection, display copy construction, source preemption, or preference persistence.
