// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'live_monitor_session_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LiveMonitorSession)
final liveMonitorSessionProvider = LiveMonitorSessionProvider._();

final class LiveMonitorSessionProvider
    extends $NotifierProvider<LiveMonitorSession, bool> {
  LiveMonitorSessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'liveMonitorSessionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$liveMonitorSessionHash();

  @$internal
  @override
  LiveMonitorSession create() => LiveMonitorSession();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$liveMonitorSessionHash() =>
    r'b72bd2bd83c8e152c42a88ea01549d55f22acaba';

abstract class _$LiveMonitorSession extends $Notifier<bool> {
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
