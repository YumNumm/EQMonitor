import 'package:freezed_annotation/freezed_annotation.dart';

part 'pending_device_location.freezed.dart';
part 'pending_device_location.g.dart';

@freezed
abstract class PendingDeviceLocation with _$PendingDeviceLocation {
  const factory({
    required String updateId,
    required double latitude,
    required double longitude,
    required double accuracy,
    required int timestampMillis,
  }) = _PendingDeviceLocation;

  factory fromJson(Map<String, dynamic> json) =>
      _$PendingDeviceLocationFromJson(json);
}
