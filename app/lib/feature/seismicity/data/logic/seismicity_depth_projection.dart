import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'seismicity_depth_projection.freezed.dart';

/// 深さ断面図の投影軸。
enum SeismicityDepthProjectionAxis { latitude, longitude }

/// 深さ断面図の1点(投影後の軸値・深さ・マグニチュード)。
@freezed
abstract class SeismicityDepthPoint with _$SeismicityDepthPoint {
  const factory SeismicityDepthPoint({
    /// 投影軸の値(緯度 or 経度)
    required double axisValue,
    required double depth,
    required double? magnitude,
    required String eventId,
  }) = _SeismicityDepthPoint;
}

/// 深さ(km) が既知のイベントを、指定軸(緯度/経度)へ投影する。
///
/// 深さ未知のイベントは断面図に描画できないため除外する。
class SeismicityDepthProjection {
  const SeismicityDepthProjection();

  List<SeismicityDepthPoint> project({
    required List<SeismicityEvent> events,
    required SeismicityDepthProjectionAxis axis,
  }) {
    return events
        .where((e) => e.depth != null)
        .map(
          (e) => SeismicityDepthPoint(
            axisValue: axis == SeismicityDepthProjectionAxis.latitude
                ? e.latitude
                : e.longitude,
            depth: e.depth!,
            magnitude: e.magnitude,
            eventId: e.eventId,
          ),
        )
        .toList();
  }
}
