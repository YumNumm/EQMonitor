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
          AsyncValue<DebugDeviceSessionSnapshot?>,
          DebugDeviceSessionSnapshot?,
          FutureOr<DebugDeviceSessionSnapshot?>
        >
    with
        $FutureModifier<DebugDeviceSessionSnapshot?>,
        $FutureProvider<DebugDeviceSessionSnapshot?> {
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
  $FutureProviderElement<DebugDeviceSessionSnapshot?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<DebugDeviceSessionSnapshot?> create(Ref ref) {
    return debugDeviceSession(ref);
  }
}

String _$debugDeviceSessionHash() =>
    r'84003edc96aac7899fe79a42020ef58805dff22d';

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
    r'386d4b980d6a175b46d72fed292ef8838364d250';
