// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'live_monitor_wake_lock_owner.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(liveMonitorWakeLockOwner)
final liveMonitorWakeLockOwnerProvider = LiveMonitorWakeLockOwnerProvider._();

final class LiveMonitorWakeLockOwnerProvider
    extends
        $FunctionalProvider<
          LiveMonitorWakeLockOwner,
          LiveMonitorWakeLockOwner,
          LiveMonitorWakeLockOwner
        >
    with $Provider<LiveMonitorWakeLockOwner> {
  LiveMonitorWakeLockOwnerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'liveMonitorWakeLockOwnerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$liveMonitorWakeLockOwnerHash();

  @$internal
  @override
  $ProviderElement<LiveMonitorWakeLockOwner> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LiveMonitorWakeLockOwner create(Ref ref) {
    return liveMonitorWakeLockOwner(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LiveMonitorWakeLockOwner value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LiveMonitorWakeLockOwner>(value),
    );
  }
}

String _$liveMonitorWakeLockOwnerHash() =>
    r'de4ad162636013150750bc59ffab7800ada8adb8';
