import 'dart:async';
import 'dart:math' as math;

import 'package:eqmonitor_map/src/flutter_scene/base_map_geometry_factory.dart';
import 'package:eqmonitor_map/src/flutter_scene/base_map_material_library.dart';
import 'package:eqmonitor_map/src/geo/map_camera.dart';
import 'package:eqmonitor_map/src/geo/map_mercator_projection.dart';
import 'package:eqmonitor_map/src/geo/map_viewport.dart';
import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/geo/tile_matrix.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_cache.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_decoder.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_repository.dart';
// `mvtDefaultExtent`だけを使う。`BaseMapTileGeometry`はどの`extent`で
// decodeしたかを保持しない([BaseMapTileLayerGeometry]参照)ため、Task 10は
// tile側と同じ既定値をtile行列へそのまま渡すしかない
// ([mvtDefaultExtent]のdoc comment、`docs/map_spec_v3.md`が前提とする
// tippecanoe既定出力と一致)。
import 'package:eqmonitor_map/src/tile/mvt/mvt_decoder.dart'
    show mvtDefaultExtent;
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
    required int maxParentFallbackSteps,
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

  // camera/projectionは各tileのnodeへ焼き込む(`_combinedTransformFor`)ため、
  // Scene側のcameraは何も変換しない恒等camera一つで足りる
  // (`_IdentityCameraProjection`のdoc comment参照)。
  final camera = scene.NodeCamera(
    scene.Node(),
    const _IdentityCameraProjection(),
  );

  late final _cache = BaseMapTileCache(
    maxEntries: limits.maxCachedTileGeometries,
  );
  late final _sceneMeshCache = _TileSceneMeshCache(
    maxEntries: limits.maxCachedTileGeometries,
  );
  static const _decoder = BaseMapTileDecoder();
  static const _geometryFactory = BaseMapGeometryFactory();

  // debug描画専用の単色。`BaseMapMaterialLibrary`はtile×layerで新しい
  // materialを作らず`fillMaterial`/`lineMaterial`の2つだけを共有するため
  // (`base_map_material_library.dart`のdoc comment)、layerごとに
  // `docs/map_spec_v3.md`が定義する色を出し分けることはできない。
  // `baseMapLayerSpecs`が定義する色のうち、最下段の`countries`行の色を
  // 代表として使う。
  static final Color _debugFillColor = baseMapLayerSpecs
      .firstWhere((spec) => spec.styleLayerId == 'countriesFill')
      .color;
  static final Color _debugLineColor = baseMapLayerSpecs
      .firstWhere((spec) => spec.styleLayerId == 'countriesLine')
      .color;
  static const _debugLineHalfWidthLogicalPixels = 1.0;

  MapCamera _camera;
  MapViewport? _viewport;
  BaseMapTileRepository? _repository;
  BaseMapMaterialLibrary? _materials;
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

  Future<void> initialize() async {
    try {
      await scene.Scene.initializeStaticResources();
      final materials = await BaseMapMaterialLibrary.load();
      materials
        ..setFillColor(_debugFillColor)
        ..setLineColor(_debugLineColor)
        ..setLineHalfWidth(
          halfWidthLogicalPixels: _debugLineHalfWidthLogicalPixels,
        );
      final repository = await BaseMapTileRepository.open(
        source: source,
        limits: limits.pmTilesLimits,
      );
      if (_isDisposed) {
        await repository.close();
        return;
      }
      _materials = materials;
      _repository = repository;
      _isReady = true;
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
    _refresh();
    notifyListeners();
  }

  void beginGesture() {
    _gestureStartZoom = _camera.zoom;
  }

  void updateGesture({
    required double cumulativeScale,
    required Offset focalPointDelta,
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
    final materials = _materials;
    if (materials == null) {
      return;
    }
    final resolved = [
      for (final tile in cover)
        (
          tile: tile,
          result: _cache.lookupWithFallback(
            sourceInstanceId: source.sourceInstanceId,
            tileId: tile.canonical,
            maxParentSteps: limits.maxParentFallbackSteps,
          ),
        ),
    ];
    final transformCache = <(int, CanonicalTileId), scene_math.Matrix4>{};
    scene_math.Matrix4 transformFor(int wrap, CanonicalTileId tileId) =>
        transformCache.putIfAbsent(
          (wrap, tileId),
          () => _combinedTransformFor(
            wrap: wrap,
            tileId: tileId,
            viewport: viewport,
          ),
        );

    // 描画順はlayer順を外側、tile順を内側にする(`docs/map_spec_v3.md`の
    // layer順に従う。tile側のsortには依存しない)。
    final nodes = <scene.Node>[];
    for (final spec in baseMapLayerSpecs) {
      if (spec.kind == BaseMapLayerKind.background) {
        // backgroundはtileを持たない全画面色であり、`ColoredBox`側で描く。
        continue;
      }
      for (final entry in resolved) {
        switch (entry.result) {
          case BaseMapTileFallbackMiss():
            continue;
          case BaseMapTileFallbackExact(:final geometry):
            nodes.addAll(
              _nodesFor(
                spec: spec,
                wrap: entry.tile.wrap,
                tileId: entry.tile.canonical,
                geometry: geometry,
                materials: materials,
                transform: transformFor(entry.tile.wrap, entry.tile.canonical),
              ),
            );
          case BaseMapTileFallbackParent(:final geometry, :final tileId):
            nodes.addAll(
              _nodesFor(
                spec: spec,
                wrap: entry.tile.wrap,
                tileId: tileId,
                geometry: geometry,
                materials: materials,
                transform: transformFor(entry.tile.wrap, tileId),
              ),
            );
          case BaseMapTileFallbackChildren(:final children):
            final childIds = entry.tile.canonical.children();
            for (var i = 0; i < children.length; i++) {
              nodes.addAll(
                _nodesFor(
                  spec: spec,
                  wrap: entry.tile.wrap,
                  tileId: childIds[i],
                  geometry: children[i],
                  materials: materials,
                  transform: transformFor(entry.tile.wrap, childIds[i]),
                ),
              );
            }
        }
      }
    }
    sceneGraph
      ..removeAll()
      ..addAll(nodes);
  }

  Iterable<scene.Node> _nodesFor({
    required BaseMapLayerSpec spec,
    required int wrap,
    required CanonicalTileId tileId,
    required BaseMapTileGeometry geometry,
    required BaseMapMaterialLibrary materials,
    required scene_math.Matrix4 transform,
  }) {
    final meshesByLayer = _sceneMeshCache.getOrBuild(
      sourceInstanceId: source.sourceInstanceId,
      tileId: tileId,
      geometry: geometry,
      geometryFactory: _geometryFactory,
      materials: materials,
    );
    final meshes = meshesByLayer[spec.styleLayerId];
    if (meshes == null || meshes.isEmpty) {
      return const [];
    }
    return [
      for (final mesh in meshes)
        scene.Node(localTransform: transform, mesh: mesh),
    ];
  }

  scene_math.Matrix4 _combinedTransformFor({
    required int wrap,
    required CanonicalTileId tileId,
    required MapViewport viewport,
  }) {
    final combined =
        viewProjectionMatrixFor(camera: _camera, viewport: viewport).multiplied(
          tileMatrixFor(
            tileId: UnwrappedTileId(wrap: wrap, canonical: tileId),
            zoom: _camera.zoom,
            extent: mvtDefaultExtent,
          ),
        );
    // double精度のまま合成した後に一度だけfloat32へ丸める
    // (`geo/tile_matrix.dart`のdoc comment「tile側だけを先にfloat32へ丸める
    // と...rebasingの意味が失われる」)。`Matrix4.fromList`は
    // `FlutterSceneOrthographicProjection`と同じ変換方法。
    return scene_math.Matrix4.fromList(combined.storage);
  }

  void _requestMissingDecodes(List<OverscaledTileId> cover) {
    final repository = _repository;
    if (repository == null) {
      return;
    }
    for (final tile in cover) {
      final tileId = tile.canonical;
      if (_pendingDecodes.contains(tileId) ||
          _knownAbsentTiles.contains(tileId)) {
        continue;
      }
      if (_cache.get(
            sourceInstanceId: source.sourceInstanceId,
            tileId: tileId,
          ) !=
          null) {
        continue;
      }
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
        sourceInstanceId: source.sourceInstanceId,
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
/// 焼き込んだ完成済みのclip座標(`_combinedTransformFor`)を持たせるため、
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
    required BaseMapMaterialLibrary materials,
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
                materials.fillMaterial,
              ),
          ],
          BaseMapTileLineLayerGeometry(:final meshes) => [
            for (final mesh in meshes)
              scene.Mesh(
                geometryFactory.lineGeometry(mesh),
                materials.lineMaterial,
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
MapCamera cameraAfterGestureUpdate({
  required MapCamera camera,
  required double gestureStartZoom,
  required double cumulativeScale,
  required Offset focalPointDelta,
  required int minZoom,
  required int maxZoom,
  MapMercatorProjection projection = const MapMercatorProjection(),
}) {
  final worldSize = projection.worldSizeForZoom(camera.zoom);
  final worldCenter = camera.worldCenter(projection: projection);
  final pannedWorldCenter = (
    x: worldCenter.x - focalPointDelta.dx,
    y: worldCenter.y - focalPointDelta.dy,
  );
  final pannedLngLat = projection.normalizedToLngLat(
    x: pannedWorldCenter.x / worldSize,
    y: pannedWorldCenter.y / worldSize,
  );
  final unclampedZoom = gestureStartZoom + _log2(cumulativeScale);
  final clampedZoom = unclampedZoom.clamp(
    minZoom.toDouble(),
    maxZoom.toDouble(),
  );
  return MapCamera(
    centerLongitude: pannedLngLat.longitude,
    centerLatitude: pannedLngLat.latitude,
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
