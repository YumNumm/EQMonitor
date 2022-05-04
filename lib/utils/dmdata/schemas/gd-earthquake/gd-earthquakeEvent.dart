import 'schemas/event.dart';

/// ## GD Earthquake Event
/// 地震情報のリスト
/// GET https://api.dmdata.jp/v2/gd/earthquake/:eventId
class GDEarthquakeEvent {
  GDEarthquakeEvent({
    required this.responseId,
    required this.responseTime,
    required this.status,
    required this.event,
  });
  GDEarthquakeEvent.fromJson(Map<String, dynamic> j)
      : responseId = j['responseId'].toString(),
        responseTime = DateTime.parse(j['responseTime'].toString()),
        status = j['status'].toString(),
        event = Event.fromJson(j['event'] as Map<String, dynamic>);

  /// API処理ID
  final String responseId;

  /// API処理時刻
  final DateTime responseTime;

  /// 成功時は`ok`, 失敗時は`error`
  final String status;

  /// 地震情報の要素と電文情報
  final Event event;
}
