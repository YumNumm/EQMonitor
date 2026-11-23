// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_creation_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ReplayCreationNotifier)
final replayCreationProvider = ReplayCreationNotifierProvider._();

final class ReplayCreationNotifierProvider
    extends $NotifierProvider<ReplayCreationNotifier, ReplayCreationProgress?> {
  ReplayCreationNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replayCreationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replayCreationNotifierHash();

  @$internal
  @override
  ReplayCreationNotifier create() => ReplayCreationNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReplayCreationProgress? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReplayCreationProgress?>(value),
    );
  }
}

String _$replayCreationNotifierHash() =>
    r'3a580ce395c0f62dac038e08b47fc78fc3a56ee0';

abstract class _$ReplayCreationNotifier
    extends $Notifier<ReplayCreationProgress?> {
  ReplayCreationProgress? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<ReplayCreationProgress?, ReplayCreationProgress?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ReplayCreationProgress?, ReplayCreationProgress?>,
              ReplayCreationProgress?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
