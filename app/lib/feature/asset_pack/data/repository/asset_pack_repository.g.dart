// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'asset_pack_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(assetPackRepository)
final assetPackRepositoryProvider = AssetPackRepositoryProvider._();

final class AssetPackRepositoryProvider
    extends
        $FunctionalProvider<
          AssetPackRepository,
          AssetPackRepository,
          AssetPackRepository
        >
    with $Provider<AssetPackRepository> {
  AssetPackRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'assetPackRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$assetPackRepositoryHash();

  @$internal
  @override
  $ProviderElement<AssetPackRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AssetPackRepository create(Ref ref) {
    return assetPackRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AssetPackRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AssetPackRepository>(value),
    );
  }
}

String _$assetPackRepositoryHash() =>
    r'a4bf1e9c400b1dfe41e116f32fb7f6e629d6b1b7';
