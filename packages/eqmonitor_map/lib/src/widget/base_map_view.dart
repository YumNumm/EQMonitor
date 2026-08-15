import 'dart:async';
import 'dart:math' as math;

import 'package:eqmonitor_map/src/flutter_scene/base_map_geometry_factory.dart';
import 'package:eqmonitor_map/src/flutter_scene/base_map_material_library.dart';
import 'package:eqmonitor_map/src/geo/map_camera.dart';
import 'package:eqmonitor_map/src/geo/map_mercator_projection.dart';
import 'package:eqmonitor_map/src/geo/map_viewport.dart';
import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/geo/tile_matrix.dart';
import 'package:eqmonitor_map/src/tile/base_map_render_plan_builder.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_cache.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_decoder.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_repository.dart';
import 'package:eqmonitor_map/src/tile/scheduler/map_tile_scheduler.dart';
import 'package:eqmonitor_map/src/tile/tile_cover_calculator.dart';
import 'package:eqmonitor_map/src/tile/verified_pm_tiles_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_scene/scene.dart' as scene;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pmtiles_v3/pmtiles_v3.dart';
import 'package:vector_math/vector_math.dart' as scene_math;

part 'base_map_view.freezed.dart';

/// [BaseMapView]がgestureとtile取得の両方を制限するために使う上限値一式。
/// 呼び出し側(app)が明示し、widget内部に固定fallbackは置かない
/// (Global Constraints「上限値は呼び出し側が渡す`limits`引数で明示する」)。
@freezed
abstract class MapBaseLayerLimits with _$MapBaseLayerLimits {
  const factory MapBaseLayerLimits({
    /// pan/pinch zoom gestureが許すcamera zoomの下限、および
    /// [TileCoverCalculator.cover]へそのまま渡すtile zoomの下限。
    ///
    /// 同じ値を2つの用途に使うのは、この2つが本来同じ「archiveが持つtile
    /// zoom範囲」を指しているため([TileCoverCalculator.cover]のdoc
    /// comment「`minZoom`未満ならfloor後の値を`minZoom`まで引き上げる」)。
    /// gestureの下限だけを別に緩めると、archiveが持たないzoomのtileを
    /// 要求して`PmTilesV3Exception`を招く。
    required int minZoom,

    /// [minZoom]と対になる上限。`maxZoom`を超えるcamera zoomは
    /// [TileCoverCalculator.cover]がoverscale(`canonical.z`を`maxZoom`に
    /// 留めたままtileを拡大表示)で吸収するが、[BaseMapView]はgesture自体を
    /// この値で止めるため、[VerifiedPmTilesSource]が指すarchiveの実際の
    /// `header.maxZoom`と一致させること(一致しない場合、`maxZoom`未満の
    /// gesture操作だけでも実際のarchiveのzoom範囲を超えるtileを要求し得る)。
    required int maxZoom,

    /// [BaseMapTileRepository.open]へ渡すPMTiles archiveの走査上限。
    required PmTilesV3Limits pmTilesLimits,

    /// [BaseMapTileDecoder.decode]へ渡すMVT decode/mesh構築の上限。
    required BaseMapTileDecodeLimits decodeLimits,

    /// [BaseMapTileCache]が保持するdecode済みgeometryの件数上限。
    ///
    /// [BaseMapView]がGPU側に持つ`scene.Mesh`のcache([_TileSceneMeshCache])
    /// も同じ値で件数を制限する。2つのcacheは同じ「一度にどれだけのtileを
    /// 覚えておくか」という運用値を指しているため、別々の上限値を持たせる
    /// 理由がない。
    required int maxCachedTileGeometries,

    /// [BaseMapTileCache.lookupWithFallback]が祖先を遡る最大段数。
    ///
    /// [BaseMapTileCache]のzoom窓(低zoom側)の深さにも同じ値を渡す
    /// (`base_map_tile_cache.dart`の「LRU容量evictionと低zoom祖先の保持の
    /// 相互作用」節参照)。祖先を`lookupWithFallback`が実際に遡れる段数と、
    /// その祖先がcacheの窓から破棄されずに残る段数を分けて設定できても
    /// 意味がない(遡れる段数より深く保持しても使われず、遡れる段数より
    /// 浅くしか保持しなければ遡っても見つからない)ため、1つの値を両方へ
    /// 渡す。
    required int maxParentFallbackSteps,

    /// 同時に走らせる tile decode の上限([MapTileScheduler]へ渡す)。
    ///
    /// 1 frame の cover に含まれる欠損 tile 全部へ無制限に `Isolate.run` decode を
    /// 張ると、cover が大きく変わった瞬間に多数の isolate を同時 spawn して
    /// resource を圧迫する。この値で同時 decode を頭打ちにし、decode 完了ごとに
    /// 次の欠損 tile を中心近傍優先で開始する(backpressure)。
    required int maxInFlightDecodes,
  }) = _MapBaseLayerLimits;
}

