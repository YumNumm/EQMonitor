// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'should_show_ads_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 広告を表示すべきかどうかを返す。
/// 以下のいずれかに該当する場合は false:
/// - Proユーザー
/// - サーバフラグ (ads_enabled) が false
/// - EEW発報中
/// - ユーザーがオプトアウト済み

@ProviderFor(shouldShowAds)
final shouldShowAdsProvider = ShouldShowAdsProvider._();

/// 広告を表示すべきかどうかを返す。
/// 以下のいずれかに該当する場合は false:
/// - Proユーザー
/// - サーバフラグ (ads_enabled) が false
/// - EEW発報中
/// - ユーザーがオプトアウト済み

final class ShouldShowAdsProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// 広告を表示すべきかどうかを返す。
  /// 以下のいずれかに該当する場合は false:
  /// - Proユーザー
  /// - サーバフラグ (ads_enabled) が false
  /// - EEW発報中
  /// - ユーザーがオプトアウト済み
  ShouldShowAdsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shouldShowAdsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shouldShowAdsHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return shouldShowAds(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$shouldShowAdsHash() => r'f0ee7a02b3533a89cb43ac1b5077bf0d074c702a';
