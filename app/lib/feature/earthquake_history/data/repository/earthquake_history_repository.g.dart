// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'earthquake_history_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(earthquakeHistoryRepository)
const earthquakeHistoryRepositoryProvider =
    EarthquakeHistoryRepositoryProvider._();

final class EarthquakeHistoryRepositoryProvider
    extends
        $FunctionalProvider<
          EarthquakeHistoryRepository,
          EarthquakeHistoryRepository
        >
    with $Provider<EarthquakeHistoryRepository> {
  const EarthquakeHistoryRepositoryProvider._()
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
      providerOverride: $ValueProvider<EarthquakeHistoryRepository>(value),
    );
  }
}

String _$earthquakeHistoryRepositoryHash() =>
    r'8334b94379f200439f3674d3213767e575237279';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
