// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'estimated_intensity_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$estimatedIntensityHash() =>
    r'a42433a8a953507f64e5c254c2501dc12c3a1ef6';

/// See also [EstimatedIntensity].
@ProviderFor(EstimatedIntensity)
final estimatedIntensityProvider = NotifierProvider<EstimatedIntensity,
    List<AnalyzedKmoniObservationPoint>>.internal(
  EstimatedIntensity.new,
  name: r'estimatedIntensityProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$estimatedIntensityHash,
  dependencies: <ProviderOrFamily>[eewAliveTelegramProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    eewAliveTelegramProvider,
    ...?eewAliveTelegramProvider.allTransitiveDependencies
  },
);

typedef _$EstimatedIntensity = Notifier<List<AnalyzedKmoniObservationPoint>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
