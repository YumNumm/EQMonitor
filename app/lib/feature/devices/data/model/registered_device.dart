import 'package:eqmonitor_api/export.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'registered_device.freezed.dart';

@freezed
abstract class RegisteredDevice with _$RegisteredDevice {
  const factory RegisteredDevice({
    required String id,
    required RegisteredDevicePlatform platform,
    required String userId,
    required RegisteredDeviceLocale locale,
    required String createdAtIso,
    required String updatedAtIso,
  }) = _RegisteredDevice;
}

enum RegisteredDevicePlatform {
  ios,
  android,
}

enum RegisteredDeviceLocale {
  ja,
  en,
  zh,
}

extension RegisteredDevicePlatformDisplay on RegisteredDevicePlatform {
  String get displayLabel => switch (this) {
        RegisteredDevicePlatform.ios => 'iOS',
        RegisteredDevicePlatform.android => 'Android',
      };
}

extension RegisteredDeviceApiExtension on api.DeviceResponse {
  RegisteredDevice get toRegisteredDevice => RegisteredDevice(
        id: id,
        platform: switch (type) {
          api.DeviceResponseType.ios => RegisteredDevicePlatform.ios,
          api.DeviceResponseType.android => RegisteredDevicePlatform.android,
        },
        userId: userId,
        locale: switch (locale) {
          api.DeviceResponseLocale.ja => RegisteredDeviceLocale.ja,
          api.DeviceResponseLocale.en => RegisteredDeviceLocale.en,
          api.DeviceResponseLocale.zh => RegisteredDeviceLocale.zh,
        },
        createdAtIso: createdAt,
        updatedAtIso: updatedAt,
      );
}
