# EQMonitor Map ベースレイヤーPMTiles描画 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** デバッグページで、Asset Pack配布のベースマップPMTilesをFlutter Scene経由のFill/Lineとして
pan/zoom付きで描画する。設計正本`docs/superpowers/specs/2026-08-02-eqmonitor-map-renderer-design.md`の
`03-foundation`/`04-tile-pipeline`/`06-scene-renderer`を、ベースレイヤーのFill/Lineだけへ絞った
縦切りとして実証する。

**Architecture:** appが`AssetPackRepository`で検証したローカルPMTilesを`VerifiedPmTilesSource`として
`eqmonitor_map`へ渡す。`eqmonitor_map`は汎用`packages/pmtiles_v3`でtile bytesを取り出し、自前の
strict MVT decoderで幾何を復元し、整数zoom単位のFill/Line meshへ変換して、Flutter Scene adapterが
tile行列とともに描画する。camera変更はtile coverを再計算し、meshは非整数zoomでは作り直さない。

**Tech Stack:** Flutter master pin (`4dacd3fc91d96262a33e5c598e17d816f0b35641`)、Dart、flutter_scene
(`7f71993b7e2a0ab1d2f59726a406098709be7291`)、`dart_earcut`、Freezed、Riverpod、go_router_builder、
melos、mise

## 参考実装

実装の正本は次の2ドキュメントである。座標変換の式、tile行列の2段構成、tile ID 3層、earcutの使い方、
line押し出しの加算位置、子→親fallbackの順序、整数zoom cacheと線幅逆補正は、これらに記録した内容を
そのまま使う。憶測で別方式を導入しない。

- `docs/knowledge/20260805_maplibre_native_renderer_reference.md` (maplibre-native `f1905c52`)
- `docs/knowledge/20260802_kevi_map_renderer_reference.md` (KyoshinEewViewerIngen `5a2bf513` / `cc5ce50b`)

## Global Constraints

- 対象はiOS/Androidのみ。bearing/pitch/透視投影は実装しない。projectionは正射影の2D行列とする。
- Flutter/Dartコマンドは必ず`mise exec --`経由で実行する。
- `eqmonitor_map`と`pmtiles_v3`は`app`へ依存しない。検証済みpath/digest/sizeはappが確定し、
  immutableな`VerifiedPmTilesSource`として渡す。packageはmanifestもAsset Pack APIも受け取らない。
- 欠損tileと不正tileを区別する。sparse archiveのtile欠損は`null`、破損・上限超過・schema不整合は
  typed exceptionにする。壊れたデータを空tileへ丸めない。fail-openのfallback値を入れない。
- 上限値は呼び出し側が渡す`limits`引数で明示する。decoder内部に隠れた固定fallbackを置かない。
- zoom依存propertyはCPUで現zoomの値を確定しuniformとして渡す。shader内で補間しない。
- meshは整数zoom単位で構築し、非整数zoomはtile行列のscaleで吸収する。線幅はそのscaleで逆補正する。
- 頂点属性はfloat32とする。MapLibreの6 byte packingは採用しない。
- joinはmiter、capはbuttのみ。miter limit超過時のbevel、round、dash、`linesofar`は実装しない。
- 公開Providerは1ファイル1つまでとする。
- 永続化するmodelはFreezed + json_serializableを基本とする。frame hot pathのmutable runtime stateは
  Freezedにしない。
- コードから読み取れる内容のコメントを書かない。理由を説明するコメントだけ残す。
- 必要性を論証できないフィールド・抽象・引数を追加しない。ラベル、動的レイヤー、remote source、
  attestation、hit test、性能HUD、Home統合はこの計画のスコープ外とする。
- widget testとgolden testは追加しない。純粋ロジックのunit testを必須とする。
- 各タスクで`mise exec -- dart format`と対象unit testを実行し、コミットする。

## 前提確認

Task 1の冒頭で次を確認し、満たせない場合はBLOCKEDとして報告する。

