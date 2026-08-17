// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'seismicity_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(seismicityGeoJsonDio)
final seismicityGeoJsonDioProvider = SeismicityGeoJsonDioProvider._();

final class SeismicityGeoJsonDioProvider
    extends $FunctionalProvider<AsyncValue<Dio>, Dio, FutureOr<Dio>>
    with $FutureModifier<Dio>, $FutureProvider<Dio> {
  SeismicityGeoJsonDioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'seismicityGeoJsonDioProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$seismicityGeoJsonDioHash();

  @$internal
  @override
  $FutureProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Dio> create(Ref ref) {
    return seismicityGeoJsonDio(ref);
  }
}

String _$seismicityGeoJsonDioHash() =>
    r'231c9e7721e667fcfab83e2b84dff837e89a81d9';

@ProviderFor(seismicityRepository)
final seismicityRepositoryProvider = SeismicityRepositoryProvider._();

final class SeismicityRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<SeismicityRepository>,
          SeismicityRepository,
          FutureOr<SeismicityRepository>
        >
    with
        $FutureModifier<SeismicityRepository>,
        $FutureProvider<SeismicityRepository> {
  SeismicityRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'seismicityRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$seismicityRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<SeismicityRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SeismicityRepository> create(Ref ref) {
    return seismicityRepository(ref);
  }
}

String _$seismicityRepositoryHash() =>
    r'6a1352b0e51ebf8eb247d2a2ebc62ef156bfeddd';
