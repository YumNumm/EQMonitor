# 距離減衰式・地域到達時刻修正 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 距離減衰式の断層半径二重控除を解消し、regionの最大震度と最早S波到達時刻を独立して正しく集約する。

**Architecture:** 観測点単位の震度算出は `EstimatedIntensityDataSource` に維持し、region集計を純粋な `EewEstimatedRegionCalculator` へ分離する。Providerは入力検証・依存取得・Isolate実行だけを担当し、Calculatorへ実データを渡す。

**Tech Stack:** Dart、Flutter、Riverpod 3、flutter_test、latlong2、JMA2001走時表

## Global Constraints

- 実装は承認済みspec `docs/superpowers/specs/2026-08-17-estimated-intensity-region-calculation-fix-design.md` に従う。
- 各本番コード変更の前に、旧実装で期待どおり失敗する回帰テストを実行する。
- 到達時刻の対象は現行と同じARV400を持つ推定震度対象点とする。
- 既存のMw変換、司・翠川式、1.31補正、ARV400補正、計測震度変換は変更しない。
- 生成コードはRiverpod generatorで再生成し、手編集しない。

---

### Task 1: 距離減衰式の断層半径二重控除を修正

**Files:**
- Modify: `app/lib/core/provider/estimated_intensity/data/estimated_intensity_data_source.dart:21-48`
- Create: `app/test/core/provider/estimated_intensity/data/estimated_intensity_data_source_test.dart`

**Interfaces:**
- Consumes: `EstimatedIntensityDataSource.getEstimatedIntensity({points, jmaMagnitude, depth, hypocenter})`
- Produces: 震央距離と深さから求めた震源距離から断層半径を1回だけ控除する推定震度列

- [ ] **Step 1: 旧実装の二重控除を検出するテストを書く**

```dart
test('M8で断層半径の外側にある遠方点は近距離点より低い震度になる', () {
  final intensities = EstimatedIntensityDataSource()
      .getEstimatedIntensity(
        points: const [
          (lat: 35, lon: 135.55, arv400: 1),
          (lat: 35, lon: 136.10, arv400: 1),
        ],
        jmaMagnitude: 8,
        depth: 10,
        hypocenter: (lat: 35, lon: 135),
      )
      .toList();

  expect(intensities.first - intensities.last, greaterThan(0.5));
});
```

- [ ] **Step 2: REDを確認する**

Run: `cd app && mise exec -- flutter test test/core/provider/estimated_intensity/data/estimated_intensity_data_source_test.dart`

Expected: 旧実装では両地点が最短距離3kmへ丸められ、震度差が0.5以下となってFAILする。

- [ ] **Step 3: 断層半径を1回だけ控除する**

```dart
final epicenterDistance = distanceCalculator.as(...);
final hypocentralDistance = math.sqrt(
  math.pow(depth, 2) + math.pow(epicenterDistance, 2),
);
final distance = hypocentralDistance - faultRadius;
final x = math.max(distance, 3);
```

- [ ] **Step 4: GREENを確認する**

Run: `cd app && mise exec -- flutter test test/core/provider/estimated_intensity/data/estimated_intensity_data_source_test.dart test/core/provider/estimated_intensity/worker/estimated_intensity_isolate_test.dart`

Expected: 新規回帰テストとIsolate契約テストがすべてPASSする。

- [ ] **Step 5: Task 1をコミットする**

```bash
git add app/lib/core/provider/estimated_intensity/data/estimated_intensity_data_source.dart app/test/core/provider/estimated_intensity/data/estimated_intensity_data_source_test.dart
git commit -m "Fix: 距離減衰式の断層半径二重控除を解消"
```

### Task 2: region最大震度と最早到達時刻を純粋Calculatorで集約

**Files:**
- Create: `app/lib/feature/eew/data/logic/eew_estimated_region_calculator.dart`
- Create: `app/test/feature/eew/data/logic/eew_estimated_region_calculator_test.dart`
- Modify: `app/lib/feature/eew/data/logic/s_wave_travel_time_lookup.dart:10-39`