- `mise exec -- flutter config --enable-dart-data-assets`がこのマシンで有効化済みであること。
  未設定だと`Scene.initializeStaticResources()`が失敗し`Flutter Scene is not ready to render.`が
  出続ける。`docs/knowledge/20260803_flutter_scene_dart_data_assets.md`を参照する。
- `app/pubspec.yaml`の`flutter.config.enable-native-assets: true`が維持されていること。
- `packages/eqmonitor_map/pubspec.yaml`のDart SDK制約と`app/pubspec.yaml`の`^3.11.0`が両立すること。
  `packages/eqmonitor_map/example/pubspec.yaml`は`^3.14.0-29.0.dev`を要求しているため、appから
  `eqmonitor_map`へ依存を張った時点でSDK制約が衝突する可能性がある。衝突した場合は制約を
  下げて回避せず、実際に解決可能な制約を計測してから報告する。

---

## Task 1: appへeqmonitor_mapを接続し空のSceneデバッグページを表示する

レンダラーを書く前にtoolchainを通す。materialのdata asset生成、native assets、go_router登録、
Flutter Scene初期化がappのビルドで動くことを最初に確定させる。

**Files:**

- Create: `packages/eqmonitor_map/hook/build.dart`
- Create: `packages/eqmonitor_map/assets/base_map_fill.fmat`
- Modify: `packages/eqmonitor_map/pubspec.yaml`
- Create: `app/lib/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_debug_page.dart`
- Modify: `app/lib/core/router/router.dart`
- Modify: `app/lib/feature/settings/children/config/debug/debug_page.dart`
- Modify: `app/pubspec.yaml`
- Modify: `packages/eqmonitor_map/README.md`

- [ ] `packages/eqmonitor_map/hook/build.dart`を作成し、`example/hook/build.dart`と同じ形で
      `buildMaterials`を呼ぶ。`materials`にはpackage自身の`assets/*.fmat`を渡す。exampleのhookは
      exampleのassetを引き続き扱い、package側のhookと二重生成しない。
- [ ] `assets/base_map_fill.fmat`を`shading_model: unlit`、`culling: none`で作成する。parameterは
      `vec4 fill_color`だけとし、`vertex{}`ブロックを持たない。
- [ ] `app/pubspec.yaml`の`dependencies`へ`eqmonitor_map: {path: ../packages/eqmonitor_map}`を追加する。
- [ ] `EqmonitorMapDebugPage`を作成する。この時点の内容は「Flutter Sceneが初期化でき、単色の三角形が
      1つ描画される」ことだけを示すものにする。既存の`packages/eqmonitor_map/lib/src/flutter_scene/`の
      spike資産を読み、再利用できるものは再利用する。新しい抽象を先に作らない。
- [ ] `router.dart`の`DebugRoute`の`routes`へ`TypedGoRoute<EqmonitorMapDebugRoute>(path: 'eqmonitor-map')`
      を追加し、対応する`EqmonitorMapDebugRoute`クラスを定義する。
- [ ] `debug_page.dart`の`_DebugWidget`へ`ListTile`を追加し、`const EqmonitorMapDebugRoute().push<void>(context)`
      で遷移させる。
- [ ] `mise exec -- dart run build_runner build --delete-conflicting-outputs`を`app`で実行し
      `router.g.dart`を再生成する。
- [ ] `mise exec -- flutter analyze`を`app`と`packages/eqmonitor_map`で実行する。
- [ ] READMEへ、appから接続済みであること、`--enable-dart-data-assets`が前提であること、
      デバッグページの到達点を追記する。
- [ ] `mise exec -- dart format`を変更ファイルへ実行し、`Feature: eqmonitor_mapデバッグページを追加`
      としてコミットする。

## Task 2: 汎用PMTiles v3 readerをpackages/pmtiles_v3へ抽出する

**Files:**

