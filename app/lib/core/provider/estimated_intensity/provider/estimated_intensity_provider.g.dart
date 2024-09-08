// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'estimated_intensity_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$estimatedIntensityCityHash() =>
    r'6d6bcad277d483556c0ef8296acd134e64ed5f4e';

/// See also [estimatedIntensityCity].
@ProviderFor(estimatedIntensityCity)
final estimatedIntensityCityProvider =
    StreamProvider<Map<String, double>>.internal(
  estimatedIntensityCity,
  name: r'estimatedIntensityCityProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$estimatedIntensityCityHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef EstimatedIntensityCityRef = StreamProviderRef<Map<String, double>>;
String _$estimatedIntensityRegionHash() =>
    r'98e57c27650c780f6cd1fb1e375462526d727470';

/// See also [estimatedIntensityRegion].
@ProviderFor(estimatedIntensityRegion)
final estimatedIntensityRegionProvider =
    StreamProvider<Map<String, double>>.internal(
  estimatedIntensityRegion,
  name: r'estimatedIntensityRegionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$estimatedIntensityRegionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef EstimatedIntensityRegionRef = StreamProviderRef<Map<String, double>>;
String _$estimatedIntensityHash() =>
    r'4556cd1859ef20b7583c73527419d394d3cacaf7';

/// See also [EstimatedIntensity].
@ProviderFor(EstimatedIntensity)
final estimatedIntensityProvider = AsyncNotifierProvider<EstimatedIntensity,
    List<EstimatedIntensityPoint>>.internal(
  EstimatedIntensity.new,
  name: r'estimatedIntensityProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$estimatedIntensityHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$EstimatedIntensity = AsyncNotifier<List<EstimatedIntensityPoint>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
