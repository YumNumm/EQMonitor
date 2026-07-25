# 観測点表示モード切替 実装計画

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 地震履歴詳細画面の観測点アイコン表示を4モード(自動/最大震度のみ/すべて数字入り/すべて色のみ)で切替可能にし、XML・震度DB両レイヤーに適用する。

**Architecture:** GeoJSONをモード非依存(`iconIdFull`/`iconIdPlain`/`isMax`プロパティを常時付与)にし、MapLibreの`icon-image`にモード別の式(自動モードはズーム`step`式)を設定する。設定は`EarthquakeHistoryConfig`にSharedPreferences永続化し、「マップレイヤー」モーダルで切替。

**Tech Stack:** Flutter / Riverpod / Freezed / maplibre (flutter-maplibre) / flutter_test

**Spec:** `docs/superpowers/specs/2026-07-25-station-display-mode-design.md`

## Global Constraints

- 作業ブランチ: `feature/station-display-mode`(作成済み。develop へ直接コミットしない)
- `dart analyze` 警告ゼロを維持。ただし app/ での analyze はハングしやすいので必ず `timeout` を付け、対象ディレクトリを絞る(例: `cd app && timeout 600 dart analyze lib/feature/earthquake_history test/feature/earthquake_history`)
- import はパッケージ import(`package:eqmonitor/...`)。相対 import 禁止
- 生成ファイル(`*.g.dart`, `*.freezed.dart`)はコミットに含める。codegen は `cd app && dart run build_runner build --delete-conflicting-outputs`
- コミットメッセージ末尾に `Co-Authored-By: Claude Fable 5 <noreply@anthropic.com>`
- **案C(2レイヤー分割)へのフォールバックはユーザー確認なしに行わない**(Task 5 参照)
- テスト実行は `cd app && flutter test <path>`。リポジトリ全体のテストには既存の無関係な失敗があるため、このプランでは `app/test/feature/earthquake_history/` 配下に限定して実行する

---

### Task 1: `StationDisplayMode.auto` と設定モデルの追加

**Files:**
- Modify: `app/lib/feature/earthquake_history/data/model/earthquake_history_config_model.dart`
- Modify: `app/lib/feature/earthquake_history/ui/layer/earthquake_history_station_intensity_layer.dart:286-293, 425-462`(enum追加によるコンパイルエラー回避)
- Test: `app/test/feature/earthquake_history/data/model/earthquake_history_config_model_test.dart`(新規)

**Interfaces:**
- Produces: `StationDisplayMode.auto`(enum値、既定モード)/ `EarthquakeHistoryDetailsConfig`(`stationDisplayMode`フィールド持ち)/ `EarthquakeHistoryConfig.details`(`@Default(EarthquakeHistoryDetailsConfig())`)
- 後続タスクは `config.details.stationDisplayMode` で参照する

- [ ] **Step 1: 失敗するテストを書く**

`app/test/feature/earthquake_history/data/model/earthquake_history_config_model_test.dart` を新規作成:

```dart
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('details キーの無い保存済み JSON からデフォルト値で復元できる', () {
    final config = EarthquakeHistoryConfig.fromJson({
      'list': <String, dynamic>{},
    });

    expect(config.details.stationDisplayMode, StationDisplayMode.auto);
  });

  test('stationDisplayMode を JSON ラウンドトリップできる', () {
    const config = EarthquakeHistoryConfig(
      list: EarthquakeHistoryListConfig(),
      details: EarthquakeHistoryDetailsConfig(
        stationDisplayMode: StationDisplayMode.allMinimized,
      ),
    );

    final restored = EarthquakeHistoryConfig.fromJson(config.toJson());

    expect(
      restored.details.stationDisplayMode,
      StationDisplayMode.allMinimized,
    );
  });
}
```

- [ ] **Step 2: テストが失敗することを確認**

Run: `cd app && flutter test test/feature/earthquake_history/data/model/earthquake_history_config_model_test.dart`
Expected: FAIL(コンパイルエラー: `details` / `EarthquakeHistoryDetailsConfig` / `StationDisplayMode.auto` が未定義)

- [ ] **Step 3: モデルを実装**

`earthquake_history_config_model.dart` の `EarthquakeHistoryConfig` を変更:

```dart
@freezed
abstract class EarthquakeHistoryConfig with _$EarthquakeHistoryConfig {
  const factory EarthquakeHistoryConfig({
    required EarthquakeHistoryListConfig list,
    @Default(EarthquakeHistoryDetailsConfig())
    EarthquakeHistoryDetailsConfig details,
  }) = _EarthquakeHistoryConfig;

  factory EarthquakeHistoryConfig.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeHistoryConfigFromJson(json);
}
```

`EarthquakeHistoryListConfig` の直後に新クラスを追加:

```dart
/// 地震履歴詳細画面の設定
@freezed
abstract class EarthquakeHistoryDetailsConfig
    with _$EarthquakeHistoryDetailsConfig {
  const factory EarthquakeHistoryDetailsConfig({
    /// 観測点アイコンの表示モード
    @Default(StationDisplayMode.auto) StationDisplayMode stationDisplayMode,
  }) = _EarthquakeHistoryDetailsConfig;

  factory EarthquakeHistoryDetailsConfig.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeHistoryDetailsConfigFromJson(json);
}
```

`StationDisplayMode` enum を変更(`auto` を先頭に追加):

```dart
/// 観測点の表示方法
enum StationDisplayMode {
  /// ズームに応じて自動切替 (閾値未満: 最大震度のみ数字入り / 閾値以上: すべて数字入り)
  auto,
  maxFocused,
  normal,
  allMinimized,
}
```

- [ ] **Step 4: enum追加で壊れる既存switchを修正**

`earthquake_history_station_intensity_layer.dart` の2箇所(このファイルはTask 4で本格改修するが、コンパイルを通すため先に最小修正する。いずれも最終仕様と同じ挙動):

`iconIdForStation`(286行付近)— `auto` は `maxFocused` と同じ扱い:

```dart
    final useSmall = switch (stationDisplayMode) {
      StationDisplayMode.normal => true,
      StationDisplayMode.auto ||
      StationDisplayMode.maxFocused => isFocused,
      StationDisplayMode.allMinimized => false,
    };
```

`buildCircleLayer` の `circle-radius` switch(425行付近)— `maxFocused` のcaseパターンを or-pattern に変更:

```dart
          StationDisplayMode.auto ||
          StationDisplayMode.maxFocused => [
            'interpolate',
            // (既存の maxFocused の式をそのまま維持)
```

- [ ] **Step 5: コード生成**

