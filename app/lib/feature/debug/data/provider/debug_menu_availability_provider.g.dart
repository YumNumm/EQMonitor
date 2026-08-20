// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'debug_menu_availability_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// デバッグメニュー(`/settings/debug` 配下)を開いてよいか。
///
/// 判定ロジックは [resolveDebugMenuAvailability] を参照。
///
/// go_router の `redirect` から同期的に読むため、非同期依存は
/// [AsyncValue.value] を参照する。ロール取得前は null 扱いで権限なし側に倒れ、
/// 取得完了後に再評価される。
///
/// keepAlive にしているのは、`redirect` の単発の [Ref.read] で
/// 非同期依存が未解決のまま false と判定され、正当な遷移が弾かれるのを防ぐため。

@ProviderFor(isDebugMenuAvailable)
final isDebugMenuAvailableProvider = IsDebugMenuAvailableProvider._();

/// デバッグメニュー(`/settings/debug` 配下)を開いてよいか。
///
/// 判定ロジックは [resolveDebugMenuAvailability] を参照。
///
/// go_router の `redirect` から同期的に読むため、非同期依存は
/// [AsyncValue.value] を参照する。ロール取得前は null 扱いで権限なし側に倒れ、
/// 取得完了後に再評価される。
///
/// keepAlive にしているのは、`redirect` の単発の [Ref.read] で
/// 非同期依存が未解決のまま false と判定され、正当な遷移が弾かれるのを防ぐため。

final class IsDebugMenuAvailableProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// デバッグメニュー(`/settings/debug` 配下)を開いてよいか。
  ///
  /// 判定ロジックは [resolveDebugMenuAvailability] を参照。
  ///
  /// go_router の `redirect` から同期的に読むため、非同期依存は
  /// [AsyncValue.value] を参照する。ロール取得前は null 扱いで権限なし側に倒れ、
  /// 取得完了後に再評価される。
  ///
  /// keepAlive にしているのは、`redirect` の単発の [Ref.read] で
  /// 非同期依存が未解決のまま false と判定され、正当な遷移が弾かれるのを防ぐため。
  IsDebugMenuAvailableProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isDebugMenuAvailableProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isDebugMenuAvailableHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isDebugMenuAvailable(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isDebugMenuAvailableHash() =>
    r'5c4578be7946880fd8d820ae71e5db65de936467';
