# EEW推定震度オーバーレイ 実装計画

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** EEW詳細画面・シミュレーション再生時に、距離減衰式によるregionごとの予想震度とS波到達時刻を地図/EewCardに表示する

**Architecture:** `EewTelegramItem` を引数に取るFamily Providerで推定震度を計算し、JMAデータとのマージはUI層で `useMemoized` により行う。フラグ `isEstimatedIntensityOnEewReplayAllowed` がONの場合のみ有効。

**Tech Stack:** Flutter, Riverpod, Freezed, MapLibre, flutter_hooks

## Global Constraints

- `dart analyze` が警告なしで通ること
- `dart format` に準拠
- 生成ファイル (`*.g.dart`, `*.freezed.dart`) はコミットする
- パッケージインポートはクロスパッケージの場合 package import を使用
- 既存の Riverpod パターンに従う

---

### Task 1: フラグ管理 — SharedPreferencesKey + Provider + デバッグ画面トグル

**Files:**
- Modify: `app/lib/core/data/preferences/shared/shared_preferences_key.dart`
- Create: `app/lib/core/provider/estimated_intensity/provider/estimated_intensity_on_eew_replay_allowed_provider.dart`
- Modify: `app/lib/feature/settings/children/config/debug/debug_page.dart`

**Interfaces:**
- Consumes: `sharedPreferencesProvider` (既存)
- Produces: `estimatedIntensityOnEewReplayAllowedProvider` — `bool` を返す `@Riverpod(keepAlive: true)` Provider

- [ ] **Step 1: SharedPreferencesKey に新しいキーを追加**

`app/lib/core/data/preferences/shared/shared_preferences_key.dart` の enum に追加:

```dart
  estimatedIntensityNoticeShown('estimated_intensity_notice_shown'),
  isEstimatedIntensityOnEewReplayAllowed(
    'is_estimated_intensity_on_eew_replay_allowed',
  ),
  ;
```

`estimatedIntensityNoticeShown` の直後、`;` の前に挿入する。

- [ ] **Step 2: Provider を作成**

`app/lib/core/provider/estimated_intensity/provider/estimated_intensity_on_eew_replay_allowed_provider.dart` を作成:

```dart
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'estimated_intensity_on_eew_replay_allowed_provider.g.dart';

@Riverpod(keepAlive: true)
class EstimatedIntensityOnEewReplayAllowed
    extends _$EstimatedIntensityOnEewReplayAllowed {
  static const _key =
      SharedPreferencesKey.isEstimatedIntensityOnEewReplayAllowed;

  @override
  bool build() {
    return ref.read(sharedPreferencesProvider).getBool(_key.key) ?? false;
  }

  Future<void> save({required bool isEnabled}) async {
    await ref.read(sharedPreferencesProvider).setBool(_key.key, isEnabled);
    state = isEnabled;
  }
}
```

- [ ] **Step 3: デバッグ画面にトグルを追加**

`app/lib/feature/settings/children/config/debug/debug_page.dart` の EEW Card セクション（line 150付近）の直前に `SwitchListTile` を追加:

```dart
import 'package:eqmonitor/core/provider/estimated_intensity/provider/estimated_intensity_on_eew_replay_allowed_provider.dart';
```

EEW Card `ListTile`（line 150）の直前に挿入:

```dart
            Builder(
              builder: (context) {
                final isAllowed = ref.watch(
                  estimatedIntensityOnEewReplayAllowedProvider,
                );
                return ListTile(
                  title: const Text('EEW 推定震度表示'),
                  subtitle: Text(
                    'EEW詳細画面で距離減衰式による推定震度を表示',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  leading: const Icon(Icons.layers),
                  trailing: AppSwitch(
                    value: isAllowed,
                    onChanged: (value) async => ref
                        .read(
                          estimatedIntensityOnEewReplayAllowedProvider.notifier,
                        )
                        .save(isEnabled: value),
                  ),
                  onTap: () async => ref
                      .read(
                        estimatedIntensityOnEewReplayAllowedProvider.notifier,
                      )
                      .save(isEnabled: !isAllowed),
                );
              },
            ),
```