Run: `cd app && dart run build_runner build --delete-conflicting-outputs`
Expected: `earthquake_history_config_model.freezed.dart` / `.g.dart` が更新され、エラーなく完了

- [ ] **Step 6: テストが通ることを確認**

Run: `cd app && flutter test test/feature/earthquake_history/data/model/earthquake_history_config_model_test.dart`
Expected: PASS(2件)

- [ ] **Step 7: コミット**

```bash
git add app/lib/feature/earthquake_history/data/model/earthquake_history_config_model.* app/lib/feature/earthquake_history/ui/layer/earthquake_history_station_intensity_layer.dart app/test/feature/earthquake_history/data/model/earthquake_history_config_model_test.dart
git commit -m "feat: StationDisplayMode.auto と詳細画面設定モデルを追加"
```

---

### Task 2: `stationTextZoom` パラメータとデバッグスライダー

**Files:**
- Modify: `app/lib/feature/earthquake_history/data/model/earthquake_history_map_layer_parameter.dart:13`
- Modify: `app/lib/feature/earthquake_history/ui/components/modal/earthquake_history_debug_modal.dart:105-111` 付近
- Test: `app/test/feature/earthquake_history/data/model/earthquake_history_map_layer_parameter_test.dart`(新規)

**Interfaces:**
- Produces: `EarthquakeHistoryMapLayerParameter.stationTextZoom`(double、既定9)。Task 4/7 が `parameter.stationTextZoom` として消費

- [ ] **Step 1: 失敗するテストを書く**

`app/test/feature/earthquake_history/data/model/earthquake_history_map_layer_parameter_test.dart` を新規作成:

```dart
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_map_layer_parameter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('stationTextZoom の既定値は 9 で、保存済み JSON に無くても復元できる', () {
    const parameter = EarthquakeHistoryMapLayerParameter();
    expect(parameter.stationTextZoom, 9);

    final restored = EarthquakeHistoryMapLayerParameter.fromJson(
      <String, dynamic>{},
    );
    expect(restored.stationTextZoom, 9);
  });
}
```

- [ ] **Step 2: テストが失敗することを確認**

Run: `cd app && flutter test test/feature/earthquake_history/data/model/earthquake_history_map_layer_parameter_test.dart`
Expected: FAIL(コンパイルエラー: `stationTextZoom` 未定義)

- [ ] **Step 3: パラメータを追加**

`earthquake_history_map_layer_parameter.dart` の `stationLabelMinZoom` の次行に追加:

```dart
    @Default(9) double stationLabelMinZoom,
    @Default(9) double stationTextZoom,
```

- [ ] **Step 4: デバッグモーダルにスライダーを追加**

`earthquake_history_debug_modal.dart` の「観測点名 表示開始」スライダーの直後に追加:

```dart
              _slider(
                '観測点 数字表示 (自動)',
                value.stationTextZoom,
                3,
                15,
                (v) => notifier.save(value.copyWith(stationTextZoom: v)),
              ),
```

- [ ] **Step 5: コード生成とテスト確認**

Run: `cd app && dart run build_runner build --delete-conflicting-outputs && flutter test test/feature/earthquake_history/data/model/earthquake_history_map_layer_parameter_test.dart`
Expected: PASS

- [ ] **Step 6: コミット**

```bash
git add app/lib/feature/earthquake_history/data/model/earthquake_history_map_layer_parameter.* app/lib/feature/earthquake_history/ui/components/modal/earthquake_history_debug_modal.dart app/test/feature/earthquake_history/data/model/earthquake_history_map_layer_parameter_test.dart
git commit -m "feat: 自動モード用ズーム閾値 stationTextZoom を追加"
```

---

### Task 3: `stationIconImageExpression` 式ヘルパー

**Files:**
- Create: `app/lib/feature/earthquake_history/ui/layer/model/station_icon_image_expression.dart`
- Test: `app/test/feature/earthquake_history/ui/layer/station_icon_image_expression_test.dart`(新規)

**Interfaces:**
- Consumes: `StationDisplayMode`(Task 1)
- Produces: `Object stationIconImageExpression({required StationDisplayMode stationDisplayMode, required double stationTextZoom})` — MapLibre `icon-image` 用の式。GeoJSON featureに `iconIdFull` / `iconIdPlain` / `isMax` プロパティがある前提。Task 4/7 が消費

- [ ] **Step 1: 失敗するテストを書く**

`app/test/feature/earthquake_history/ui/layer/station_icon_image_expression_test.dart` を新規作成:

```dart
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/model/station_icon_image_expression.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const full = ['get', 'iconIdFull'];
  const plain = ['get', 'iconIdPlain'];
  const maxOnly = [
    'case',
    ['get', 'isMax'],
    full,
    plain,
  ];

  test('auto はズーム step 式で切り替える', () {
    expect(
      stationIconImageExpression(
        stationDisplayMode: StationDisplayMode.auto,
        stationTextZoom: 9,
      ),
      [
        'step',
        ['zoom'],
        maxOnly,
        9.0,
        full,
      ],
    );
  });

  test('maxFocused は isMax 分岐のみ', () {
    expect(
      stationIconImageExpression(
        stationDisplayMode: StationDisplayMode.maxFocused,
        stationTextZoom: 9,
      ),
      maxOnly,
    );
  });

  test('normal は常に数字入り', () {
    expect(
      stationIconImageExpression(
        stationDisplayMode: StationDisplayMode.normal,
        stationTextZoom: 9,
      ),
      full,
    );
  });

  test('allMinimized は常に色のみ', () {
    expect(
      stationIconImageExpression(
        stationDisplayMode: StationDisplayMode.allMinimized,
        stationTextZoom: 9,
      ),
      plain,
    );
  });
}
```

- [ ] **Step 2: テストが失敗することを確認**

Run: `cd app && flutter test test/feature/earthquake_history/ui/layer/station_icon_image_expression_test.dart`
Expected: FAIL(ファイルが存在しないためコンパイルエラー)

- [ ] **Step 3: ヘルパーを実装**

`app/lib/feature/earthquake_history/ui/layer/model/station_icon_image_expression.dart` を新規作成:

