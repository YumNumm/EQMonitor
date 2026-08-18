// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'asset_pack_storage_root_resolver.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(assetPackStorageRootResolver)
final assetPackStorageRootResolverProvider =
    AssetPackStorageRootResolverProvider._();

final class AssetPackStorageRootResolverProvider
    extends
        $FunctionalProvider<
          AssetPackStorageRootResolver,
          AssetPackStorageRootResolver,
          AssetPackStorageRootResolver
        >
    with $Provider<AssetPackStorageRootResolver> {
  AssetPackStorageRootResolverProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'assetPackStorageRootResolverProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$assetPackStorageRootResolverHash();

  @$internal
  @override
  $ProviderElement<AssetPackStorageRootResolver> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AssetPackStorageRootResolver create(Ref ref) {
    return assetPackStorageRootResolver(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AssetPackStorageRootResolver value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AssetPackStorageRootResolver>(value),
    );
  }
}

String _$assetPackStorageRootResolverHash() =>
    r'ce9b71000ba1802815b03fe23afec50fda432702';
