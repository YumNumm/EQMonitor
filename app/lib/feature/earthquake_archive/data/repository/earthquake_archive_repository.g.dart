// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_archive_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(earthquakeArchiveRepository)
final earthquakeArchiveRepositoryProvider =
    EarthquakeArchiveRepositoryProvider._();

final class EarthquakeArchiveRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<EarthquakeArchiveRepository>,
          EarthquakeArchiveRepository,
          FutureOr<EarthquakeArchiveRepository>
        >
    with
        $FutureModifier<EarthquakeArchiveRepository>,
        $FutureProvider<EarthquakeArchiveRepository> {
  EarthquakeArchiveRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'earthquakeArchiveRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$earthquakeArchiveRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<EarthquakeArchiveRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<EarthquakeArchiveRepository> create(Ref ref) {
    return earthquakeArchiveRepository(ref);
  }
}

String _$earthquakeArchiveRepositoryHash() =>
    r'1e9cd9452baef67ee5c35b9e35efa9e49dd1b386';