- [ ] **Step 4: コード生成を実行**

```bash
melos run generate
```

- [ ] **Step 5: analyze を実行して確認**

```bash
cd app && dart analyze
```

Expected: No issues found

- [ ] **Step 6: コミット**

```bash
git add app/lib/core/data/preferences/shared/shared_preferences_key.dart \
  app/lib/core/provider/estimated_intensity/provider/estimated_intensity_on_eew_replay_allowed_provider.dart \
  app/lib/core/provider/estimated_intensity/provider/estimated_intensity_on_eew_replay_allowed_provider.g.dart \
  app/lib/feature/settings/children/config/debug/debug_page.dart
git commit -m "feat: EEW推定震度表示フラグのProvider・デバッグ画面トグルを追加"
```

---

### Task 2: EewEstimatedRegion データモデル

**Files:**
- Create: `app/lib/feature/eew/data/model/eew_estimated_region.dart`

**Interfaces:**
- Consumes: `JmaIntensity` (既存 enum)
- Produces: `EewEstimatedRegion` — regionCode, regionName, intensity (double), jmaIntensity (JmaIntensity?), sWaveArrivalTime (DateTime?), isArrived (bool) を持つ Freezed モデル

- [ ] **Step 1: Freezed モデルを作成**

`app/lib/feature/eew/data/model/eew_estimated_region.dart`:

```dart
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_estimated_region.freezed.dart';

@Freezed(toJson: false)
abstract class EewEstimatedRegion with _$EewEstimatedRegion {
  const factory EewEstimatedRegion({
    required String regionCode,
    required String regionName,
    required double intensity,
    JmaIntensity? jmaIntensity,
    DateTime? sWaveArrivalTime,
    @Default(false) bool isArrived,
  }) = _EewEstimatedRegion;
}
```

- [ ] **Step 2: コード生成を実行**

```bash
melos run generate
```

- [ ] **Step 3: analyze を実行**

```bash
cd app && dart analyze
```

- [ ] **Step 4: コミット**

```bash
git add app/lib/feature/eew/data/model/eew_estimated_region.dart \
  app/lib/feature/eew/data/model/eew_estimated_region.freezed.dart
git commit -m "feat: EewEstimatedRegion Freezedモデルを追加"
```

---

### Task 3: eewEstimatedRegionIntensity Provider

**Files:**
- Create: `app/lib/feature/eew/data/provider/eew_estimated_region_intensity_provider.dart`

**Interfaces:**
- Consumes:
  - `EstimatedIntensityDataSource` — `getEstimatedIntensity(points, jmaMagnitude, depth, hypocenter)` → `Iterable<double>`
  - `jmaParameterProvider` — `Future<JmaParameterState>` → `.earthquake.prefectures[].regions[].cities[].stations[]`
  - `travelTimeProvider` — `TravelTimeTables` → `.table` (`List<TravelTimeTable>`)
  - `EewTelegramItem` — 引数
  - `JmaIntensityDouble.toJmaIntensity` — `double` → `JmaIntensity?`
- Produces: `eewEstimatedRegionIntensityProvider(EewTelegramItem)` — `Future<List<EewEstimatedRegion>>` を返す Family Provider

- [ ] **Step 1: Provider を作成**

`app/lib/feature/eew/data/provider/eew_estimated_region_intensity_provider.dart`:

