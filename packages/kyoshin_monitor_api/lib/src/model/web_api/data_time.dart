import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart';

part 'data_time.freezed.dart';
part 'data_time.g.dart';

@freezed
abstract class DataTime with _$DataTime implements KyoshinMonitorWebApiResponse {
  const factory DataTime({
    required Security? security,
    required Result? result,
    @JsonKey(fromJson: dateTimeFromString, toJson: dateTimeToString)
    required DateTime latestTime,
    @JsonKey(fromJson: dateTimeFromString, toJson: dateTimeToString)
    required DateTime requestTime,
  }) = _DataTime;

  factory DataTime.fromJson(Map<String, dynamic> json) =>
      _$DataTimeFromJson(json);
}
