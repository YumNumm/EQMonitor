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

String _$_deviceInfoHash() => r'438a6364267c70d8ff70ba1f9712fd2447a20dfe';

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
    r'e1835805ae76364aed1fb0ba812b4d71a694590f';

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
    r'2d6650a29bb881ae0f360d290049a0231edbc704';

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
