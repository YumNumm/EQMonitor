// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'live_monitor_coordinator.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LiveMonitorCoordinator)
final liveMonitorCoordinatorProvider = LiveMonitorCoordinatorProvider._();

final class LiveMonitorCoordinatorProvider
    extends $NotifierProvider<LiveMonitorCoordinator, LiveMonitorDisplayState> {
  LiveMonitorCoordinatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'liveMonitorCoordinatorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$liveMonitorCoordinatorHash();

  @$internal
  @override
  LiveMonitorCoordinator create() => LiveMonitorCoordinator();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LiveMonitorDisplayState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LiveMonitorDisplayState>(value),
    );
  }
}

String _$liveMonitorCoordinatorHash() =>
    r'd68e74e30e836ec454d033f8bdeaf3e56a210a27';

abstract class _$LiveMonitorCoordinator
    extends $Notifier<LiveMonitorDisplayState> {
  LiveMonitorDisplayState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<LiveMonitorDisplayState, LiveMonitorDisplayState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LiveMonitorDisplayState, LiveMonitorDisplayState>,
              LiveMonitorDisplayState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
