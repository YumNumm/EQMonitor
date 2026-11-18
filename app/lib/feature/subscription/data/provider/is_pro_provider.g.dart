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

@ProviderFor(isPro)
final isProProvider = IsProProvider._();

/// Pro ユーザーかどうかを返す。
///
/// [subscriptionProvider] を watch し、active なら true。

final class IsProProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Pro ユーザーかどうかを返す。
  ///
  /// [subscriptionProvider] を watch し、active なら true。
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

String _$isProHash() => r'f9df95402989718da5a4c6433a3de58b8fec69c0';

/// 購読状態が確定している場合だけ、Pro ユーザーかどうかを返す。
///
/// 読み込み中・エラー時は null。[isProProvider] はその間 false を返すため、
/// 永続化する値（Widget と共有する App Group など）には、未確定の false で
/// 前回の値を上書きしないようこちらを使う。

@ProviderFor(confirmedIsPro)
final confirmedIsProProvider = ConfirmedIsProProvider._();

/// 購読状態が確定している場合だけ、Pro ユーザーかどうかを返す。
///
/// 読み込み中・エラー時は null。[isProProvider] はその間 false を返すため、
/// 永続化する値（Widget と共有する App Group など）には、未確定の false で
/// 前回の値を上書きしないようこちらを使う。

final class ConfirmedIsProProvider
    extends $FunctionalProvider<bool?, bool?, bool?>
    with $Provider<bool?> {
  /// 購読状態が確定している場合だけ、Pro ユーザーかどうかを返す。
  ///
  /// 読み込み中・エラー時は null。[isProProvider] はその間 false を返すため、
  /// 永続化する値（Widget と共有する App Group など）には、未確定の false で
  /// 前回の値を上書きしないようこちらを使う。
  ConfirmedIsProProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'confirmedIsProProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$confirmedIsProHash();

  @$internal
  @override
  $ProviderElement<bool?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool? create(Ref ref) {
    return confirmedIsPro(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool?>(value),
    );
  }
}

String _$confirmedIsProHash() => r'38a10f45451dbf9c57717bec50f2afe76f22ecec';
