import 'package:eqmonitor_map/src/mesh/fill_mesh_builder_limits.dart';
import 'package:eqmonitor_map/src/mesh/line_mesh_builder_limits.dart';
import 'package:eqmonitor_map/src/tile/mvt/mvt_decode_limits.dart';

/// 推計震度 MVT decode と mesh 生成へ適用する caller-owned 上限。
final class EstimatedIntensityTileDecodeLimits {
  const new({
    required this.mvtLimits,
    required this.fillLimits,
    required this.lineLimits,
    required this.lineMiterLimit,
  });

  final MvtDecodeLimits mvtLimits;
  final FillMeshBuilderLimits fillLimits;
  final LineMeshBuilderLimits lineLimits;
  final double lineMiterLimit;

  EstimatedIntensityTileDecodeLimits copyWith({
    MvtDecodeLimits? mvtLimits,
    FillMeshBuilderLimits? fillLimits,
    LineMeshBuilderLimits? lineLimits,
    double? lineMiterLimit,
  }) => EstimatedIntensityTileDecodeLimits(
    mvtLimits: mvtLimits ?? this.mvtLimits,
    fillLimits: fillLimits ?? this.fillLimits,
    lineLimits: lineLimits ?? this.lineLimits,
    lineMiterLimit: lineMiterLimit ?? this.lineMiterLimit,
  );
}
