# eqmonitor_map 地震震度塗り・観測点 GPU 表示設計

## 目的

`packages/eqmonitor_map` の既存ベース地図描画へ、実際の地震詳細データから生成した
JMA震度の区域塗りと観測点円を重ねる。最初の受け入れ地点は、設定内の
`EQMonitor Map (Flutter Scene)` デバッグ画面で、ベース地図・震度塗り・観測点が
同じcamera上に表示されることとする。

本設計は
`docs/superpowers/specs/2026-08-02-eqmonitor-map-renderer-design.md` の
`08-dynamic-interaction` をすべて実装するものではない。将来のHome移行を妨げない
型付き境界を作りながら、区域塗りと観測点表示を一本の動く縦切りとして先行させる。

## 現状

ベース地図は次の経路で Flutter Scene/GPU まで接続済みである。

```text
VerifiedPmTilesSource
  -> BaseMapTileRepository
  -> BaseMapTileDecoder
  -> BaseMapTileCache
  -> BaseMapPackedMeshCache
  -> MapRenderSubmission
  -> FlutterSceneBaseMapAdapter
  -> SceneView/GPU
```

地震情報は `EarthquakeIntensity` から MapLibre のStyleLayer/GeoJSONへ変換されており、
上記経路とは接続されていない。さらに、現行MVT decoderはfeature IDとpropertiesを
読み飛ばすため、`areaForecastLocalE.code` と
`areaInformationCityQuake.regioncode` を使った区域選択ができない。観測点用の
instance layout、material、shader、Scene adapterも存在しない。

## スコープ

### 含むもの

- MVT v1/v2のstring propertyを上限付きでdecodeする
- `areaForecastLocalE` の `code` と `areaInformationCityQuake` の
  `regioncode` を保持したpolygon meshをtile cacheへ載せる
- JMA震度ごとの地域・市区町村Fillをbase mapより上へ描画する
- 観測点を安定ID、WGS84座標、RGBA色、半径、最大震度強調の型付きsnapshotへ変換する
- 観測点を `StaticInstanceGeometry` による単一GPU batchの円として描画する
- デバッグ画面で最新の震度1以上の地震詳細を取得し、overlayへ変換する
- loading、地震データ取得失敗、震度データなしを地図上の状態表示として区別する
- package単体テスト、app側変換テスト、静的解析、iOS Simulator可視確認

### 含まないもの

- LPGM、震度DB、推計震度tile
- 震度アイコン、観測点名ラベル、震源、P/S波
- tap/hit test、fitBounds、選択状態
- atomic delta API。最初の縦切りはrevision付きimmutable full snapshotの置換のみ
- Home、地震履歴詳細、Live MonitorのMapLibre置換
- MapLibre依存や既存MapLibreレイヤーの削除
- Flutter Scene forkのinstance batching問題そのものの修正
- MVT feature IDの保持。区域codeが安定識別子になるため、この縦切りでは引き続き読み飛ばす

## 採用する構成

### 1. MVT property decode

`MvtFeature` は不変な `Map<String, String>` を保持する。MVT layerはfield順を仮定せず、
二段階でdecodeする。第1段階ではfield 2のfeature bytesとpacked `uint32` tags、field 3の
keys、field 4のValue messageをそれぞれ上限付きで保持する。layerを最後まで読んだ後、
tagsを `(keyIndex, valueIndex)` の対として解決してgeometry付きfeatureを確定する。

MVTのValueは複数型を持つが、この縦切りで保持するのは文字列だけである。Value messageが
複数の値fieldを持つ、UTF-8が不正、tag indexがtable外、tagsが奇数個、同一feature内で
keyが重複する場合はtyped `MvtDecodeException`としてtile全体をfail closedする。
string以外の正常なValueは検証後に保持せず、要求propertyがstring以外または欠損なら
feature geometryはbase map用に維持しつつoverlay coverageを不完全として記録する。

`MvtDecodeLimits` へ以下を追加し、すべて呼び出し側が明示する。

- `maxKeysPerLayer`
- `maxValuesPerLayer`
- `maxTagsPerFeature`
- `maxPropertyStringBytes`

property文字列のbyte長はlength-delimited payloadを確保・decodeする前に検証する。
既存geometry上限と同様、固定fallbackは置かない。

### 2. 区域geometry

`BaseMapTileGeometry` はベース地図用の集約meshに加え、次のoverlay用geometryを持つ。

```text
EarthquakeAreaTileGeometry
  forecastRegions: EarthquakeAreaTileLayerGeometry(extent, features)
  cities:          EarthquakeAreaTileLayerGeometry(extent, features)

CodedFillGeometry(code, meshes)
```

