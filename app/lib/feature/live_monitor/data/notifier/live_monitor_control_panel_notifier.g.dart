// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'live_monitor_control_panel_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LiveMonitorControlPanelNotifier)
final liveMonitorControlPanelProvider =
    LiveMonitorControlPanelNotifierProvider._();

final class LiveMonitorControlPanelNotifierProvider
    extends $NotifierProvider<LiveMonitorControlPanelNotifier, bool> {
  LiveMonitorControlPanelNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'liveMonitorControlPanelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$liveMonitorControlPanelNotifierHash();

  @$internal
  @override
  LiveMonitorControlPanelNotifier create() => LiveMonitorControlPanelNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$liveMonitorControlPanelNotifierHash() =>
    r'1c4e13b37e253d015b6308ade33d9712629317c8';

abstract class _$LiveMonitorControlPanelNotifier extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
