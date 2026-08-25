import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/clock/map_clock_source_identity_provider.dart';
import 'package:eqmonitor/core/util/map/app_map_clock.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/latest_earthquake_overlay_provider.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_camera_action.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_debug_overlay_layout.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_gpu_probe_action.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_gpu_probe_panel.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_debug_source_provider.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_overlay_banner.dart';
import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// `docs/superpowers/plans/2026-08-05-eqmonitor-map-base-layer-pmtiles.md`
/// のTask 1〜9が組んだtile pipelineを`BaseMapView`で実際に描画するデバッグ
/// ページ。zoom範囲(`minZoom`/`maxZoom`)は`eqmonitorMapDebugSourceProvider`
/// が実際のarchiveの`PmTilesV3Header`から読んだ値をそのまま使う。固定値を
/// 転記しない理由は`eqmonitor_map_debug_source_provider.dart`の
/// `_readHeader`のdoc comment参照。
class EqmonitorMapDebugPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) => switch (mapGpuProbeCompileTimeEnabled) {
    true => const _EqmonitorMapGpuProbeDebugPage(),
    false => const _EqmonitorMapDebugContent(probeBindings: null),
  };
}

class _EqmonitorMapGpuProbeDebugPage extends HookConsumerWidget {
  const new();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final atlasFixture = useState(MapSpriteAtlasProbeFixture.production);
    final faultPoint = useState<MapGpuFaultPoint?>(null);
    final counterSnapshot = useState<MapGpuResourceCounterSnapshot?>(null);
    final probeController = useMemoized(MapGpuProbeController.new, const []);
    final configuration = useMemoized(
      () => MapGpuProbeConfiguration(
        faultPoint: faultPoint.value,
        atlasFixture: atlasFixture.value,
      ),
      [faultPoint.value, atlasFixture.value],
    );
    final counterCallbackGuard = useMemoized(
      () => EqmonitorMapDebugGpuCounterCallbackGuard(
        isMounted: () => context.mounted,
        onSnapshot: (snapshot) => counterSnapshot.value = snapshot,
      ),
      const [],
    );
    return _EqmonitorMapDebugContent(
      probeBindings: _EqmonitorMapGpuProbeBindings(
        configuration: configuration,
        controller: probeController,
        counterSnapshot: counterSnapshot.value,
        onCounterChanged: counterCallbackGuard.publish,
        onAtlasFixtureChanged: (value) {
          final next = ref
              .read(eqmonitorMapGpuProbeActionProvider)
              .withAtlasFixture(
                currentConfiguration: configuration,
                atlasFixture: value,
              );
          atlasFixture.value = next.atlasFixture;
        },
        onFaultPointChanged: (value) {
          final next = ref
              .read(eqmonitorMapGpuProbeActionProvider)
              .withFaultPoint(
                currentConfiguration: configuration,
                faultPoint: value,
              );
          faultPoint.value = next.faultPoint;
        },
        onInvalidateRendererContextGeneration: () {
          final result = ref
              .read(eqmonitorMapGpuProbeActionProvider)
              .invalidateRendererContextGeneration(controller: probeController);
          final message = switch (result) {
            EqmonitorMapGpuProbeInvalidationSucceeded() =>
              'Renderer generation を更新しました',
            EqmonitorMapGpuProbeInvalidationNotReady() => '地図の初期化完了後に再試行してください',
          };
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(message)));
        },
      ),
    );
  }
}

class _EqmonitorMapDebugContent extends HookConsumerWidget {
  const new({required this.probeBindings});