```dart
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';

/// 観測点シンボルレイヤーの `icon-image` 式を表示モードから組み立てる
///
/// GeoJSON feature は以下のプロパティを持つ前提:
/// - `iconIdFull`: 数字入りアイコンの画像 ID
/// - `iconIdPlain`: 色のみアイコンの画像 ID
/// - `isMax`: その地震の最大震度観測点か
Object stationIconImageExpression({
  required StationDisplayMode stationDisplayMode,
  required double stationTextZoom,
}) {
  const full = ['get', 'iconIdFull'];
  const plain = ['get', 'iconIdPlain'];
  const maxOnly = [
    'case',
    ['get', 'isMax'],
    full,
    plain,
  ];
  return switch (stationDisplayMode) {
    StationDisplayMode.auto => [
      'step',
      ['zoom'],
      maxOnly,
      stationTextZoom,
      full,
    ],
    StationDisplayMode.maxFocused => maxOnly,
    StationDisplayMode.normal => full,
    StationDisplayMode.allMinimized => plain,
  };
}
```

- [ ] **Step 4: テストが通ることを確認**

Run: `cd app && flutter test test/feature/earthquake_history/ui/layer/station_icon_image_expression_test.dart`
Expected: PASS(4件)

- [ ] **Step 5: コミット**

```bash
git add app/lib/feature/earthquake_history/ui/layer/model/station_icon_image_expression.dart app/test/feature/earthquake_history/ui/layer/station_icon_image_expression_test.dart
git commit -m "feat: 観測点 icon-image 式ヘルパーを追加"
```

---

### Task 4: XML側レイヤーのモード非依存GeoJSON化と式適用

**Files:**
- Modify: `app/lib/feature/earthquake_history/ui/layer/earthquake_history_station_intensity_layer.dart`
- Modify: `app/test/feature/earthquake_history/ui/layer/earthquake_history_station_intensity_layer_lifecycle_test.dart`
- Test: `app/test/feature/earthquake_history/ui/layer/earthquake_history_station_geo_json_builder_test.dart`(新規)

**Interfaces:**
- Consumes: `stationIconImageExpression`(Task 3)/ `parameter.stationTextZoom`(Task 2)
- Produces:
  - `EarthquakeHistoryStationGeoJsonBuilder.build({required EarthquakeIntensity? intensity, required IntensityColors colorModel, required bool showingLpgmIntensity})` — `stationDisplayMode` 引数は**削除**
  - GeoJSON properties: `color` / `name` / `isMax` / `iconIdFull` / `iconIdPlain` / `sortKey`(`isFocused` と `iconId` は廃止)
  - `EarthquakeHistoryStationIntensityLayerBuilder.buildIconLayer({required EarthquakeHistoryMapLayerParameter parameter, required StationDisplayMode stationDisplayMode})`
  - Widgetの `stationDisplayMode` 既定値は `StationDisplayMode.auto` に変更

- [ ] **Step 1: 失敗するテストを書く**

`app/test/feature/earthquake_history/ui/layer/earthquake_history_station_geo_json_builder_test.dart` を新規作成:

```dart
import 'dart:convert';

import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_station.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/lpgm_intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_station_intensity_layer.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lat_lng/lat_lng.dart';

StationIntensityNode _station(
  String code, {
  JmaIntensity? maxIntensity,
  JmaLpgmIntensity? maxLpgmIntensity,
}) {
  final item = EarthquakeParameterStationItem(
    code: code,
    noCode: code,
    name: LocalizedName(ja: '観測点$code'),
    kana: null,
    status: EarthquakeStationStatus.operating,
    sourceStatus: 'test',
    owner: 'test',
    location: const LatLng(35, 139),
  );
  return StationIntensityNode(
    station: item,
    intensity: IntensityStation(
      code: item.code,
      name: item.name.ja,
      sva: null,
      prePeriods: null,
      maxIntensity: maxIntensity,
      maxLpgmIntensity: maxLpgmIntensity,
    ),
  );
}

EarthquakeIntensity _intensity() {
  const prefecture = IntensityPrefecture(
    prefecture: EarthquakeParameterPrefectureItem(
      code: '001',
      name: LocalizedName(ja: 'テスト都道府県'),
      regions: [],
    ),
    maxIntensity: JmaIntensity.four,
  );
  const city = EarthquakeParameterCityItem(
    code: '001001',
    name: LocalizedName(ja: 'テスト市区町村'),
    kana: null,
    stations: [],
  );
  const region = EarthquakeParameterRegionItem(
    code: '001',
    name: LocalizedName(ja: 'テスト地域'),
    kana: null,
    cities: [],
  );
  final maxStation = _station(
    '001001001',
    maxIntensity: JmaIntensity.four,
    maxLpgmIntensity: JmaLpgmIntensity.two,
  );
  final subStation = _station(
    '001001002',
    maxIntensity: JmaIntensity.three,
    maxLpgmIntensity: JmaLpgmIntensity.one,
  );
  return EarthquakeIntensity(
    maxIntensity: JmaIntensity.four,
    maxLpgmIntensity: JmaLpgmIntensity.two,
    regions: const {},
    intensityTree: {
      JmaIntensity.four: [
        PrefectureIntensityNode(
          prefecture: prefecture,
          cities: [
            CityIntensityNode(
              city: city,
              maxIntensity: JmaIntensity.four,
              stations: [maxStation, subStation],
            ),
          ],
        ),
      ],
    },
    lpgmIntensityTree: {
      JmaLpgmIntensity.two: [
        PrefectureLpgmIntensityNode(
          region: region,
          maxLpgmIntensity: JmaLpgmIntensity.two,
          cities: [
            CityLpgmIntensityNode(
              city: city,
              maxLpgmIntensity: JmaLpgmIntensity.two,
              stations: [
                StationLpgmIntensityNode(
                  station: maxStation.station,
                  intensity: maxStation.intensity,
                ),
                StationLpgmIntensityNode(
                  station: subStation.station,
                  intensity: subStation.intensity,
                ),
              ],
            ),
          ],
        ),
      ],
    },
  );
}

List<Map<String, dynamic>> _properties(String geoJson) {
  final decoded = jsonDecode(geoJson) as Map<String, dynamic>;
  return (decoded['features'] as List)
      .cast<Map<String, dynamic>>()
      .map((f) => f['properties']! as Map<String, dynamic>)
      .toList();
}

void main() {
  final colorModel = AppTheme.eqmonitorDefault().light!.intensity;
  const builder = EarthquakeHistoryStationGeoJsonBuilder();

  test('JMA: 全観測点に iconIdFull/iconIdPlain/isMax が付与される', () {
    final geoJson = builder.build(
      intensity: _intensity(),
      colorModel: colorModel,
      showingLpgmIntensity: false,
    );
    final props = _properties(geoJson);

    expect(props, hasLength(2));
    final max = props.singleWhere((p) => p['isMax'] == true);
    expect(max['iconIdFull'], 'JmaIntensity.small.four');
    expect(max['iconIdPlain'], 'JmaIntensity.smallWithoutText.four');
    final sub = props.singleWhere((p) => p['isMax'] == false);
    expect(sub['iconIdFull'], 'JmaIntensity.small.three');
    expect(sub['iconIdPlain'], 'JmaIntensity.smallWithoutText.three');
  });

  test('LPGM: maxLpgmIntensity 基準で isMax が付与される', () {
    final geoJson = builder.build(
      intensity: _intensity(),
      colorModel: colorModel,
      showingLpgmIntensity: true,
    );
    final props = _properties(geoJson);

    expect(props, hasLength(2));
    final max = props.singleWhere((p) => p['isMax'] == true);
    expect(max['iconIdFull'], 'JmaLpgmIntensity.small.two');
    expect(max['iconIdPlain'], 'JmaLpgmIntensity.smallWithoutText.two');
    final sub = props.singleWhere((p) => p['isMax'] == false);
    expect(sub['iconIdFull'], 'JmaLpgmIntensity.small.one');
  });
}
```

