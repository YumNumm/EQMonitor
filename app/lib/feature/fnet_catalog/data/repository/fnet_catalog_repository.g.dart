// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'fnet_catalog_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fnetCatalogRepository)
const fnetCatalogRepositoryProvider = FnetCatalogRepositoryProvider._();

final class FnetCatalogRepositoryProvider
    extends
        $FunctionalProvider<
          FnetCatalogRepository,
          FnetCatalogRepository,
          FnetCatalogRepository
        >
    with $Provider<FnetCatalogRepository> {
  const FnetCatalogRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fnetCatalogRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fnetCatalogRepositoryHash();

  @$internal
  @override
  $ProviderElement<FnetCatalogRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FnetCatalogRepository create(Ref ref) {
    return fnetCatalogRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FnetCatalogRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FnetCatalogRepository>(value),
    );
  }
}

String _$fnetCatalogRepositoryHash() =>
    r'4eda8b05040a963e3f2f24ad37060845844659c7';
