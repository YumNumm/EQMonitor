# Platform Asset ベースマップ設計

## 背景

現在のベースマップは、MapLibre の style JSON から
`pmtiles://https://v2.map.eqmonitor.app/all.pmtiles` を参照している。
一方、リポジトリには同梱用の
`app/assets/map/earthquake_tsunami_all.pmtiles` が存在するが、現在のstyleからは
利用されていない。

iOSとAndroidでは、この既存PMTilesを各プラットフォームのAssetとして同梱し、
MapLibre Nativeから直接参照する。これにより、ベースマップの描画をHTTP通信に
依存させない。

## 対象範囲

- iOSとAndroidのベースマップPMTilesをPlatform Assetから直接参照する。
- macOSとWebは既存のHTTPS参照を維持する。
- 地名表示用GlyphのHTTPS参照は変更しない。
- イベントごとに配信される推計震度PMTilesなど、ベースマップ以外のデータ取得は
  変更しない。

## Asset配置

PMTilesの実体を次の場所へ移動する。

```text
app/assets/map/earthquake_tsunami_all.pmtiles
  -> app/assets/platform/earthquake_tsunami_all.pmtiles
```

`app/assets/platform/earthquake_tsunami_all.pmtiles` を唯一の実体とし、ファイルを
iOS用とAndroid用に複製しない。

Androidでは `app/assets/platform/` をアプリのassets source setへ登録する。
iOSでは同じPMTilesをRunner targetのBundle Resourcesへ参照登録する。
Flutterの `pubspec.yaml` から旧 `assets/map/` 登録を削除し、Flutter Assetとしては
同梱しない。

## URI選択

ベースマップURIは同期的なプラットフォーム分岐で決定する。Provider、Notifier、
MethodChannelなどの状態管理・非同期境界は追加しない。

| 実行環境 | ベースマップURI |
| --- | --- |
| iOS | `pmtiles://asset://earthquake_tsunami_all.pmtiles` |
| Android | `pmtiles://asset://earthquake_tsunami_all.pmtiles` |
| macOS | `pmtiles://https://v2.map.eqmonitor.app/all.pmtiles` |
| Web | `pmtiles://https://v2.map.eqmonitor.app/all.pmtiles` |

`MapStyleUtil.getStyle()` は同期的に選択したURIを既存の `eqmonitor_map` vector sourceへ
設定する。MapLibre NativeはiOSとAndroidの両方で `pmtiles://asset://` をサポートするため、
Application Supportなどへの実行時コピーは行わない。

## エラーとフォールバック

iOSとAndroidでは、Platform Assetの読込失敗時にHTTPSへフォールバックしない。
固定値や生成データによる代替も行わない。

今回の変更では、Asset更新、バージョン管理、マニフェスト、実行時ハッシュ検証、
再ダウンロード、専用エラーUIを追加しない。Platform Assetはアプリのビルド成果物として
固定され、MapLibre Nativeが直接読み込む。

## 将来のBackground Assets対応

Background Assetsへの移行は今回の対象外とする。移行時には、モバイル向けの同期的な
URI選択を、ダウンロード済みファイルを示す `pmtiles://file://` URIの解決へ置き換える。
今回、そのための抽象化や未使用コードは先行追加しない。

## 検証方針

ユーザーの指定により、新規の単体テスト、Widgetテスト、ビルド成果物テスト、
オフラインスモークテストは追加しない。実装差分の確認では、次の構成のみを確認する。

- PMTilesの実体が `app/assets/platform/` に一つだけ存在する。
- AndroidとiOSが同じ実体をPlatform Assetとして参照する。
- iOSとAndroidのベースマップURIにHTTPSフォールバックがない。
- macOSとWebの既存HTTPS参照が維持される。
- Flutter Assetの旧PMTiles登録と生成参照が残っていない。

## 変更しないもの

- PMTilesファイルの内容とファイル名
- MapLibre forkとMapLibre Nativeのバージョン
- `eqmonitor_map` のsource IDと各source-layer
- Glyph、推計震度PMTiles、その他のネットワークデータ取得
- マップ画面のUIと状態管理