```dart
import 'dart:isolate';
import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:eqmonitor/core/extension/double_to_jma_forecast_intensity.dart';
import 'package:eqmonitor/core/provider/estimated_intensity/data/estimated_intensity_data_source.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/core/provider/travel_time/provider/travel_time_provider.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_estimated_region.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:latlong2/latlong.dart' as latlong2;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_estimated_region_intensity_provider.g.dart';

typedef _RegionStation = ({
  String regionCode,
  String regionName,
  CalculationPoint point,
});

typedef _ComputeArgs = ({
  double jmaMagnitude,
  int depth,
  double lat,
  double lon,
  List<CalculationPoint> points,
});

List<double> _computeIntensities(_ComputeArgs args) {
  final calculator = EstimatedIntensityDataSource();
  return calculator
      .getEstimatedIntensity(
        points: args.points,
        jmaMagnitude: args.jmaMagnitude,
        depth: args.depth,
        hypocenter: (lat: args.lat, lon: args.lon),
      )
      .toList();
}

@riverpod
Future<List<EewEstimatedRegion>> eewEstimatedRegionIntensity(
  Ref ref,
  EewTelegramItem eew,
) async {
  final hypocenter = eew.hypocenter;
  if (hypocenter == null ||
      !hypocenter.hasLatLng ||
      hypocenter.magnitude == null ||
      hypocenter.depth == null) {
    return [];
  }

  final parameter = await ref.read(jmaParameterProvider.future);
  final travelTimeTables = ref.read(travelTimeProvider);

  // station一覧を構築
  final stations = <_RegionStation>[];
  for (final prefecture in parameter.earthquake.prefectures) {
    for (final region in prefecture.regions) {
      for (final city in region.cities) {
        for (final station in city.stations) {
          if (station.arv400 == null) {
            continue;
          }
          stations.add((
            regionCode: region.code,
            regionName: region.name.ja,
            point: (
              lat: station.location.lat,
              lon: station.location.lon,
              arv400: station.arv400!,
            ),
          ));
        }
      }
    }
  }

  if (stations.isEmpty) {
    return [];
  }

  final points = stations.map((s) => s.point).toList();

  // Isolateで推定震度を計算
  final intensities = await Isolate.run(
    () => _computeIntensities((
      jmaMagnitude: hypocenter.magnitude!,
      depth: hypocenter.depth!,
      lat: hypocenter.latitude!,
      lon: hypocenter.longitude!,
      points: points,
    )),
  );

  // regionCode単位で最大震度を集約
  final regionMap = <String, (String name, double maxIntensity)>{};
  for (var i = 0; i < stations.length; i++) {
    final s = stations[i];
    final current = regionMap[s.regionCode];
    if (current == null || intensities[i] > current.$2) {
      regionMap[s.regionCode] = (s.regionName, intensities[i]);
    }
  }

  // 各regionの代表点(最大震度stationの位置)の震源距離からS波到達時刻を算出
  final regionStationMap = <String, CalculationPoint>{};
  for (var i = 0; i < stations.length; i++) {
    final s = stations[i];
    final current = regionMap[s.regionCode];
    if (current != null && intensities[i] == current.$2) {
      regionStationMap[s.regionCode] = s.point;
    }
  }

  final originTime = eew.originTime;
  final depth = hypocenter.depth!;
  const distanceCalc = latlong2.Distance();

  return regionMap.entries.map((entry) {
    final regionCode = entry.key;
    final (name, maxIntensity) = entry.value;
    final jmaIntensity = maxIntensity.toJmaIntensity;

    DateTime? sWaveArrivalTime;
    if (originTime != null) {
      final point = regionStationMap[regionCode];
      if (point != null) {
        final epicenterDistanceKm = distanceCalc.as(
          latlong2.LengthUnit.Kilometer,
          latlong2.LatLng(point.lat, point.lon),
          latlong2.LatLng(hypocenter.latitude!, hypocenter.longitude!),
        );
        final hypoDistanceKm = math.sqrt(
          math.pow(depth, 2) + math.pow(epicenterDistanceKm, 2),
        );

        // 走時テーブルからS波到達時間(秒)を逆引き
        final sTimeSec = _lookupSWaveTravelTime(
          travelTimeTables,
          depth,
          hypoDistanceKm,
        );
        if (sTimeSec != null) {
          sWaveArrivalTime = originTime.add(
            Duration(milliseconds: (sTimeSec * 1000).round()),
          );
        }
      }
    }

    return EewEstimatedRegion(
      regionCode: regionCode,
      regionName: name,
      intensity: maxIntensity,
      jmaIntensity: jmaIntensity,
      sWaveArrivalTime: sWaveArrivalTime,
    );
  }).toList();
}

/// 走時テーブルからS波到達時間(秒)を距離(km)から逆引き
double? _lookupSWaveTravelTime(
  TravelTimeTables tables,
  int depth,
  double distanceKm,
) {
  final depthTables =
      tables.table.where((t) => t.depth == depth).toList()
        ..sort((a, b) => a.distance.compareTo(b.distance));

  if (depthTables.isEmpty) {
    return null;
  }

  final d1 = depthTables.lastWhereOrNull(
    (t) => t.distance <= distanceKm,
  );
  final d2 = depthTables.firstWhereOrNull(
    (t) => t.distance >= distanceKm,
  );

  if (d1 == null || d2 == null) {
    return null;
  }

  if (d1.distance == d2.distance) {
    return d1.s;
  }

  // 線形補間
  final ratio =
      (distanceKm - d1.distance) / (d2.distance - d1.distance);
  return d1.s + ratio * (d2.s - d1.s);
}
```

