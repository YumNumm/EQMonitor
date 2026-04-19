// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ReplayNotifier)
final replayProvider = ReplayNotifierProvider._();

final class ReplayNotifierProvider
    extends $NotifierProvider<ReplayNotifier, ReplayState?> {
  ReplayNotifierProvider._()
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

String _$replayNotifierHash() => r'd1261eacf321da78b8f4601f426c0f3afa53fe99';

abstract class _$ReplayNotifier extends $Notifier<ReplayState?> {
  ReplayState? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ReplayState?, ReplayState?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ReplayState?, ReplayState?>,
              ReplayState?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
