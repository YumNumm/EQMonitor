// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'live_activity_test_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LiveActivityTestNotifier)
final liveActivityTestProvider = LiveActivityTestNotifierProvider._();

final class LiveActivityTestNotifierProvider
    extends $NotifierProvider<LiveActivityTestNotifier, LiveActivityTestState> {
  LiveActivityTestNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'liveActivityTestProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$liveActivityTestNotifierHash();

  @$internal
  @override
  LiveActivityTestNotifier create() => LiveActivityTestNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LiveActivityTestState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LiveActivityTestState>(value),
    );
  }
}

String _$liveActivityTestNotifierHash() =>
    r'437d6a42c69b9ff2efd89d040b99deded8324b3a';

abstract class _$LiveActivityTestNotifier
    extends $Notifier<LiveActivityTestState> {
  LiveActivityTestState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<LiveActivityTestState, LiveActivityTestState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LiveActivityTestState, LiveActivityTestState>,
              LiveActivityTestState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
