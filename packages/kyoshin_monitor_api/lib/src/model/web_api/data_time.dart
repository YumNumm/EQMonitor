import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart';

part 'data_time.freezed.dart';
part 'data_time.g.dart';

@freezed
class DataTime with _$DataTime implements KyoshinMonitorWebApiResponse {
  const factory DataTime({
    required Security? security,
    required Result? result,
    required DateTime latestTime,
    required DateTime requestTime,
  }) = _DataTime;

  factory DataTime.fromJson(Map<String, dynamic> json) =>
      _$DataTimeFromJson(json);
}
