import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
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
    .ios => 'iOS',
    .android => 'Android',
  };
}

extension RegisteredDeviceApiExtension on api.DeviceResponse {
  RegisteredDevice get toRegisteredDevice => RegisteredDevice(
    id: id,
    platform: switch (type) {
      .ios => .ios,
      .android => .android,
    },
    userId: userId,
    locale: switch (locale) {
      .ja => .ja,
      .en => .en,
      .zh => .zh,
    },
    createdAtIso: createdAt,
    updatedAtIso: updatedAt,
  );
}
