# MapLibre の表示・ライフサイクル

確認日: 2026-11-23。地図描画には `maplibre` 0.4（描画は MapLibre Native C API ベースの `maplibre_native`）を使用する。
対象: `app/lib/core/util/map/`、`app/lib/feature/home/ui/component/map/`、各機能の地図レイヤー。

## 初期化と更新

- `style.sources.add`・`addImage`・`style.layers.add` は style ごとに初期化し、可変 GeoJSON は `style.sources.updateGeoJsonData`、filter は `style.layers[id]?.filter` で更新する。
- `layers.add` は重複 ID・未登録の source・未登録の `belowLayerId` を `ArgumentError`、`sources.add` は重複 ID を `ArgumentError`、`sources.remove` は使用中の source を `StateError` で拒否する。いずれも `on Exception` では捕捉できない。未登録 ID の `remove` と、未追加 layer への filter 設定は何もしない。
- layer は `paint` / `layout` の map ではなく型付き引数で組み立てる。定数は `.literal`、既存の style-spec 式（list）は JSON を変えずに `.raw` で包む。`StyleLayer` は可変で `const` にできず、1 つの style にしか所属できない。
- paint/layout に更新 API がない場合は layer だけ差し替える。source の再作成は URL など定義自体が変わる場合に限定する。
- 同じ style への操作は `MapOperationQueueScope` の共有キューで直列化する。パラメータや timer tick を初期化 effect の依存へ混ぜない。
- 更新は初期化 Future を待ち、await 前後で lifecycle token を確認する。初期化完了時には開始時の snapshot でなく最新データを反映する。
- dispose は同期的に無効化してから layer → source → image の順に削除する。各削除を独立して試行し、途中の失敗で後続 cleanup を止めない。
- `flutter_hooks` の `useEffect` は依存が変わると、新しい effect を先に実行し、古い cleanup をその後に呼ぶ。「effect で固定 ID を追加し、cleanup で同じ ID を削除する」だけの実装は、style 以外の依存が変わるたびに追加直後の layer を削除する。cleanup は、後発の effect が置き換えていないこと（世代・トークンの一致）を確認してから削除する。
- `Theme.of(context)` 由来の色は、テーマ切替のアニメーション中、フレームごとに変わる。effect の依存に置くとその回数だけ再実行される。
- 取得済みの `styleString` がある間は `mapConfigurationProvider` の再読込中も `MapLibreMap` を保持すれば、テーマ切替は style の差し替えになり、カメラと Widget の状態が残る（市区町村別最大震度・表示範囲選択）。差し替えでは旧 `StyleController` への操作が無視され、追加済みの layer・source・画像を持たない新しい `StyleController` が渡る。`AsyncData` だけを地図表示の条件にすると、再読込のたびに地図が作り直され、カメラが初期位置へ戻る。
- style の差し替えに対応するレイヤーは、上記の cleanup の確認に加え、初期化済みフラグ・送信済みデータのキャッシュを新しい `StyleController` で作り直す必要がある。未対応のレイヤーは[地図の描画・操作・実機検証](../todo/800_map_display_verification.md)に記録している。
- 非同期データの初回取得前はレイヤー Widget をマウントしない。`AsyncValue.valueOrPrevious` を使い、再取得中・失敗時も既存表示を維持する。
- loading overlay は戻る操作を遮らない。再試行 Future の例外は画面の provider 状態で扱い、ボタンから再伝播させない。
- EEW が既に活性中なら controller 接続直後にも現在値を同期する。空の EEW 領域には非表示 filter を返す。
- `MapController.maybeOf(context)` を参照するレイヤーはカメラ移動でも再構築される。観測点の GeoJSON は `useMemoized` で生成結果を保持し、通常表示は観測データ・配色・長周期表示、震度DB表示は観測ツリーの変更時だけ再生成する。送信時の重複抑止だけでは生成コストを避けられない。

## 描画順・式

