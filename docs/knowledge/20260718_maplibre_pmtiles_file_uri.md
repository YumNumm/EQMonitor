# MapLibre PMTiles は file:// 絶対パスで読む

## 公式仕様（Android）

MapLibre Native Android の現行ドキュメントは次を明記している。

- 対応: `pmtiles://https://...` / `pmtiles://file://<absolute-path>`
- **未対応**: `pmtiles://asset://...`（`AssetManagerFileSource` が byte-range 未実装）

参考: https://maplibre.org/maplibre-native/android/examples/data/PMTiles/

## EQMonitor の実装制約

- ベースマップ URI の組み立ては `BaseMapPmtilesRepository`
- ローカル絶対パス解決は `packages/assets_util`（FlutterGen の `Assets` とは別物）
  - iOS: Native Assets + Swift FFI（`EQMAssetsUtil` / Runner `Bundle.main`）
  - Android: Flutter plugin + Java + jnigen（`filesDir/map/` へ atomic copy、versionCode マーカー）
- HTTPS フォールバックはしない
- URI は `pmtiles://${Uri.file(absolutePath)}` でエンコードする

## 将来の Background Assets / Play Asset Delivery

差し替え点は `assets_util` の `resolveLocalPath` 実装。
MapStyleUtil / MapLibre 側の `pmtiles://file://` 契約は維持する。

## 検証コマンド

```bash
rg -n "pmtiles://asset://|MethodChannel|EventChannel|BasicMessageChannel" \
  packages/assets_util app/lib/feature/map

cd app && mise exec -- dart analyze \
  lib/feature/map/data/provider/map_style_util.dart \
  lib/feature/map/data/repository/base_map_pmtiles_repository.dart
```
