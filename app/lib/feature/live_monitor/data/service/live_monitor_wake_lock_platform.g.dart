// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'live_monitor_wake_lock_platform.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(liveMonitorWakeLockPlatform)
final liveMonitorWakeLockPlatformProvider =
    LiveMonitorWakeLockPlatformProvider._();

final class LiveMonitorWakeLockPlatformProvider
    extends
        $FunctionalProvider<
          LiveMonitorWakeLockPlatform,
          LiveMonitorWakeLockPlatform,
          LiveMonitorWakeLockPlatform
        >
    with $Provider<LiveMonitorWakeLockPlatform> {
  LiveMonitorWakeLockPlatformProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'liveMonitorWakeLockPlatformProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$liveMonitorWakeLockPlatformHash();

  @$internal
  @override
  $ProviderElement<LiveMonitorWakeLockPlatform> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LiveMonitorWakeLockPlatform create(Ref ref) {
    return liveMonitorWakeLockPlatform(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LiveMonitorWakeLockPlatform value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LiveMonitorWakeLockPlatform>(value),
    );
  }
}

String _$liveMonitorWakeLockPlatformHash() =>
    r'b4810a705bab434ae17762ef507d6603c7388ec8';
