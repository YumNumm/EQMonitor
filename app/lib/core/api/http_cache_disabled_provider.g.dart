// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'http_cache_disabled_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// HTTPキャッシュ(ETag/304透過キャッシュ)の読み書きを完全に無効化するフラグ。
/// デバッグ用途。変更は dio プロバイダが watch しているため即座に反映される。

@ProviderFor(HttpCacheDisabled)
final httpCacheDisabledProvider = HttpCacheDisabledProvider._();

/// HTTPキャッシュ(ETag/304透過キャッシュ)の読み書きを完全に無効化するフラグ。
/// デバッグ用途。変更は dio プロバイダが watch しているため即座に反映される。
final class HttpCacheDisabledProvider
    extends $AsyncNotifierProvider<HttpCacheDisabled, bool> {
  /// HTTPキャッシュ(ETag/304透過キャッシュ)の読み書きを完全に無効化するフラグ。
  /// デバッグ用途。変更は dio プロバイダが watch しているため即座に反映される。
  HttpCacheDisabledProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'httpCacheDisabledProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$httpCacheDisabledHash();

  @$internal
  @override
  HttpCacheDisabled create() => HttpCacheDisabled();
}

String _$httpCacheDisabledHash() => r'ae9551c321718ad1e481a76fad8351f840103a5c';

/// HTTPキャッシュ(ETag/304透過キャッシュ)の読み書きを完全に無効化するフラグ。
/// デバッグ用途。変更は dio プロバイダが watch しているため即座に反映される。

abstract class _$HttpCacheDisabled extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
