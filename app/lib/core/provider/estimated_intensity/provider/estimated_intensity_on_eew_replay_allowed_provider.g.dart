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
    extends $NotifierProvider<EstimatedIntensityOnEewReplayAllowed, bool> {
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

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$estimatedIntensityOnEewReplayAllowedHash() =>
    r'56dbff49630888f39e938ea4c42d114a2bd0c634';

abstract class _$EstimatedIntensityOnEewReplayAllowed extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
