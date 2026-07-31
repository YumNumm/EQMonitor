// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'asset_pack_debug_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(assetPackDebugRepository)
final assetPackDebugRepositoryProvider = AssetPackDebugRepositoryProvider._();

final class AssetPackDebugRepositoryProvider
    extends
        $FunctionalProvider<
          AssetPackDebugRepository,
          AssetPackDebugRepository,
          AssetPackDebugRepository
        >
    with $Provider<AssetPackDebugRepository> {
  AssetPackDebugRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'assetPackDebugRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$assetPackDebugRepositoryHash();

  @$internal
  @override
  $ProviderElement<AssetPackDebugRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AssetPackDebugRepository create(Ref ref) {
    return assetPackDebugRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AssetPackDebugRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AssetPackDebugRepository>(value),
    );
  }
}

String _$assetPackDebugRepositoryHash() =>
    r'cfc1fb9dceef5c71e638ab49aee9f38ab782068d';