/// 検証済みPMTiles archiveから、pan/pinch zoom付きでベースレイヤー
/// (Fill/Line)を描画するwidget。
///
/// 公開引数は[source]・[initialCamera]・[limits]の3つだけであり、内部で
/// 保持するcamera状態やFlutter Sceneのcontroller/[scene.Scene]は外へ
/// 公開しない(brief要求)。`initialCamera`は最初のフレームにしか使わず、
/// 後から[BaseMapView]が再構築されても(同じ[source]/[limits]である限り)
/// 現在のcamera状態を保つ。
class BaseMapView extends HookWidget {
  const BaseMapView({
    required this.source,
    required this.initialCamera,
    required this.limits,
    super.key,
  });

  // 検証済みPMTiles archiveの入力値そのものであり、Flutter Inspector越しの
  // 検査対象ではない。
  // ignore: diagnostic_describe_all_properties
  final VerifiedPmTilesSource source;

  // 最初のフレームにしか使わない起動値であり、Flutter Inspector越しの
  // 検査対象ではない。
  // ignore: diagnostic_describe_all_properties
  final MapCamera initialCamera;

  // gesture/tile取得の上限値の入力値そのものであり、Flutter Inspector越しの
  // 検査対象ではない。
  // ignore: diagnostic_describe_all_properties
  final MapBaseLayerLimits limits;

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(
      () => _BaseMapController(
        source: source,
        limits: limits,
        initialCamera: initialCamera,
      ),
      [source, limits],
    );
    useEffect(() => controller.dispose, [controller]);
    useListenable(controller);

    useEffect(() {
      unawaited(controller.initialize());
      return null;
    }, [controller]);

    final logicalSize = MediaQuery.sizeOf(context);
    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
    useEffect(() {
      if (logicalSize.width <= 0 || logicalSize.height <= 0) {
        return null;
      }
      controller.updateViewport(
        MapViewport(
          logicalSize: logicalSize,
          devicePixelRatio: devicePixelRatio,
        ),
      );
      return null;
    }, [controller, logicalSize, devicePixelRatio]);

    final initError = controller.initError;
    if (initError != null) {
      return _BaseMapViewError(error: initError);
    }
    if (!controller.isReady) {
      return const Center(child: CircularProgressIndicator());
    }

    return ColoredBox(
      color: controller.backgroundColor,
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onScaleStart: (_) => controller.beginGesture(),
              onScaleUpdate: (details) => controller.updateGesture(
                cumulativeScale: details.scale,
                focalPointDelta: details.focalPointDelta,
                focalPoint: details.localFocalPoint,
              ),
              onScaleEnd: (_) => controller.endGesture(),
              child: scene.SceneView(
                controller.sceneGraph,
                camera: controller.camera,
              ),
            ),
          ),
          Positioned(
            left: 12,
            right: 12,
            bottom: 12,
            child: _BaseMapDebugHud(controller: controller),
          ),
        ],
      ),
    );
  }
}

class _BaseMapViewError extends StatelessWidget {
  const _BaseMapViewError({required this.error});

  // privateなdebug表示専用のwidgetであり、Flutter Inspector越しの検査対象
  // ではない。
  // ignore: diagnostic_describe_all_properties
  final Object error;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          'ベースレイヤーの初期化に失敗しました: $error',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.error,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _BaseMapDebugHud extends StatelessWidget {
  const _BaseMapDebugHud({required this.controller});

  // privateなdebug表示専用のwidgetであり、Flutter Inspector越しの検査対象
  // ではない。
  // ignore: diagnostic_describe_all_properties
  final _BaseMapController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final camera = controller.camera_;
    return Material(
      color: theme.colorScheme.surface.withValues(alpha: 0.94),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 12,
          runSpacing: 4,
          children: [
            Text('lng=${camera.centerLongitude.toStringAsFixed(3)}'),
            Text('lat=${camera.centerLatitude.toStringAsFixed(3)}'),
            Text('zoom=${camera.zoom.toStringAsFixed(2)}'),
            Text('visibleTiles=${controller.visibleTileCount}'),
            Text('decoding=${controller.pendingDecodeCount}'),
          ],
        ),
      ),
    );
  }
}