- [ ] **Step 2: コード生成を実行**

```bash
melos run generate
```

- [ ] **Step 3: analyze を実行**

```bash
cd app && dart analyze
```

- [ ] **Step 4: テストを作成**

`app/test/feature/eew/data/provider/eew_estimated_region_intensity_provider_test.dart`:

```dart
import 'package:eqmonitor/core/provider/travel_time/model/travel_time_table.dart';
import 'package:eqmonitor/feature/eew/data/provider/eew_estimated_region_intensity_provider.dart';
import 'package:flutter_test/flutter_test.dart';

// _lookupSWaveTravelTime はファイルプライベートなので、
// 同等のロジックを public helper として切り出してテスト可能にするか、
// Provider 統合テストで検証する。
// ここでは EstimatedIntensityDataSource のロジックが正しく動くことを
// 既存テストに委ね、Provider の統合動作はウィジェットテストで検証する方針。

void main() {
  group('EewEstimatedRegion model', () {
    test('intensity < 0.5 gives null jmaIntensity', () {
      // JmaIntensityDouble extension のテスト
      // 既存の double_to_jma_forecast_intensity.dart のロジック確認
      expect(0.3.toJmaIntensity, isNull); // < -0.5 → null
    });
  });
}
```

注: `_lookupSWaveTravelTime` はファイルプライベート関数。必要に応じて後から `@visibleForTesting` で公開しテストを追加する。

- [ ] **Step 5: テスト実行**

```bash
cd app && flutter test test/feature/eew/data/provider/eew_estimated_region_intensity_provider_test.dart
```

- [ ] **Step 6: コミット**

```bash
git add app/lib/feature/eew/data/provider/eew_estimated_region_intensity_provider.dart \
  app/lib/feature/eew/data/provider/eew_estimated_region_intensity_provider.g.dart \
  app/test/feature/eew/data/provider/eew_estimated_region_intensity_provider_test.dart
git commit -m "feat: EewTelegramItemベースの推定震度Family Providerを追加"
```

---

### Task 4: EewForecastRegionLayer の拡張 — 推定震度の地図表示

**Files:**
- Modify: `app/lib/feature/eew/ui/components/eew_forecast_region_layer.dart`

**Interfaces:**
- Consumes:
  - `EewTelegramItem` (既存)
  - `EewForecastRegionInfo` (既存) — 追加regions用に `additionalRegions` パラメータで受け取る
- Produces: `EewForecastRegionLayer` に `additionalRegions: List<EewForecastRegionInfo>?` パラメータを追加

- [ ] **Step 1: additionalRegions パラメータを追加**

