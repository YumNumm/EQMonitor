// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'asset_pack_storage_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(assetPackStorageRepository)
final assetPackStorageRepositoryProvider =
    AssetPackStorageRepositoryProvider._();

final class AssetPackStorageRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<AssetPackStorageRepository>,
          AssetPackStorageRepository,
          FutureOr<AssetPackStorageRepository>
        >
    with
        $FutureModifier<AssetPackStorageRepository>,
        $FutureProvider<AssetPackStorageRepository> {
  AssetPackStorageRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'assetPackStorageRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$assetPackStorageRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<AssetPackStorageRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AssetPackStorageRepository> create(Ref ref) {
    return assetPackStorageRepository(ref);
  }
}

String _$assetPackStorageRepositoryHash() =>
    r'732040dfccc59ad4b5d9f8294bdb1c6387e0efe5';