注意: `EarthquakeParameterStationItem` / `IntensityStation` などのコンストラクタ引数は
`app/test/feature/earthquake_history/ui/layer/earthquake_history_map_layer_mode_test.dart:347-372`
の既存フィクスチャと同じ形。コンパイルエラーが出たら同ファイルを参照して合わせること。

- [ ] **Step 2: テストが失敗することを確認**

Run: `cd app && flutter test test/feature/earthquake_history/ui/layer/earthquake_history_station_geo_json_builder_test.dart`
Expected: FAIL(`build` に `stationDisplayMode` が必要 / プロパティ不一致)

- [ ] **Step 3: GeoJSONビルダーをモード非依存に書き換える**

`earthquake_history_station_intensity_layer.dart` の `EarthquakeHistoryStationGeoJsonBuilder` を以下に置き換える(`iconIdForStation` / `lpgmIconIdForStation` メソッドは削除):

```dart
class EarthquakeHistoryStationGeoJsonBuilder {
  const EarthquakeHistoryStationGeoJsonBuilder();

  static const iconSmallPrefix = 'JmaIntensity.small.';
  static const iconSmallNoTextPrefix = 'JmaIntensity.smallWithoutText.';
  static const lpgmIconSmallPrefix = 'JmaLpgmIntensity.small.';
  static const lpgmIconSmallNoTextPrefix = 'JmaLpgmIntensity.smallWithoutText.';

  String build({
    required EarthquakeIntensity? intensity,
    required IntensityColors colorModel,
    required bool showingLpgmIntensity,
  }) => showingLpgmIntensity
      ? buildLpgmGeoJson(intensity: intensity, colorModel: colorModel)
      : buildJmaGeoJson(intensity: intensity, colorModel: colorModel);

  String buildJmaGeoJson({
    required EarthquakeIntensity? intensity,
    required IntensityColors colorModel,
  }) {
    if (intensity == null) {
      return jsonEncode({'type': 'FeatureCollection', 'features': <dynamic>[]});
    }

    final features = <Map<String, dynamic>>[];
    for (final entry in intensity.intensityTree.entries) {
      for (final region in entry.value) {
        for (final city in region.cities) {
          for (final stationNode in city.stations) {
            final jmaIntensity = stationNode.intensity?.maxIntensity;
            if (jmaIntensity == null) {
              continue;
            }
            final color = colorModel
                .fromJmaIntensity(jmaIntensity)
                .background
                .toHexStringRGB();
            final isMax = intensity.maxIntensity == jmaIntensity;
            final station = stationNode.station;
            features.add({
              'type': 'Feature',
              'geometry': {
                'type': 'Point',
                'coordinates': [station.location.lon, station.location.lat],
              },
              'properties': {
                'color': color,
                'name': station.name.ja,
                'isMax': isMax,
                'iconIdFull': '$iconSmallPrefix${jmaIntensity.name}',
                'iconIdPlain': '$iconSmallNoTextPrefix${jmaIntensity.name}',
                'sortKey': jmaIntensity.index,
              },
            });
          }
        }
      }
    }

    return jsonEncode({'type': 'FeatureCollection', 'features': features});
  }

  String buildLpgmGeoJson({
    required EarthquakeIntensity? intensity,
    required IntensityColors colorModel,
  }) {
    if (intensity == null) {
      return jsonEncode({'type': 'FeatureCollection', 'features': <dynamic>[]});
    }

    final features = <Map<String, dynamic>>[];
    for (final entry in intensity.lpgmIntensityTree.entries) {
      for (final region in entry.value) {
        for (final city in region.cities) {
          for (final stationNode in city.stations) {
            final lpgmIntensity = stationNode.intensity?.maxLpgmIntensity;
            if (lpgmIntensity == null) {
              continue;
            }
            final color = colorModel
                .fromJmaLpgmIntensity(lpgmIntensity)
                .background
                .toHexStringRGB();
            final isMax = intensity.maxLpgmIntensity == lpgmIntensity;
            final station = stationNode.station;
            features.add({
              'type': 'Feature',
              'geometry': {
                'type': 'Point',
                'coordinates': [station.location.lon, station.location.lat],
              },
              'properties': {
                'color': color,
                'name': station.name.ja,
                'isMax': isMax,
                'iconIdFull': '$lpgmIconSmallPrefix${lpgmIntensity.name}',
                'iconIdPlain': '$lpgmIconSmallNoTextPrefix${lpgmIntensity.name}',
                'sortKey': lpgmIntensity.index,
              },
            });
          }
        }
      }
    }

    return jsonEncode({'type': 'FeatureCollection', 'features': features});
  }
}
```

- [ ] **Step 4: レイヤービルダーとWidgetを更新**

同ファイル内で以下を変更:

1. import 追加:
```dart
import 'package:eqmonitor/feature/earthquake_history/ui/layer/model/station_icon_image_expression.dart';
```

2. `buildIconLayer` に `stationDisplayMode` を追加し `icon-image` を式に変更:
```dart
  SymbolStyleLayer buildIconLayer({
    required EarthquakeHistoryMapLayerParameter parameter,
    required StationDisplayMode stationDisplayMode,
  }) {
    return SymbolStyleLayer(
      id: iconLayerId,
      sourceId: sourceId,
      minZoom: parameter.stationMinZoom,
      layout: {
        'icon-image': stationIconImageExpression(
          stationDisplayMode: stationDisplayMode,
          stationTextZoom: parameter.stationTextZoom,
        ),
        'icon-allow-overlap': true,
        'icon-ignore-placement': true,
        'symbol-sort-key': ['get', 'sortKey'],
        'icon-size': [
          'interpolate',
          ['linear'],
          ['zoom'],
          3,
          parameter.stationIconSizeMin,
          7,
          parameter.stationIconSizeMid,
          20,
          parameter.stationIconSizeMax,
        ],
      },
    );
  }
```

