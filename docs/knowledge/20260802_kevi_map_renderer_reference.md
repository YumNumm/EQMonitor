# KEVi地図描画から参照する設計知見

## 調査対象

- Repository: `ingen084/KyoshinEewViewerIngen`
- Commit: `5a2bf513b6b9c93ee06473f70b6d27ee96070b3f`
- License: MIT, Copyright © 2019 ingen084
- 固定参照: https://github.com/ingen084/KyoshinEewViewerIngen/tree/5a2bf513b6b9c93ee06473f70b6d27ee96070b3f

KEViはAvaloniaの`CompositionCustomVisual`からSkiaSharpの`SKCanvas`へ順序付きlayerを直接描画する。PMTiles/MVT tile engineではないため、tile選択の正本にはしない。

## 採用するパターン

- `MapControl.cs` / `MapLayer.cs`: UI/render間のstate snapshot、`RefreshRequested`、`NeedPersistentUpdate`をframe schedulingの参考にする。typed dirty reasonはKEViで観測したものではなく、EQMonitor側の強化とする。
- `MapLayerHost.cs`: 宣言順を描画順、逆順をhit test優先順として同じtreeから導出する。
- `PointLayoutCache.cs` / `NormalizedPointSet.cs`: array-backed point dataと投影cacheを参考にする。投影済みpointとflat spatial indexをimmutableに共有することはEQMonitor側のpolicyとする。
- `HoverTracker.cs`: callerが提供するequalityで更新後の要素を照合する。stable Feature IDでhover/selectionを再束縛することはEQMonitor側のpolicyとする。
- `MapLayerLabelRenderer.cs`: 実測文字サイズに基づくscreen placement候補とleader lineをrenderer policyの参考にする。alternate geographic anchorをKEViへ帰属させない。
- metricsはopt-inかつrate-limitedにし、frameとnode/layerの両方を観測する。

## 採用しないパターン

- 既定Miller projection、緯度±80°clamp、1回だけのlongitude wrapをWeb Mercator実装へ流用しない。
- camera変更ごとの全`SKPicture`破棄をGPU mesh/buffer cacheへ流用しない。
- host lockを保持した全render、exact zoomやarray referenceだけのcache keyを採用しない。
- 次frame開始時のdisposeをGPU completionとみなさない。
- dynamic layerを毎frame全再描画せず、typed deltaと部分buffer更新を使う。
- mutable paintやsetter中心のlayerを、Freezed DTO + reconcilerの公開APIへ持ち込まない。

## EQMonitorでの適用境界

KEViはframe snapshot、ordered layer、array-backed動的点群、screen上のlabel placementの参考とする。EQMonitorのlabel assetは1つの地理anchorだけを持ち、right/left/up/down候補を実測文字サイズとDPRからrendererで生成する。leader lineもrenderer policyであり、assetへalternate anchorやleader line属性を持たせない。

Web Mercator、tile cover、overzoom、world wrap、MVT edge処理、PMTiles range fetchはMapLibreの仕様・実装に従う。KEViの個別EEW P/S波実装を検証済みとは扱わず、本設計のgeodesic P/S波はEQMonitor独自の要件とする。

参照ファイルの固定URLは設計正本`docs/superpowers/specs/2026-08-02-eqmonitor-map-renderer-design.md`に記録する。