- Create: `packages/pmtiles_v3/pubspec.yaml`
- Create: `packages/pmtiles_v3/lib/pmtiles_v3.dart`
- Create: `packages/pmtiles_v3/lib/src/**`（`seismicity_pmtiles`から移設）
- Create: `packages/pmtiles_v3/test/**`（対応するtestを移設）
- Modify: `packages/seismicity_pmtiles/pubspec.yaml`
- Modify: `packages/seismicity_pmtiles/lib/**`
- Modify: `pubspec.yaml`（workspaceは`packages/*` globで解決されるため通常は変更不要。確認のみ）

- [ ] `packages/seismicity_pmtiles/lib/src/archive/`と`lib/src/reader/`のうち、PMTiles v3仕様だけに
      依存する部分（header decoder、directory decoder、compression decoder、tile ID変換、
      range validator、file/asset random access reader）を`packages/pmtiles_v3`へ移設する。
      `seismicity`という語を含む型名・ファイル名は汎用名へ改名する。
- [ ] 公開APIを次のとおりにする。既存実装の意味論を変えず、名前と引数だけを汎用化する。

      ```dart
      abstract interface class PmTilesRandomAccessReader {
        Future<Uint8List> readAt({required int offset, required int length});
        Future<void> close();
      }

      abstract interface class PmTilesV3Archive {
        static Future<PmTilesV3Archive> open({
          required PmTilesRandomAccessReader reader,
          required PmTilesV3Limits limits,
        });
        PmTilesV3Header get header;
        Future<Uint8List?> readTile({required int z, required int x, required int y});
        Stream<int> occupiedTileIdsAtZoom({required int zoom});
        Future<void> close();
      }
      ```

- [ ] `readTile`はsparse archiveでentryが存在しないtileへ`null`を返す。header不整合、directory破損、
      offset/length算術異常、`limits`超過はtyped exceptionにする。両者を同じ戻り値へ丸めない。
- [ ] `PmTilesV3Limits`は`seismicity_pmtiles`が現在内部で使っている上限値をそのまま引数化する。
      新しい上限を発明せず、既存の値を移すだけにする。既存に上限がない項目を追加しない。
- [ ] `seismicity_pmtiles`を`pmtiles_v3`へ依存させ、`SeismicityPmTilesArchiveDescriptor`と
      その検証（`dataZoom`、`schemaVersion`、`expectedFeatureCount`、`archiveRevision`、`periodFrom/To`、
      clustered ordering検証、件数一致検証）だけを残す薄い層にする。`SeismicityPmTilesArchive`の
      既存公開APIシグネチャは変えない。
- [ ] 移設したtestが`pmtiles_v3`で通ることを確認し、`seismicity_pmtiles`側には震源固有の検証testだけを
      残す。testの内容を弱めない。
- [ ] `mise exec -- dart test`を`packages/pmtiles_v3`と`packages/seismicity_pmtiles`で実行する。
- [ ] `mise exec -- dart format`を実行し、`Refactor: PMTiles v3 readerを汎用packageへ抽出`として
      コミットする。

## Task 3: strict MVT decoderを実装する

**Files:**

- Create: `packages/eqmonitor_map/lib/src/tile/mvt/mvt_decoder.dart`
- Create: `packages/eqmonitor_map/lib/src/tile/mvt/mvt_tile.dart`
- Create: `packages/eqmonitor_map/lib/src/tile/mvt/mvt_decode_limits.dart`
- Create: `packages/eqmonitor_map/lib/src/tile/mvt/mvt_decode_exception.dart`
- Create: `packages/eqmonitor_map/test/tile/mvt/mvt_decoder_test.dart`
- Create: `packages/eqmonitor_map/test/tile/mvt/fixtures/**`

- [ ] protobufのwire formatを自前で読む。`protobuf`パッケージのコード生成を使わない。varint、
      zigzag、length-delimited、未知field番号のskipを実装する。skip時も長さの境界検証を行う。
