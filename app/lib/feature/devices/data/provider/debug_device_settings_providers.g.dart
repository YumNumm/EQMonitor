// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'debug_device_settings_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(debugDeviceSession)
final debugDeviceSessionProvider = DebugDeviceSessionProvider._();

final class DebugDeviceSessionProvider
    extends
        $FunctionalProvider<
          AsyncValue<DebugDeviceSessionSnapshot>,
          DebugDeviceSessionSnapshot,
          FutureOr<DebugDeviceSessionSnapshot>
        >
    with
        $FutureModifier<DebugDeviceSessionSnapshot>,
        $FutureProvider<DebugDeviceSessionSnapshot> {
  DebugDeviceSessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debugDeviceSessionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debugDeviceSessionHash();

  @$internal
  @override
  $FutureProviderElement<DebugDeviceSessionSnapshot> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<DebugDeviceSessionSnapshot> create(Ref ref) {
    return debugDeviceSession(ref);
  }
}

String _$debugDeviceSessionHash() =>
    r'0c9400e292f082b4c991b889d2f9e6b5bdf384a4';

@ProviderFor(debugNotificationHistory)
final debugNotificationHistoryProvider = DebugNotificationHistoryProvider._();

final class DebugNotificationHistoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PushNotificationLogEntry>>,
          List<PushNotificationLogEntry>,
          FutureOr<List<PushNotificationLogEntry>>
        >
    with
        $FutureModifier<List<PushNotificationLogEntry>>,
        $FutureProvider<List<PushNotificationLogEntry>> {
  DebugNotificationHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debugNotificationHistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debugNotificationHistoryHash();

  @$internal
  @override
  $FutureProviderElement<List<PushNotificationLogEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PushNotificationLogEntry>> create(Ref ref) {
    return debugNotificationHistory(ref);
  }
}

String _$debugNotificationHistoryHash() =>
    r'e572b43fd6193eedee7f0e518a3180ebb4ca7dcb';