`app/lib/feature/eew/ui/components/eew_forecast_region_layer.dart` のコンストラクタを変更:

```dart
class EewForecastRegionLayer extends HookConsumerWidget {
  const EewForecastRegionLayer({
    required this.eew,
    required this.displayMode,
    this.additionalRegions,
    super.key,
  });

  final EewTelegramItem? eew;
  final EewDisplayMode displayMode;
  final List<EewForecastRegionInfo>? additionalRegions;
```

- [ ] **Step 2: regionMaxIntensities の計算を変更**

`useMemoized` 内で `additionalRegions` を合成するように変更:

```dart
    final regionMaxIntensities = useMemoized(() {
      final regions = [
        ...eew?.forecastIntensity?.regions ?? const [],
        ...?additionalRegions,
      ];
      return regions
          .groupListsBy((e) => e.code)
          .map(
            (key, values) => MapEntry(
              key,
              values.sortedBy((e) => e.intensity.orderIndex).last,
            ),
          )
          .values
          .toList();
    }, [eew, additionalRegions]);
```

`useMemoized` の依存に `additionalRegions` を追加すること。

- [ ] **Step 3: analyze を実行**

```bash
cd app && dart analyze
```

- [ ] **Step 4: コミット**

```bash
git add app/lib/feature/eew/ui/components/eew_forecast_region_layer.dart
git commit -m "feat: EewForecastRegionLayerにadditionalRegionsパラメータを追加"
```

---

### Task 5: EewCard の到達時間表示対応

**Files:**
- Modify: `app/lib/feature/home/ui/component/eew/eew_card.dart`

**Interfaces:**
- Consumes:
  - `EewEstimatedRegion` (Task 2) — `userRegionEstimate` パラメータで受け取る
  - 既存の `localForecastRegion` ロジック — JMA値があればそちらを優先
- Produces: `EewCard` に `userRegionEstimate: EewEstimatedRegion?` パラメータを追加。JMAの `localRegion` が `null` で `userRegionEstimate` がある場合、推定値から到達時間・震度を表示

- [ ] **Step 1: EewCard にパラメータを追加**

```dart
import 'package:eqmonitor/feature/eew/data/model/eew_estimated_region.dart';

class EewCard extends ConsumerWidget {
  const EewCard({
    required this.eew,
    required this.index,
    this.nowOverride,
    this.userRegionEstimate,
    super.key,
  });

  final EewTelegramItem eew;
  final String? index;
  final DateTime? nowOverride;
  final EewEstimatedRegion? userRegionEstimate;
```

- [ ] **Step 2: build メソッド内で推定値をフォールバックとして使用**

`localRegion` が `null` かつ `userRegionEstimate` が存在する場合のフォールバックロジックを追加。

`EewCard.build()` 内の `localRegion` 取得の直後に:

```dart
    final localRegion = localForecastRegion(eew, regionCode);

    // JMAのlocalRegionがない場合、推定値をフォールバック
    final estimate = userRegionEstimate;
    final effectiveLocalIntensity =
        localRegion?.intensity ?? estimate?.jmaIntensity;
    final effectiveRegionName =
        regionDisplayName ?? estimate?.regionName;

    // 到達時間: JMA値を優先、なければ推定値
    final effectiveArrivalTime =
        localRegion?.arrivalTime ?? estimate?.sWaveArrivalTime;
    final effectiveIsArrived =
        localRegion?.isArrived ?? estimate?.isArrived ?? false;
```

そして `_EewMainCard` に渡す部分を変更:

```dart
    final nowValue = nowOverride ?? now.asData?.value;
    final hasArrived =
        effectiveIsArrived ||
        (effectiveArrivalTime != null &&
            nowValue != null &&
            nowValue.isAfter(effectiveArrivalTime));

    int? secondsUntilArrival;
    if (!hasArrived && effectiveArrivalTime != null && nowValue != null) {
      final diff = effectiveArrivalTime.difference(nowValue).inSeconds;
      if (diff > 0) {
        secondsUntilArrival = diff;
      }
    }
```

