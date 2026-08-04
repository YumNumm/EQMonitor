# KEVi地図描画から参照する設計知見

## 調査対象

- Repository: `ingen084/KyoshinEewViewerIngen`
- Commit: `5a2bf513b6b9c93ee06473f70b6d27ee96070b3f`
- License: MIT, Copyright © 2019 ingen084
- 固定参照: https://github.com/ingen084/KyoshinEewViewerIngen/tree/5a2bf513b6b9c93ee06473f70b6d27ee96070b3f

KEViはAvaloniaの`CompositionCustomVisual`からSkiaSharpの`SKCanvas`へ順序付きlayerを直接描画する。PMTiles/MVT tile engineではないため、tile選択の正本にはしない。

2026-08-05にジオメトリcacheとline描画を対象として再調査した。この追加調査だけは
commit `cc5ce50b19e0a68b18bcc3a7caa0df413bd8ed05`を参照している（上記pinより新しい）。
追加分の知見は「ジオメトリcache戦略」節に記録する。

## 採用するパターン

- `MapControl.cs` / `MapLayer.cs`: UI/render間のstate snapshot、`RefreshRequested`、`NeedPersistentUpdate`をframe schedulingの参考にする。typed dirty reasonはKEViで観測したものではなく、EQMonitor側の強化とする。
- `MapLayerHost.cs`: 同一render phase内の宣言順とその逆順hit testを同じtreeから導出する着想を参考にする。EQMonitorでは全resolved node/specがphaseを明示し、cross-phase orderを含むcanonical `RenderSortKey`だけを描画・hit testの正本とするため、KEViの宣言順をglobal orderとしては採用しない。
- `PointLayoutCache.cs` / `NormalizedPointSet.cs`: array-backed point dataと投影cacheを参考にする。投影済みpointとflat spatial indexをimmutableに共有することはEQMonitor側のpolicyとする。
- `HoverTracker.cs`: callerが提供するequalityで更新後の要素を照合する。stable Feature IDでhover/selectionを再束縛することはEQMonitor側のpolicyとする。
- `MapLayerLabelRenderer.cs`: 実測文字サイズに基づくscreen placement候補とleader lineをrenderer policyの参考にする。alternate geographic anchorをKEViへ帰属させない。
- metricsはopt-inかつrate-limitedにし、frameとnode/layerの両方を観測する。

## ジオメトリcache戦略

`Data/PolygonFeature.cs`、`Data/PolylineFeature.cs`、`Data/MapData.cs`、`Layers/LandBorderLayer.cs`。
KEViがGPU実装へそのまま持ち込める形で解いている問題は、非整数zoomのジオメトリ再構築である。

- ジオメトリcacheは整数zoomしか持たない。`baseZoom = ceil(zoom)`でcacheを引き、
  `scale = 2^(zoom - baseZoom)`をcanvas変換として掛けて縮小表示する。非整数zoomのために
  ジオメトリを作り直さない。GPUではこのcanvas変換がmodel/camera行列のscaleに置き換わるだけで、
  発想はそのまま使える。
- 線幅は`StrokeWidth = 基準幅 / scale`で逆補正する。「baseZoomにおける見た目の太さ」を維持し、
  frame内の微小zoomでは太さを変えない。EQMonitorのlineも整数zoom単位でmeshを作り、非整数分は
  shader側のscaleで吸収する。
- 頂点間引きは実行時のDouglas-Peucker（`tolerance = 1px`固定、そのzoomのpixel座標系で実施）で
  行う。zoom別に簡略化済みファイルを持たない。`points.Length <= 1`、閉路で`<= 4`は描画しない。
- polygon塗りは`LibTessDotNet`で三角形化し`SKVertices`（頂点＋indexバッファ）を作って
  `DrawVertices`する。`SKPath`のfill typeに頼らない。ushort index上限超過時はindexを捨てて
  flatな頂点列へfallbackする。
- 三角形化は`Task.Run`で非同期に行い、`IsWorking`で多重実行を防ぐ。生成中は`zoom-1`/`zoom+1`の
  cacheを`Scale(2)`/`Scale(.5)`して代用表示し、画面を空白にしない。
- cacheは2分間隔のtimerで、3分以内に使われたzoomの±1以外を破棄する。一定期間描画がなければ
  全解放する。
- cullingは`BoundingBox`の線形走査のみで空間indexを持たない。BoundingBoxは緯度経度空間で保持し、
  pixel変換前に判定する。
- 座標decodeは`ArrayPool<PointD>.Shared`/`ArrayPool<Location>.Shared`でGC負荷を抑えている。
- 地図データはTopoJSON由来のarc共有トポロジをMessagePack + LZ4Blockで固めた`.mpk.lz4`である。
  arc参照は符号でエンコードし（負値は逆方向、`abs(i)-1`が実index）、隣接ポリゴン間で境界線を
  重複させない。zoomごとのファイル分割ではなく、`LandLayerSet`が`MinZoom`表で参照する行政区分の
  粒度を切り替える。

線のstroke自体は`SKPaint(Style=Stroke)`へ丸投げしており、太線を三角形化する実装はKEViに存在
しない。したがってEQMonitorのline meshは新規実装であり、KEViから引き継げるのは「線幅とzoomの
関係の設計方針」「整数zoom単位cacheと粗密fallback」「間引き→三角形化の順序」だけである。

## 採用しないパターン

- 既定Miller projection、緯度±80°clamp、1回だけのlongitude wrapをWeb Mercator実装へ流用しない。
- camera変更ごとの全`SKPicture`破棄をGPU mesh/buffer cacheへ流用しない。
- host lockを保持した全render、exact zoomやarray referenceだけのcache keyを採用しない。
- 次frame開始時のdisposeをGPU completionとみなさない。
- dynamic layerを毎frame全再描画せず、typed deltaと部分buffer更新を使う。
- mutable paintやsetter中心のlayerを、Freezed DTO + reconcilerの公開APIへ持ち込まない。

## EQMonitorでの適用境界

KEViはframe snapshot、phase内ordered layer、array-backed動的点群、screen上のlabel placementの参考とする。EQMonitorのlabel assetは1つの地理anchorだけを持ち、right/left/up/down候補を実測文字サイズとDPRからrendererで生成する。採用済みlabelとleader lineは`labelForeground` phaseのcanonical `RenderSortKey`で描画・hit testする。leader lineもrenderer policyであり、assetへalternate anchorやleader line属性を持たせない。

Web Mercator、tile cover、overzoom、world wrap、MVT edge処理、PMTiles range fetchはMapLibreの仕様・実装に従う。KEViの個別EEW P/S波実装を検証済みとは扱わず、本設計のgeodesic P/S波はEQMonitor独自の要件とする。

参照ファイルの固定URLは設計正本`docs/superpowers/specs/2026-08-02-eqmonitor-map-renderer-design.md`に記録する。
