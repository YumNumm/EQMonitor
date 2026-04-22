// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'device_notification_settings_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deviceNotificationSettingsRepository)
final deviceNotificationSettingsRepositoryProvider =
    DeviceNotificationSettingsRepositoryProvider._();

final class DeviceNotificationSettingsRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<DeviceNotificationSettingsRepository>,
          DeviceNotificationSettingsRepository,
          FutureOr<DeviceNotificationSettingsRepository>
        >
    with
        $FutureModifier<DeviceNotificationSettingsRepository>,
        $FutureProvider<DeviceNotificationSettingsRepository> {
  DeviceNotificationSettingsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceNotificationSettingsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$deviceNotificationSettingsRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<DeviceNotificationSettingsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<DeviceNotificationSettingsRepository> create(Ref ref) {
    return deviceNotificationSettingsRepository(ref);
  }
}

String _$deviceNotificationSettingsRepositoryHash() =>
    r'19256b603218852a671c9b498fde96f7c0fad528';
