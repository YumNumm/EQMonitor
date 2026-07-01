# EEW推定震度オーバーレイ設計

## 概要

EEW詳細画面・シミュレーション再生時に、距離減衰式によるregionごとの予想震度とS波到達時刻を表示する機能。JMAが発表済みのregionはJMA値を優先し、未発表regionのみ距離減衰式で補完する。

## アプローチ

**C. EewTelegramItemを入力とするFamily Provider**

`EewTelegramItem` を引数に取るFamily Providerで推定震度を計算。JMAデータとのマージはUI層で `useMemoized` により行う。

## ゲート条件

`estimatedIntensityOnEewReplayAllowedProvider == true` の場合のみ機能が有効。将来的に一般ユーザーにも展開予定のため、命名に「debug」は使わない。

## 設計

### 1. フラグ管理

`SharedPreferencesKey` に `isEstimatedIntensityOnEewReplayAllowed`（bool, default: false）を追加。

```dart
@Riverpod(keepAlive: true)
class EstimatedIntensityOnEewReplayAllowed extends _$... {
  bool build() => prefs.getBool(key) ?? false;
  void save({required bool isEnabled}) { ... }
}
```

デバッグ画面のEEWセクション付近に `SwitchListTile` を配置。

### 2. 推定震度Provider（計算のみ）

```dart
@riverpod
Future<List<EewEstimatedRegion>> eewEstimatedRegionIntensity(
  Ref ref,
  EewTelegramItem eew,
) async { ... }
```

ロジック:
1. `eew.hypocenter` から震源情報（lat, lon, magnitude, depth）を取得
2. `EstimatedIntensityDataSource` で全station点の推定震度を計算（Isolateで実行）
3. regionCode単位で最大値を集約
4. S波到達時刻を `TravelTimeProvider` + 各regionの代表点への震源距離から算出

### 3. データモデル

```dart
@Freezed()
class EewEstimatedRegion {
  final String regionCode;
  final String regionName;
  final double intensity;           // 計測震度スケール
  final JmaIntensity? jmaIntensity; // JMA震度階級に変換済み（震度1未満はnull）
  final DateTime? sWaveArrivalTime; // S波到達時刻（null=算出不可）
  final bool isArrived;             // 到達済みかどうか
}
```

### 4. UI層でのJMAマージ（useMemoized）

```dart
final mergedRegions = useMemoized(() {
  final estimated = estimatedRegions;
  final jmaRegions = eew.forecastIntensity?.regions ?? [];
  final jmaCodes = jmaRegions.map((r) => r.code).toSet();

  return [
    ...jmaRegions,
    ...estimated.where((e) => !jmaCodes.contains(e.regionCode)),
  ];
}, [estimated, eew]);
```

### 5. 地図レイヤーの変更

`EewForecastRegionLayer` に `additionalRegions: List<EewEstimatedRegion>?` パラメータを追加。

- フラグON時: マージ結果を渡す
- フラグOFF時: `null` → 従来通りJMAのみ
- `jmaIntensity` が `null`（震度1未満）のregionは色分け対象外

### 6. EewCardの到達時間表示

`EewCard` に `userRegionEstimate: EewEstimatedRegion?` パラメータを追加。

- ユーザーの現在地regionは `JmaRegionResolver.resolveRegionCode()` で取得
- マージ済みリストからユーザーのregionCodeに一致するものを検索
- S波到達時刻から現在時刻（シミュレーション時は仮想時刻）を引いて残り秒数を算出
  - 未到達: 「あとXX秒」
  - 到達済み: 「到達済み」
- 震度1未満のregionでも到達時間は表示

### 7. データフロー全体像

```
EewTelegramItem
  |
  +---> eewEstimatedRegionIntensityProvider(eew)
  |       -> List<EewEstimatedRegion>（距離減衰式の計算結果）
  |
  +---> eew.forecastIntensity.regions
  |       -> List<EewForecastRegionInfo>（JMA発表値）
  |
  +---> UI層 useMemoized でマージ
          +---> EewForecastRegionLayer（地図色分け）
          +---> EewCard（ユーザー現在地の到達時間）

ゲート条件:
  estimatedIntensityOnEewReplayAllowedProvider == true
```

## 表示スコープ

- EEW詳細画面（非シミュレーション）: 選択した報に対して表示
- シミュレーション再生時: currentReportに対して表示
- いずれもフラグON時のみ

## 既存コードの再利用

| コンポーネント | 用途 |
|---|---|
| `EstimatedIntensityDataSource` | 距離減衰式（藤本・翠川系） |
| `TravelTimeProvider` | S波走時テーブル |
| `JmaRegionResolver` | ユーザー現在地のregionCode解決 |
| `EewForecastRegionLayer` | 地図上のregion色分け |
| `EewCard` | EEW情報カード |
| `EarthquakeParameter` | station一覧（lat, lon, arv400, regionCode） |
