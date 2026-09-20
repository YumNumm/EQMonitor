import 'package:eqmonitor_map/src/mesh/fill_mesh_builder_limits.dart';
import 'package:eqmonitor_map/src/mesh/line_mesh_builder_limits.dart';
import 'package:eqmonitor_map/src/tile/mvt/mvt_decode_limits.dart';

/// 推計震度 MVT decode と mesh 生成へ適用する caller-owned 上限。
final class const EstimatedIntensityTileDecodeLimits({
  required final MvtDecodeLimits mvtLimits,
  required final FillMeshBuilderLimits fillLimits,
  required final LineMeshBuilderLimits lineLimits,
  required final double lineMiterLimit,
}) {
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