区域meshは同じMVT featureのgeometryからdecode worker内で生成する。base map用に集約した
meshからfeature境界を逆算しない。`CodedFillGeometry` は1 featureを単位とし、
Uint16上限によって複数segmentになった場合も同じcodeの下に保持する。

`EarthquakeAreaTileLayerGeometry.extent` は対応source layerが存在するとき必須とし、
tile-local meshの変換に使う。city fillは既存base style specにないが、同じ
`areaInformationCityQuake` source layerをoverlay decoderがpolygonとしてmesh化する。

overlayは `EarthquakeOverlayExactTileResolver` を通し、要求中の
`UnwrappedTileId.canonical` を `BaseMapTileCache.get` で直接引く。親・子fallbackを持つ
`BaseMapRenderTileResolver` は利用しない。resolver結果はrequested unwrapped tile、
exact canonical tile、source identity、layer extentを保持する。exact hitがないtileは
描かずcoverageを不完全とする。破損propertyやsnapshot不整合を空の正常データへ丸めない。

### 3. package公開snapshot

`eqmonitor_map` はappの `Earthquake`、`EarthquakeIntensity`、`JmaIntensity`、テーマ型へ
依存しない。appが以下の型付きsnapshotへ変換して `BaseMapView` に渡す。

```dart
EarthquakeMapOverlaySnapshot(
  sourceId: String,
  revision: int,
  regionToCityZoom: double,
  stationMinZoom: double,
  regionStyles: List<EarthquakeAreaStyle>,
  cityStyles: List<EarthquakeAreaStyle>,
  stations: List<EarthquakeObservationPoint>,
)

EarthquakeAreaStyle(code: String, color: Color, opacity: double)

EarthquakeObservationPoint(
  id: String,
  longitude: double,
  latitude: double,
  color: Color,
  radiusLogicalPixels: double,
)
```

factoryはtrim後の空ID/code、負revision、非有限zoom/座標、緯度経度範囲外、非正半径、
`[0,1]` 外のopacity、重複区域code、重複観測点IDを拒否する。collectionは不変にする。
同じsourceIdでrevisionが下がったsnapshotはcontrollerが拒否し、現在の描画を維持する。
別sourceIdは新しいfull snapshotとしてatomicに置き換える。型はpackage公開APIとして
`eqmonitor_map.dart` からexportし、生成コードも同じコミットで更新する。

`BaseMapView` の公開引数には nullable な `earthquakeOverlay` を追加する。`null` は
overlay非表示を意味し、エラーや期限切れを意味しない。app側の取得エラーは別のUI状態で
表示する。

### 4. Scene compositorと震度Fill packet

区域codeから色を引くlookupをsnapshot revisionごとに一度構築する。可視exact tileの
`CodedFillGeometry` だけを走査し、該当codeを震度色ごとにbucket化する。既存fillの
packed layoutを再利用するが、pipeline keyとmaterialは
`earthquake-area-fill` としてbase mapから分離する。

`assets/earthquake_area_fill.fmat` はunlit、culling none、alpha blendingとし、
`fill_color` のRGBは非premultipliedのまま、alphaだけを
`fill_color.alpha * opacity` とした `MaterialInputs.base_color` を出力する。
Flutter Sceneのunlit fmat runtimeが最終出力を一度だけpremultiplyするため、shader側で
RGBへopacityを掛けない。region/cityのopacityは
`EarthquakeAreaStyle.opacity` からmaterial parameter blockへ渡し、app側の既定値は既存
`EarthquakeHistoryMapLayerParameter` と同じ0.6とする。

Sceneの所有者は1つにする。`MapSceneFrameSubmission` がbase mapとearthquake Fillの
`MapRenderSubmission`、およびnullableな観測点batchを束ね、
`FlutterSceneMapAdapter.submitFrame` だけが `Scene.removeAll()` とnode追加を行う。
ベース専用adapterを別にsubmitしてnodeを相互に消す構成は採用しない。

phase policyは `base`、`earthquakeRegion`、`earthquakeCity`、
`observationPoint`、`labelForeground` の順とする。Fillは通常の
`MapRenderPacket`、観測点は `StaticInstanceGeometry` を受け取る専用batchだが、
compositorがphase rankに従って両者を同じframeで追加する。さらにfork側の
`Node.translucentSortPriority` を `RenderItem` へ伝播し、Flutter Sceneの透過sortを
`priority` 昇順、同一priority内は従来どおりcamera depthのback-to-frontにする。
priorityの既定値は0で既存Sceneの挙動を維持し、base=0、earthquakeRegion=100、
earthquakeCity=200、observationPoint=300、labelForeground=400を割り当てる。
source-over blendでは小さいpriorityを先に、大きいpriorityを後にdrawするため、
観測点は区域Fillより常に前面になる。opaque itemのpipeline/front-to-back sortには
このpriorityを適用しない。