**Interfaces:**
- Consumes: `List<EstimatedIntensityRegionStation>`、同順の `List<double>`、`TravelTimeTables`、震源緯度経度・深さ・発震時刻
- Produces: `EewEstimatedRegionCalculator.calculate(...) -> List<EewEstimatedRegion>`
- Uses: `SWaveTravelTimeLookup.lookup({tables, depth, distanceKm})`。`distanceKm` は震央距離

- [ ] **Step 1: 最大震度地点と最早到達地点が異なる回帰テストを書く**

```dart
test('震度は最大地点、到達時刻は最早地点から独立して集約する', () {
  final result = calculator.calculate(
    stations: [nearStationInRegionA, farStationInRegionA],
    intensities: const [3, 6],
    tables: travelTimeTables,
    depth: 100,
    latitude: 35,
    longitude: 135,
    originTime: originTime,
  );

  expect(result.single.intensity, 6);
  expect(result.single.sWaveArrivalTime, originTime.add(const Duration(seconds: 10)));
});
```

- [ ] **Step 2: 震央直下で震央距離0kmを走時表へ渡す回帰テストを書く**

```dart
test('走時表の距離軸には深さを合成せず震央距離を使う', () {
  final result = calculator.calculate(
    stations: [stationAtEpicenter],
    intensities: const [4],
    tables: const TravelTimeTables(table: [
      TravelTimeTable(p: 5, s: 10, depth: 100, distance: 0),
      TravelTimeTable(p: 10, s: 20, depth: 100, distance: 100),
    ]),
    depth: 100,
    latitude: 35,
    longitude: 135,
    originTime: originTime,
  );

  expect(result.single.sWaveArrivalTime, originTime.add(const Duration(seconds: 10)));
});
```

- [ ] **Step 3: region分離と安全な境界条件のテストを書く**

観測点と震度の件数不一致は空リスト、発震時刻なしは最大震度を保持して到達時刻 `null`、一部走時取得不可は取得可能地点の最小値、異なるregionCodeは別々に集約されることをリテラル値で検証する。

- [ ] **Step 4: REDを確認する**

Run: `cd app && mise exec -- flutter test test/feature/eew/data/logic/eew_estimated_region_calculator_test.dart`

Expected: Calculatorが未定義のためコンパイルエラーとなる。テストAPIの誤りがないことを確認後、最小のクラス定義を追加して旧集計相当を実装し、最早到達テストが期待値不一致でFAILすることまで確認する。

- [ ] **Step 5: `EewEstimatedRegionCalculator` を実装する**

Calculatorは1回の走査でregionCodeごとの最大震度と最小S波走時秒を更新する。各地点の距離は `latlong2.Distance` で震央距離として求め、`SWaveTravelTimeLookup` にそのまま渡す。発震時刻は最小走時決定後に1回だけ加算する。

- [ ] **Step 6: GREENを確認する**

Run: `cd app && mise exec -- flutter test test/feature/eew/data/logic/eew_estimated_region_calculator_test.dart`

Expected: region集計の新規テストがすべてPASSする。

- [ ] **Step 7: Task 2をコミットする**

```bash
git add app/lib/feature/eew/data/logic/eew_estimated_region_calculator.dart app/lib/feature/eew/data/logic/s_wave_travel_time_lookup.dart app/test/feature/eew/data/logic/eew_estimated_region_calculator_test.dart
git commit -m "Fix: 地域の最大震度と最早到達時刻を独立集計"
```

### Task 3: ProviderをCalculatorへ配線

**Files:**
- Modify: `app/lib/feature/eew/data/provider/eew_estimated_region_intensity_provider.dart:1-123`
- Modify: `app/lib/feature/eew/data/provider/eew_estimated_region_intensity_provider.g.dart`
- Test: `app/test/feature/eew/data/logic/eew_estimated_region_calculator_test.dart`
- Test: `app/test/feature/eew/data/provider/eew_estimated_region_intensity_provider_test.dart`

