import 'package:eqmonitor/feature/earthquake_history/data/provider/latest_earthquake_overlay_provider.dart';
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
class EqmonitorMapDebugPage extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final source = ref.watch(eqmonitorMapDebugSourceProvider);
    final overlayState = ref.watch(latestEarthquakeOverlayProvider);
    final coverageSnapshot = useState<EarthquakeOverlayCoverageSnapshot?>(
      null,
    );
    final presentation = EqmonitorMapOverlayPresentation.from(
      overlayState: overlayState,
      coverageSnapshot: coverageSnapshot.value,
    );
    final overlay = presentation.overlay;
    final onCoverageChanged =
        useCallback<ValueChanged<EarthquakeOverlayCoverageSnapshot>>(
          (snapshot) => coverageSnapshot.value = snapshot,
          const [],
        );
    return Scaffold(
      appBar: AppBar(title: const Text('EQMonitor Map (Flutter Scene)')),
      body: source.when(
        data: (result) => Stack(
          fit: StackFit.expand,
          children: [
            BaseMapView(
              source: result.source,
              initialCamera: EqmonitorMapDebugConfiguration.initialCamera,
              limits: EqmonitorMapDebugConfiguration.limitsFor(
                minZoom: result.minZoom,
                maxZoom: result.maxZoom,
              ),
              earthquakeOverlay: overlay,
              onEarthquakeOverlayCoverageChanged: onCoverageChanged,
            ),
            Positioned(
              top: 12,
              left: 12,
              right: 12,
              child: SafeArea(
                child: EqmonitorMapOverlayBanner(
                  presentation: presentation,
                ),
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => const _EqmonitorMapDebugSourceError(),
      ),
    );
  }
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
