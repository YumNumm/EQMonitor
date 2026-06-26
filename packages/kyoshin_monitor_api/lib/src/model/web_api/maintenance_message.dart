import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart';

part 'maintenance_message.freezed.dart';
part 'maintenance_message.g.dart';

@freezed
abstract class MaintenanceMessage
    with _$MaintenanceMessage
    implements KyoshinMonitorWebApiResponse {
  const factory MaintenanceMessage({
    required String? message,
    required Security? security,
    required MaintenanceMessageType? type,
    @JsonKey(fromJson: dateTimeFromString, toJson: dateTimeToString)
    required DateTime requestTime,
    required Result? result,
  }) = _MaintenanceMessage;

  factory MaintenanceMessage.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceMessageFromJson(json);
}

@JsonEnum(valueField: 'type')
enum MaintenanceMessageType {
  non('0'),
  small('1'),
  highLight('2');

  const MaintenanceMessageType(this.type);
  final String type;
}
