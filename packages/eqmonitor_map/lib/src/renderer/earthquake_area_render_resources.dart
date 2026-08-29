import 'package:eqmonitor_map/src/foundation/render/map_render_packet.dart';
import 'package:eqmonitor_map/src/overlay/earthquake_map_overlay_snapshot.dart';
import 'package:eqmonitor_map/src/tile/earthquake_overlay_exact_tile_resolver.dart';

typedef EarthquakeAreaMaterialParametersFor =
    MapMaterialParameterBlock Function({required EarthquakeAreaStyle style});

/// 1 code分のstyle順序と再利用可能なmaterial parameter block。
final class EarthquakeAreaRenderStyleEntry {
  const new({
    required this.style,
    required this.declarationOrder,
    required this.materialParameters,
  });

  final EarthquakeAreaStyle style;
  final int declarationOrder;
  final MapMaterialParameterBlock materialParameters;
}

/// 1 snapshot/layer modeについて一度だけ構築するstyle lookup。
final class EarthquakeAreaRenderStyleResources {
  EarthquakeAreaRenderStyleResources._({
    required this._styleIdentity,
    required this.entriesByCode,
  });

  final List<EarthquakeAreaStyle> _styleIdentity;
  final Map<String, EarthquakeAreaRenderStyleEntry> entriesByCode;

  bool matches(List<EarthquakeAreaStyle> styles) =>
      identical(_styleIdentity, styles);
}

/// 現snapshotのregion/city lookupとparameter blockだけを保持するbounded cache。
final class EarthquakeAreaRenderStyleCache {
  List<EarthquakeAreaStyle>? _regionIdentity;
  EarthquakeAreaRenderStyleResources? _region;
  List<EarthquakeAreaStyle>? _cityIdentity;
  EarthquakeAreaRenderStyleResources? _city;

  EarthquakeAreaRenderStyleResources resolve({
    required EarthquakeMapOverlaySnapshot snapshot,
    required EarthquakeAreaLayerMode layerMode,
    required EarthquakeAreaMaterialParametersFor parametersFor,
  }) {
    final styles = switch (layerMode) {
      EarthquakeAreaLayerMode.region => snapshot.regionStyles,
      EarthquakeAreaLayerMode.city => snapshot.cityStyles,
    };
    final cached = switch (layerMode) {
      EarthquakeAreaLayerMode.region when identical(_regionIdentity, styles) =>
        _region,
      EarthquakeAreaLayerMode.city when identical(_cityIdentity, styles) =>
        _city,
      _ => null,
    };
    if (cached != null) {
      return cached;
    }
    final resources = EarthquakeAreaRenderStyleResources._(
      styleIdentity: styles,
      entriesByCode: Map.unmodifiable({
        for (final (index, style) in styles.indexed)
          style.code: EarthquakeAreaRenderStyleEntry(
            style: style,
            declarationOrder: index,
            materialParameters: parametersFor(style: style),
          ),
      }),
    );
    switch (layerMode) {
      case EarthquakeAreaLayerMode.region:
        _regionIdentity = styles;
        _region = resources;
      case EarthquakeAreaLayerMode.city:
        _cityIdentity = styles;
        _city = resources;
    }
    return resources;
  }

  void clear() {
    _regionIdentity = null;
    _region = null;
    _cityIdentity = null;
    _city = null;
  }
}

/// material準備用にregion/city両方の再利用資源を返す。
List<EarthquakeAreaRenderStyleResources>
earthquakeAreaRenderStyleResourcesForSnapshot({
  required EarthquakeAreaRenderStyleCache cache,
  required EarthquakeMapOverlaySnapshot snapshot,
  required EarthquakeAreaMaterialParametersFor parametersFor,
}) => List.unmodifiable([
  cache.resolve(
    snapshot: snapshot,
    layerMode: EarthquakeAreaLayerMode.region,
    parametersFor: parametersFor,
  ),
  cache.resolve(
    snapshot: snapshot,
    layerMode: EarthquakeAreaLayerMode.city,
    parametersFor: parametersFor,
  ),
]);