3. `buildCircleLayer` 内の `['get', 'isFocused']` を2箇所とも `['get', 'isMax']` に変更(Task 1で導入済みの `auto || maxFocused` パターンは維持)。

4. Widget側:
   - コンストラクタ既定値: `this.stationDisplayMode = StationDisplayMode.auto,`
   - `geoJsonBuilder.build(...)` 呼び出し(69行付近)から `stationDisplayMode: stationDisplayMode,` を削除
   - `buildIconLayer` の2箇所の呼び出し(111行・211行付近)にそれぞれ `stationDisplayMode: latestStationDisplayMode.value,` / `stationDisplayMode: stationDisplayMode,` を追加

- [ ] **Step 5: 既存lifecycle testの引数を修正**

`earthquake_history_station_intensity_layer_lifecycle_test.dart` の `builder.build(...)` から `stationDisplayMode: StationDisplayMode.normal,` を削除し、未使用になった import(`earthquake_history_config_model.dart`)も削除する。

- [ ] **Step 6: テストが通ることを確認**

Run: `cd app && flutter test test/feature/earthquake_history/ui/layer/`
Expected: 全件PASS

- [ ] **Step 7: コミット**

```bash
git add app/lib/feature/earthquake_history/ui/layer/earthquake_history_station_intensity_layer.dart app/test/feature/earthquake_history/ui/layer/
git commit -m "feat: XML観測点レイヤーをモード非依存GeoJSON+icon-image式に変更"
```

---

### Task 5: 案Aの実機検証チェックポイント(ユーザー確認必須)

**Files:** なし(検証のみ)

- [ ] **Step 1: ユーザーに動作検証を依頼する**

ここで実装を一時停止し、ユーザーに以下の検証を依頼する(エージェントは端末での目視確認ができないため):

1. `cd app && flutter run` でアプリを起動(iOSシミュレータ/Android実機どちらでも可、可能なら両方)
2. 地震履歴からXML由来の地震の詳細画面を開く
3. ズームレベル9未満: 最大震度の観測点のみ数字入り、他は色のみの円になること
4. ズームレベル9以上に拡大: すべての観測点が数字入りになること
5. ズームをまたいで往復してもアイコンが正しく切り替わること(多少の遅延は許容)

- [ ] **Step 2: 結果に応じて分岐**

- 動作OK → Task 6へ進む
- 動作NG(`step`+`case`式が `icon-image` で効かない等)→ **作業を停止し、案C(minZoom/maxZoomで分割した2枚のシンボルレイヤー)への切替可否をユーザーに確認する。確認なしに案Cを実装しないこと**

---

### Task 6: 震度DB固有アイコンの色のみバリアント

**Files:**
- Modify: `app/lib/feature/earthquake_history/ui/components/shindo_db_intensity_class_icon.dart`
- Modify: `app/lib/feature/earthquake_history/data/provider/shindo_db_intensity_icon_provider.dart`
- Modify: `app/lib/feature/earthquake_history/ui/layer/earthquake_history_shindo_db_station_layer.dart:100-103`(`toMapStyleImages` 廃止に伴う修正)
- Test: `app/test/feature/earthquake_history/ui/shindo_db_intensity_class_map_icon_test.dart`(追記)

**Interfaces:**
- Consumes: `IntensityIconType.smallWithoutText`(既存)
- Produces:
  - `ShindoDbIntensityClass.mapIconIdPlain`(String getter)
  - `ShindoDbIntensityClassMapIcon.withText`(bool、既定true)
  - `shindoDbIntensityIconProvider` の型が `Future<Map<String, Uint8List>>`(キー=画像ID)に変更。`ShindoDbIntensityIconEx.toMapStyleImages` 拡張は削除

- [ ] **Step 1: 失敗するテストを書く**

`shindo_db_intensity_class_map_icon_test.dart` の `group('ShindoDbIntensityClassMapIcon', ...)` 内に追記:

```dart
    test('mapIconIdPlain は smallWithoutText 系の画像 ID を返すこと', () {
      expect(
        ShindoDbIntensityClass.four.mapIconIdPlain,
        'JmaIntensity.smallWithoutText.four',
      );
      expect(
        ShindoDbIntensityClass.five.mapIconIdPlain,
        'ShindoDbIntensityClass.smallWithoutText.five',
      );
      expect(
        ShindoDbIntensityClass.unknownFelt.mapIconIdPlain,
        'ShindoDbIntensityClass.smallWithoutText.unknownFelt',
      );
    });

    testWidgets('withText=false ではラベルテキストを描画しないこと', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light().copyWith(
            extensions: <ThemeExtension<dynamic>>[
              DesignSystemThemeExtension.light(),
            ],
          ),
          home: const Scaffold(
            body: Center(
              child: ShindoDbIntensityClassMapIcon(
                intensityClass: ShindoDbIntensityClass.unknownFelt,
                withText: false,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('震度不明'), findsNothing);
      expect(tester.takeException(), isNull);
    });
```

- [ ] **Step 2: テストが失敗することを確認**

Run: `cd app && flutter test test/feature/earthquake_history/ui/shindo_db_intensity_class_map_icon_test.dart`
Expected: FAIL(`mapIconIdPlain` / `withText` 未定義)

- [ ] **Step 3: アイコンID・Widgetを実装**

`shindo_db_intensity_class_icon.dart` の extension に `mapIconIdPlain` を追加:

```dart
  /// 色のみ (ラベルテキストなし) 版の観測点アイコン画像 ID
  String get mapIconIdPlain {
    final exact = exactJmaIntensity;
    return exact != null
        ? 'JmaIntensity.${IntensityIconType.smallWithoutText.name}.${exact.name}'
        : 'ShindoDbIntensityClass.${IntensityIconType.smallWithoutText.name}.$name';
  }
```

`ShindoDbIntensityClassMapIcon` を変更:

```dart
class ShindoDbIntensityClassMapIcon extends StatelessWidget {
  const ShindoDbIntensityClassMapIcon({
    required this.intensityClass,
    this.size = 50,
    this.withText = true,
    super.key,
  });

  final ShindoDbIntensityClass intensityClass;
  final double size;

  /// false の場合はラベルテキストを描画しない (色のみアイコン)
  final bool withText;

  @override
  Widget build(BuildContext context) {
    final exact = intensityClass.exactJmaIntensity;
    if (exact != null) {
      return JmaIntensityIcon(
        intensity: exact,
        type: withText
            ? IntensityIconType.small
            : IntensityIconType.smallWithoutText,
        size: size,
      );
    }

    final colorTheme = context.designSystem.colorTheme;
    final colorJma = intensityClass.colorJmaIntensity;
    final entry = colorJma != null
        ? colorTheme.intensity.fromJmaIntensity(colorJma)
        : null;
    final fg = entry?.resolvedForeground ?? colorTheme.onSurface;
    final bg = entry?.background ?? colorTheme.surfaceContainerHighest;
    final borderColor = Color.lerp(bg, fg, 0.3) ?? fg;
    return SizedBox(
      height: size,
      width: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bg,
          border: Border.all(color: borderColor, width: 5),
        ),
        child: !withText
            ? null
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      intensityClass.label,
                      style: TextStyle(
                        color: fg,
                        fontSize: 100,
                        fontWeight: FontWeight.bold,
                        fontFamily: FontFamily.googleSansCode,
                        fontFamilyFallback: const [FontFamily.notoSansJP],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
```

- [ ] **Step 4: プロバイダを両バリアント生成に変更**

`shindo_db_intensity_icon_provider.dart` の関数本体と拡張を置き換える(戻り値型変更、`ShindoDbIntensityIconEx` は削除):

```dart
/// 震度データベース固有の震度階級 (旧階級 5/6・歴史的階級) の地図用アイコン
///
/// 現行の JMA 震度と一致する階級は intensityIconProvider の画像を流用するため、
/// ここでは [ShindoDbIntensityClass.exactJmaIntensity] を持たない階級のみ、
/// 数字入り・色のみの両バリアントを描画する。キーは地図スタイル画像 ID。
@Riverpod(keepAlive: true)
Future<Map<String, Uint8List>> shindoDbIntensityIcon(
  Ref ref,
) async {
  final colorSet = ref.watch(activeColorSetProvider);
  final brightness = ref.watch(brightnessProvider);

  final result = <String, Uint8List>{};
  final futures = <Future<void>>[];
  for (final cls in ShindoDbIntensityClass.values.where(
    (cls) => cls.exactJmaIntensity == null,
  )) {
    for (final (id, withText) in [
      (cls.mapIconId, true),
      (cls.mapIconIdPlain, false),
    ]) {
      futures.add(() async {
        final bytes = await renderWidgetToImageBytes(
          logicalSize: const Size(50, 50),
          widget: Theme(
            data: buildTheme(colorSet: colorSet, brightness: brightness),
            child: ShindoDbIntensityClassMapIcon(
              intensityClass: cls,
              withText: withText,
            ),
          ),
        );
        if (bytes == null) {
          throw Exception('Failed to render ShindoDbIntensityClassMapIcon');
        }
        result[id] = bytes;
      }());
    }
  }
  await futures.wait;
  return result;
}
```

`earthquake_history_shindo_db_station_layer.dart` の `addImages` 呼び出し(100-103行)を修正:

```dart
            await styleController.addImages({
              ...iconData.toMapStyleImages,
              ...dbIconData,
            });
```

- [ ] **Step 5: コード生成とテスト確認**

Run: `cd app && dart run build_runner build --delete-conflicting-outputs && flutter test test/feature/earthquake_history/ui/shindo_db_intensity_class_map_icon_test.dart`
Expected: PASS

- [ ] **Step 6: コミット**

```bash
git add app/lib/feature/earthquake_history/ui/components/shindo_db_intensity_class_icon.dart app/lib/feature/earthquake_history/data/provider/shindo_db_intensity_icon_provider.* app/lib/feature/earthquake_history/ui/layer/earthquake_history_shindo_db_station_layer.dart app/test/feature/earthquake_history/ui/shindo_db_intensity_class_map_icon_test.dart
git commit -m "feat: 震度DB固有階級の色のみアイコンバリアントを追加"
```

---

### Task 7: 震度DBレイヤーのモード対応

**Files:**
- Modify: `app/lib/feature/earthquake_history/ui/layer/earthquake_history_shindo_db_station_layer.dart`
- Test: `app/test/feature/earthquake_history/ui/layer/earthquake_history_shindo_db_station_layer_lifecycle_test.dart`(追記)

**Interfaces:**
- Consumes: `stationIconImageExpression`(Task 3)/ `mapIconIdPlain`(Task 6)/ `parameter.stationTextZoom`(Task 2)
- Produces:
  - `EarthquakeHistoryShindoDbStationLayer` に `this.stationDisplayMode = StationDisplayMode.auto` パラメータ追加
  - `EarthquakeHistoryShindoDbStationLayerBuilder.build({required parameter, required stationDisplayMode})`
  - GeoJSON properties: `name` / `iconIdFull` / `iconIdPlain` / `isMax` / `sortKey`(`iconId` は廃止)

- [ ] **Step 1: 失敗するテストを書く**

`earthquake_history_shindo_db_station_layer_lifecycle_test.dart` に追記:

```dart
  ShindoDbStationNode station(String code, ShindoDbIntensityClass cls) =>
      ShindoDbStationNode(
        record: EarthquakeCatalogStationRecord(
          stationCode: code,
          intensityClass: cls,
          instrumentalIntensity: null,
          observedAt: null,
          maxAcceleration: null,
          maxAccelTime: null,
          periods: null,
          observationCount: null,
        ),
        name: '観測点$code',
        location: const LatLng(35, 139),
      );

  test('全観測点に iconIdFull/iconIdPlain/isMax が付与される', () {
    final geoJson = const EarthquakeHistoryShindoDbStationGeoJsonBuilder()
        .build(
          tree: ShindoDbIntensityTree(
            tree: const {},
            unresolvedStations: {
              ShindoDbIntensityClass.five: [
                station('001', ShindoDbIntensityClass.five),
              ],
              ShindoDbIntensityClass.three: [
                station('002', ShindoDbIntensityClass.three),
              ],
            },
            totalStationCount: 2,
          ),
        );
    final decoded = jsonDecode(geoJson) as Map<String, dynamic>;
    final props = (decoded['features'] as List)
        .cast<Map<String, dynamic>>()
        .map((f) => f['properties']! as Map<String, dynamic>)
        .toList();

    expect(props, hasLength(2));
    final max = props.singleWhere((p) => p['isMax'] == true);
    expect(max['iconIdFull'], 'ShindoDbIntensityClass.small.five');
    expect(max['iconIdPlain'], 'ShindoDbIntensityClass.smallWithoutText.five');
    final sub = props.singleWhere((p) => p['isMax'] == false);
    expect(sub['iconIdFull'], 'JmaIntensity.small.three');
    expect(sub['iconIdPlain'], 'JmaIntensity.smallWithoutText.three');
  });
```