/// gesture・decode・Scene node管理を持つ内部controller。[BaseMapView]の外へは
/// 公開しない(brief要求)。
class _BaseMapController extends ChangeNotifier {
  _BaseMapController({
    required this.source,
    required this.limits,
    required MapCamera initialCamera,
  }) : _camera = initialCamera;

  final VerifiedPmTilesSource source;
  final MapBaseLayerLimits limits;

  final sceneGraph = scene.Scene();

  // camera/projectionは各tileのnodeへ焼き込む
  // (`baseMapTileViewProjectionMatrixFor`)ため、
  // Scene側のcameraは何も変換しない恒等camera一つで足りる
  // (`_IdentityCameraProjection`のdoc comment参照)。
  final camera = scene.NodeCamera(
    scene.Node(),
    const _IdentityCameraProjection(),
  );

  late final _cache = BaseMapTileCache(
    maxEntries: limits.maxCachedTileGeometries,
    maxParentFallbackSteps: limits.maxParentFallbackSteps,
  );
  late final _sceneMeshCache = _TileSceneMeshCache(
    maxEntries: limits.maxCachedTileGeometries,
  );
  late final _scheduler = MapTileScheduler(
    maxInFlightDecodes: limits.maxInFlightDecodes,
  );
  static const _decoder = BaseMapTileDecoder();
  static const _geometryFactory = BaseMapGeometryFactory();

  // Line layerの半線幅(全layer共通)。`docs/map_spec_v3.md`は線幅もzoomで
  // 変化させるが、Task 10のスコープでは固定値のdebug描画とする。
  static const _debugLineHalfWidthLogicalPixels = 1.0;

  MapCamera _camera;
  MapViewport? _viewport;
  BaseMapTileRepository? _repository;

  /// `styleLayerId`ごとに独立した`scene.PreprocessedMaterial`。
  /// `baseMapLayerSpecs`の`color`をlayerごとに反映するため、fill/line
  /// それぞれ1つを全layerで共有していた旧実装から変更した
  /// (`base_map_material_library.dart`のdoc comment参照)。
  Map<String, scene.PreprocessedMaterial>? _materialsByStyleLayerId;
  Object? _initError;
  var _isReady = false;
  var _isDisposed = false;
  var _visibleTileCount = 0;

  final _pendingDecodes = <CanonicalTileId>{};
  final _knownAbsentTiles = <CanonicalTileId>{};

  double? _gestureStartZoom;

  Object? get initError => _initError;
  bool get isReady => _isReady;
  int get visibleTileCount => _visibleTileCount;
  int get pendingDecodeCount => _pendingDecodes.length;

  /// HUD表示専用の読み取り。widgetの`camera`(`scene.NodeCamera`)と名前が
  /// 衝突するため`camera_`にしている。
  MapCamera get camera_ => _camera;

  Color get backgroundColor => baseMapLayerSpecs
      .firstWhere((spec) => spec.kind == BaseMapLayerKind.background)
      .color;

  /// [_viewport]がまだ設定されていない場合に[initialize]がmaterial生成時
  /// だけ使う暫定値。`_refresh`は`viewport == null`の間nodeを一切追加しない
  /// (`_refresh`の早期returnを参照)ため、この値で計算された
  /// `half_width_ndc`が実際に画面へ出ることはなく、最初の`updateViewport`
  /// 呼び出しで(`initialize`完了時の再適用、または以後の`updateViewport`
  /// 自体が持つ再適用ロジックにより)即座に正しい値へ上書きされる。
  static final _placeholderViewportBeforeFirstUpdate = MapViewport(
    logicalSize: const Size(1, 1),
    devicePixelRatio: 1,
  );

