import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';

/// 地図上で選択された緯度経度矩形でイベントをフィルタする。
class SeismicityBoundsFilter {
  const SeismicityBoundsFilter();

  List<SeismicityEvent> filter({
    required List<SeismicityEvent> events,
    required double minLatitude,
    required double maxLatitude,
    required double minLongitude,
    required double maxLongitude,
  }) {
    return events
        .where(
          (e) =>
              e.latitude >= minLatitude &&
              e.latitude <= maxLatitude &&
              e.longitude >= minLongitude &&
              e.longitude <= maxLongitude,
        )
        .toList();
  }
}
