import 'package:eqmonitor_map/src/mesh/fill_mesh.dart';
import 'package:flutter/foundation.dart';

/// 1つの予報区・市区町村codeに対応するFill mesh群。
@immutable
final class CodedFillGeometry {
  const new({required this.code, required this.meshes});

  final String code;
  final List<FillMesh> meshes;
}

/// 同種の震度区域source layerから得た、code付きFill geometry。
@immutable
final class EarthquakeAreaTileLayerGeometry {
  const new({
    required this.extent,
    required this.features,
    this.missingOrInvalidCodeCount = 0,
  }) : assert(
         missingOrInvalidCodeCount >= 0,
         'missingOrInvalidCodeCount must be non-negative',
       );

  /// source MVT layerが欠損した場合のみ`null`。
  final int? extent;
  final List<CodedFillGeometry> features;

  /// polygon featureのうち要求codeが欠損・非string・空だった件数。
  final int missingOrInvalidCodeCount;
}

/// 地震情報の予報区・市区町村へ対応付けるためのtile-local Fill geometry。
@immutable
final class EarthquakeAreaTileGeometry {
  const new({required this.forecastRegions, required this.cities});

  const EarthquakeAreaTileGeometry.empty()
    : forecastRegions = const EarthquakeAreaTileLayerGeometry(
        extent: null,
        features: [],
      ),
      cities = const EarthquakeAreaTileLayerGeometry(
        extent: null,
        features: [],
      );

  final EarthquakeAreaTileLayerGeometry forecastRegions;
  final EarthquakeAreaTileLayerGeometry cities;
}
