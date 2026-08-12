// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'is_pro_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Pro ユーザーかどうかを返す。
///
/// [subscriptionProvider] を watch し、active なら true。
/// ただし [BuildConfig.isProFeaturesEnabled] が false のビルドでは、Pro 機能を
/// 一時的に無効化しているため、購読状態に関わらず常に false を返す。

@ProviderFor(isPro)
final isProProvider = IsProProvider._();

/// Pro ユーザーかどうかを返す。
///
/// [subscriptionProvider] を watch し、active なら true。
/// ただし [BuildConfig.isProFeaturesEnabled] が false のビルドでは、Pro 機能を
/// 一時的に無効化しているため、購読状態に関わらず常に false を返す。

final class IsProProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Pro ユーザーかどうかを返す。
  ///
  /// [subscriptionProvider] を watch し、active なら true。
  /// ただし [BuildConfig.isProFeaturesEnabled] が false のビルドでは、Pro 機能を
  /// 一時的に無効化しているため、購読状態に関わらず常に false を返す。
  IsProProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isProProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isProHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isPro(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isProHash() => r'cd9d34f2a30f069ce325cb0ba46805338fa46000';