- [ ] 復元する構造は次だけとする。`properties`（tag/key/valueのdecode）とfeature IDはこの縦切りでは
      復元せず、wire上はskipする。skipの実装は必要だが、モデルへ持たせない。

      ```dart
      final class MvtTile { final List<MvtLayer> layers; }
      final class MvtLayer {
        final String name;
        final int version;
        final int extent;
        final List<MvtFeature> features;
      }
      final class MvtFeature {
        final MvtGeometryType type;   // point / lineString / polygon
        final List<Int32List> rings;  // ringごとにx,yを交互に詰めたtile-local座標
      }
      MvtTile decodeMvtTile(Uint8List bytes, {required MvtDecodeLimits limits});
      ```

- [ ] `extent`はlayerの宣言値を読む。宣言がない場合はMVT仕様の既定値4096とし、それを定数として
      1箇所に置く。tippecanoe前提の値を各所へ散らさない。
- [ ] geometry commandは`MoveTo`/`LineTo`/`ClosePath`のみ受理する。command IDと引数個数の整合、
      Pointは`MoveTo`のみ、LineStringは`MoveTo`後に`LineTo`が1回以上、Polygonは`ClosePath`で
      ringが閉じることを検証する。違反はtyped exceptionにする。
- [ ] `MvtDecodeLimits`はlayer数、layerあたりfeature数、featureあたりring数、ringあたり頂点数、
      commandの総数、layer名のbyte長を持つ。呼び出し側が値を渡す。
- [ ] `version`が1と2以外のlayerはtyped exceptionにする。
- [ ] fixtureは`utils/map_converter/data/pmtiles/earthquake_tsunami_all.pmtiles`から実tileを1〜2枚
      抽出して`test/tile/mvt/fixtures/`へ置く。抽出手順をtestのdoc commentへ記録する。加えて
      malformed fixture（切り詰めたbyte列、command不整合、上限超過、未知field）を手で作る。
- [ ] testでPoint/LineString/穴付きPolygonの復元、ring winding、extent読み取り、各limit超過、
      malformed rejectを検証する。
- [ ] `mise exec -- flutter test test/tile/mvt`を実行する。
- [ ] `mise exec -- dart format`を実行し、`Feature: strict MVT decoderを追加`としてコミットする。

## Task 4: 座標系とcameraを実装する

**Files:**

- Create: `packages/eqmonitor_map/lib/src/geo/map_mercator_projection.dart`
- Create: `packages/eqmonitor_map/lib/src/geo/map_camera.dart`
- Create: `packages/eqmonitor_map/lib/src/geo/map_viewport.dart`
- Create: `packages/eqmonitor_map/lib/src/geo/tile_id.dart`
- Create: `packages/eqmonitor_map/lib/src/geo/tile_matrix.dart`
- Create: `packages/eqmonitor_map/test/geo/**`
- Modify: `packages/eqmonitor_map/lib/src/renderer/eqmonitor_orthographic_projection.dart`

- [ ] 既存の`eqmonitor_orthographic_projection.dart`と`spike_screen_projector.dart`を先に読む。
      同じ責務があれば新規作成せず拡張する。重複した投影実装を2つ持たない。
- [ ] `MapMercatorProjection`を実装する。`maxLatitude = 85.0511287798066`、`tilePixelSize = 512`。
      `scaleForZoom(zoom) = pow(2, zoom)`、`worldSizeForZoom(zoom) = scaleForZoom(zoom) * tilePixelSize`。
      経度緯度からnormalized Mercator（Xが東、Yが南、原点は左上、範囲`[0,1)`）への変換と逆変換を
      持つ。緯度はclampし、元のWGS84値を書き換えない。
- [ ] `MapCamera`をFreezedで`centerLongitude`、`centerLatitude`、`zoom`だけを持つimmutable型にする。
      bearing/pitchのフィールドを追加しない。