  final _EqmonitorMapGpuProbeBindings? probeBindings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appClockNow = ref.watch(appClockProvider.notifier).now;
    final clockSourceIdentity = ref.watch(mapClockSourceIdentityProvider);
    final mapSession = useMemoized(
      () => EqmonitorMapDebugMapSession(now: appClockNow),
      [appClockNow],
    );
    useEffect(() {
      return mapSession.dispose;
    }, [mapSession]);
    final committedCamera = useValueListenable(
      mapSession.cameraController.committedCameraListenable,
    );
    final mapClock = useMemoized(
      () => mapSession.clockFor(sourceIdentity: clockSourceIdentity),
      [mapSession, clockSourceIdentity],
    );
    final source = ref.watch(eqmonitorMapDebugSourceProvider);
    final overlayState = ref.watch(latestEarthquakeOverlayProvider);
    final coverageSnapshot = useState<EarthquakeOverlayCoverageSnapshot?>(
      null,
    );
    final presentation = EqmonitorMapOverlayPresentation.from(
      overlayState: overlayState,
      coverageSnapshot: coverageSnapshot.value,
      committedCamera: committedCamera,
    );
    final overlay = presentation.overlay;
    final hypocenter = presentation.hypocenter;
    final onMoveToHypocenter =
        presentation.canMoveToHypocenter && hypocenter != null
        ? () async {
            final result = await ref
                .read(eqmonitorMapCameraActionProvider)
                .moveToHypocenter(
                  controller: mapSession.cameraController,
                  longitude: hypocenter.longitude,
                  latitude: hypocenter.latitude,
                );
            if (!context.mounted) {
              return;
            }
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(eqmonitorMapCameraActionMessage(result)),
                ),
              );
          }
        : null;
    final onCoverageChanged =
        useCallback<ValueChanged<EarthquakeOverlayCoverageSnapshot>>(
          (snapshot) => coverageSnapshot.value = snapshot,
          const [],
        );
    return Scaffold(
      appBar: AppBar(title: const Text('EQMonitor Map (Flutter Scene)')),
      body: source.when(
        data: (result) => EqmonitorMapDebugOverlayLayout(
          map: BaseMapView(
            source: result.source,
            initialCamera: EqmonitorMapDebugConfiguration.initialCamera,
            clock: mapClock,
            cameraController: mapSession.cameraController,
            limits: EqmonitorMapDebugConfiguration.limitsFor(
              minZoom: result.minZoom,
              maxZoom: result.maxZoom,
            ),
            earthquakeOverlay: overlay,
            onEarthquakeOverlayCoverageChanged: onCoverageChanged,
            gpuProbeConfiguration: probeBindings?.configuration,
            onGpuResourceCounterChanged: probeBindings?.onCounterChanged,
            gpuProbeController: probeBindings?.controller,
          ),
          banner: EqmonitorMapOverlayBanner(
            presentation: presentation,
            onMoveToHypocenter: onMoveToHypocenter,
          ),
          probePanel: switch (probeBindings) {
            final bindings? => EqmonitorMapGpuProbePanel(
              atlasFixture: bindings.configuration.atlasFixture,
              faultPoint: bindings.configuration.faultPoint,
              counterSnapshot: bindings.counterSnapshot,
              onAtlasFixtureChanged: bindings.onAtlasFixtureChanged,
              onFaultPointChanged: bindings.onFaultPointChanged,
              onInvalidateRendererContextGeneration:
                  bindings.onInvalidateRendererContextGeneration,
            ),
            null => null,
          },
        ),
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
        error: (error, stackTrace) => const _EqmonitorMapDebugSourceError(),
      ),
    );
  }
}

final class _EqmonitorMapGpuProbeBindings {
  const new({
    required this.configuration,
    required this.controller,
    required this.counterSnapshot,
    required this.onCounterChanged,
    required this.onAtlasFixtureChanged,
    required this.onFaultPointChanged,
    required this.onInvalidateRendererContextGeneration,
  });

  final MapGpuProbeConfiguration configuration;
  final MapGpuProbeController controller;
  final MapGpuResourceCounterSnapshot? counterSnapshot;
  final ValueChanged<MapGpuResourceCounterSnapshot> onCounterChanged;
  final ValueChanged<MapSpriteAtlasProbeFixture> onAtlasFixtureChanged;
  final ValueChanged<MapGpuFaultPoint?> onFaultPointChanged;
  final VoidCallback onInvalidateRendererContextGeneration;
}

