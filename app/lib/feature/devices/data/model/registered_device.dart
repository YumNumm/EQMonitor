import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'registered_device.freezed.dart';

@freezed
abstract class RegisteredDevice with _$RegisteredDevice {
  const factory RegisteredDevice({
    required String id,
    required DevicePlatform platform,
    required String? userId,
    required DeviceLocale locale,
    required String createdAtIso,
    required String updatedAtIso,
  }) = _RegisteredDevice;
}

enum DevicePlatform {
  ios,
  android,
}

enum DeviceLocale {
  ja,
  en,
  zh,
}

extension DevicePlatformDisplay on DevicePlatform {
  String get displayLabel => switch (this) {
    .ios => 'iOS',
    .android => 'Android',
  };
}

extension DeviceApiExtension on api.DeviceMeResponse {
  RegisteredDevice get toRegisteredDevice => RegisteredDevice(
    id: id,
    platform: type?.toString() == 'ANDROID' ? .android : .ios,
    userId: userId,
    locale: switch (locale?.toString()) {
      'en' => DeviceLocale.en,
      'zh' => DeviceLocale.zh,
      _ => DeviceLocale.ja,
    },
    createdAtIso: createdAt.toIso8601String(),
    updatedAtIso: updatedAt.toIso8601String(),
  );
}


extension DevicePlatformApiExtension on DevicePlatform {
  api.DeviceType get toDeviceType => switch (this) {
    .ios => api.DeviceType.ios,
    .android => api.DeviceType.android,
  };
}

extension DeviceLocaleApiExtension on DeviceLocale {
  api.DeviceLocale get toDeviceLocale => switch (this) {
    .ja => api.DeviceLocale.ja,
    .en => api.DeviceLocale.en,
    .zh => api.DeviceLocale.zh,
  };
}
