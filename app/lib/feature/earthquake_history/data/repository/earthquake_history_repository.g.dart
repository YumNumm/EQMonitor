// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_history_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(earthquakeHistoryRepository)
final earthquakeHistoryRepositoryProvider =
    EarthquakeHistoryRepositoryProvider._();

final class EarthquakeHistoryRepositoryProvider
    extends
        $FunctionalProvider<
          EarthquakeHistoryRepository,
          EarthquakeHistoryRepository,
          EarthquakeHistoryRepository
        >
    with $Provider<EarthquakeHistoryRepository> {
  EarthquakeHistoryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'earthquakeHistoryRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$earthquakeHistoryRepositoryHash();

  @$internal
  @override
  $ProviderElement<EarthquakeHistoryRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EarthquakeHistoryRepository create(Ref ref) {
    return earthquakeHistoryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EarthquakeHistoryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EarthquakeHistoryRepository>(value),
    );
  }
}

String _$earthquakeHistoryRepositoryHash() =>
    r'c9b7ff5f15475ddb3ffe29bf95bc86e2049802ae';
