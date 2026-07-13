// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'estimated_intensity_on_eew_replay_allowed_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EstimatedIntensityOnEewReplayAllowed)
final estimatedIntensityOnEewReplayAllowedProvider =
    EstimatedIntensityOnEewReplayAllowedProvider._();

final class EstimatedIntensityOnEewReplayAllowedProvider
    extends $AsyncNotifierProvider<EstimatedIntensityOnEewReplayAllowed, bool> {
  EstimatedIntensityOnEewReplayAllowedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'estimatedIntensityOnEewReplayAllowedProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$estimatedIntensityOnEewReplayAllowedHash();

  @$internal
  @override
  EstimatedIntensityOnEewReplayAllowed create() =>
      EstimatedIntensityOnEewReplayAllowed();
}

String _$estimatedIntensityOnEewReplayAllowedHash() =>
    r'd2058855e1fc28a5960ddfdd8b1ddcca70604945';

abstract class _$EstimatedIntensityOnEewReplayAllowed
    extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
