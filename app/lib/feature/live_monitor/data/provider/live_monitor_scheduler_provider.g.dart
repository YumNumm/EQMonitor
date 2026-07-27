// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'live_monitor_scheduler_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(liveMonitorScheduler)
final liveMonitorSchedulerProvider = LiveMonitorSchedulerProvider._();

final class LiveMonitorSchedulerProvider
    extends
        $FunctionalProvider<
          LiveMonitorScheduler,
          LiveMonitorScheduler,
          LiveMonitorScheduler
        >
    with $Provider<LiveMonitorScheduler> {
  LiveMonitorSchedulerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'liveMonitorSchedulerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$liveMonitorSchedulerHash();

  @$internal
  @override
  $ProviderElement<LiveMonitorScheduler> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LiveMonitorScheduler create(Ref ref) {
    return liveMonitorScheduler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LiveMonitorScheduler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LiveMonitorScheduler>(value),
    );
  }
}

String _$liveMonitorSchedulerHash() =>
    r'e6523ca67ef45ae331a3101594ee5087bf4129fb';