- [ ] `MapViewport`を`logicalSize`と`devicePixelRatio`だけを持つimmutable型にする。
- [ ] `CanonicalTileId`、`OverscaledTileId`、`UnwrappedTileId`を実装する。
      `CanonicalTileId.scaledTo(z)`、`children()`、`OverscaledTileId.overscaleFactor`、
      `toUnwrapped()`を持つ。`UnwrappedTileId`は`wrap`を持つ。
- [ ] `tile_matrix.dart`で`Matrix4`を返す2段構成を実装する。
      `s = worldSizeForZoom(zoom) / (1 << canonicalZ)`として
      `translate((x + wrap * (1 << z)) * s, y * s, 0)`のあと`scale(s / extent, s / extent, 1)`を掛ける。
      extentは引数で受け取り、定数を埋め込まない。
- [ ] 正射影のprojection行列は、viewportのlogical sizeとcamera中心のworld座標から作る。camera中心を
      原点とするorigin rebasingを行い、GPUへ渡す前にworld座標の絶対値を小さくする。
- [ ] testでWGS84↔normalized↔screenの往復、緯度限界、date line跨ぎ、`scaledTo`/`children`の整合、
      tile行列がtile四隅を期待するscreen座標へ写すこと、複数DPRを検証する。
- [ ] `mise exec -- flutter test test/geo`を実行する。
- [ ] `mise exec -- dart format`を実行し、`Feature: Mercator投影とtile行列を追加`としてコミットする。

## Task 5: tile coverを実装する

**Files:**

- Create: `packages/eqmonitor_map/lib/src/tile/tile_cover_calculator.dart`
- Create: `packages/eqmonitor_map/test/tile/tile_cover_calculator_test.dart`

- [ ] `TileCoverCalculator.cover({required MapCamera camera, required MapViewport viewport,
      required int minZoom, required int maxZoom})`が`List<OverscaledTileId>`を返す。
- [ ] source zoomはcameraの連続zoomから`minZoom`/`maxZoom`で制限して決める。`maxZoom`超過時は
      `overscaledZ`だけを上げ、`canonical.z`を`maxZoom`に留める。
- [ ] 画面4隅をnormalized world座標へ投影し、その範囲を覆うtile矩形を求める。frustum-AABB四分木は
      実装しない。
- [ ] 結果はcamera中心からの距離昇順にsortする。同距離の順序を安定させる。
- [ ] 日本国内表示を主対象とするが、`wrap`は0固定にせずdate line跨ぎで正しい`wrap`を返す。
- [ ] testでzoom整数/非整数、maxZoom超過時のoverscale、viewport aspect比、date line跨ぎ、
      sort順の決定性を検証する。
- [ ] `mise exec -- flutter test test/tile/tile_cover_calculator_test.dart`を実行する。
- [ ] `mise exec -- dart format`を実行し、`Feature: tile coverを追加`としてコミットする。

## Task 6: Fill頂点生成を実装する

**Files:**

- Modify: `packages/eqmonitor_map/pubspec.yaml`（`dart_earcut`を追加）
- Create: `packages/eqmonitor_map/lib/src/mesh/fill_mesh_builder.dart`
- Create: `packages/eqmonitor_map/lib/src/mesh/fill_mesh.dart`
- Create: `packages/eqmonitor_map/test/mesh/fill_mesh_builder_test.dart`

- [ ] `dart_earcut`を依存へ追加する。三角形化を自前実装しない。
- [ ] ring windingで外形と穴を分類する。MVT仕様のとおり、面積の符号で外形/穴を判定する。
      degenerateなring（頂点3未満、面積0）はrejectしてtyped errorにする。
- [ ] 穴数の上限とfeatureあたり頂点数の上限を引数で受け取る。index bufferは`Uint16List`とし、
      頂点数が65535を超える場合はsegmentへ分割する。分割規則をtestで固定する。
- [ ] 出力は次のとおりtile-local座標のfloat32とする。

      ```dart
      final class FillMesh {
        final Float32List positions; // x,y を交互
        final Uint16List indices;
        final int vertexCount;
      }
      ```