  Future<void> initialize() async {
    try {
      await scene.Scene.initializeStaticResources();
      final materialsByStyleLayerId = <String, scene.PreprocessedMaterial>{};
      final viewportForInitialLoad =
          _viewport ?? _placeholderViewportBeforeFirstUpdate;
      for (final spec in baseMapLayerSpecs) {
        switch (spec.kind) {
          case BaseMapLayerKind.background:
            // backgroundはtileのmaterialを持たない(`ColoredBox`側で描く)。
            continue;
          case BaseMapLayerKind.fill:
            materialsByStyleLayerId[spec.styleLayerId] =
                await BaseMapMaterialLibrary.loadFillMaterial(
                  color: spec.color,
                );
          case BaseMapLayerKind.line:
            materialsByStyleLayerId[spec.styleLayerId] =
                await BaseMapMaterialLibrary.loadLineMaterial(
                  color: spec.color,
                  halfWidthLogicalPixels: _debugLineHalfWidthLogicalPixels,
                  viewport: viewportForInitialLoad,
                );
        }
      }
      final repository = await BaseMapTileRepository.open(
        source: source,
        limits: limits.pmTilesLimits,
      );
      if (_isDisposed) {
        await repository.close();
        return;
      }
      _materialsByStyleLayerId = materialsByStyleLayerId;
      _repository = repository;
      _isReady = true;
      // `_viewport`がここまでの間(loadLineMaterialの非同期処理中)に
      // 判明していれば、暫定値で焼き込んだ`half_width_ndc`を正しい値へ
      // 上書きする。`_refresh`はこの後に呼ぶため、上書き前にnodeが
      // 構築されることはない。
      final viewport = _viewport;
      if (viewport != null) {
        _applyLineHalfWidthToAllMaterials(viewport);
      }
      _refresh();
      // 初期化失敗の原因はGPU初期化・material読み込み・archive openなど
      // 多岐にわたり、握り潰さずそのまま`_initError`へ入れてUIへ出すために
      // 型を問わず受け止める。
      // ignore: avoid_catches_without_on_clauses
    } catch (error) {
      _initError = error;
    } finally {
      if (!_isDisposed) {
        notifyListeners();
      }
    }
  }

  void updateViewport(MapViewport viewport) {
    if (_viewport == viewport) {
      return;
    }
    _viewport = viewport;
    // NDC単位の半線幅はviewportのlogical sizeに依存するため、resizeや
    // 画面回転でviewportが変わる度に再計算して既存materialへ反映する
    // (`base_map_material_library.dart`の`halfLineWidthNdcFor`doc comment
    // 参照)。
    _applyLineHalfWidthToAllMaterials(viewport);
    _refresh();
    notifyListeners();
  }

  /// 全line layerのmaterialへ、[viewport]から求め直した`half_width_ndc`を
  /// 再適用する。materialがまだ`initialize`で構築されていなければ何もしない
  /// (`initialize`側がその後で改めて呼ぶ)。
  void _applyLineHalfWidthToAllMaterials(MapViewport viewport) {
    final materialsByStyleLayerId = _materialsByStyleLayerId;
    if (materialsByStyleLayerId == null) {
      return;
    }
    for (final spec in baseMapLayerSpecs) {
      if (spec.kind != BaseMapLayerKind.line) {
        continue;
      }
      final material = materialsByStyleLayerId[spec.styleLayerId];
      if (material == null) {
        continue;
      }
      BaseMapMaterialLibrary.setLineHalfWidth(
        material: material,
        halfWidthLogicalPixels: _debugLineHalfWidthLogicalPixels,
        viewport: viewport,
      );
    }
  }

  void beginGesture() {
    _gestureStartZoom = _camera.zoom;
  }

  void updateGesture({
    required double cumulativeScale,
    required Offset focalPointDelta,
    required Offset focalPoint,
  }) {
    final gestureStartZoom = _gestureStartZoom;
    if (gestureStartZoom == null) {
      return;
    }
    _camera = cameraAfterGestureUpdate(
      camera: _camera,
      gestureStartZoom: gestureStartZoom,
      cumulativeScale: cumulativeScale,
      focalPointDelta: focalPointDelta,
      focalPoint: focalPoint,
      viewportLogicalSize: _viewport?.logicalSize,
      minZoom: limits.minZoom,
      maxZoom: limits.maxZoom,
    );
    _refresh();
    notifyListeners();
  }

  void endGesture() {
    _gestureStartZoom = null;
  }

