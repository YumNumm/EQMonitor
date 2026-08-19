import 'package:freezed_annotation/freezed_annotation.dart';

part 'seismicity_depth_point.freezed.dart';

/// 深さ断面図の1点(投影後の軸値・深さ・マグニチュード)。
@freezed
abstract class SeismicityDepthPoint with _$SeismicityDepthPoint {
  const factory({
    /// 投影軸の値(緯度 or 経度)
    required double axisValue,
    required double depth,
    required double? magnitude,
    required String eventId,
  }) = _SeismicityDepthPoint;
}