- [ ] MVT extent外bufferの頂点は落とさずmeshへ残す。tile境界のclipは描画側のscissorで行う。
- [ ] testで単純な四角、穴1つ、穴2つ、外形2つ、winding逆転、degenerate ring reject、
      65535超過のsegment分割を検証する。
- [ ] `mise exec -- flutter test test/mesh/fill_mesh_builder_test.dart`を実行する。
- [ ] `mise exec -- dart format`を実行し、`Feature: Fill頂点生成を追加`としてコミットする。

## Task 7: Line頂点生成を実装する

**Files:**

- Create: `packages/eqmonitor_map/lib/src/mesh/line_mesh_builder.dart`
- Create: `packages/eqmonitor_map/lib/src/mesh/line_mesh.dart`
- Create: `packages/eqmonitor_map/test/mesh/line_mesh_builder_test.dart`

- [ ] 中心線の各頂点へ押し出し法線を持たせる。出力は次のとおり。

      ```dart
      final class LineMesh {
        final Float32List positions; // tile-local x,y を交互
        final Float32List extrudes;  // 単位法線 x,y を交互
        final Uint16List indices;
        final int vertexCount;
      }
      ```

- [ ] joinはmiterのみ、capはbuttのみ実装する。隣接segmentの単位法線から
      `joinNormal = normalize(prevNormal + nextNormal)`、`miterLength = 1 / cosHalfAngle`を求め、
      押し出し法線に`miterLength`を掛けて格納する。miter limitを引数で受け取り、超過した頂点は
      法線を`miterLength`ではなくlimitでclampする。bevel三角形は追加しない。
- [ ] 連続する重複頂点と、長さ0のsegmentを除去する。除去後に頂点2未満になったlineはmeshへ出さない。
- [ ] indexは明示的なtriangle listとする。triangle stripを使わない。頂点数65535超過時はFillと同じ
      規則でsegment分割する。
- [ ] Douglas-Peuckerによる間引きはこのタスクでは実装しない。間引きを後から挿入できるよう、builderの
      入力はring座標列とし、内部で座標を生成しない。
- [ ] testで直線、直角、鋭角でのmiter clamp、閉路、重複頂点除去、頂点2未満のskip、segment分割、
      押し出し法線が線に直交することを検証する。
- [ ] `mise exec -- flutter test test/mesh/line_mesh_builder_test.dart`を実行する。
- [ ] `mise exec -- dart format`を実行し、`Feature: Line頂点生成を追加`としてコミットする。

## Task 8: Flutter Scene adapterでFill/Lineを描画する

**Files:**

- Create: `packages/eqmonitor_map/assets/base_map_line.fmat`
- Create: `packages/eqmonitor_map/lib/src/flutter_scene/base_map_geometry_factory.dart`
- Create: `packages/eqmonitor_map/lib/src/flutter_scene/base_map_material_library.dart`
- Modify: `packages/eqmonitor_map/hook/build.dart`
- Create: `packages/eqmonitor_map/test/flutter_scene/base_map_geometry_factory_test.dart`

- [ ] `base_map_line.fmat`を作成する。`attributes`へ`vec2 extrude`を宣言し、`vertex{}`ブロックで
      `vertex.world_position.xy += extrude * material_params.half_width_world;`の形に押し出す。
      parameterは`vec4 line_color`と`float half_width_world`だけとする。
- [ ] `half_width_world`はCPUで毎frame確定する。logical pixelの半線幅をworld単位へ換算した値であり、
      shader内でzoomから再計算しない。換算式をdoc commentで根拠付きで残す。
- [ ] `BaseMapGeometryFactory`が`FillMesh`/`LineMesh`から`scene.Geometry`を作る。Fillは
      `MeshGeometry.fromArrays(positions:, indices:, primitiveType: triangle)`を使う。Lineは
      `setCustomAttribute('extrude', ..., components: 2)`で押し出し法線を渡す。頂点bufferの
      アップロードは1回だけとし、`GeometryStorage`の選択理由をdoc commentへ残す。
