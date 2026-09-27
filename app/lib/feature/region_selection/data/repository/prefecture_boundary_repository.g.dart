// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'prefecture_boundary_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(prefectureBoundaryGeoJson)
final prefectureBoundaryGeoJsonProvider = PrefectureBoundaryGeoJsonProvider._();

final class PrefectureBoundaryGeoJsonProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  PrefectureBoundaryGeoJsonProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'prefectureBoundaryGeoJsonProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$prefectureBoundaryGeoJsonHash();

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    return prefectureBoundaryGeoJson(ref);
  }
}

String _$prefectureBoundaryGeoJsonHash() =>
    r'cd6316f96c3caed1448787e8b80111185d54af79';
