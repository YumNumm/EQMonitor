// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'live_monitor_settings_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LiveMonitorSettingsNotifier)
final liveMonitorSettingsProvider = LiveMonitorSettingsNotifierProvider._();

final class LiveMonitorSettingsNotifierProvider
    extends
        $AsyncNotifierProvider<
          LiveMonitorSettingsNotifier,
          LiveMonitorSettings
        > {
  LiveMonitorSettingsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'liveMonitorSettingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$liveMonitorSettingsNotifierHash();

  @$internal
  @override
  LiveMonitorSettingsNotifier create() => LiveMonitorSettingsNotifier();
}

String _$liveMonitorSettingsNotifierHash() =>
    r'48b185060836f4d8daeb2576682663e5f481c786';

abstract class _$LiveMonitorSettingsNotifier
    extends $AsyncNotifier<LiveMonitorSettings> {
  FutureOr<LiveMonitorSettings> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<LiveMonitorSettings>, LiveMonitorSettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<LiveMonitorSettings>, LiveMonitorSettings>,
              AsyncValue<LiveMonitorSettings>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