final class EqmonitorMapDebugGpuCounterCallbackGuard {
  const new({required this.isMounted, required this.onSnapshot});

  final bool Function() isMounted;
  final ValueChanged<MapGpuResourceCounterSnapshot> onSnapshot;

  void publish(MapGpuResourceCounterSnapshot snapshot) {
    if (isMounted()) {
      onSnapshot(snapshot);
    }
  }
}

final class EqmonitorMapDebugMapSession {
  new({required DateTime Function() now}) : _now = now;

  final DateTime Function() _now;
  final cameraController = MapViewCameraController();
  MapClockSourceIdentity? _sourceIdentity;
  MapClock? _clock;

  MapClock clockFor({required MapClockSourceIdentity sourceIdentity}) {
    final currentClock = _clock;
    if (_sourceIdentity == sourceIdentity && currentClock != null) {
      return currentClock;
    }
    final nextClock = createAppMapClock(
      now: _now,
      sourceIdentity: sourceIdentity,
    );
    _sourceIdentity = sourceIdentity;
    _clock = nextClock;
    return nextClock;
  }

  void dispose() => cameraController.dispose();
}

final class EqmonitorMapDebugConfiguration {
  static const initialCamera = MapCamera(
    centerLongitude: 137.5,
    centerLatitude: 36.5,
    zoom: 4,
  );

  static MapBaseLayerLimits limitsFor({
    required int minZoom,
    required int maxZoom,
  }) => MapBaseLayerLimits(
    minZoom: minZoom,
    maxZoom: maxZoom,
    pmTilesLimits: const PmTilesV3Limits(
      maxDirectoryDepth: 3,
      rootDirectoryWindowLength: 16384,
      // 最大6並列でも展開済みtileを96MiB以内に抑える暫定allocation policy。
      // event sourceは実archive契約に合わせた独立の厳格値を使う。
      maxDirectoryEncodedBytes: 1 << 20,
      maxDirectoryDecodedBytes: 8 << 20,
      maxTileEncodedBytes: 4 << 20,
      maxTileDecodedBytes: 16 << 20,
    ),
    decodeLimits: const BaseMapTileDecodeLimits(
      mvtLimits: MvtDecodeLimits(
        maxLayers: 16,
        maxFeaturesPerLayer: 20000,
        maxRingsPerFeature: 2000,
        maxVerticesPerRing: 65536,
        maxCommandsPerFeature: 200000,
        maxLayerNameBytes: 64,
        maxKeysPerLayer: 64,
        maxValuesPerLayer: 20000,
        maxTagsPerFeature: 64,
        maxPropertyStringBytes: 256,
      ),
      fillLimits: FillMeshBuilderLimits(
        maxHolesPerPolygon: 500,
        maxVerticesPerFeature: 65536,
        maxVerticesPerSegment: 65536,
      ),
      lineLimits: LineMeshBuilderLimits(maxVerticesPerSegment: 65536),
      lineMiterLimit: 4,
    ),
    maxCachedTileGeometries: 64,
    maxParentFallbackSteps: 4,
    maxInFlightDecodes: 6,
    // Impellerが同時に処理し得るframe数(現状のFlutterは3 buffer)より
    // 余裕を持たせた値。GPU resourceの参照を落とすのは、可視tileから外れて
    // この frame 数ぶん経ってからになる。
    maxFramesInFlight: 3,
    spriteRendererLimits: const MapSpriteRendererLimits(
      maxActiveAtlases: 1,
      maxTopologyVariants: 1,
      maxPolicyBatches: 1,
    ),
    maxSceneNodeCount: 512,
  );
}

/// [eqmonitorMapDebugSourceProvider]がエラーの場合の短い表示。
class _EqmonitorMapDebugSourceError extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          'ベースマップPMTilesの取得に失敗しました。',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.error,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
