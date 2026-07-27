// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'live_monitor_wake_lock_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LiveMonitorWakeLockController)
final liveMonitorWakeLockControllerProvider =
    LiveMonitorWakeLockControllerProvider._();

final class LiveMonitorWakeLockControllerProvider
    extends $AsyncNotifierProvider<LiveMonitorWakeLockController, void> {
  LiveMonitorWakeLockControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'liveMonitorWakeLockControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$liveMonitorWakeLockControllerHash();

  @$internal
  @override
  LiveMonitorWakeLockController create() => LiveMonitorWakeLockController();
}

String _$liveMonitorWakeLockControllerHash() =>
    r'7278d73f3b2b8d994aa5eb6ec635e8661aa0df6f';

abstract class _$LiveMonitorWakeLockController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
