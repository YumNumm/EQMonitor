# EQMonitor Map 地震overlayのGPU検証

## 適用範囲

Flutter Scene版 `BaseMapView` で、実APIの地震情報をPMTilesの予報区・市区町村へ
Fillし、観測点をraw shaderのinstance batchで重ねる場合の検証手順と契約を記す。
生命に関わる表示なので、event、code、tileは固定fallbackで補わず、実APIとverified
Asset Packを照合してから描画不具合を判断する。

## Asset Pack

bundled assetは次のコマンドだけでstageする。network/sandbox failure時も同じcommandを
権限昇格して再実行し、古い手元fileや固定URLへfallbackしない。

```sh
mise exec -- tool/asset_pack/stage_from_r2.sh --target bundled
```

2026-08-24の検証値:

- pack version: `0.0.9`
- distribution source: `https://assets.eqmonitor.app/v1/assets/packs/0.0.9/asset-pack-v0.0.9.zip`
- archive SHA-256: `19b29e0ca615d5892911860a9f75696d0f17fa26f2574c42d2400e624fd5e46d`
- staged PMTiles: `app/assets/platform/map/all.pmtiles`
- PMTiles SHA-256: `cae6974d7c53f429ca3b7caeb15669c25259ccb3c3d847c39724b65c78e`
- PMTiles size: `12,333,724 bytes`
- staged manifest SHA-256: `3666ea26ad6278a9630d1f74a5db3f1a2fe8490eb4b839485ec9d47aa9c664a7`
- manifest generated_at: `2026-08-20T02:21:07.188Z`

digestはstage commandが検証・表示した値を記録する。stage先はgitignore対象であり、
archiveや展開物をcommitしない。

## 実APIとtileの照合

最新震度1以上をevent ID降順で取得し、detailのregion、city、stationを確認する。
最新eventに震度・観測点がない場合は条件を満たす直近eventをAPIから選び、選択根拠を
記録する。API responseそのものやdevice情報は成果物へ保存しない。

2026-08-24のread-only diagnosticでは最新条件適合eventをそのまま使用できた。

- event ID: `20260824013623`
- 発生時刻: `2026-08-24 01:36 JST`
- 最大震度: `2`
- region codes: `102, 106, 151, 152, 156`
- station count: `12`
- station metadataから解決したcity codes:
  `0120200, 0122400, 0160700, 0160900, 0161000, 0163700, 0164900`
- 対象tile: z6 `6/57/23`
- production `BaseMapTileDecoder`でregion 5 codeとcity 7 codeがすべて実在することを確認

city codeはstation codeから固定変換せず、bundled
`earthquake_stations.json`のmetadataで解決する。renderer defectを判断する前に、実際の
可視tileをproduction decoderでdecodeし、source layer、extent、code、decode errorを分ける。

## 描画順とalpha契約

1つのSceneでtranslucent sort priorityを次の順に固定する。

1. base map: `0`
2. region Fill: `100`
3. city Fill: `200`
4. observation point: `300`
5. foreground label: `400`

zoom `< 6`はregion Fill、zoom `>= 6`はcity Fillと観測点を選ぶ。priorityをnode作成側で
独自に決めず、`mapSceneRenderPhasePolicy`と共通validatorを使う。

Fill materialへ渡すRGBAはstraight alphaで、RGBをpremultiplyせずalphaだけへopacityを
掛ける。Filament materialの`blending: alpha`にpremultiply済みRGBを渡すと二重乗算になる。
一方、観測点raw fragment shaderはcoverageを含めたalphaを計算し、
`vec4(rgb * alpha, alpha)`のpremultiplied alphaを出力する。この2経路を混同しない。

## observation instance lifecycle

- 全観測点を28-byte strideの単一instance stream、1 geometry、1 Scene nodeにまとめる。
- 同一snapshot objectのcamera-only更新ではinstance holderとgeometryを再利用する。
- 同じsource/revisionでもstation snapshot identityが変われば新しいinstance generationを使う。
- snapshot置換、context generation変更、background、disposeでは旧geometryを再利用しない。
- Sceneからnodeを外した後、その時点までのrenderer submissionをfenceし、GPU completion後に
  一度だけ`retire()`する。後続frameの到着へretireを依存させない。
- material preflightまたはScene submitに失敗した候補をcommitせず、base-onlyへfail closedする。

## 自動検証

Flutter/Dart commandはすべて`mise exec --`経由で実行する。

```sh
cd third_party/flutter_scene/packages/flutter_scene
mise exec -- flutter test --reporter compact

cd ../../../../packages/eqmonitor_map
mise exec -- flutter test --reporter compact --no-pub
mise exec -- dart analyze . --fatal-infos

cd ../../app
mise exec -- flutter test \
  test/feature/earthquake_history/data/earthquake_map_overlay_builder_test.dart \
  test/feature/earthquake_history/data/latest_earthquake_overlay_provider_test.dart \
  test/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_overlay_presentation_test.dart
mise exec -- flutter analyze --fatal-infos \
  lib/feature/earthquake_history/data/logic/earthquake_map_overlay_builder.dart \
  lib/feature/earthquake_history/data/provider/latest_earthquake_overlay_provider.dart \
  lib/feature/settings/children/config/debug/eqmonitor_map
```

2026-08-24の結果は、fork 1,231件成功・GPU unavailable 35件skip、package 648件成功、
package analyze issue 0、app focused 12件成功、app対象analyze issue 0だった。GPU skipを
platform smokeの代用にはしない。

## iOS Simulator smoke

検証command例:

```sh
cd app
mise exec -- flutter run -d <SIMULATOR_UDID> --debug \
  --enable-flutter-gpu --enable-impeller --no-pub \
  --dart-define=FLAVOR=dev \
  --dart-define=REST_API_URL=https://v2.api.eqmonitor.app \
  --dart-define=WS_API_URL=wss://ws.eqmonitor.app \
  --dart-define=APP_ID_SUFFIX=.dev \
  '--dart-define=APP_NAME=[dev] EQMonitor' \
  --dart-define=IS_PRO_FEATURES_ENABLED=false \
  --dart-define=IS_SHAKE_DETECTION_ENABLED=false
```

2026-08-24はiPhone 17 Pro / iOS 26.4 Simulatorでdebug build・runに成功し、engine logの
`Using the Impeller rendering backend (Metal).`を確認した。実API event
`20260824013623`のregion Fillがbase map上へ震度色で表示され、単一pointer pan後も追従した。
この確認中にoverlay由来のFlutter Scene/GPU例外は観測しなかった。

zoom 4の可視tile診断は次のとおりだった。

| tile | `earthquake_region` | invalid/missing code feature |
|---|---:|---:|
| `4/13/5` | source layerなし | 0 |
| `4/13/6` | あり | 1 |
| `4/14/5` | あり | 3 |
| `4/14/6` | あり | 0 |

したがって「表示範囲の震度情報は不完全です」はload待ちやdecode例外ではなく、required 4
tile中source-layer-covered 3、invalid/missing code計4という実データをcoverage contractが
fail closedで通知した結果だった。水域・国外tileでsource layerがない場合も、完全表示と
推測してbannerを消さない。

このrunではSimulator入力をユーザーへ返すため操作を中断した。次は別の占有runで、
zoom 5.999/6の実pinch、city Fill、12観測点、background/foreground復帰を画面とlogで確認する。
これらは未確認であり、今回のregion Fill成功から推測して成功扱いにしない。現時点で
implementation defectは特定されていないためtodoは作らず、platform smokeの残項目として
ここに記録する。
