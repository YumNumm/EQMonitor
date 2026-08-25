import 'package:eqmonitor_map/src/mesh/fill_mesh.dart';
import 'package:eqmonitor_map/src/mesh/line_mesh.dart';

/// `seismic_intensity.name` が受理できる推計震度 class。
enum EstimatedIntensityClass {
  intensity4('intensity:4'),
  intensity5Lower('intensity:5-'),
  intensity5Upper('intensity:5+'),
  intensity6Lower('intensity:6-'),
  intensity6Upper('intensity:6+'),
  intensity7('intensity:7');

  const EstimatedIntensityClass(this.sourceName);

  final String sourceName;

  static EstimatedIntensityClass? fromSourceName(String value) =>
      switch (value) {
        'intensity:4' => intensity4,
        'intensity:5-' => intensity5Lower,
        'intensity:5+' => intensity5Upper,
        'intensity:6-' => intensity6Lower,
        'intensity:6+' => intensity6Upper,
        'intensity:7' => intensity7,
        _ => null,
      };
}

/// 1 class 分の style 非依存 geometry。
final class EstimatedIntensityClassGeometry {
  new({
    required this.intensityClass,
    required List<FillMesh> fillMeshes,
    required List<LineMesh> boundaryMeshes,
  }) : fillMeshes = List.unmodifiable(fillMeshes),
       boundaryMeshes = List.unmodifiable(boundaryMeshes);

  final EstimatedIntensityClass intensityClass;
  final List<FillMesh> fillMeshes;
  final List<LineMesh> boundaryMeshes;
}

/// Required layer が存在した推計震度 tile の decode 結果。
sealed class EstimatedIntensityTileGeometry {
  const new({required this.extent});

  final int extent;
}

/// Required layer は存在するが feature が0件の authoritative empty。
final class EstimatedIntensityTileEmpty extends EstimatedIntensityTileGeometry {
  const new({required super.extent});
}

/// 全 feature の検証と mesh 化が完了した tile。
final class EstimatedIntensityTileReady extends EstimatedIntensityTileGeometry {
  new({
    required super.extent,
    required List<EstimatedIntensityClassGeometry> classes,
  }) : classes = List.unmodifiable(classes);

  /// Feature が存在した class だけを enum 宣言順で保持する。
  final List<EstimatedIntensityClassGeometry> classes;
}
