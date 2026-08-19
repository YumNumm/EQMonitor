# task-3: Flutter Scene / eqmonitor_map app integration status

## 結論

- `packages/eqmonitor_map`は現在`app`の依存に入っている。`/home/yumnumm/EQMonitor/app/pubspec.yaml`の`dependencies`に`eqmonitor_map: path: ../packages/eqmonitor_map`があり、同じ`pubspec.yaml`で`maplibre`も直接依存として残っている。
- rootのworkspace管理は`melos.yaml`ではなく`/home/yumnumm/EQMonitor/pubspec.yaml`内の`workspace`/`melos:`セクションで行われている。workspaceには`packages/*`と`packages/eqmonitor_map/example`が含まれる。
- productionの地図surfaceはまだ`eqmonitor_map`/`BaseMapView`へ移行されていない。`BaseMapView`のapp内利用は設定配下のデバッグページ「EQMonitor Map (Flutter Scene)」のみ。
- Home Mapも現在は`MapLibreMap`を直接hostしており、Home本番surfaceはMapLibre専用のまま。

## 依存とconsumer

`eqmonitor_map`を依存として持つのは次の2つ。

- `/home/yumnumm/EQMonitor/app/pubspec.yaml`: app本体が`eqmonitor_map`へpath依存している。同時に`maplibre: ^0.3.5`も依存し、MapLibre git overrideも残っている。
- `/home/yumnumm/EQMonitor/packages/eqmonitor_map/example/pubspec.yaml`: package exampleが自身を依存している。

app内で`package:eqmonitor_map/eqmonitor_map.dart`をimportする実コードは次のデバッグ用途のみ。

- `/home/yumnumm/EQMonitor/app/lib/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_debug_page.dart`: `BaseMapView`を描画。
- `/home/yumnumm/EQMonitor/app/lib/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_debug_source_provider.dart`: `VerifiedPmTilesSource`、`PmTilesV3Archive`などを使い、BaseMapViewへ渡すPMTiles sourceとzoom範囲を組み立て。

`packages/eqmonitor_map/README.md`にも、appからの利用はデバッグページ「EQMonitor Map (Flutter Scene)」から`BaseMapView`を表示する、と明記されている。

## Surface別ステータス(todo 780照合)

| surface | status | evidence |
| --- | --- | --- |
| Home Map | still MapLibre | `/home/yumnumm/EQMonitor/app/lib/feature/home/ui/component/map/home_map_view.dart`が`package:maplibre/maplibre.dart`をimportし、`_MapLibreMapHost`内で`MapLibreMap`を直接生成。EEW、強震観測点、P/S波、揺れ検知、震源、label等もMapLibre childrenとして接続。 |
| Home表示範囲selector | still MapLibre | `/home/yumnumm/EQMonitor/app/lib/feature/home/ui/page/home_map_bounds_selector_page.dart`が`MapLibreMap`を直接生成し、`MapController.getVisibleRegion()`で保存範囲を取得。 |
| Live Monitor | still MapLibre | `/home/yumnumm/EQMonitor/app/lib/feature/live_monitor/ui/components/live_monitor_map_host.dart`が`MapLibreMap`を直接生成し、`MapController` ownership、automatic focus、`fit`/`LngLatBounds`連携をMapLibre前提で保持。 |
| EEW details | still MapLibre | `/home/yumnumm/EQMonitor/app/lib/feature/eew/ui/components/eew_details_map_view.dart`が`MapLibreMap`を直接生成し、forecast region、P/S波、震源layerをchildrenに追加。 |
| Earthquake History details | still MapLibre | `/home/yumnumm/EQMonitor/app/lib/feature/earthquake_history/ui/components/earthquake_history_details_map_view.dart`が`MapLibreMap`を直接生成。tap時に`MapController.queryLayers(event.screenPoint)`を使い、station/Shindo DB/city/region popupや`fitBounds`をMapLibre controllerで処理。 |
| Intensity History | still MapLibre | `/home/yumnumm/EQMonitor/app/lib/feature/intensity_history/ui/intensity_history_page.dart`が`MapLibreMap`を直接生成。click/long-clickで`queryLayers(screenPoint)`、drill-down/back、`fitBounds`、detail modalをMapLibre前提で実装。 |
| Region picker | still MapLibre | `/home/yumnumm/EQMonitor/app/lib/feature/earthquake_history/ui/components/region_picker_map_page.dart`が`MapLibreMap`を直接生成し、`MapEventClick`の地理座標からJMA地域を解決。 |
| Tsunami details | still MapLibre | `/home/yumnumm/EQMonitor/app/lib/feature/tsunami/ui/components/tsunami_details_map_view.dart`が`MapLibreMap`を直接生成。GeoJSON source/layer、style resource lifecycle、`fitBounds`をMapLibre style/controllerで処理。 |
| Seismicity | still MapLibre | `/home/yumnumm/EQMonitor/app/lib/feature/seismicity/ui/seismicity_page.dart`が`MapLibreMap`を直接生成し、PMTiles/epicenter layerと矩形選択overlayをMapLibre controller前提で利用。 |
| Hi-net Seismicity debug | still MapLibre | `/home/yumnumm/EQMonitor/app/lib/feature/settings/children/config/debug/hinet_seismicity/ui/hinet_seismicity_page.dart`が`MapLibreMap`を直接生成し、debug-onlyの震源点/矩形選択/analysis panelをMapLibreで実装。 |
| Shake Detection history details | still MapLibre | `/home/yumnumm/EQMonitor/app/lib/feature/shake_detection/ui/shake_detection_history_details_page.dart`が`MapLibreMap`を直接生成。`MapEventStyleLoaded`後に`GeoJsonSource`、`FillStyleLayer`、`LineStyleLayer`を追加し、`fitBounds`を呼ぶ。 |

