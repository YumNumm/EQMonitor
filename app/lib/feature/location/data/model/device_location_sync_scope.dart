import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_location_sync_scope.freezed.dart';
part 'device_location_sync_scope.g.dart';

@freezed
abstract class DeviceLocationSyncScope with _$DeviceLocationSyncScope {
  const factory({
    @JsonKey(name: 'apiEndpoint')
    required String apiEndpoint,
  }) = _DeviceLocationSyncScope;

  factory fromJson(Map<String, dynamic> json) =>
      _$DeviceLocationSyncScopeFromJson(json);

  static DeviceLocationSyncScope fromApiBaseUrl({
    required String apiBaseUrl,
  }) {
    final baseUri = Uri.parse(apiBaseUrl);
    return DeviceLocationSyncScope(
      apiEndpoint: Uri.parse(
        baseUri.origin,
      ).resolve('/v2/device/me/location').toString(),
    );
  }
}
