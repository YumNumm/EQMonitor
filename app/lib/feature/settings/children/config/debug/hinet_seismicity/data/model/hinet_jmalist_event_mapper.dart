import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:nied_api_client/nied_api_client.dart';

/// Hi-net jmalist 由来のイベントを公開版と共通の [SeismicityEvent] へ変換する。
extension HinetJmalistEventMapper on HinetJmalistEvent {
  SeismicityEvent get toSeismicityEvent => SeismicityEvent(
    eventId:
        'hinet-${originTime.microsecondsSinceEpoch}-'
        '${latitude.toStringAsFixed(3)}-${longitude.toStringAsFixed(3)}',
    originTime: originTime,
    magnitude: magnitude2 ?? magnitude1,
    depth: depthKm,
    latitude: latitude,
    longitude: longitude,
    maxIntensity: null,
  );
}