現時点で「partially migrated」と呼べるproduction surfaceは見つからなかった。app側に`eqmonitor_map`依存とDart Data Asset設定は入っているが、todo 780のsurface本体はすべて`MapLibreMap`を直接hostしている。

## experimental/debug route

Scene mapの導線はデバッグページのみ。

- route: `/settings/debug/eqmonitor-map`相当。`/home/yumnumm/EQMonitor/app/lib/core/router/router.dart`の`DebugRoute`配下に`TypedGoRoute<EqmonitorMapDebugRoute>(path: 'eqmonitor-map')`があり、`EqmonitorMapDebugRoute`は`EqmonitorMapDebugPage`を返す。
- menu: `/home/yumnumm/EQMonitor/app/lib/feature/settings/children/config/debug/debug_page.dart`に`EQMonitor Map (Flutter Scene)`の`ListTile`があり、tapで`EqmonitorMapDebugRoute`へ遷移する。
- page: `/home/yumnumm/EQMonitor/app/lib/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_debug_page.dart`が`BaseMapView`を表示する。
- source: `/home/yumnumm/EQMonitor/app/lib/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_debug_source_provider.dart`が通常は`AssetPackRepository.resolveAsset(AssetPackAssetId.baseMapPmtiles)`でbase map PMTilesを解決し、Asset Pack未準備時だけデバッグページ専用manual override `eqmonitor_map_debug/base_map_debug.pmtiles`を試す。

本番surface切替用のfeature flag、`bool.fromEnvironment`、runtime設定、Home MapのScene/MapLibre分岐は見つからなかった。debug pageの表示可否は既存のdebug settings/launcher経由で、Scene rendererをproduction surfaceへ切り替えるflagではない。

## Home MapのMapLibre専用性

Home MapはまだMapLibre専用。

- `/home/yumnumm/EQMonitor/app/lib/feature/home/ui/component/map/home_map_view.dart`は`package:maplibre/maplibre.dart`をimport。
- `HomeMapView`は`mapConfigurationProvider`からMapLibre styleStringを取得し、`homeMapOptionsFromSettings`で`MapOptions`を作る。
- `_MapLibreMapHost`が`MapLibreMap`を生成し、`HomeMapCameraState`へ`MapController`を登録、location有効化、`MapLibreEventProvider`へのevent転送を行う。
- childrenは`EewEstimatedIntensityLayer`、`EewWarningRegionsLayer`、`KyoshinMonitorObservationLayer`、`EewPsWaveLayer`、`ShakeDetectionLayer`、`EewHypocenterLayer`、`HomeMapLabelLayer`など、既存MapLibre layer群。

`BaseMapView`はHome Mapに接続されていない。

## MapLibre migration gate status

todo 780のgateは未達。

- `MapLibreEventProvider`、`MapOperationQueueScope`、style/source/layer helper、GeoJSON更新系はまだ多数のproduction surfaceが利用しているため削除不可。
- `queryLayers` parityは少なくとも`Intensity History`と`Earthquake History details`で未解決。実コードでも`MapController.queryLayers`が残り、tapからrender hitのsource layer判定、さらにJMA最寄り解決へ進む二段階処理が残っている。
- `getVisibleRegion`、`fitBounds`、`toLngLat`、MapLibre style load後のsource/layer追加など、surface固有のcontroller API依存が残っている。
- `lockBearing`等の共有MapLibre設定はHome/Live/Detailsなどが`homeMapOptionsFromSettings`/`sharedMapOptionsFromSettings`経由で引き続き利用しているため維持が必要。
- `maplibre` package/platform asset連携は、production surfaceとdebug surfaceの参照が消えるまで削除不可。

## first production surface migrationをブロックしているもの

最初のproduction移行を始める直接のブロッカーは、`eqmonitor_map`がまだdebug-onlyの`BaseMapView`段階で、production surfaceが必要とするMapLibre互換機能が未接続なこと。

特にHome Map初期移行では次が必要。

- base map以外の動的layer API: EEW推定震度/警報区域、強震観測点、P/S波、揺れ検知、震源、labelをMapLibre children/style layerではなくeqmonitor_mapのtyped layer/snapshotへ載せる実装。
- camera/event/controller parity: camera保存/復元、現在地、map event配信、debug control、fit/viewport操作をMapLibre controllerから切り離すこと。
- asset/render reliability: `packages/eqmonitor_map/README.md`に、BaseMapViewはiOS simulatorでpan/tile差し替え確認済みだが、pinch zoom、物理端末profile/release、線幅/tile境界、background色は未確認。また海が`areaForecastLocalEwLine`色で塗られる既知不具合があり、原因/修正は未着手と記載されている。
- query/hit-test parity: Home初期移行自体はqueryLayers parityをgateにしない方針だが、全surface移行にはIntensity History/Earthquake History detailsのhit test fixture化が必要。

従って、最初のproduction候補はHome Mapだが、現状は「依存導入 + debug routeでBaseMapView表示」までで、本番layer/camera/event/asset reliabilityの移植がgateとして残っている。
