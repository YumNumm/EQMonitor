// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'city_max_intensity_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(cityMaxIntensityRepository)
final cityMaxIntensityRepositoryProvider =
    CityMaxIntensityRepositoryProvider._();

final class CityMaxIntensityRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<CityMaxIntensityRepository>,
          CityMaxIntensityRepository,
          FutureOr<CityMaxIntensityRepository>
        >
    with
        $FutureModifier<CityMaxIntensityRepository>,
        $FutureProvider<CityMaxIntensityRepository> {
  CityMaxIntensityRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cityMaxIntensityRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cityMaxIntensityRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<CityMaxIntensityRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CityMaxIntensityRepository> create(Ref ref) {
    return cityMaxIntensityRepository(ref);
  }
}

String _$cityMaxIntensityRepositoryHash() =>
    r'ea37493d797ed2acd927f6898dec4c041baea142';