  void _refresh() {
    final viewport = _viewport;
    if (!_isReady || viewport == null) {
      return;
    }
    final cover = TileCoverCalculator.cover(
      camera: _camera,
      viewport: viewport,
      minZoom: limits.minZoom,
      maxZoom: limits.maxZoom,
    );
    _visibleTileCount = cover.length;
    _cache.noteActiveZoom(
      canonicalZoomFor(
        zoom: _camera.zoom,
        minZoom: limits.minZoom,
        maxZoom: limits.maxZoom,
      ),
    );
    _rebuildSceneNodes(cover: cover, viewport: viewport);
    _requestMissingDecodes(cover);
  }

  void _rebuildSceneNodes({
    required List<OverscaledTileId> cover,
    required MapViewport viewport,
  }) {
    final materialsByStyleLayerId = _materialsByStyleLayerId;
    if (materialsByStyleLayerId == null) {
      return;
    }
    final plans = buildBaseMapRenderPlans(
      requestedCover: cover,
      sourceInstanceId: source.cacheIdentity,
      cache: _cache,
      maxParentSteps: limits.maxParentFallbackSteps,
      zoom: _camera.zoom,
    );
    final transformCache = <(UnwrappedTileId, int), scene_math.Matrix4>{};
    scene_math.Matrix4 transformFor(BaseMapTileTransformInput input) =>
        transformCache.putIfAbsent(
          (input.tileId, input.extent),
          () => scene_math.Matrix4.fromList(
            baseMapTileViewProjectionMatrixFor(
              camera: _camera,
              viewport: viewport,
              tileId: input.tileId,
              zoom: input.zoom,
              extent: input.extent,
            ).storage,
          ),
        );
    final nodes = <scene.Node>[
      for (final plan in plans)
        ..._nodesFor(
          plan: plan,
          materialsByStyleLayerId: materialsByStyleLayerId,
          transform: transformFor(plan.transformInput),
        ),
    ];
    sceneGraph
      ..removeAll()
      ..addAll(nodes);
  }

  Iterable<scene.Node> _nodesFor({
    required BaseMapLayerRenderPlan plan,
    required Map<String, scene.PreprocessedMaterial> materialsByStyleLayerId,
    required scene_math.Matrix4 transform,
  }) {
    final meshesByLayer = _sceneMeshCache.getOrBuild(
      sourceInstanceId: source.cacheIdentity,
      tileId: plan.transformInput.tileId.canonical,
      geometry: plan.tileGeometry,
      geometryFactory: _geometryFactory,
      materialsByStyleLayerId: materialsByStyleLayerId,
    );
    final meshes = meshesByLayer[plan.layerGeometry.styleLayerId];
    if (meshes == null || meshes.isEmpty) {
      return const [];
    }
    return [
      for (final mesh in meshes)
        scene.Node(localTransform: transform, mesh: mesh),
    ];
  }

  void _requestMissingDecodes(List<OverscaledTileId> cover) {
    final repository = _repository;
    if (repository == null) {
      return;
    }
    // 既に decode 済み(cache hit)/欠損確定の tile は scheduler の対象外にする。
    final completed = <CanonicalTileId>{
      for (final tile in cover)
        if (_knownAbsentTiles.contains(tile.canonical) ||
            _cache.get(
                  sourceInstanceId: source.cacheIdentity,
                  tileId: tile.canonical,
                ) !=
                null)
          tile.canonical,
    };
    // scheduler が中心近傍優先・canonical 単位の coalesce・backpressure を適用し、
    // 今 frame で開始してよい分だけ返す。残りは decode 完了ごとに `_refresh`→
    // `_requestMissingDecodes` が再評価して順に開始する(drain ループ)。
    final toStart = _scheduler.selectNext(
      coverOrdered: [for (final tile in cover) tile.toUnwrapped()],
      inFlight: _pendingDecodes,
      completed: completed,
    );
    for (final tile in toStart) {
      final tileId = tile.canonical;
      _pendingDecodes.add(tileId);
      unawaited(_decodeTile(repository: repository, tileId: tileId));
    }
  }

