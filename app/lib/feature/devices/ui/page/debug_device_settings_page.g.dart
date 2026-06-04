// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'debug_device_settings_page.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(_deviceInfo)
final _deviceInfoProvider = _DeviceInfoFamily._();

final class _DeviceInfoProvider
    extends
        $FunctionalProvider<
          AsyncValue<RegisteredDevice>,
          RegisteredDevice,
          FutureOr<RegisteredDevice>
        >
    with $FutureModifier<RegisteredDevice>, $FutureProvider<RegisteredDevice> {
  _DeviceInfoProvider._({
    required _DeviceInfoFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'_deviceInfoProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$_deviceInfoHash();

  @override
  String toString() {
    return r'_deviceInfoProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<RegisteredDevice> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<RegisteredDevice> create(Ref ref) {
    final argument = this.argument as String;
    return _deviceInfo(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is _DeviceInfoProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$_deviceInfoHash() => r'ee2acd4f0440b61dfea0d82b15347af70ba51313';

final class _DeviceInfoFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<RegisteredDevice>, String> {
  _DeviceInfoFamily._()
    : super(
        retry: null,
        name: r'_deviceInfoProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _DeviceInfoProvider call(String deviceId) =>
      _DeviceInfoProvider._(argument: deviceId, from: this);

  @override
  String toString() => r'_deviceInfoProvider';
}

@ProviderFor(_notificationSettings)
final _notificationSettingsProvider = _NotificationSettingsFamily._();

final class _NotificationSettingsProvider
    extends
        $FunctionalProvider<
          AsyncValue<GeneralNotificationSettings>,
          GeneralNotificationSettings,
          FutureOr<GeneralNotificationSettings>
        >
    with
        $FutureModifier<GeneralNotificationSettings>,
        $FutureProvider<GeneralNotificationSettings> {
  _NotificationSettingsProvider._({
    required _NotificationSettingsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'_notificationSettingsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$_notificationSettingsHash();

  @override
  String toString() {
    return r'_notificationSettingsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<GeneralNotificationSettings> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<GeneralNotificationSettings> create(Ref ref) {
    final argument = this.argument as String;
    return _notificationSettings(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is _NotificationSettingsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$_notificationSettingsHash() =>
    r'1acb74708543e0b4b4049a0fc3a22fda1d8df4ac';

final class _NotificationSettingsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<GeneralNotificationSettings>,
          String
        > {
  _NotificationSettingsFamily._()
    : super(
        retry: null,
        name: r'_notificationSettingsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _NotificationSettingsProvider call(String deviceId) =>
      _NotificationSettingsProvider._(argument: deviceId, from: this);

  @override
  String toString() => r'_notificationSettingsProvider';
}

@ProviderFor(_notificationHistory)
final _notificationHistoryProvider = _NotificationHistoryFamily._();

final class _NotificationHistoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PushNotificationLogEntry>>,
          List<PushNotificationLogEntry>,
          FutureOr<List<PushNotificationLogEntry>>
        >
    with
        $FutureModifier<List<PushNotificationLogEntry>>,
        $FutureProvider<List<PushNotificationLogEntry>> {
  _NotificationHistoryProvider._({
    required _NotificationHistoryFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'_notificationHistoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$_notificationHistoryHash();

  @override
  String toString() {
    return r'_notificationHistoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<PushNotificationLogEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PushNotificationLogEntry>> create(Ref ref) {
    final argument = this.argument as String;
    return _notificationHistory(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is _NotificationHistoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$_notificationHistoryHash() =>
    r'a2505d29bdaf75b761863edf1d78eda7f7c3eadf';

final class _NotificationHistoryFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<PushNotificationLogEntry>>,
          String
        > {
  _NotificationHistoryFamily._()
    : super(
        retry: null,
        name: r'_notificationHistoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _NotificationHistoryProvider call(String deviceId) =>
      _NotificationHistoryProvider._(argument: deviceId, from: this);

  @override
  String toString() => r'_notificationHistoryProvider';
}

@ProviderFor(_isProvisioned)
final _isProvisionedProvider = _IsProvisionedProvider._();

final class _IsProvisionedProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  _IsProvisionedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_isProvisionedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$_isProvisionedHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return _isProvisioned(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$_isProvisionedHash() => r'2f8d126c3bc56972a9eda138053d417c165ef26c';

@ProviderFor(_deviceTokenPresent)
final _deviceTokenPresentProvider = _DeviceTokenPresentProvider._();

final class _DeviceTokenPresentProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  _DeviceTokenPresentProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_deviceTokenPresentProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$_deviceTokenPresentHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return _deviceTokenPresent(ref);
  }
}

String _$_deviceTokenPresentHash() =>
    r'c951fda194d9cd7635a10fb9f8371b7e6e92e097';

@ProviderFor(_legacyDeviceId)
final _legacyDeviceIdProvider = _LegacyDeviceIdProvider._();

final class _LegacyDeviceIdProvider
    extends $FunctionalProvider<String?, String?, String?>
    with $Provider<String?> {
  _LegacyDeviceIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_legacyDeviceIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$_legacyDeviceIdHash();

  @$internal
  @override
  $ProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String? create(Ref ref) {
    return _legacyDeviceId(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$_legacyDeviceIdHash() => r'e44ebb20404a38ef6e434b9767ddd6549de18eab';

@ProviderFor(_osNotificationPermission)
final _osNotificationPermissionProvider = _OsNotificationPermissionProvider._();

final class _OsNotificationPermissionProvider
    extends
        $FunctionalProvider<
          AsyncValue<NotificationSettings>,
          NotificationSettings,
          FutureOr<NotificationSettings>
        >
    with
        $FutureModifier<NotificationSettings>,
        $FutureProvider<NotificationSettings> {
  _OsNotificationPermissionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_osNotificationPermissionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$_osNotificationPermissionHash();

  @$internal
  @override
  $FutureProviderElement<NotificationSettings> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<NotificationSettings> create(Ref ref) {
    return _osNotificationPermission(ref);
  }
}

String _$_osNotificationPermissionHash() =>
    r'e5a08176ccf64f87859bf32f4970fa11b36fd19d';
