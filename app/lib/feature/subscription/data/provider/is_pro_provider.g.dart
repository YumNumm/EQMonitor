// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'is_pro_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// P5実装前のスタブ。RevenueCat連携後にProユーザー判定に置き換える。

@ProviderFor(isPro)
final isProProvider = IsProProvider._();

/// P5実装前のスタブ。RevenueCat連携後にProユーザー判定に置き換える。

final class IsProProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// P5実装前のスタブ。RevenueCat連携後にProユーザー判定に置き換える。
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

String _$isProHash() => r'9126025efc06867fc0949744acfb88c941280888';