  Future<void> _decodeTile({
    required BaseMapTileRepository repository,
    required CanonicalTileId tileId,
  }) async {
    final token = _cache.beginDecode();
    try {
      final bytes = await repository.readTile(tileId);
      if (bytes == null) {
        // sparse archiveの正当な欠損。このarchiveは差し替わらないため、
        // 同じtileを永続的に既知の欠損として扱い、pan中に何度も再読込
        // しない。
        _knownAbsentTiles.add(tileId);
        return;
      }
      final geometry = await _decoder.decode(
        tileBytes: bytes,
        limits: limits.decodeLimits,
      );
      _cache.put(
        sourceInstanceId: source.cacheIdentity,
        tileId: tileId,
        geometry: geometry,
        token: token,
      );
      // 壊れたtile 1枚のdecode失敗でwidget全体を落とさない。ログにだけ残し、
      // このtileは`BaseMapTileFallbackMiss`のまま(祖先/子があれば
      // fallback表示のまま)描かれない。
      // ignore: avoid_catches_without_on_clauses
    } catch (error) {
      debugPrint('BaseMapView: failed to decode tile $tileId: $error');
    } finally {
      _pendingDecodes.remove(tileId);
      if (!_isDisposed) {
        _refresh();
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    if (_isDisposed) {
      return;
    }
    _isDisposed = true;
    _cache.dispose();
    _sceneMeshCache.clear();
    unawaited(_repository?.close());
    sceneGraph.removeAll();
    super.dispose();
  }
}

/// 何も変換しないcamera projection。各tileのnodeにcamera/projectionを
/// 焼き込んだ完成済みのclip座標(`baseMapTileViewProjectionMatrixFor`)を
/// 持たせるため、
/// Scene側のcameraが二重に変換をかけないようにする。
class _IdentityCameraProjection implements scene.CameraProjection {
  const _IdentityCameraProjection();

  @override
  scene_math.Matrix4 getProjectionMatrix(double aspectRatio) =>
      scene_math.Matrix4.identity();
}

/// decode済み[BaseMapTileGeometry]から作った`scene.Mesh`(GPU geometry +
/// material)のcache。
///
/// [BaseMapTileCache]が保持するのは`FillMesh`/`LineMesh`という生の頂点列
/// までで、GPUへのアップロード(`scene.MeshGeometry.fromArrays`)はここでは
/// 行わない([BaseMapTileCache]は`app`はおろか`flutter_scene`にも依存しない
/// 層のため)。このcacheは同じ(sourceInstanceId, CanonicalTileId)に対して
/// GPUアップロードを1回しか行わないための、Task 10側の追加cacheであり、
/// 「meshの再構築は整数zoom境界を跨いだときだけ行う」という制約を、
/// gestureのたびに呼ばれる`_rebuildSceneNodes`から見て満たす
/// (`_rebuildSceneNodes`は毎frame呼ばれ得るが、同じtileが要求され続ける限り
/// ここでhitし続け、GPU再アップロードは起きない)。
class _TileSceneMeshCache {
  _TileSceneMeshCache({required this.maxEntries})
    : assert(maxEntries > 0, 'maxEntries must be positive');

  final int maxEntries;
  final _entries = <(String, CanonicalTileId), Map<String, List<scene.Mesh>>>{};

  Map<String, List<scene.Mesh>> getOrBuild({
    required String sourceInstanceId,
    required CanonicalTileId tileId,
    required BaseMapTileGeometry geometry,
    required BaseMapGeometryFactory geometryFactory,
    required Map<String, scene.PreprocessedMaterial> materialsByStyleLayerId,
  }) {
    final key = (sourceInstanceId, tileId);
    final cached = _entries[key];
    if (cached != null) {
      return cached;
    }
    final built = <String, List<scene.Mesh>>{
      for (final layer in geometry.layers)
        layer.styleLayerId: switch (layer) {
          BaseMapTileFillLayerGeometry(:final meshes) => [
            for (final mesh in meshes)
              scene.Mesh(
                geometryFactory.fillGeometry(mesh),
                materialsByStyleLayerId[layer.styleLayerId]!,
              ),
          ],
          BaseMapTileLineLayerGeometry(:final meshes) => [
            for (final mesh in meshes)
              scene.Mesh(
                geometryFactory.lineGeometry(mesh),
                materialsByStyleLayerId[layer.styleLayerId]!,
              ),
          ],
        },
    };
    _entries[key] = built;
    if (_entries.length > maxEntries) {
      _entries.remove(_entries.keys.first);
    }
    return built;
  }

  void clear() => _entries.clear();
}

/// pan/pinch zoom gestureの1回の`onScaleUpdate`から次の[MapCamera]を計算する
/// pure関数。widget testを避けるため(Global Constraints)、`GestureDetector`の
/// callbackから計算そのものを分離している。
///
/// [cumulativeScale]は`ScaleUpdateDetails.scale`(gesture開始からの累積値)
/// をそのまま渡す想定で、zoomは[gestureStartZoom]からの差分として
/// 再計算する(累積値からの再計算により、frameごとの誤差が蓄積しない)。
/// [focalPointDelta]は`ScaleUpdateDetails.focalPointDelta`(直前の
/// callbackからの差分)をそのまま渡す想定で、pan量として累積的に
/// [camera]へ適用する。rotationは引数として受け取らない
/// (北固定、brief要求)。
///
/// 画面pixelとworld pixelの換算係数が1であること
/// (`base_map_material_library.dart`の`halfLineWidthWorldFor`のdoc
/// comment参照)を使い、[focalPointDelta]を[camera]のzoomにおけるworld
/// pixel量としてそのままworld中心へ加算する。
///
/// [focalPoint]は`ScaleUpdateDetails.localFocalPoint`(2本指の中間点、
/// widget-local座標)、[viewportLogicalSize]はその widget の logical size。
/// **両方を渡したときだけ zoom が焦点基準になる。** [MapCamera]は中心と
/// zoomでしか定義されないため、焦点を渡さないと zoom は必然的に画面中央
/// 基準になり、指の下の地点が中央へ滑る。
///
/// 焦点固定は正規化world座標(zoom非依存)で行う。pan適用後の焦点直下の
/// 地点を求め、**clamp後の**zoomにおけるworldサイズで、その地点が同じ
/// 画面位置に来るような中心を逆算する。clamp前のzoomでアンカーを計算
/// すると、zoom上限に張り付いたまま指を動かしたときに地図が滑る。
MapCamera cameraAfterGestureUpdate({
  required MapCamera camera,
  required double gestureStartZoom,
  required double cumulativeScale,
  required Offset focalPointDelta,
  required int minZoom,
  required int maxZoom,
  Offset? focalPoint,
  Size? viewportLogicalSize,
  MapMercatorProjection projection = const MapMercatorProjection(),
}) {
  final worldSize = projection.worldSizeForZoom(camera.zoom);
  final worldCenter = camera.worldCenter(projection: projection);
  final pannedWorldCenter = (
    x: worldCenter.x - focalPointDelta.dx,
    y: worldCenter.y - focalPointDelta.dy,
  );
  final unclampedZoom = gestureStartZoom + _log2(cumulativeScale);
  final clampedZoom = unclampedZoom.clamp(
    minZoom.toDouble(),
    maxZoom.toDouble(),
  );

  // 焦点の画面中央からのずれ。1 logical pixel == 1 world pixel なので
  // そのまま world 上のずれとして扱える。
  final fromCenter = (focalPoint == null || viewportLogicalSize == null)
      ? Offset.zero
      : focalPoint -
            Offset(
              viewportLogicalSize.width / 2,
              viewportLogicalSize.height / 2,
            );

  final anchorNormalized = (
    x: (pannedWorldCenter.x + fromCenter.dx) / worldSize,
    y: (pannedWorldCenter.y + fromCenter.dy) / worldSize,
  );
  final zoomedWorldSize = projection.worldSizeForZoom(clampedZoom);
  final zoomedWorldCenter = (
    x: anchorNormalized.x * zoomedWorldSize - fromCenter.dx,
    y: anchorNormalized.y * zoomedWorldSize - fromCenter.dy,
  );

  final lngLat = projection.normalizedToLngLat(
    x: zoomedWorldCenter.x / zoomedWorldSize,
    y: zoomedWorldCenter.y / zoomedWorldSize,
  );
  return MapCamera(
    centerLongitude: lngLat.longitude,
    centerLatitude: lngLat.latitude,
    zoom: clampedZoom,
  );
}

double _log2(double value) => math.log(value) / math.ln2;

/// [TileCoverCalculator.cover]が内部で使うのと同じ、
/// 「floorしたcamera zoomをtile zoom範囲へclampする」計算。`cover`の結果に
/// 依存せず`BaseMapTileCache.noteActiveZoom`へ渡す値を求められるようpure
/// 関数として切り出している。
int canonicalZoomFor({
  required double zoom,
  required int minZoom,
  required int maxZoom,
}) {
  final flooredZoom = zoom.floor();
  final overscaledZ = flooredZoom < minZoom ? minZoom : flooredZoom;
  return overscaledZ > maxZoom ? maxZoom : overscaledZ;
}
