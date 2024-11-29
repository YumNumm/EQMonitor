// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'location.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$locationStreamHash() => r'512cf5869f3db7a5bc88d1c027ab5cc84e006ab8';

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LocationStreamRef = AutoDisposeStreamProviderRef<Position>;
String _$closestKmoniObservationPointStreamHash() =>
    r'0094c2c47c008397a4f460398410ce01c5f4847a';

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ClosestKmoniObservationPointStreamRef
    = AutoDisposeStreamProviderRef<(KyoshinObservationPoint, double km)>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