- 同じ `belowLayerId` に追加すると後から追加した layer が上になる。順序に依存する layer 群は一括で下→上に構築し、`MapStyleLayerReplacer.replace` へ渡す。
- 挿入アンカーは style 自体が持つ `BaseLayer` だけを使う。別の Widget が追加する layer を `belowLayerId` に指定しない。style 読み込み時の `InheritedModel` 通知は `HashMap` の走査順で届き、兄弟 Widget の effect は子の並び順に実行されないため、アンカー未追加のまま `layers.add` が例外になり、再試行されず layer が欠ける。挿入位置は `belowLayerId` だけで指定する。
- 複数の Widget が同じ位置（最前面や同じアンカーの直下）へ追加すると、重なり順が初期化順・再追加のタイミングで変わる。Widget ごとに `BaseLayer` の常設アンカーを分ける。アンカーは透明な `background` layer で、下から `regionFillAnchor`（不透明な区域 fill。S 波 fill はこの上、`areaForecastLocalEewLine` の下）→ 境界線 → `regionOverlayAnchor`（Home の警報区域 fill）→ `foregroundOverlayAnchor`（強震モニタ観測点）→ `markerBackgroundAnchor`（震源誤差範囲・警報区域や津波予報区の線）→ `waveLineAnchor`（P/S 波の線）→ `markerLowerAnchor` → `markerUpperAnchor`（震源マーク・観測点）。
- アンカーを増やすときは `BaseLayer` と `MapStyleUtil.buildStyleJson` の両方へ同じ順で追加する。順序は `test/feature/map/data/provider/map_style_util_test.dart` で固定している。
- 震度色を持つ半透明の細分区域・市区町村 fill を重ねない。切替 zoom では下側の opacity を 0 にする。
- 細分区域・市区町村の震度アイコンは、ポリゴン層でなく専用の点層 `areaForecastLocalELabel` / `areaInformationCityQuakeLabel` に symbol を置く。ポリゴン層の symbol はタイルで分割された断片ごとに 1 個ずつ描かれる。点層の属性は塗りと同じ `code` / `regioncode` で、塗りと同じコード集合を filter に使う。
- 区域アイコンの zoom 切替は symbol layer の `minzoom` / `maxzoom` で行う。不透明度 0 の symbol は衝突判定に残り、他のアイコンを隠す。範囲は `EarthquakeHistoryMapLayerModeResolver.regionIconZoomRange` / `cityIconZoomRange` に集約し、観測点を表示していて観測点データがある地震では、観測点アイコンが見える zoom（`stationMinZoom` 以上）で出さない。
- 衝突する symbol は style の上にある layer が優先して配置される。震度別の layer は震度の小さい順に追加し、大きい震度を残す。
- 点層を持たない旧 Asset Pack では、区域アイコンの layer は何も描かない。iOS Simulator では例外なく塗りだけが表示された（2026-11-23）。Android は未検証。
- 英数字を描く `text-field` には `text-font` へ `Noto Sans CJK JP Regular` か `Noto Sans CJK JP Bold` を明示する。glyph の配信元 `glyphs.geolonia.com` は、MapLibre 既定の fontstack（`Open Sans Regular,Arial Unicode MS Regular`）へ 403 を返す。
- 観測点名ラベルは `text-variable-anchor` の symbol layer で描く。symbol の配置は上の layer から行われるため、ラベル layer は観測点アイコン layer の下に置き、アイコン側は `icon-ignore-placement: false` にして衝突判定へ参加させる。逆順ではラベルが他の観測点へ重なる。
- ラベルの `text-radial-offset` は観測点の実寸から計算する。震度アイコンは論理 50px を端末のピクセル比で拡大した画像をピクセル比 1 で登録するため、半径は `25 × devicePixelRatio × icon-size`。小さく見積もると全ラベルが自分のアイコンと衝突して消える。`icon-padding`・`text-padding`（既定 2px）も衝突範囲に含まれる。
- circle layer は衝突判定に入らない。強震モニタのラベルは、観測点と同じ大きさの透明画像を置く symbol layer をラベル layer の上に重ねて他の観測点を避ける。ラベルの source は毎秒更新される観測値の source と分け、観測点の集合が変わったときだけ更新する。
- ラベルの背景は `icon-text-fit: both` と `StyleImageOptions.stretchX` / `stretchY` を指定した画像で描ける（`text-variable-anchor` との併用を iOS シミュレータで確認済み）。
- zoom 依存 `interpolate` は式の最上位に置く。倍率は各 stop 値へ畳み込み、乗算式の内側へ zoom 式を入れない。
- Dart の式テスト（`layer.toJson()` の検証）だけで native の描画結果を検証済みとしない。
- 非表示 filter に `['==', 1, 0]` を使わない。MapLibre Native はこれを旧形式の比較と解釈し、数値の属性名を拒否する。地域選択は `RegionMapLayers.hiddenFilter` の空集合への所属判定を使う。

## 推計震度の raster-dem 表示