**Interfaces:**
- Consumes: `eewEstimatedRegionCalculatorProvider`
- Produces: `eewEstimatedRegionIntensityProvider(eew)` の既存戻り値契約を維持した `Future<List<EewEstimatedRegion>>`

- [ ] **Step 1: Providerの既存条件を保つことを確認する**

現行の入力除外条件（震源・精度欠落、PLUM、1点検知、深さ150km以上）を読み直し、Calculatorへの委譲前後で変更しない。

- [ ] **Step 2: Provider内の集計・距離計算をCalculator呼び出しへ置換する**

```dart
final calculator = ref.watch(eewEstimatedRegionCalculatorProvider);
return calculator.calculate(
  stations: stationIndex.regionStations,
  intensities: intensities,
  tables: travelTimeTables,
  depth: depth,
  latitude: latitude,
  longitude: longitude,
  originTime: eew.originTime,
);
```

- [ ] **Step 3: Riverpod生成コードを更新する**

Run: `cd app && mise exec -- dart run build_runner build --delete-conflicting-outputs`

Expected: Calculator Providerを参照する生成コードを含め、生成処理がexit 0で完了する。

- [ ] **Step 4: Providerと利用側の関連テストを実行する**

Run: `cd app && mise exec -- flutter test test/feature/eew/data/provider/eew_estimated_region_intensity_provider_test.dart test/feature/home/ui/eew_card_estimated_region_test.dart test/feature/home/ui/home_eew_card_test.dart`

Expected: 既存のモデル変換・到達カウントダウン表示テストがすべてPASSする。

- [ ] **Step 5: Task 3をコミットする**

```bash
git add app/lib/feature/eew/data/provider/eew_estimated_region_intensity_provider.dart app/lib/feature/eew/data/provider/eew_estimated_region_intensity_provider.g.dart
git commit -m "Refactor: EEW推定地域集計をCalculatorへ委譲"
```

### Task 4: 全体検証とPR公開

**Files:**
- Verify: Task 1〜3の全変更
- Publish: PRテンプレートに従う説明文

**Interfaces:**
- Consumes: 完成したブランチ差分
- Produces: `origin/develop` 向けDraft Pull Request

- [ ] **Step 1: formatと差分検査を実行する**

Run: `cd app && mise exec -- dart format lib/core/provider/estimated_intensity/data/estimated_intensity_data_source.dart lib/feature/eew/data/logic/eew_estimated_region_calculator.dart lib/feature/eew/data/logic/s_wave_travel_time_lookup.dart lib/feature/eew/data/provider/eew_estimated_region_intensity_provider.dart test/core/provider/estimated_intensity/data/estimated_intensity_data_source_test.dart test/feature/eew/data/logic/eew_estimated_region_calculator_test.dart`

Run: `git --no-pager diff --check origin/develop...HEAD`

- [ ] **Step 2: analyzeを実行する**

Run: `cd app && mise exec -- flutter analyze lib/core/provider/estimated_intensity lib/feature/eew/data test/core/provider/estimated_intensity test/feature/eew/data`

Expected: error 0件。

- [ ] **Step 3: appの全テストを実行する**

Run: `cd app && mise exec -- flutter test`

Expected: failure 0件。

- [ ] **Step 4: コードレビューを依頼して重要指摘を反映する**

`origin/develop` とHEADの差分、承認済みspec、実装計画をレビュアーへ渡す。Critical/Important指摘は修正し、関連テストと全体検証を再実行する。

- [ ] **Step 5: 最終差分をコミットする**

未コミットの生成コード・format・レビュー修正だけを明示的にstageし、内容に応じた短いコミットメッセージでコミットする。

- [ ] **Step 6: pushしてDraft PRを作成する**

```bash
git push -u origin codex/fix-estimated-intensity-region-arrival
```

PR本文には、3つの根本原因、修正内容、利用者影響、RED/GREENを含む検証コマンドを記載し、baseを `develop`、headを `codex/fix-estimated-intensity-region-arrival` とする。
