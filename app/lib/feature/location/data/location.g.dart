// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'location.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$locationStreamHash() => r'e4989c7c7324f98829b1f655bb9aadb77dd5ef19';

/// See also [locationStream].
@ProviderFor(locationStream)
final locationStreamProvider = AutoDisposeStreamProvider<Position>.internal(
  locationStream,
  name: r'locationStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$locationStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LocationStreamRef = AutoDisposeStreamProviderRef<Position>;
String _$closestKmoniObservationPointStreamHash() =>
    r'9ed9db9ec44171fb92f9f211d659cbc490538f43';

/// See also [closestKmoniObservationPointStream].
@ProviderFor(closestKmoniObservationPointStream)
final closestKmoniObservationPointStreamProvider =
    AutoDisposeStreamProvider<(KyoshinObservationPoint, double km)>.internal(
  closestKmoniObservationPointStream,
  name: r'closestKmoniObservationPointStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$closestKmoniObservationPointStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ClosestKmoniObservationPointStreamRef
    = AutoDisposeStreamProviderRef<(KyoshinObservationPoint, double km)>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
