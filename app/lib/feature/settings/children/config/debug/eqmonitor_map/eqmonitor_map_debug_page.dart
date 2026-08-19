import 'package:eqmonitor/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_debug_source_provider.dart';
import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// `docs/superpowers/plans/2026-08-05-eqmonitor-map-base-layer-pmtiles.md`
/// のTask 1〜9が組んだtile pipelineを`BaseMapView`で実際に描画するデバッグ
/// ページ。zoom範囲(`minZoom`/`maxZoom`)は`eqmonitorMapDebugSourceProvider`
/// が実際のarchiveの`PmTilesV3Header`から読んだ値をそのまま使う。固定値を
/// 転記しない理由は`eqmonitor_map_debug_source_provider.dart`の
/// `_readHeader`のdoc comment参照。
class EqmonitorMapDebugPage extends ConsumerWidget {
  const new({super.key});

  static const _initialCamera = MapCamera(
    centerLongitude: 137.5,
    centerLatitude: 36.5,
    zoom: 4,
  );

  static MapBaseLayerLimits _limitsFor({
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
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final source = ref.watch(eqmonitorMapDebugSourceProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('EQMonitor Map (Flutter Scene)')),
      body: source.when(
        data: (result) => BaseMapView(
          source: result.source,
          initialCamera: _initialCamera,
          limits: _limitsFor(minZoom: result.minZoom, maxZoom: result.maxZoom),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            _EqmonitorMapDebugSourceError(error: error),
      ),
    );
  }
}

/// [eqmonitorMapDebugSourceProvider]がエラー(典型的には
/// `AssetPackNotReadyException`)の場合の表示。地図を空で描かず、原因を
/// そのまま出す(brief要求)。
class _EqmonitorMapDebugSourceError extends StatelessWidget {
  const new({required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          'ベースマップPMTilesの取得に失敗しました:\n$error',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.error,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
