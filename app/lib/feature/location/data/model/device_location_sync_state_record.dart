import 'package:eqmonitor/feature/location/data/model/device_location_payload.dart';
import 'package:eqmonitor/feature/location/data/model/device_location_sync_scope.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_location_sync_state_record.freezed.dart';
part 'device_location_sync_state_record.g.dart';

@freezed
abstract class DeviceLocationSyncStateRecord
    with _$DeviceLocationSyncStateRecord {
  @JsonSerializable(explicitToJson: true)
  const factory({
    required DeviceLocationSyncScope scope,
    required DeviceLocationPayload payload,
  }) = _DeviceLocationSyncStateRecord;

  factory fromJson(Map<String, dynamic> json) =>
      _$DeviceLocationSyncStateRecordFromJson(json);
}