このfork変更は通常meshと `StaticInstanceGeometry` の双方で同じpriority comparatorを
通す。`scene_encoder_test.dart` に、異なるdepthでもpriority順が優先されること、同一
priorityでは従来のdepth順になること、既定値0の後方互換を追加する。package側では
compositorが各nodeへ上記priorityを設定したことをadapter境界のテストで確認する。
単なるnode追加順やdepth biasには依存しない。未知pipeline、phase欠落、mesh batchと
観測点batchのpriority違反はsubmit前にfail closedする。

描画順は次で固定する。

```text
base map Fill/Line
  -> earthquake region Fill
  -> earthquake city Fill
  -> observation circles
  -> labelForeground (将来)
```

zoom 6未満はregionだけ、zoom 6以上はcityだけを描画する。city sourceが欠損しても
regionへfallbackせずcoverageを不完全とする。region/cityの同一code重複はapp変換時に
最大震度だけへ正規化する。

### 5. 観測点GPU batch

観測点は全点を1個の `StaticInstanceGeometry` と1個のScene nodeで描画する。
Flutter Scene forkの既知問題を避けるため、同じgeometryを複数nodeへ共有しない。

- vertex-rate buffer: `corner` float32x2、offset 0、stride 8 byteのquad 4頂点
- index buffer: triangle 2枚
- instance-rate buffer: `centerMercator` float32x2 @0、`color` float32x4 @8、
  `radiusLogicalPixels` float32 @24、stride 28 byte
- instance座標はX東向き・Y南向きのnormalized Mercator `[0,1)`
- `ObservationFrame` vertex uniformはstd140のvec4を2本、合計32 byte。前半に
  camera normalized X/Y・`worldSize = 512 * 2^zoom`、後半にviewport logical
  width/height・stroke logical pixelsを入れる
- shaderはcenter Xとcamera Xの差から整数worldを引き、cameraに最も近いdate-line wrapを
  選ぶ。stationはzoom 6以上だけで描くため、viewport内に複数world copyを要求しない
- centerのlogical pixel差をviewport幅/高さで割ってNDCへ変換し、Yだけ反転する。
  corner offsetもlogical pixel半径からNDCへ変換するためDPRは掛けない
- fragment shaderは補間したcorner長から円外をdiscardし、1 logical pixel相当の白strokeを
  smoothstepでanti-aliasする。出力はpremultiplied alphaとする

raw shaderは `assets/earthquake_observation.vert` / `.frag` とmanifestへ置き、
`hook/build.dart` が `buildTargetShaderBundleJson` をData Asset必須で生成する。
`ShaderMaterial` はcustom vertex/fragment shader、culling none、
`isOpaqueOverride: false` とし、source-over alpha blendingのtranslucent passへ載せる。
専用layout以外や後付けcustom attributeはinstance buffer slotをずらすため禁止する。

instance dataはsnapshot revisionごとに一度だけ構築・uploadする。camera移動では
view-projection/viewport uniformだけを更新し、instance bufferを再生成しない。
snapshot置換、background、surface generation変更、disposeではframes-in-flight後に
`StaticInstanceGeometry.retire()` を明示的に呼んでから参照を落とす。
`MapGpuResourceLedger` はretire callbackを自動実行しないため、観測点resource ownerが
callbackを保持する。retire後のgeometry再利用はfail closedする。

### 6. app変換とデバッグ画面

app側に `EarthquakeMapOverlayBuilder` を置き、既存
`EarthquakeHistoryFillLayerBuilder` と `EarthquakeHistoryStationGeoJsonBuilder` が持つ
分類規則をJSON/MapLibre型へ変換せず再利用可能なpure logicとして整理する。

- 市区町村は全震度階級を横断し、同じcodeを最大震度のbucketにだけ入れる
- 地域は `EarthquakeIntensity.regions` だけを使い、全震度階級を横断して同じcodeを
  最大震度のbucketにだけ入れる。`forecastLocalEIntensityPairs` はcode体系が異なり得るため
  利用しない