`_EewMainCard` に渡す値も更新:

```dart
          _EewMainCard(
            eew: eew,
            isWarning: isWarning,
            happenedTime: happenedTime,
            localForecastIntensity: effectiveLocalIntensity,
            regionDisplayName: effectiveRegionName,
            secondsUntilArrival: secondsUntilArrival,
            showArrived:
                (localRegion != null || estimate != null) &&
                (hasArrived ||
                    (effectiveArrivalTime != null &&
                        secondsUntilArrival == null)),
          ),
```

`showLocalForecast` の条件も更新（震度1未満でも到達時間は表示するため）:

```dart
    // 注: showLocalForecast は _EewMainCard 内で決定。
    // localForecastIntensity が null でも到達時間があれば表示するようにする。
```

→ `_EewMainCard` 内の `showLocalForecast` 条件を変更:

```dart
    final showLocalForecast =
        (localForecastIntensity != null || secondsUntilArrival != null || showArrived) &&
        regionDisplayName != null &&
        regionDisplayName!.isNotEmpty;
```

- [ ] **Step 3: analyze を実行**

```bash
cd app && dart analyze
```

- [ ] **Step 4: コミット**

```bash
git add app/lib/feature/home/ui/component/eew/eew_card.dart
git commit -m "feat: EewCardに推定震度・S波到達時間のフォールバック表示を追加"
```

---

### Task 6: EewDetailsByEventIdPage の統合 — フラグ/Provider/マージ/レイヤー/Card連携

**Files:**
- Modify: `app/lib/feature/eew/ui/page/eew_details_by_event_id_page.dart`

**Interfaces:**
- Consumes:
  - `estimatedIntensityOnEewReplayAllowedProvider` (Task 1)
  - `eewEstimatedRegionIntensityProvider(eew)` (Task 3)
  - `EewEstimatedRegion.toEewForecastRegionInfo()` — 変換用 extension（このタスクで作成）
  - `locationStreamProvider` (既存)
  - `jmaMapAreaForecastLocalEInsideProvider` (既存)
- Produces: EEW詳細画面・シミュレーション画面で推定震度の地図表示と EewCard への到達時間表示が統合される

- [ ] **Step 1: EewEstimatedRegion → EewForecastRegionInfo 変換 extension を追加**

`app/lib/feature/eew/data/model/eew_estimated_region.dart` に extension を追加:

```dart
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';

extension EewEstimatedRegionConversion on EewEstimatedRegion {
  EewForecastRegionInfo toForecastRegionInfo() => EewForecastRegionInfo(
    code: regionCode,
    name: regionName,
    isPlum: false,
    isWarning: false,
    intensity: jmaIntensity ?? JmaIntensity.unknown,
    intensityIsOver: false,
    arrivalTime: sWaveArrivalTime,
    isArrived: isArrived,
  );
}
```

- [ ] **Step 2: _SimulationView を変更**

import を追加:

```dart
import 'package:eqmonitor/core/provider/estimated_intensity/provider/estimated_intensity_on_eew_replay_allowed_provider.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_estimated_region.dart';
import 'package:eqmonitor/feature/eew/data/provider/eew_estimated_region_intensity_provider.dart';
import 'package:eqmonitor/feature/location/data/location.dart';
import 'package:eqmonitor/feature/location/data/nearest_jma_feature.dart';
import 'package:lat_lng/lat_lng.dart' as lat_lng;
```

`_SimulationView` を `HookConsumerWidget` に変更し、推定震度のマージロジックを追加:

