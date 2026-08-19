// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'bundled_asset_pack_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bundledAssetPackRepository)
final bundledAssetPackRepositoryProvider =
    BundledAssetPackRepositoryProvider._();

final class BundledAssetPackRepositoryProvider
    extends
        $FunctionalProvider<
          BundledAssetPackRepository,
          BundledAssetPackRepository,
          BundledAssetPackRepository
        >
    with $Provider<BundledAssetPackRepository> {
  BundledAssetPackRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bundledAssetPackRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bundledAssetPackRepositoryHash();

  @$internal
  @override
  $ProviderElement<BundledAssetPackRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BundledAssetPackRepository create(Ref ref) {
    return bundledAssetPackRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BundledAssetPackRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BundledAssetPackRepository>(value),
    );
  }
}

String _$bundledAssetPackRepositoryHash() =>
    r'b85690761f0e1d93fd7074d6bd22d94c056312b2';
