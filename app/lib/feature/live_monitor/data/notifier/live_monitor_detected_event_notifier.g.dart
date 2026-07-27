// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'live_monitor_detected_event_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LiveMonitorDetectedEventNotifier)
final liveMonitorDetectedEventProvider =
    LiveMonitorDetectedEventNotifierProvider._();

final class LiveMonitorDetectedEventNotifierProvider
    extends
        $AsyncNotifierProvider<
          LiveMonitorDetectedEventNotifier,
          LiveMonitorEventEnvelope?
        > {
  LiveMonitorDetectedEventNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'liveMonitorDetectedEventProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$liveMonitorDetectedEventNotifierHash();

  @$internal
  @override
  LiveMonitorDetectedEventNotifier create() =>
      LiveMonitorDetectedEventNotifier();
}

String _$liveMonitorDetectedEventNotifierHash() =>
    r'95fabcc199ced3ec9ff11fb55915fe6d86a2aa9e';

abstract class _$LiveMonitorDetectedEventNotifier
    extends $AsyncNotifier<LiveMonitorEventEnvelope?> {
  FutureOr<LiveMonitorEventEnvelope?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<LiveMonitorEventEnvelope?>,
              LiveMonitorEventEnvelope?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<LiveMonitorEventEnvelope?>,
                LiveMonitorEventEnvelope?
              >,
              AsyncValue<LiveMonitorEventEnvelope?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
