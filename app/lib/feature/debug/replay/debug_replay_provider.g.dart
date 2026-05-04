// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'debug_replay_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DebugReplay)
final debugReplayProvider = DebugReplayProvider._();

final class DebugReplayProvider
    extends $NotifierProvider<DebugReplay, DebugReplayState> {
  DebugReplayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debugReplayProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debugReplayHash();

  @$internal
  @override
  DebugReplay create() => DebugReplay();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DebugReplayState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DebugReplayState>(value),
    );
  }
}

String _$debugReplayHash() => r'24df1ab17bb32fdf06a6f0d5b8667c19354de4bd';

abstract class _$DebugReplay extends $Notifier<DebugReplayState> {
  DebugReplayState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<DebugReplayState, DebugReplayState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DebugReplayState, DebugReplayState>,
              DebugReplayState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
