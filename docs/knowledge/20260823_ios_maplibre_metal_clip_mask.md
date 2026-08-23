# iOS MapLibre Metal のタイル単位 fill 欠損

## 症状

- 複数の vector source を重ねた地図で、fill がタイル境界に沿って断続的に欠損する。
- 同じタイルの line や label は残ることがある。
- 小さなカメラ移動で欠損位置が変わる。
- Metal 固有の問題であり、Android と同じ MVT を使っても iOS でのみ発生する。

EQMonitor では、ベース地図 PMTiles に推計震度 PMTiles を動的追加する地震履歴詳細画面がこの条件を満たす。

## 原因

MapLibre Native の Metal backend における clip mask 用 UBO の bind cache が原因。

1 frame 内で 2 回目以降に `renderTileClippingMasks` が呼ばれると、clip UBO は stack-local な一時 `BufferResource` に入る。連続する再構築で同じ stack address と初期 version が再利用されると、`RenderPass` の vertex buffer bind cache が古い buffer と同一だと誤認し、`setVertexBuffer` を省略する。

その結果、直前の tile matrix と stencil reference で clip mask が描かれ、stencil clipping を使う fill がタイル単位で消える。Flutter 側の source/layer lifecycle や PMTiles の欠損ではない。

Upstream の修正と回帰テスト:

- [maplibre-native PR #4342](https://github.com/maplibre/maplibre-native/pull/4342)
- `Context::renderTileClippingMasks` で clip UBO slot を明示的に unbind してから bind する。
- `MetalClipMask.RebuildBindsFreshBufferAfterAddressReuse` が、修正なしでは stale buffer bind を再現する。

2026-08-23 時点で PR #4342 は open。EQMonitor が使用する iOS MapLibre Native 6.28.0 には未収録。

## 実データの切り分け

対象イベント `20260823020050` の PMTiles:

```text
https://tiles.eqmonitor.app/ixac41/20260823020050/86eecccd44b812c294b8d06e6224a373bede507ce21bd5380535ae0ae7eda2aa.pmtiles
```

検証結果:

- SHA-256: `86eecccd44b812c294b8d06e6224a373bede507ce21bd5380535ae0ae7eda2aa`
- go-pmtiles v1.31.2 の `verify` に成功
- z0-14、addressed tiles 3999、MVT `seismic_intensity` layer
- 3999 tile をすべて読み出し、repo 内 MVT decoder で decode できた

```bash
pmtiles verify /tmp/eqmonitor-20260823020050.pmtiles
pmtiles show /tmp/eqmonitor-20260823020050.pmtiles
```

したがって、配信ファイルの tile 欠落や壊れた MVT geometry を原因として扱わない。

## 再検証方法

1. ベース地図 source を持つ style を読み込む。
2. 推計震度 PMTiles を別 vector source として動的追加する。
3. `seismic_intensity` の fill と line を同時に表示する。
4. 推計震度範囲付近で zoom/pan を繰り返し、同じタイルで fill と line を比較する。
5. PR #4342 を含む MapLibre Native build と現行 build を同じカメラ・style・PMTiles で比較する。

最終確認では実機または Simulator の画面を使う。`MLNMapSnapshotter` は同じ style を正常描画する場合があり、snapshot だけを修正確認にしない。

## 修正方針

- 第一候補は PR #4342 の merge/release 後に MapLibre Native を更新すること。
- release を待てない場合は、同じ 1-line fix と upstream regression test を含む Native distribution を YumNumm 管理下で検証する。
- Flutter 側で layer の再追加順序や opacity を変える対応は、根本原因を直さず再現条件をずらすだけなので恒久対策にしない。

## 暫定配布版

2026-08-23 に、upstream への書き込みを行わず YumNumm 管理下で次の版を作成した。

- MapLibre Native fork: `YumNumm/maplibre-native`
- ベース: upstream `main` の `0c7fbe2b2938b06ad671b7fcf43e967065e05376`
- 修正版: `yumnumm/ios-metal-clip-mask` の `076b0e8af68b80da5ac389283f1406efea312da6`
- Release: `ios-v6.29.0-yumnumm.2`
- Asset: `MapLibre.dynamic.xcframework.zip`
- SwiftPM checksum: `473ce393b16a54ba787d2d626968ec92614573f1ab00b5af9c65660cc5d18ebc`
- flutter-maplibre: `YumNumm/flutter-maplibre` の `59b744a1452e797e55806c82e9a443a1263a223a`

PR #4342 のテストは古い `mbgl` namespace のままだったため、最新 `main` に合わせて include と namespace を `mln` に移植した。Metal renderer を指定した `//test:tests` のコンパイル、および device arm64 / Simulator arm64・x86_64 を含む XCFramework の生成に成功している。

Release asset は次の URL から直接取得する。

```text
https://github.com/YumNumm/maplibre-native/releases/download/ios-v6.29.0-yumnumm.2/MapLibre.dynamic.xcframework.zip
```

MapLibre Native と同じリポジトリに Swift Package 用ブランチと tag を置き、そのリポジトリを package dependency にすると、SwiftPM が巨大な Native リポジトリ全体を clone する。検証時は約 640 万 object を取得してディスク不足になった。そのため EQMonitor が参照する `flutter-maplibre` では、Package.swift の `binaryTarget` に Release asset URL と checksum を直接記述する。これなら Native リポジトリの source clone は発生しない。

Release asset の同一 URL への上書きは GitHub CDN に古い内容が残り、manifest の checksum と一致しないことがある。配布ZIPを変更する場合は既存assetを上書きせず、新しいtagとURLを発行する。

Xcode の package resolve で Release asset のダウンロードと展開を確認し、展開後の device binary の SHA-256 がビルド元と一致することも確認した。Xcode 27 beta では custom package cache を指定した resolve が PrivacyInfo resource 処理中に内部例外で終了したが、通常の DerivedData を使い Runner scheme と iOS Simulator を明示した build は成功した。生成された Runner.app に arm64 / x86_64 の MapLibre.framework が埋め込まれ、Simulator への install と process launch も成功した。

ローカルに実値入りの `environment/.env.dev` がない場合、アプリは MapLibre 画面へ到達する前に Theme 用 dart-define 不足で停止する。XCFramework の取得・リンク確認と、対象PMTilesを表示した画面確認は区別して記録する。