- 観測点は `station.code` を安定IDとし、座標と実測最大震度を使う
- 色は `activeColorSetProvider.intensity` からapp側で確定してsnapshotへ渡す
- 最大震度観測点は既存auto表示相当の大きい半径、それ以外は小さい半径にする

`latestEarthquakeOverlayProvider` は既存 `earthquakeHistoryProvider` をevent ID降順・
震度1以上でwatchし、先頭event IDの `earthquakeHistoryDetailsProvider(eventId)` をwatchする。
選択generationを持ち、一覧更新後に旧eventのdetailが完了しても破棄する。snapshot revisionは
選択中eventの `telegramMetadata.reportedAt` 最大値のUTC microsecondsとし、metadataが
空ならtyped unavailableにする。色テーマだけが変わった場合は同revisionのfull snapshotを
置換できるが、provider generationが最新build以外の公開を防ぐ。

取得中、event切替中、失敗時、震度データなしでは `BaseMapView.earthquakeOverlay` に
`null` を渡し、旧eventのoverlayを残さない。base mapは維持し、event ID・発生時刻・
電文statusを常時表示するbannerにloading、error、震度データなしを表示する。

`BaseMapView` は `onEarthquakeOverlayCoverageChanged` で `hidden` / `incomplete` /
`complete` を返す。coverageは表示モードで要求される可視exact tile数、ready数、
missing/invalid code数を持つ。exact tile準備中、decode error、要求source layer欠損、
code欠損・非stringは `incomplete` とし、bannerへ「表示範囲の震度情報は不完全」と明示する。
全要求tileと全要求propertyが揃ったときだけ `complete` とする。

## エラーとlifecycle

- MVT/property破損: typed exception。tile cacheへ格納しない
- 区域code欠損・非string: 該当featureだけoverlay対象外。base map geometryは維持し、
  overlay coverageを `incomplete` にする
- 古いsnapshot revision: rejectし、現在のoverlayを維持
- event切替・地震取得失敗: 旧overlayを消し、base mapを維持してapp overlay UIに状態表示
- background/surface再生成: GPU resourceを捨て、CPU snapshot/packed meshから再構築
- 観測点0件: Fillは描画し、観測点batchは作らない
- Fill対象0件: 観測点は描画し、空geometry/nodeは作らない

## テスト

### `packages/eqmonitor_map`

- MVT keys/values/tagsの正常decode
- tag index、奇数tag、重複key、string byte上限、件数上限のfail closed
- 区域codeとfeature meshの対応、同code複数segment
- exact tileのみをoverlayへ使い、親fallbackを使わないこと
- region/city/pointのcanonical render order
- snapshot validation、revision低下拒否、source交換
- station instance buffer byte一致、座標投影、pixel→NDC半径
- Scene adapterのpure引数組み立てと1 geometry / 1 node契約
- 既存package全テストと `dart analyze . --fatal-infos`

### `app`

- 同一region/city codeは最大震度だけに属する
- 観測点ID・座標・色・最大震度半径の変換
- loading/error/no-intensity/dataの表示分岐
- event切替中の旧detail破棄、旧overlay消去、coverage incomplete表示
- 関連テストと対象 `flutter analyze`

### platform smoke

iOS Simulatorでデバッグ画面を開き、次を画面とlogで確認する。

その前に `mise exec -- tool/asset_pack/stage_from_r2.sh --target bundled` で検証済みAsset Packを
配置し、使用version/digestを記録する。対象eventのregion codeとcity `regioncode` が、
実際のarchiveの可視tile（cityはzoom 6以上）に存在することをdiagnostic decodeで確認する。
過去にcity polygon欠損があったため、この確認なしにcity非表示をrenderer不具合と判定しない。

- 日本のベース地図上に実際の地震の地域または市区町村が震度色で塗られる
- 観測点円が対応位置へ表示される
- pan/pinchでFillと観測点が同じcameraへ追従する
- background/foreground復帰後に再表示される
- exception counterや連続Scene/GPU例外がない

SimulatorでFlutter GPU/Scene固有の表示を確認できない場合は、コード上の成功に
置き換えず、iOS実機またはAndroid端末へ移して同じchecklistを実行する。

## 完了条件

- 実地震データから生成したJMA区域塗りと観測点円がFlutter Scene/GPUで同時表示される
- `eqmonitor_map` がapp固有型やMapLibre/GeoJSONへ依存しない
- event overlayは親tile・異revisionへfallbackしない
- incomplete coverageとevent切替中に旧・部分overlayを完全な震度分布として表示しない
- 既存MapLibre経路は変更・削除されない
- 自動テストと解析が成功し、platform smokeの環境・結果・残リスクが記録される
