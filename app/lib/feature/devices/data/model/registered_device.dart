import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'registered_device.freezed.dart';

@freezed
abstract class RegisteredDevice with _$RegisteredDevice {
  const factory({
    required String id,
    required DevicePlatform platform,
    required String? userId,
    required DeviceLocale locale,
    required String createdAtIso,
    required String updatedAtIso,
  }) = _RegisteredDevice;
}

enum DevicePlatform { ios, android }

enum DeviceLocale { ja, en, zh }

extension DeviceApiExtension on api.DeviceMeResponse {
  RegisteredDevice get toRegisteredDevice => RegisteredDevice(
    id: id,
    platform: switch (type) {
      .android => .android,
      .ios => .ios,
    },
    userId: userId,
    locale: switch (locale) {
      .en => .en,
      .zh => .zh,
      .ja => .ja,
    },
    createdAtIso: createdAt.toIso8601String(),
    updatedAtIso: updatedAt.toIso8601String(),
  );
}

extension DevicePlatformApiExtension on DevicePlatform {
  api.DeviceType get toDeviceType => switch (this) {
    .ios => .ios,
    .android => .android,
  };
}

extension DeviceLocaleApiExtension on DeviceLocale {
  api.DeviceLocale get toDeviceLocale => switch (this) {
    .ja => .ja,
    .en => .en,
    .zh => .zh,
  };
}
