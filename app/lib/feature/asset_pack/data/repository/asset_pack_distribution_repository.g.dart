// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'asset_pack_distribution_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(assetPackDistributionRepository)
final assetPackDistributionRepositoryProvider =
    AssetPackDistributionRepositoryProvider._();

final class AssetPackDistributionRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<AssetPackDistributionRepository>,
          AssetPackDistributionRepository,
          FutureOr<AssetPackDistributionRepository>
        >
    with
        $FutureModifier<AssetPackDistributionRepository>,
        $FutureProvider<AssetPackDistributionRepository> {
  AssetPackDistributionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'assetPackDistributionRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$assetPackDistributionRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<AssetPackDistributionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AssetPackDistributionRepository> create(Ref ref) {
    return assetPackDistributionRepository(ref);
  }
}

String _$assetPackDistributionRepositoryHash() =>
    r'a5a42e451bbd5eea61cd2c050654d28d5c82415b';