- 推計震度は API の `estimated_intensity_dem_archive` があれば raster-dem の PMTiles（計測震度を 0.1 刻みの標高として持つ Mapbox Terrain-RGB、512px、z0〜10、データなしは標高 -10000）を `color-relief` layer で描く。無い地震は従来のベクトル archive を使う。
- 階級表示と 0.1 単位表示の切り替えは `color-relief-color` の式だけを差し替える。source と layer は作り直さない。
- MapLibre Native は `color-relief` の `resampling` を受け付けず、layer 追加が `invalidArgument` で失敗する（iOS Simulator、2026-11-23）。DEM は線形補間で読まれるため、色の境界の両側に stop を置いて中間値のにじみを抑える。データなしを -10000 に置くことで、領域の縁に低い震度の色が出ない。
- `color-relief-color` は `['elevation']` を入力にした `interpolate` で書く。Android での表示は未確認。
- 配色: `EstimatedIntensityDemColorResolver` が決める。階級表示はテーマの推計震度色。0.1 単位表示は `EstimatedIntensityScaleColorResolver` の震度配色グラデーションか、`KyoshinShindoColorMap.json` の強震モニタ配色を選べる。地図・凡例・カードのプレビューは同じ resolver から色を取る。

## 座標・選択・初期カメラ

- カメラの bounds 計算は `app/lib/feature/map/data/logic/map_camera_bounds_fitter.dart`、モデルは同 `data/model/map_camera.dart`・`map_camera_bounds.dart` に集約し、既存の fitBounds テスト・fixture は `app/test/feature/map/data/logic/` に置く。
- `LatLng` は `(latitude, longitude)`。geobase の `Geographic` / `GeoBox` は経度が先（`west, south, east, north`）。保存・再読込まで異なる緯度経度値で確認する。
- アプリ内の bounds は `MapCameraBounds` で持つ。`GeoBox` のコンストラクタは経度の折り返しと緯度の丸めを黙って行うため、範囲外・非有限値の拒否ができない。`GeoBox` は `CameraUpdate.bounds` や `getVisibleBounds()` など API 境界だけで使う。
- 緯度経度グリッドは 12 桁スケールの整数 ceil/floor と index の積から生成する。浮動小数の反復加算を避け、負値・`-0.0`・`0.3 / 0.1` などの境界を確認する。
- ポリゴンの地域判定は `nearest_jma_feature.dart` の常駐 worker provider を使う。main isolate で `JmaMapUtility.findNearestItem` を実行しない。全画面地図は worker を事前に温める。
- タップ位置の判定は `await controller.queryRenderedFeatures(.point(screenPoint))`。結果の `layerId` / `sourceLayer` で分岐する。地域判定のゲートにすると zoom やタイル有無へ依存するため、コード体系が必要なら worker 判定を使う。
- イベントは `onClick`・`onLongClick`・`onCameraMoveStart` など個別の callback で受ける。`onClick` はズームのジェスチャーが有効な間、ダブルタップ判定を待ってから届く。
- 市区町村別最大震度のタップは zoom にかかわらず市区町村選択。低 zoom で県へ寄せるだけの操作にしない。ディープリンクは市区町村コードから詳細を開き、領域外は選択解除する。
- 観測点のない震度速報は `intensity.regions` の境界を使う。`jmaMapProvider` と layout サイズが揃ってから `MapCameraBoundsFitter` に論理ピクセルを渡す。
- 初期範囲は `MapOptions.initCamera`（`CameraUpdate.position`）に設定する。表示後の `CameraUpdate.bounds` による移動を避け、境界が得られない場合は固定位置で補わない。
- style は `MapStyleUtil` が書き出したファイルを `MapStyle.file(path)` で渡す。
- `animateCamera` の既定は 300 ms の ease。範囲へ合わせる移動（旧 `fitBounds`）は既定のまま使い、時間を指定する自動フォーカスは `CameraAnimation.fly(duration:)` を渡す。中断は例外ではなく `CameraAnimationResult.cancelled` で返る。
- 現在地は `UserLocationLayer` に `geolocator` の stream を渡して描く（`HomeMapUserLocationLayer`）。権限の要求は設定画面側で行い、レイヤーは未許可なら何も描かない。
- 登録画像は `pixelRatio` の既定 1 で、画像 1 px が論理 1 px として表示される。`icon-size` の式はこの前提で調整している。
- MapLibre（Native・GL JS）の zoom は 512px タイル基準（Native は `include/mln/util/constants.hpp` の `tileSize_D`）。zoom を自前で計算するときは `MapZoomCalculator.tileSize` か `MapCameraBoundsFitter` を使い、256px 基準の式を使わない。256px 基準では zoom が 1 段深くなり、指定範囲の約 2 倍に拡大されて画面に収まらない。

