// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'city_max_intensity_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 全国の市区町村ごとの観測史上最大震度をキャッシュする provider。

@ProviderFor(CityMaxIntensityNotifier)
final cityMaxIntensityProvider = CityMaxIntensityNotifierProvider._();

/// 全国の市区町村ごとの観測史上最大震度をキャッシュする provider。
final class CityMaxIntensityNotifierProvider
    extends $AsyncNotifierProvider<CityMaxIntensityNotifier, CityMaxIntensity> {
  /// 全国の市区町村ごとの観測史上最大震度をキャッシュする provider。
  CityMaxIntensityNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cityMaxIntensityProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cityMaxIntensityNotifierHash();

  @$internal
  @override
  CityMaxIntensityNotifier create() => CityMaxIntensityNotifier();
}

String _$cityMaxIntensityNotifierHash() =>
    r'172686190ae2bc399d82ed6b70cfaefe441e133e';

/// 全国の市区町村ごとの観測史上最大震度をキャッシュする provider。

abstract class _$CityMaxIntensityNotifier
    extends $AsyncNotifier<CityMaxIntensity> {
  FutureOr<CityMaxIntensity> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<CityMaxIntensity>, CityMaxIntensity>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CityMaxIntensity>, CityMaxIntensity>,
              AsyncValue<CityMaxIntensity>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
