# 震度DB観測点アイコン表示統一 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 震度DB観測点へXML観測点と同じfull/plain/最大震度のアイコン表示要件を適用する。

**Architecture:** 震度階級からラベルなしアイコンIDを解決する責務を既存のアイコンID extensionへ追加する。震度DB GeoJSONを表示モード非依存のfull/plain/isMax契約に変更し、MapLibreレイヤーではXMLと同じ `stationIconImageExpression` を利用する。

**Tech Stack:** Flutter、Dart、MapLibre style expressions、flutter_test

## Global Constraints

- Flutter/Dartコマンドは `mise exec --` 経由で実行する。
- 歴史的分類はラベルなしでは意味を区別できないため、plainでもラベルを維持する。
- 最大震度階級は実データの階級から導出し、固定値へフォールバックしない。
- ユーザーの無関係な作業ツリー変更には触れない。

---

### Task 1: full/plainアイコンID契約

**Files:**
- Modify: `app/lib/feature/earthquake_history/ui/components/shindo_db_intensity_class_icon.dart`
- Test: `app/test/feature/earthquake_history/ui/shindo_db_intensity_class_map_icon_test.dart`

**Interfaces:**
- Produces: `ShindoDbIntensityClass.mapIconId`（ラベル入り）と `ShindoDbIntensityClass.plainMapIconId`（ラベルなし）

- [ ] **Step 1: ラベルなしIDの失敗テストを書く**

```dart
expect(ShindoDbIntensityClass.four.plainMapIconId,
    'JmaIntensity.smallWithoutText.four');
expect(ShindoDbIntensityClass.five.plainMapIconId,
    'JmaIntensity.smallWithoutText.fiveUnknown');
expect(ShindoDbIntensityClass.local.plainMapIconId,
    'ShindoDbIntensityClass.small.local');
```

- [ ] **Step 2: REDを確認する**

Run: `cd app && mise exec -- flutter test test/feature/earthquake_history/ui/shindo_db_intensity_class_map_icon_test.dart`
Expected: `plainMapIconId` が未定義でFAIL。

- [ ] **Step 3: 最小実装を追加する**

```dart
String get plainMapIconId => switch (this) {
  .five => 'JmaIntensity.${IntensityIconType.smallWithoutText.name}.fiveUnknown',
  .six => 'JmaIntensity.${IntensityIconType.smallWithoutText.name}.sixUnknown',
  _ when exactJmaIntensity case final exact? =>
    'JmaIntensity.${IntensityIconType.smallWithoutText.name}.${exact.name}',
  _ => mapIconId,
};
```

- [ ] **Step 4: GREENを確認してコミットする**

Run: Step 2と同じ。Expected: PASS。
Commit: `Fix: 震度DB階級にラベルなしアイコンIDを追加`

### Task 2: 震度DBレイヤーの共通表示式移行

**Files:**
- Modify: `app/lib/feature/earthquake_history/ui/layer/earthquake_history_shindo_db_station_layer.dart`
- Test: `app/test/feature/earthquake_history/ui/layer/earthquake_history_shindo_db_station_layer_lifecycle_test.dart`

**Interfaces:**
- Consumes: `mapIconId`、`plainMapIconId`、`stationIconImageExpression`
- Produces: GeoJSON properties `iconIdFull`、`iconIdPlain`、`isMax`、`sortKey`

- [ ] **Step 1: GeoJSON契約の失敗テストを書く**

震度3、旧震度5、歴史的分類localの実 `ShindoDbStationNode` を `unresolvedStations` に入れ、literal値で次を検証する。

```dart
expect(propertiesByName['震度3'], containsPair('isMax', false));
expect(propertiesByName['旧震度5'], containsPair('isMax', true));
expect(propertiesByName['旧震度5'], containsPair(
  'iconIdPlain', 'JmaIntensity.smallWithoutText.fiveUnknown'));
expect(propertiesByName['局発'], containsPair(
  'iconIdPlain', 'ShindoDbIntensityClass.small.local'));
```

- [ ] **Step 2: REDを確認する**

Run: `cd app && mise exec -- flutter test test/feature/earthquake_history/ui/layer/earthquake_history_shindo_db_station_layer_lifecycle_test.dart`
Expected: `iconIdFull` / `iconIdPlain` / `isMax` が無くFAIL。

- [ ] **Step 3: GeoJSONとレイヤーを最小修正する**

全観測階級から `orderIndex` 最大の階級を導出し、各featureへfull/plain/isMaxを格納する。`EarthquakeHistoryShindoDbStationLayer` とBuilderへ既定値 `.auto` の `StationDisplayMode` を渡し、`icon-image` を次へ変更する。

```dart
'icon-image': stationIconImageExpression(
  stationDisplayMode: stationDisplayMode,
  stationTextZoom: parameter.stationTextZoom,
),
```

- [ ] **Step 4: GREENと関連テストを確認する**

Run: `cd app && mise exec -- flutter test test/feature/earthquake_history/ui/layer/earthquake_history_shindo_db_station_layer_lifecycle_test.dart test/feature/earthquake_history/ui/layer/station_icon_image_expression_test.dart test/feature/earthquake_history/ui/shindo_db_intensity_class_map_icon_test.dart`
Expected: 全件PASS。

- [ ] **Step 5: format/analyze後にコミットする**

Run: `mise exec -- dart format app/lib/feature/earthquake_history/ui/components/shindo_db_intensity_class_icon.dart app/lib/feature/earthquake_history/ui/layer/earthquake_history_shindo_db_station_layer.dart app/test/feature/earthquake_history/ui/shindo_db_intensity_class_map_icon_test.dart app/test/feature/earthquake_history/ui/layer/earthquake_history_shindo_db_station_layer_lifecycle_test.dart`
Run: `cd app && mise exec -- flutter analyze lib/feature/earthquake_history/ui/components/shindo_db_intensity_class_icon.dart lib/feature/earthquake_history/ui/layer/earthquake_history_shindo_db_station_layer.dart`
Commit: `Fix: 震度DB観測点をXMLと同じ表示条件に統一`
