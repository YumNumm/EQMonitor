// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'asset_pack_distribution_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Asset Pack の配布元（R2）へ更新情報と署名を取りに行く Dio。
///
/// 自前 API 用の Dio は端末 ID・認証・App Check の interceptor と、
/// アプリの版・端末種別のヘッダーを持つ。配布元は自前 API ではないため、
/// それらを送らない専用の Dio を使う。

@ProviderFor(assetPackDistributionDio)
final assetPackDistributionDioProvider = AssetPackDistributionDioProvider._();

/// Asset Pack の配布元（R2）へ更新情報と署名を取りに行く Dio。
///
/// 自前 API 用の Dio は端末 ID・認証・App Check の interceptor と、
/// アプリの版・端末種別のヘッダーを持つ。配布元は自前 API ではないため、
/// それらを送らない専用の Dio を使う。

final class AssetPackDistributionDioProvider
    extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  /// Asset Pack の配布元（R2）へ更新情報と署名を取りに行く Dio。
  ///
  /// 自前 API 用の Dio は端末 ID・認証・App Check の interceptor と、
  /// アプリの版・端末種別のヘッダーを持つ。配布元は自前 API ではないため、
  /// それらを送らない専用の Dio を使う。
  AssetPackDistributionDioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'assetPackDistributionDioProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$assetPackDistributionDioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return assetPackDistributionDio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$assetPackDistributionDioHash() =>
    r'6cd35b160f8690069e9f466f08502facfb1cfe66';

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
    r'2ef94d9108a7405793e8299514a0b2b5a64f538d';