- [ ] `positions`は2成分のtile-local座標である。`MeshGeometry.fromArrays`が3成分positionを要求する
      場合はzを0で埋め、その事実をdoc commentへ残す。埋める処理をbuilder側へ漏らさない。
- [ ] `BaseMapMaterialLibrary`が`loadFmatMaterial`で2つのmaterialを読み、色と`half_width_world`を
      設定する公開methodを持つ。materialはlayerごとに作り直さず、`tile × layer × material`単位の
      batchで共有する。
- [ ] `hook/build.dart`の`materials`へ`assets/base_map_line.fmat`を追加する。
- [ ] testはGPU初期化を必要としない範囲だけを検証する。頂点配列からgeometry生成時の引数組み立て、
      成分数、index型の選択、`half_width_world`の換算式を検証する。GPU描画結果のassertを書かない。
- [ ] `mise exec -- flutter test test/flutter_scene`を実行する。
- [ ] `mise exec -- dart format`を実行し、`Feature: Fill/LineのScene adapterを追加`としてコミットする。

## Task 9: tile pipelineとgeometry cacheを組む

**Files:**

- Create: `packages/eqmonitor_map/lib/src/tile/verified_pm_tiles_source.dart`
- Create: `packages/eqmonitor_map/lib/src/tile/base_map_tile_repository.dart`
- Create: `packages/eqmonitor_map/lib/src/tile/base_map_tile_decoder.dart`
- Create: `packages/eqmonitor_map/lib/src/tile/base_map_tile_cache.dart`
- Modify: `packages/eqmonitor_map/pubspec.yaml`（`pmtiles_v3`を追加）
- Create: `packages/eqmonitor_map/test/tile/base_map_tile_cache_test.dart`
- Create: `packages/eqmonitor_map/test/tile/base_map_tile_decoder_test.dart`

- [ ] `VerifiedPmTilesSource`をFreezedで作る。フィールドは`sourceInstanceId`、`absolutePath`、
      `sizeBytes`、`sha256`だけとする。appが検証済みの値を詰めて渡す契約であることをdoc commentへ
      書く。packageはこの値を再検証せず、manifestを知らない。
- [ ] `BaseMapTileRepository`が`VerifiedPmTilesSource`から`PmTilesV3Archive`を開き、
      `CanonicalTileId`でtile bytesを取る。欠損tileは`null`、破損はtyped errorとして区別して返す。
- [ ] `BaseMapTileDecoder`がtile bytesをMVT decode→Fill/Line meshへ変換する。実行はUI isolate外で
      行う。`compute`または`Isolate.run`のどちらを使うか、`TransferableTypedData`が必要かを、
      実測した転送コストを根拠にdoc commentへ記録する。根拠なく重い機構を入れない。
- [ ] layerごとのFill/Line振り分けは、layer名からlayer specへ引くtableで決める。既存MapLibre実装の
      描画順`background → countriesFill → countriesLine → areaForecastLocalEFill →
      areaForecastLocalEewLine → areaForecastLocalELine → areaInformationCityQuakeLine`を
      `docs/map_spec_v3.md`から読み取り、同じ順序と同じlayer名で構成する。色はこの縦切りでは
      固定値でよいが、値の出所をコメントで示す。
- [ ] `BaseMapTileCache`は`sourceInstanceId`＋`CanonicalTileId`＋整数zoomをkeyにする。camera zoomが
      小数だけ変わったときにcacheを無効化しない。直近使用zoom±1の外を破棄するeviction規則を持ち、
      上限は引数で受け取る。
- [ ] 進行中のdecodeはcamera変更でcancelできるようincarnation tokenを持つ。await前後でtokenを検証し、
      古い結果をcacheへ入れない。cancelをエラーとして扱わない。
