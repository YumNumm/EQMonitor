// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'earthquake_history_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$earthquakeHistoryHasNextFetchHash() =>
    r'dbc04e4db75f455c34a5057c0bf368ece5c2dd19';

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
    r'0dab9a494bf9c1a41ae897ff5e074d7c3f350e3d';

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
