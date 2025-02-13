// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'estimated_intensity_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$estimatedIntensityCityHash() =>
    r'9bcbac883935662bc3388807662d7d6a4c8f7da6';

/// See also [estimatedIntensityCity].
@ProviderFor(estimatedIntensityCity)
final estimatedIntensityCityProvider =
    StreamProvider<Map<String, double>>.internal(
      estimatedIntensityCity,
      name: r'estimatedIntensityCityProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$estimatedIntensityCityHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EstimatedIntensityCityRef = StreamProviderRef<Map<String, double>>;
String _$estimatedIntensityRegionHash() =>
    r'bc6d5fcbeeb39c3b9705951ed3412df7bf83645e';

/// See also [estimatedIntensityRegion].
@ProviderFor(estimatedIntensityRegion)
final estimatedIntensityRegionProvider =
    StreamProvider<Map<String, double>>.internal(
      estimatedIntensityRegion,
      name: r'estimatedIntensityRegionProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$estimatedIntensityRegionHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EstimatedIntensityRegionRef = StreamProviderRef<Map<String, double>>;
String _$estimatedIntensityHash() =>
    r'd60154c92ffedbd45ee522e8f26d8000cc8c74fd';

/// See also [EstimatedIntensity].
@ProviderFor(EstimatedIntensity)
final estimatedIntensityProvider = AsyncNotifierProvider<
  EstimatedIntensity,
  List<EstimatedIntensityPoint>
>.internal(
  EstimatedIntensity.new,
  name: r'estimatedIntensityProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$estimatedIntensityHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$EstimatedIntensity = AsyncNotifier<List<EstimatedIntensityPoint>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
