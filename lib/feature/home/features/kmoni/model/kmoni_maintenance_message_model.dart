import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'kmoni_maintenance_message_model.freezed.dart';
part 'kmoni_maintenance_message_model.g.dart';

@freezed
class KmoniMaintenanceMessageModel with _$KmoniMaintenanceMessageModel {
  const factory KmoniMaintenanceMessageModel({
    @Default('')
        String message,
    @JsonKey(
      fromJson: KmoniMaintenanceMessageTypeFromJson,
      toJson: KmoniMaintenanceMessageTypeToJson,
    )
    @Default(KmoniMaintenanceMessageType.non)
        KmoniMaintenanceMessageType type,
  }) = _KmoniMaintenanceMessageModel;

  factory KmoniMaintenanceMessageModel.fromJson(Map<String, dynamic> json) =>
      _$KmoniMaintenanceMessageModelFromJson(json);
}

@JsonEnum(valueField: 'type')
enum KmoniMaintenanceMessageType {
  non('0'),
  small('1'),
  highLight('2');

  const KmoniMaintenanceMessageType(this.type);
  final String type;
}

String KmoniMaintenanceMessageTypeToJson(KmoniMaintenanceMessageType type) =>
    type.type;

KmoniMaintenanceMessageType KmoniMaintenanceMessageTypeFromJson(
  String type,
) =>
    KmoniMaintenanceMessageType.values.firstWhereOrNull(
      (element) => element.type == type,
    ) ??
    KmoniMaintenanceMessageType.non;