必要なimportを追加:

```dart
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_catalog.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_class.dart';
import 'package:lat_lng/lat_lng.dart';
```

- [ ] **Step 2: テストが失敗することを確認**

Run: `cd app && flutter test test/feature/earthquake_history/ui/layer/earthquake_history_shindo_db_station_layer_lifecycle_test.dart`
Expected: FAIL(プロパティが `iconId` のまま)

- [ ] **Step 3: GeoJSONビルダーとレイヤーを実装**

`earthquake_history_shindo_db_station_layer.dart` を変更。

1. import 追加:
```dart
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/model/station_icon_image_expression.dart';
```

2. Widget にパラメータ追加:
```dart
  const EarthquakeHistoryShindoDbStationLayer({
    required this.tree,
    required this.parameter,
    this.stationDisplayMode = StationDisplayMode.auto,
    super.key,
  });

  final ShindoDbIntensityTree tree;
  final EarthquakeHistoryMapLayerParameter parameter;
  final StationDisplayMode stationDisplayMode;
```

3. レイヤー再構築 useEffect(83-121行)内の `LayerBuilder.build` 呼び出しに `stationDisplayMode: stationDisplayMode,` を追加し、依存配列を `[styleController, parameter, stationDisplayMode, iconData, dbIconData]` に変更。

4. `EarthquakeHistoryShindoDbStationLayerBuilder.build` を変更:
```dart
  static SymbolStyleLayer build({
    required EarthquakeHistoryMapLayerParameter parameter,
    required StationDisplayMode stationDisplayMode,
  }) => SymbolStyleLayer(
    id: EarthquakeHistoryShindoDbStationLayer.iconLayerId,
    sourceId: EarthquakeHistoryShindoDbStationLayer.sourceId,
    minZoom: parameter.stationMinZoom,
    layout: {
      'icon-image': stationIconImageExpression(
        stationDisplayMode: stationDisplayMode,
        stationTextZoom: parameter.stationTextZoom,
      ),
      'icon-allow-overlap': true,
      'icon-ignore-placement': true,
      'symbol-sort-key': ['get', 'sortKey'],
      'icon-size': [
        'interpolate',
        ['linear'],
        ['zoom'],
        3,
        parameter.stationIconSizeMin,
        7,
        parameter.stationIconSizeMid,
        20,
        parameter.stationIconSizeMax,
      ],
    },
  );
```

5. `EarthquakeHistoryShindoDbStationGeoJsonBuilder.build` を変更(最大階級の算出と新プロパティ):
```dart
  String build({required ShindoDbIntensityTree tree}) {
    final classes = {...tree.tree.keys, ...tree.unresolvedStations.keys};
    final maxClass = classes.isEmpty
        ? null
        : classes.reduce((a, b) => a.orderIndex >= b.orderIndex ? a : b);
    final features = <Map<String, dynamic>>[];

    void addStation(ShindoDbStationNode station, ShindoDbIntensityClass cls) {
      final loc = station.location;
      if (loc == null) {
        return;
      }
      features.add({
        'type': 'Feature',
        'geometry': {
          'type': 'Point',
          'coordinates': [loc.lon, loc.lat],
        },
        'properties': {
          'name': station.name,
          'iconIdFull': cls.mapIconId,
          'iconIdPlain': cls.mapIconIdPlain,
          'isMax': cls == maxClass,
          // 高震度が上に描画されるようソートキーに使用
          'sortKey': cls.orderIndex,
        },
      });
    }
```
(以降の tree / unresolvedStations のループと `jsonEncode` は既存のまま)

- [ ] **Step 4: テストが通ることを確認**

Run: `cd app && flutter test test/feature/earthquake_history/ui/layer/`
Expected: 全件PASS

- [ ] **Step 5: コミット**

```bash
git add app/lib/feature/earthquake_history/ui/layer/earthquake_history_shindo_db_station_layer.dart app/test/feature/earthquake_history/ui/layer/earthquake_history_shindo_db_station_layer_lifecycle_test.dart
git commit -m "feat: 震度DB観測点レイヤーに表示モードを適用"
```

---

### Task 8: マップレイヤーモーダルUIと配線

**Files:**
- Create: `app/lib/feature/earthquake_history/ui/components/modal/station_display_mode_setting_cards.dart`
- Modify: `app/lib/feature/earthquake_history/ui/components/modal/earthquake_history_details_map_layer_modal.dart`
- Modify: `app/lib/feature/earthquake_history/ui/components/earthquake_history_details_map_view.dart:105付近, 210-214, 234-239`
- Test: `app/test/feature/earthquake_history/ui/components/station_display_mode_setting_cards_test.dart`(新規)

**Interfaces:**
- Consumes: `earthquakeHistoryConfigProvider`(既存)/ `EarthquakeHistoryDetailsConfig`(Task 1)/ 両レイヤーの `stationDisplayMode` パラメータ(Task 4/7)
- Produces: `StationDisplayModeSettingCards({required StationDisplayMode selected, required ValueChanged<StationDisplayMode> onSelect})`

- [ ] **Step 1: 失敗するテストを書く**

`app/test/feature/earthquake_history/ui/components/station_display_mode_setting_cards_test.dart` を新規作成:

```dart
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/modal/station_display_mode_setting_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pump(
    WidgetTester tester, {
    required StationDisplayMode selected,
    required ValueChanged<StationDisplayMode> onSelect,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.light().copyWith(
          extensions: <ThemeExtension<dynamic>>[
            DesignSystemThemeExtension.light(),
          ],
        ),
        home: Scaffold(
          body: StationDisplayModeSettingCards(
            selected: selected,
            onSelect: onSelect,
          ),
        ),
      ),
    );
  }

  testWidgets('4モードすべての選択肢が表示される', (tester) async {
    await pump(
      tester,
      selected: StationDisplayMode.auto,
      onSelect: (_) {},
    );

    expect(find.text('自動'), findsOneWidget);
    expect(find.text('最大震度のみ'), findsOneWidget);
    expect(find.text('すべて数字'), findsOneWidget);
    expect(find.text('色のみ'), findsOneWidget);
  });

  testWidgets('タップで対応するモードがコールバックされる', (tester) async {
    StationDisplayMode? selected;
    await pump(
      tester,
      selected: StationDisplayMode.auto,
      onSelect: (mode) => selected = mode,
    );

    await tester.tap(find.text('すべて数字'));
    await tester.pump();

    expect(selected, StationDisplayMode.normal);
  });
}
```

