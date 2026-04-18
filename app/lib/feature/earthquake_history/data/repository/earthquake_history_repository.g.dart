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
          AsyncValue<EarthquakeHistoryRepository>,
          EarthquakeHistoryRepository,
          FutureOr<EarthquakeHistoryRepository>
        >
    with
        $FutureModifier<EarthquakeHistoryRepository>,
        $FutureProvider<EarthquakeHistoryRepository> {
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
  $FutureProviderElement<EarthquakeHistoryRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<EarthquakeHistoryRepository> create(Ref ref) {
    return earthquakeHistoryRepository(ref);
  }
}

String _$earthquakeHistoryRepositoryHash() =>
    r'cc977a936429b9398b20432b23a827f69bc182f2';
