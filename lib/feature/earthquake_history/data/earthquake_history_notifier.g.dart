// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'earthquake_history_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$earthquakeHistoryHasNextFetchHash() =>
    r'9582948b6f2cd1696bb15a8b02615aa4e2cae1ae';

/// See also [earthquakeHistoryHasNextFetch].
@ProviderFor(earthquakeHistoryHasNextFetch)
final earthquakeHistoryHasNextFetchProvider =
    AutoDisposeProvider<bool>.internal(
  earthquakeHistoryHasNextFetch,
  name: r'earthquakeHistoryHasNextFetchProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$earthquakeHistoryHasNextFetchHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef EarthquakeHistoryHasNextFetchRef = AutoDisposeProviderRef<bool>;
String _$earthquakeHistoryNotifierHash() =>
    r'534ed47648abb99aa76254ad093a3d5f2c1dd6ec';

/// See also [EarthquakeHistoryNotifier].
@ProviderFor(EarthquakeHistoryNotifier)
final earthquakeHistoryNotifierProvider = AsyncNotifierProvider<
    EarthquakeHistoryNotifier, List<EarthquakeV1>>.internal(
  EarthquakeHistoryNotifier.new,
  name: r'earthquakeHistoryNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$earthquakeHistoryNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$EarthquakeHistoryNotifier = AsyncNotifier<List<EarthquakeV1>>;
String _$earthquakeHistoryTotalCountHash() =>
    r'5b9331fd3a026ba2b6fe24687966484dc79482ee';

/// See also [EarthquakeHistoryTotalCount].
@ProviderFor(EarthquakeHistoryTotalCount)
final earthquakeHistoryTotalCountProvider =
    NotifierProvider<EarthquakeHistoryTotalCount, int?>.internal(
  EarthquakeHistoryTotalCount.new,
  name: r'earthquakeHistoryTotalCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$earthquakeHistoryTotalCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$EarthquakeHistoryTotalCount = Notifier<int?>;
String _$earthquakeHistoryParameterNotifierHash() =>
    r'ef89f5a80c8b2e1d4cdf9ed97d2e281e81caef4f';

/// See also [EarthquakeHistoryParameterNotifier].
@ProviderFor(EarthquakeHistoryParameterNotifier)
final earthquakeHistoryParameterNotifierProvider = NotifierProvider<
    EarthquakeHistoryParameterNotifier, EarthquakeHistoryParameter>.internal(
  EarthquakeHistoryParameterNotifier.new,
  name: r'earthquakeHistoryParameterNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$earthquakeHistoryParameterNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$EarthquakeHistoryParameterNotifier
    = Notifier<EarthquakeHistoryParameter>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
