// `PmTilesV3Archive`/`PmTilesV3Header`/`PmTilesV3FileRandomAccessReader`は、
// appが`VerifiedPmTilesSource`を組み立てる前にarchiveの実際のzoom範囲
// (`header.minZoom`/`maxZoom`)を読むために公開している。`BaseMapView`自身は
// これらを使わない(`tile/base_map_tile_repository.dart`が内部で使う)。
export 'package:pmtiles_v3/pmtiles_v3.dart'
    show
        PmTilesV3Archive,
        PmTilesV3FileRandomAccessReader,
        PmTilesV3Header,
        PmTilesV3Limits;

export 'src/eqmonitor_map_library.dart';
export 'src/flutter_scene/base_map_material_preflight_view.dart';
export 'src/foundation/frame/map_clock.dart';
export 'src/foundation/frame/map_frame_revision.dart';
export 'src/foundation/frame/map_frame_snapshot.dart';
export 'src/foundation/map_child_reconciler.dart';
export 'src/foundation/map_element.dart';
export 'src/foundation/map_node.dart';
export 'src/foundation/map_node_identity.dart';
export 'src/foundation/map_scene.dart';
export 'src/foundation/revision/map_revision.dart';
export 'src/foundation/revision/map_revision_commit_store.dart';
export 'src/foundation/revision/map_revision_state_owner.dart';
export 'src/foundation/revision/map_source_identity.dart';
export 'src/geo/map_camera.dart';
export 'src/geo/map_viewport.dart';
export 'src/mesh/fill_mesh_builder_limits.dart';
export 'src/mesh/line_mesh_builder_limits.dart';
export 'src/renderer/eqmonitor_orthographic_projection.dart';
export 'src/renderer/map_scene_renderer_adapter.dart';
export 'src/renderer/spike_mesh_frame.dart';
export 'src/tile/base_map_tile_decoder.dart' show BaseMapTileDecodeLimits;
export 'src/tile/mvt/mvt_decode_limits.dart';
export 'src/tile/verified_pm_tiles_source.dart';
export 'src/widget/base_map_view.dart';

// The physical-device Scene spike stays under src as a manual smoke harness.