- [ ] **Step 2: テストが失敗することを確認**

Run: `cd app && flutter test test/feature/earthquake_history/ui/components/station_display_mode_setting_cards_test.dart`
Expected: FAIL(ファイル未作成)

- [ ] **Step 3: 選択カードWidgetを実装**

`app/lib/feature/earthquake_history/ui/components/modal/station_display_mode_setting_cards.dart` を新規作成(カードの見た目は `earthquake_history_details_map_layer_modal.dart` の `_LocationCard` と同じスタイル):

```dart
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:flutter/material.dart';

/// 観測点アイコン表示モードの選択カード (2x2)
class StationDisplayModeSettingCards extends StatelessWidget {
  const StationDisplayModeSettingCards({
    required this.selected,
    required this.onSelect,
    super.key,
  });

  final StationDisplayMode selected;
  final ValueChanged<StationDisplayMode> onSelect;

  static const _items = [
    (
      mode: StationDisplayMode.auto,
      title: '自動',
      icon: Icons.hdr_auto,
    ),
    (
      mode: StationDisplayMode.maxFocused,
      title: '最大震度のみ',
      icon: Icons.filter_center_focus,
    ),
    (
      mode: StationDisplayMode.normal,
      title: 'すべて数字',
      icon: Icons.pin,
    ),
    (
      mode: StationDisplayMode.allMinimized,
      title: '色のみ',
      icon: Icons.circle_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var row = 0; row < _items.length; row += 2)
          Row(
            children: [
              for (final item in _items.sublist(row, row + 2))
                Expanded(
                  child: _ModeCard(
                    title: item.title,
                    icon: item.icon,
                    isSelected: selected == item.mode,
                    onTap: () => onSelect(item.mode),
                  ),
                ),
            ],
          ),
      ],
    );
  }
}

class _ModeCard extends StatelessWidget {
  const _ModeCard({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final designSystem = context.designSystem;

    return Card.outlined(
      elevation: 0,
      color: isSelected
          ? designSystem.colorTheme.primaryContainer
          : designSystem.colorTheme.surfaceContainer,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected
                    ? designSystem.colorTheme.onPrimaryContainer
                    : designSystem.colorTheme.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isSelected
                        ? designSystem.colorTheme.onPrimaryContainer
                        : designSystem.colorTheme.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 4: テストが通ることを確認**

Run: `cd app && flutter test test/feature/earthquake_history/ui/components/station_display_mode_setting_cards_test.dart`
Expected: PASS(2件)

- [ ] **Step 5: モーダルにセクションを追加**

`earthquake_history_details_map_layer_modal.dart` を変更。

1. import 追加:
```dart
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_config_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/modal/station_display_mode_setting_cards.dart';
```

2. body の sliver 一覧(68行付近)を変更:
```dart
          const SliverToBoxAdapter(child: _StationDisplayModeSection()),
          const SliverToBoxAdapter(child: _LocationSettingCards()),
```

3. `_LocationSettingCards` の前に新クラスを追加:
```dart
class _StationDisplayModeSection extends ConsumerWidget {
  const _StationDisplayModeSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final configAsync = ref.watch(earthquakeHistoryConfigProvider);

    return configAsync.when(
      data: (config) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '観測点アイコン',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            StationDisplayModeSettingCards(
              selected: config.details.stationDisplayMode,
              onSelect: (mode) => lightHapticFunction(
                () => ref
                    .read(earthquakeHistoryConfigProvider.notifier)
                    .save(
                      config.copyWith(
                        details: config.details.copyWith(
                          stationDisplayMode: mode,
                        ),
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
    );
  }
}
```

- [ ] **Step 6: 地図Viewへ配線**

`earthquake_history_details_map_view.dart` の `_MapContent.build` 内(`parameter` のwatch付近、105行辺り)に追加:

```dart
    final stationDisplayMode = ref.watch(
      earthquakeHistoryConfigProvider.select(
        (config) =>
            config.value?.details.stationDisplayMode ?? StationDisplayMode.auto,
      ),
    );
```

import 追加:
```dart
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_config_notifier.dart';
```

`EarthquakeHistoryShindoDbStationLayer`(210行付近)と `EarthquakeHistoryStationIntensityLayer`(234行付近)の両方に引数を追加:

```dart
                  stationDisplayMode: stationDisplayMode,
```

- [ ] **Step 7: レイヤー配下テストの回帰確認**

Run: `cd app && flutter test test/feature/earthquake_history/`
Expected: 全件PASS(このプランで追加・変更したテスト含む)

- [ ] **Step 8: コミット**

```bash
git add app/lib/feature/earthquake_history/ui/components/modal/ app/lib/feature/earthquake_history/ui/components/earthquake_history_details_map_view.dart app/test/feature/earthquake_history/ui/components/station_display_mode_setting_cards_test.dart
git commit -m "feat: マップレイヤーモーダルに観測点表示モード切替を追加"
```

---

### Task 9: 総仕上げ(解析・全テスト・実機確認)

**Files:** なし(検証と微修正のみ)

- [ ] **Step 1: 静的解析**

Run: `cd app && timeout 600 dart analyze lib/feature/earthquake_history test/feature/earthquake_history`
Expected: `No issues found!`(警告が出たら修正してからコミット)

- [ ] **Step 2: フォーマット確認**

Run: `cd app && dart format --set-exit-if-changed lib/feature/earthquake_history test/feature/earthquake_history`
Expected: 変更なし(差分が出たらそのままコミットに含める)

- [ ] **Step 3: feature配下の全テスト**

Run: `cd app && flutter test test/feature/earthquake_history/`
Expected: 全件PASS

- [ ] **Step 4: ユーザーによる最終実機確認を依頼**

ユーザーに以下の確認を依頼する:

1. XML由来の地震詳細でモーダルから4モードを順に切替 → 地図が即時に追従すること
2. 震度DB由来(ソース切替またはDB専用データ)でも同様に4モードが機能すること
3. 旧5/旧6を含む過去地震(1996年以前)で: 数字系モードは「5」「6」ラベル、色のみモードは色付き円になること
4. 震度不明を含む地震で: 色のみモードでラベルなしグレー円になること
5. アプリ再起動後もモード設定が保持されること
6. 長周期地震動階級表示でもモードが機能すること

- [ ] **Step 5: 問題なければコミット(残差分があれば)して完了報告**

```bash
git status  # 未コミット差分がないことを確認
```

superpowers:finishing-a-development-branch スキルに従い、マージ/PR方針をユーザーに確認する。
