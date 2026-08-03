# MapLibre地図surfaceをeqmonitor_mapへ移行する

## 背景

Home Mapの初期移行だけではMapLibre依存は削除できない。2026-08-02時点で`MapLibreMap`を直接hostする全surfaceと、そのlayer・interactionの移行gateをこの文書で一元管理する。

## Surface inventory

- [ ] Home Map (`app/lib/feature/home/ui/component/map/home_map_view.dart`): base map、EEW推定震度/警報区域、強震観測点、P/S波、揺れ検知、震源、label、camera保存/復元、現在地、layer/debug control、map eventを移行する。これは初期rendererの対象とする。
- [ ] Home表示範囲selector (`app/lib/feature/home/ui/page/home_map_bounds_selector_page.dart`): pan/zoom、visible region取得、custom bounds保存を移行する。
- [ ] Live Monitor (`app/lib/feature/live_monitor/ui/components/live_monitor_map_host.dart`): realtimeのHome相当layer、earthquake historyの推定震度/区域/観測station/震源layer、automatic focus、map instance ownership、event配信を移行する。
- [ ] EEW details (`app/lib/feature/eew/ui/components/eew_details_map_view.dart`): forecast region、static/simulation P/S波、震源、表示範囲を移行する。
- [ ] Earthquake History details (`app/lib/feature/earthquake_history/ui/components/earthquake_history_details_map_view.dart`): region/city fill、推定震度、Shindo DB fill/station、観測station、震源/誤差、表示mode、fitBounds、tap popupを移行する。
- [ ] Intensity History (`app/lib/feature/intensity_history/ui/intensity_history_page.dart`): prefecture/city fill、click/long-click、drill-down/back、fitBounds、detail modalを移行する。
- [ ] Region picker (`app/lib/feature/earthquake_history/ui/components/region_picker_map_page.dart`): tap地理座標からのJMA地域解決、loading、選択確定を移行する。
- [ ] Tsunami details (`app/lib/feature/tsunami/ui/components/tsunami_details_map_view.dart`): warning coastline、震源、観測station、station state、fitBounds、style resource lifecycleを移行する。
- [ ] Seismicity (`app/lib/feature/seismicity/ui/seismicity_page.dart`): epicenter point、color/span変更、矩形選択、screen/geographic変換、analysis panel連携を移行する。
- [ ] Hi-net Seismicity debug (`app/lib/feature/settings/children/config/debug/hinet_seismicity/ui/hinet_seismicity_page.dart`): epicenter point、filter、矩形選択、screen/geographic変換、analysis panel連携を移行する。
- [ ] Shake Detection history details (`app/lib/feature/shake_detection/ui/shake_detection_history_details_page.dart`): event polygonのfill/line、fitBounds、style-load初期化をtyped Polygonへ移行する。

## Query parity gates

Home移行は`queryLayers` parityをgateにしない。現行callerは次の2つだけであり、各surface移行時に二段階の選択処理までfixture化する。

- [ ] Intensity History: render hitでcity/region source layerを識別し、tap地理座標から`JmaMapUtility.findNearestItem`で最寄りregion/cityを解決してdrill-downまたはmodalを開く。
- [ ] Earthquake History details: render hitでstation、Shindo DB station、city/regionを識別し、tap地理座標から最寄りstationまたはJMA region/cityを解決してpopupを開く。

## Cross-surface completion gates

- [ ] 各surfaceでbase map、layer順、Light/Dark、loading/degraded/error、camera、gesture、fitBounds、必要なhit testのparity fixtureを通す。
- [ ] `MapLibreEventProvider`、`MapOperationQueueScope`、MapLibre style/source/layer helperとGeoJSON更新を、全consumer移行後にだけ削除する。
- [ ] 共有`lockBearing`設定/UIはlegacy MapLibre consumerが1つでも残る間は維持する。全surfaceでrotation policyを決定し、別途承認したmigrationでfield/UIを削除する。
- [ ] MapLibre packageとplatform asset連携は全surface、test、debug routeから参照がなくなったことを確認してから削除する。