## 通知地域と EEW フォーカス

### 共通の地域選択

- 地域選択は `feature/region_selection` の `RegionSelectionRoute` に集約する。`RegionSelectionRequest.kinds` で対象種別、`mode` で単一・複数選択、`initialSelection` で復元、`allowEmpty` で全解除の確定可否を指定する。結果は `List<RegionOption>`、キャンセルは `null`、全解除は空リスト。
- ホーム指定地域、観測地域フィルター、通知追加、ウィジェット設定、履歴の地域検索は共通の検索・一覧・地図・選択確認を使う。既存の単一地域を保存する呼び出し元は単一選択のまま利用する。震央フィルターは複数選択。
- 通知は `notification: true` と `eewRegion` / `city` を組み合わせ、同じ市でも親EEW区域が違う候補を区別する。一般の観測用細分区域を通知区域へ転用しない。
- Asset Pack v0.1 の `areaEpicenter` は数値属性 `id` を持つ。`areaEpicenter` コード表のコードを数値として照合し、地名と読みはコード表から取得する。未知IDは選ばず、地図領域がない地名は一覧に残す。旧packで当該layerがない場合も一覧で選択できる。
- 震央条件は `EarthquakeHistoryParameter.epicenterCodes` へ保存する。観測地域・震度などの条件とは独立し、地域変更や個別解除で相互の条件を消さない。
- 地図lookupは種別・親・選択・styleの変更とdisposeで無効化する。検索結果の遅延完了で解除済みの選択を戻さない。選択overlayは専用layerを使い、cleanupで除去する。

- 通知の `regionId` は `areaForecastLocalEew`、市区町村の表示名・ふりがなは `EarthquakeParameter` が正本。観測点を含む `jma_code_table.areaInformationCity` は親区域の結合に限定し、結合不能を近隣地域で補わない。
- 通知地域のタップ検索とカメラ操作は世代を持ち、完了時・キュー実行開始時の最新世代と mounted を確認する。dispose で世代と controller を無効化する。
- EEW 自動フォーカスを解除するのは `CameraChangeReason.gesture`。`programmatic` / `map` では解除しない。
- 解除後は同じ EEW の更新で再開せず、新 event ID で再開する。EEW 中のホームボタンは `autoZoom` によらず EEW へ再フォーカスする。animation 開始前に状態を公開し、完了時は session 一致を確認する。揺れ検知だけの場合も同じ session（`HomeMapRealtimeFocusTransition`）で扱う。
- 揺れ検知は南西端 inclusive の格子へ points を集約し、各セルの最大レベルだけを枠線で描く。空セル・中心/四隅 marker は描かない。レベル順で高い枠を上へ置き、Weaker は `#546E7A`。
- 揺れ検知の格子は経度 0.5°（`ShakeDetectionGridCell.step`）幅で、緯度はメルカトル投影上で同じ長さになるよう区切る。地図上では緯度によらず正方形になり、緯度方向の度数は高緯度ほど小さい（北緯 35° 付近で約 0.41°）。
- 揺れ検知の自動フォーカスは、イベントの矩形を同じ格子の外側の辺へ広げてから bounds を求める。検知範囲がセル内で変わっても bounds が変わらず、カメラが小刻みに動かない。
- intensity の境界は `< 0.5`、`< 2.5`、`< 3.5`、`< 5.5`、それ以上の順に Weaker/Weak/Medium/Strong/Stronger。`ShakeDetectionGridCellBuilder` と配信側の境界を揃える。

## PMTiles と native 障害の切り分け

