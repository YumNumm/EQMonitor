# EEW 関連バグ・未実装機能

> **着手して実装したら削除すること。**
それぞれの機能についてコミットして、プッシュすること。

## 背景

EEW 表示にまたがる 3 つの既知問題をまとめた。
いずれもコード内の `TODO(eqmonitor_api)` / `TODO(YumNumm)` コメントで把握されていたが、個別のタスクとして整理できていなかった。

---

## 1. `intensity` / `maxIntensity` が常に `unknown` になる codegen バグ

**ファイル (3 箇所):**
- `app/lib/feature/home/ui/component/map/layer/eew_estimated_intensity_layer.dart:34`
- `app/lib/feature/eew/ui/components/eew_table.dart:168`
- `app/lib/feature/eew/ui/screen/eew_details_screen.dart:73`

**問題:**
`eqmonitor_api` パッケージの codegen バグにより、EEW 予報区の `intensity` および `maxIntensity` フィールドが常に `JmaIntensity.unknown` として返される。
EEW テーブル・詳細画面で予想震度が表示されない原因になっている。

**修正方針:**
1. `packages/eqmonitor_api` の OpenAPI スキーマを確認し、intensity フィールドの型定義・codegen 設定を修正する。
2. 修正後、上記 3 箇所の `TODO(eqmonitor_api)` コメントを削除し、`sortedBy` 等の intensity 比較ロジックを有効化する。

---

## 2. 予想震度レイヤーの更新ロジックがコメントアウト

**ファイル:** `app/lib/feature/home/ui/component/map/layer/eew_estimated_intensity_layer.dart:89-114`

**問題:**
データ更新 `useEffect` 内のベクタータイルフィルター更新処理がすべてコメントアウトされている。
レイヤー自体は初期化されるが、EEW データが変わってもマップ上の色が更新されない。

```dart
// TODO(YumNumm): 予想震度レイヤー
// unawaited(() async {
//   await JmaIntensity.values.map(...updateFilter...).wait;
// }());
```

**修正方針:**
1. 上記 1 の codegen バグを修正して `intensity` が正しく取得できるようになってから対応する。
2. `styleController.updateFilter(...)` を用いて各震度レイヤーのフィルターを更新するロジックを実装・有効化する。
3. `eew_forecast_region_layer.dart:22` の `TODO(impl)` も合わせて確認する（ベクタータイルフィルター操作の実装待ち）。

---

## 3. WebSocket 未接続時の API フォールバックが未実装

**ファイル:** `app/lib/feature/eew/data/eew_telegram.dart:39-44`

**問題:**
10 秒ごとの `Timer.periodic` コールバックが空 `{}` のまま。WebSocket 切断時に EEW データが更新されない。

```dart
final refreshTimer = Timer.periodic(
  const Duration(seconds: 10),
  (_) async {
    // TODO(YumNumm): WebSocketが接続されていない場合には、API経由で取得する
  },
);
```

**修正方針:**
```dart
(_) async {
  final isConnected = ref.read(realtimeConnectionStateProvider);
  if (!isConnected) {
    ref.invalidate(_eewRestProvider);
  }
},
```
`realtimeConnectionStateProvider`（または相当するプロバイダー）で WebSocket の接続状態を確認し、切断中のみ REST API を再フェッチする。

---

## 参照

- `app/lib/feature/home/ui/component/map/layer/eew_estimated_intensity_layer.dart`
- `app/lib/feature/eew/ui/components/eew_table.dart`
- `app/lib/feature/eew/ui/screen/eew_details_screen.dart`
- `app/lib/feature/eew/data/eew_telegram.dart`
- `app/lib/feature/eew/ui/components/eew_forecast_region_layer.dart`