```dart
class _SimulationView extends HookConsumerWidget {
  const _SimulationView({
    required this.selectedEew,
    required this.displayMode,
    required this.initialCenter,
  });

  final EewTelegramItem? selectedEew;
  final EewDisplayMode displayMode;
  final Geographic initialCenter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final simulation = ref.watch(eewSimulationProvider);
    final currentEew = simulation?.currentReport ?? selectedEew;
    final isEstimatedAllowed = ref.watch(
      estimatedIntensityOnEewReplayAllowedProvider,
    );

    ref.watch(timeTickerProvider());

    DateTime? virtualNow;
    if (simulation != null) {
      final firstReportTime = simulation.reports.first.reportTime;
      final elapsed = DateTime.now().difference(simulation.startedAt);
      virtualNow = firstReportTime.add(elapsed);
    }

    // 推定震度の取得
    final estimatedRegions = isEstimatedAllowed && currentEew != null
        ? ref.watch(eewEstimatedRegionIntensityProvider(currentEew)).value
        : null;

    // JMAとのマージ（additionalRegions用）
    final additionalRegions = useMemoized(() {
      if (estimatedRegions == null || currentEew == null) {
        return null;
      }
      final jmaCodes = (currentEew.forecastIntensity?.regions ?? [])
          .map((r) => r.code)
          .toSet();
      return estimatedRegions
          .where((e) => !jmaCodes.contains(e.regionCode))
          .where((e) => e.jmaIntensity != null)
          .map((e) => e.toForecastRegionInfo())
          .toList();
    }, [estimatedRegions, currentEew]);

    // ユーザー現在地regionの推定値
    final positionAsync = ref.watch(locationStreamProvider);
    final position = positionAsync.value;
    final regionItem = position != null
        ? ref
              .watch(
                jmaMapAreaForecastLocalEInsideProvider(
                  lat_lng.LatLng(position.latitude, position.longitude),
                ),
              )
              .value
        : null;
    final userRegionCode = regionItem?.property?.code;

    final userEstimate = useMemoized(() {
      if (estimatedRegions == null || userRegionCode == null) {
        return null;
      }
      return estimatedRegions.firstWhereOrNull(
        (e) => e.regionCode == userRegionCode,
      );
    }, [estimatedRegions, userRegionCode]);

    return Stack(
      children: [
        Positioned.fill(
          child: EewDetailsMapView(
            selectedEew: currentEew,
            displayMode: displayMode,
            initialCenter: initialCenter,
            initZoom: 5,
            isSimulation: true,
            additionalRegions: additionalRegions,
          ),
        ),
        if (currentEew != null)
          Positioned(
            left: 8,
            right: 8,
            bottom: MediaQuery.of(context).padding.bottom + 8,
            child: EewCard(
              eew: currentEew,
              index: null,
              nowOverride: virtualNow,
              userRegionEstimate: isEstimatedAllowed ? userEstimate : null,
            ),
          ),
      ],
    );
  }
}
```

- [ ] **Step 3: _ResponsiveLayout に推定震度パラメータを追加**

`_ResponsiveLayout` に `additionalRegions` と `userRegionEstimate` パラメータを追加し、`EewDetailsMapView` と呼び出し元に伝播:

`EewDetailsByEventIdPage.build()` 内の非シミュレーションパスでも同様のマージロジックを追加する。`selectedEew` に対して推定震度を取得し、同様のパターンでマージ・表示する。

```dart
    // EewDetailsByEventIdPage.build() 内、eewsAsyncValue.when(data: ...) 内
    final isEstimatedAllowed = ref.watch(
      estimatedIntensityOnEewReplayAllowedProvider,
    );

    final estimatedRegions =
        isEstimatedAllowed && selectedEew != null
            ? ref
                  .watch(
                    eewEstimatedRegionIntensityProvider(selectedEew!),
                  )
                  .value
            : null;

    final additionalRegions = useMemoized(() {
      if (estimatedRegions == null || selectedEew == null) {
        return null;
      }
      final jmaCodes =
          (selectedEew!.forecastIntensity?.regions ?? [])
              .map((r) => r.code)
              .toSet();
      return estimatedRegions
          .where((e) => !jmaCodes.contains(e.regionCode))
          .where((e) => e.jmaIntensity != null)
          .map((e) => e.toForecastRegionInfo())
          .toList();
    }, [estimatedRegions, selectedEew]);
```

