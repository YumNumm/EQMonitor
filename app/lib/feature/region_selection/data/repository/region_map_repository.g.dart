// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'region_map_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(regionMapRepository)
final regionMapRepositoryProvider = RegionMapRepositoryProvider._();

final class RegionMapRepositoryProvider
    extends
        $FunctionalProvider<
          RegionMapRepository,
          RegionMapRepository,
          RegionMapRepository
        >
    with $Provider<RegionMapRepository> {
  RegionMapRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'regionMapRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$regionMapRepositoryHash();

  @$internal
  @override
  $ProviderElement<RegionMapRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RegionMapRepository create(Ref ref) {
    return regionMapRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RegionMapRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RegionMapRepository>(value),
    );
  }
}

String _$regionMapRepositoryHash() =>
    r'4f31c7d9e4fa877782f1a8fe0f8e11e190998927';
