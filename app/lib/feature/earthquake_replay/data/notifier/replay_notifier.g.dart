// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ReplayNotifier)
const replayProvider = ReplayNotifierProvider._();

final class ReplayNotifierProvider
    extends $NotifierProvider<ReplayNotifier, ReplayState?> {
  const ReplayNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replayProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replayNotifierHash();

  @$internal
  @override
  ReplayNotifier create() => ReplayNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReplayState? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReplayState?>(value),
    );
  }
}

String _$replayNotifierHash() => r'2ab2dcfeaabf79c1d90b1d932c32834ba1ef0978';

abstract class _$ReplayNotifier extends $Notifier<ReplayState?> {
  ReplayState? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ReplayState?, ReplayState?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ReplayState?, ReplayState?>,
              ReplayState?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
