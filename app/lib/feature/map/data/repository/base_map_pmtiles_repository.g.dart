// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'base_map_pmtiles_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(baseMapPmtilesRepository)
final baseMapPmtilesRepositoryProvider = BaseMapPmtilesRepositoryProvider._();

final class BaseMapPmtilesRepositoryProvider
    extends
        $FunctionalProvider<
          BaseMapPmtilesRepository,
          BaseMapPmtilesRepository,
          BaseMapPmtilesRepository
        >
    with $Provider<BaseMapPmtilesRepository> {
  BaseMapPmtilesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'baseMapPmtilesRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$baseMapPmtilesRepositoryHash();

  @$internal
  @override
  $ProviderElement<BaseMapPmtilesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BaseMapPmtilesRepository create(Ref ref) {
    return baseMapPmtilesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BaseMapPmtilesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BaseMapPmtilesRepository>(value),
    );
  }
}

String _$baseMapPmtilesRepositoryHash() =>
    r'6f48c9622e85f0153790543a91a6e28f5ab24863';