- ローカル URI は `pmtiles://${Uri.file(absolutePath)}`。`pmtiles://asset://` は使わず、asset をローカルファイルに配置してから開く。旧 `assets_util` は削除済みのため依存を復活させない。
- 配布物には `countries`、`areaForecastLocalE`、`areaForecastLocalEew`、`areaInformationCityQuake` の source layer が必要。別用途の区域 archive や HTTPS へ黙って置換しない。
- 市区町村地物の表示下限は `BaseMapTileSpec.cityMinZoom` に集約する。現行のタイルは z0 から市区町村地物を持つため値は 0 で、`effectiveRegionToCityZoom` の下限補正は実質無効。タイル側で下限を上げたときは、この定数だけを変更すれば参照側の補正が有効になる。metadata の minzoom だけで地物の存在を判断しない。
- pin の正本は `app/pubspec.yaml` の `YumNumm/flutter-maplibre`・`YumNumm/maplibre-native-ffi` の ref と lockfile。fork の `main` は upstream（`maplibre/flutter-maplibre`）と同じツリーで、`maplibre`・`maplibre_native`・`maplibre_platform_interface`・`maplibre_web` を同じ ref に揃える。native の本体は `maplibre_native_ffi` が配布するビルド済み C ライブラリ。
- gzip metadata エラーの abort 対処は upstream [#4399](https://github.com/maplibre/maplibre-native/pull/4399)（2026-07-14 マージ）。これは他の decode 障害すべてを防ぐ保証ではない。
- iOS Metal で複数 vector source の fill だけがタイル単位で欠ける場合、clip mask UBO の bind cache 再利用を疑う。[#4342](https://github.com/maplibre/maplibre-native/pull/4342) が原因・回帰テストの参照先。layer 再追加や opacity 変更を恒久対策にしない。
- #4342 は 2026-11-22 時点で upstream 未マージ。0.3 系では `YumNumm/maplibre-native` の `ios-v6.29.0-yumnumm.2` に修正を入れて回避していたが、0.4 の `maplibre_native_ffi` は upstream のビルドを使うため、この修正は含まれないと考えられる。iOS 実機での fill 欠けの有無は未確認。
- 0.4 の native 本体は `maplibre_native_ffi` の `hook/native_release.json` が指すビルド済みアーカイブで、build hook が sha256 を照合して取得する。`app/pubspec.yaml` で `maplibre_native_ffi` を `YumNumm/maplibre-native-ffi`（`bindings/dart`）へ override している。fork は upstream の tag `v0.202611.0`（MapLibre Native `8e144d0` に同リポジトリの `patches/` を当てたもの）から切った `yumnumm/v0.202611.0` が基点。
- fork の差分は iOS シミュレータ（`ios-simulator-arm64`）だけ。このアーカイブは fork の release `v0.202611.0-yumnumm.1` から取得し、ほかのプラットフォームは upstream v0.202611.0 のアーカイブと sha256 のまま。fork の hook は `native_release.json` の artifact が持つ `url` を優先する。
- upstream v0.202611.0 のままだと、iOS シミュレータでタイル境界の両側（tippecanoe のバッファ幅。z8 タイルで約 ±0.027°）に line の直線が 2 本 1 組で出る。0.3 系（`MLNMapView`）では出ない。原因は `src/render/metal/metal_texture_backend.mm` が `#if !TARGET_OS_SIMULATOR` で stencil を作らないこと。シミュレータの depth は `Depth32Float_Stencil8` だが stencil attachment に設定されず、タイルの clip mask が無効になり、バッファ領域で切断されたポリゴンの辺が隣のタイルへはみ出す。
- 同じ原因で、半透明の fill はバッファ幅の帯で二重に塗られる。line の直線と帯が同じ位置に出れば clip mask の無効を疑う。実機は別の `Stencil8` を付ける経路で、コード上は該当しない（実機での確認は未実施）。
- fork の修正は `metal_surface_session.mm` と同じく、depth が `Depth32Float_Stencil8` のとき同じ texture を stencil attachment にも設定する。style 側の filter・layer 分割やタイル再生成で隠さない。
- `maplibre` を更新して `maplibre_native_ffi` の版が上がるときは、override を外して upstream のビルドで同じカメラ位置（ズーム 10・北緯 32.8 / 東経 130.7 と九州の広域）を確認する。直線が残る場合は fork を新しい tag へ作り直す。upstream の `main` は構成が変わっており（`src/` がなく `third_party/mln-rs` を参照。2026-11-23 時点）、同じ欠陥が残るかは未確認。
- シミュレータ用アーカイブの再ビルドは、fork で `tools/deps/sync-submodules` の後に CMake preset `ios-simulator-arm64-metal` を install まで実行する。Rust の target `aarch64-apple-ios-sim` と `cargo-about` が要る。`hooks.user_defines.maplibre_native_ffi.local_build` に install 先を指定すると手元のビルドを使えるが、全プラットフォームに効くためコミットしない。
- Metal の確認は同じ実 archive・camera・style で fill と line を比較する。`MLNMapSnapshotter` や取得・リンク成功だけでは画面の修正を確認できない。

## 変更時の確認

`app/` から関連する既存テストを実行する。初回取得、invalidate、再取得成功・失敗、dispose 中の完了を確認し、式・Metal・PMTiles 表示は iOS/Android でも確認する。

```sh
mise exec -- flutter test test/core/util/map --dart-define=CI=true
mise exec -- flutter test test/feature/intensity_history --dart-define=CI=true
```

関連: [PMTiles](pmtiles.md)