- [ ] 未ロードtileのfallbackは子4枚→親1段ずつの順で探す。親探索の段数上限を引数で受け取る。
- [ ] testでcache keyの一致・不一致、小数zoom変化でのcache維持、eviction、token invalidation、
      子→親fallbackの選択順、layer spec tableの順序を検証する。
- [ ] `mise exec -- flutter test test/tile`を実行する。
- [ ] `mise exec -- dart format`を実行し、`Feature: ベースマップtile pipelineを追加`としてコミットする。

## Task 10: デバッグページでpan/zoom付きベースレイヤーを描画する

**Files:**

- Create: `packages/eqmonitor_map/lib/src/widget/base_map_view.dart`
- Modify: `packages/eqmonitor_map/lib/eqmonitor_map.dart`
- Modify: `app/lib/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_debug_page.dart`
- Create: `app/lib/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_debug_source_provider.dart`
- Modify: `packages/eqmonitor_map/README.md`
- Modify: `docs/todo/800_eqmonitor_map_deferred_verification.md`

- [ ] `BaseMapView`を公開する。引数は`VerifiedPmTilesSource source`と`MapCamera initialCamera`、
      および`MapBaseLayerLimits limits`だけとする。controllerを外へ公開しない。
- [ ] pan/pinch zoomのgestureを実装する。rotation gestureは受け取らず北固定にする。min/max zoomを
      引数のlimitsで制限する。gesture中はtile coverの再計算をframeごとに行い、meshの再構築は整数zoom
      境界を跨いだときだけ行う。
- [ ] `MapCamera`変更→tile cover→repository→decoder→cache→Scene nodeの経路を組む。Scene nodeは
      `tile × layer × material`単位とし、feature単位のnodeを作らない。
- [ ] 描画順は`docs/map_spec_v3.md`のlayer順に従う。tile間の順序はtile coverのsortではなく、
      layer順を外側、tile順を内側とする。
- [ ] appのデバッグページで`AssetPackRepository.resolveAsset(AssetPackAssetId.baseMapPmtiles)`から
      検証済み`File`を取り、`VerifiedPmTilesSource`を組んで`BaseMapView`へ渡すProviderを作る。
      Providerは1ファイル1つとする。`AssetPackNotReadyException`はエラー表示へ流し、地図を空で
      描かない。
- [ ] デバッグページに現在のcamera（経度、緯度、zoom）と、表示中tile数、decode中tile数を表示する。
      性能HUDは作らない。
- [ ] `mise exec -- flutter analyze`を`app`と`packages/eqmonitor_map`で実行する。
- [ ] iOSまたはAndroidの実機かsimulatorで、デバッグページを開いてベースレイヤーが描画されること、
      pan/pinch zoomでtileが差し替わること、日本全域から市区町村レベルまでズームできることを確認する。
      確認できた内容と確認できなかった内容をREADMEへ事実として記録する。未確認を確認済みと書かない。
- [ ] `docs/todo/800_eqmonitor_map_deferred_verification.md`へ、この縦切りで先送りした項目
      （properties/feature ID decode、bevel/round join、cap、dash、Douglas-Peucker間引き、
      MVT extent外bufferのscissor、ラベル、remote source、attestation、hit test、性能HUD、
      widget/golden test、6 byte packing）を追記する。
- [ ] `mise exec -- dart format`を実行し、`Feature: デバッグページでPMTilesベースレイヤーを描画`
      としてコミットする。

---

## 完了条件

- デバッグページでAsset Pack配布のベースマップPMTilesがFill/Lineとして描画される。
- pan/pinch zoomでtile coverが追従し、整数zoom境界でmeshが差し替わる。小数zoom変化でmeshを
  再構築しない。
- `mise exec -- flutter analyze`が`app`と`packages/eqmonitor_map`と`packages/pmtiles_v3`で通る。
- Task 2〜9で追加したunit testが通る。
- `packages/seismicity_pmtiles`の既存公開APIと既存testが壊れていない。
- 実機・simulatorでの確認結果がREADMEへ事実として記録されている。