`_ResponsiveLayout` のコンストラクタに追加:

```dart
  final List<EewForecastRegionInfo>? additionalRegions;
```

`_ResponsiveLayout.build()` 内の `EewDetailsMapView` に渡す:

```dart
    final mapWidget = EewDetailsMapView(
      selectedEew: selectedEew,
      displayMode: displayMode,
      initialCenter: initialCenter,
      initZoom: initZoom,
      additionalRegions: additionalRegions,
    );
```

- [ ] **Step 4: EewDetailsMapView に additionalRegions パラメータを追加**

`app/lib/feature/eew/ui/components/eew_details_map_view.dart` を変更:

```dart
class EewDetailsMapView extends HookConsumerWidget {
  const EewDetailsMapView({
    required this.selectedEew,
    required this.displayMode,
    required this.initialCenter,
    required this.initZoom,
    this.isSimulation = false,
    this.additionalRegions,
    super.key,
  });

  final EewTelegramItem? selectedEew;
  final Geographic initialCenter;
  final double initZoom;
  final EewDisplayMode displayMode;
  final bool isSimulation;
  final List<EewForecastRegionInfo>? additionalRegions;
```

`_MapContent` にも同様に `additionalRegions` を伝播し、`EewForecastRegionLayer` に渡す:

```dart
        EewForecastRegionLayer(
          eew: selectedEew,
          displayMode: displayMode,
          additionalRegions: additionalRegions,
        ),
```

- [ ] **Step 5: コード生成を実行**

```bash
melos run generate
```

- [ ] **Step 6: analyze を実行**

```bash
cd app && dart analyze
```

- [ ] **Step 7: コミット**

```bash
git add app/lib/feature/eew/data/model/eew_estimated_region.dart \
  app/lib/feature/eew/data/model/eew_estimated_region.freezed.dart \
  app/lib/feature/eew/ui/page/eew_details_by_event_id_page.dart \
  app/lib/feature/eew/ui/components/eew_details_map_view.dart \
  app/lib/feature/eew/ui/components/eew_forecast_region_layer.dart
git commit -m "feat: EEW詳細画面・シミュレーション画面に推定震度オーバーレイを統合"
```

---

### Task 7: 動作確認・エッジケース対応

**Files:**
- 変更なし（確認のみ）

- [ ] **Step 1: コード生成が最新であることを確認**

```bash
melos run generate
```

- [ ] **Step 2: 全体の analyze を実行**

```bash
melos run analyze
```

Expected: No issues found

- [ ] **Step 3: テストを実行**

```bash
melos run test
```

- [ ] **Step 4: エッジケースの確認**

以下のケースが正しく処理されることをコードレビューで確認:

1. **震源情報なし**: `hypocenter == null` → 推定震度は空リスト → 従来通りJMAのみ表示
2. **PLUM法**: `isPlum == true` → hypocenter に lat/lng がない場合は推定不可 → 従来通り
3. **フラグOFF**: `estimatedIntensityOnEewReplayAllowedProvider == false` → 推定震度計算をスキップ
4. **震度1未満**: `jmaIntensity == null` → 地図色分け対象外だがS波到達時刻は `EewEstimatedRegion` に含まれる → EewCard で到達時間を表示
5. **JMAとのマージ**: JMA発表済みregionは推定から除外。JMAが同じregionCodeを持つ場合はJMA値が使われる
6. **ユーザー位置情報なし**: `locationStreamProvider.value == null` → `userRegionEstimate` は `null` → EewCard は従来通り

- [ ] **Step 5: 最終コミット（必要な場合のみ）**

修正があった場合:

```bash
git add -u
git commit -m "fix: EEW推定震度オーバーレイのエッジケース修正"
```
