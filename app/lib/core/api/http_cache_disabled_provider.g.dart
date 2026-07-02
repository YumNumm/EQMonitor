// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'http_cache_disabled_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// HTTPキャッシュ(ETag/304透過キャッシュ)の読み書きを完全に無効化するフラグ。
/// デバッグ用途。変更は [dio] が watch しているため即座に反映される。

@ProviderFor(HttpCacheDisabled)
final httpCacheDisabledProvider = HttpCacheDisabledProvider._();

/// HTTPキャッシュ(ETag/304透過キャッシュ)の読み書きを完全に無効化するフラグ。
/// デバッグ用途。変更は [dio] が watch しているため即座に反映される。
final class HttpCacheDisabledProvider
    extends $NotifierProvider<HttpCacheDisabled, bool> {
  /// HTTPキャッシュ(ETag/304透過キャッシュ)の読み書きを完全に無効化するフラグ。
  /// デバッグ用途。変更は [dio] が watch しているため即座に反映される。
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

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$httpCacheDisabledHash() => r'080ae9e009188f1951fc33eab7d37153d807f09c';

/// HTTPキャッシュ(ETag/304透過キャッシュ)の読み書きを完全に無効化するフラグ。
/// デバッグ用途。変更は [dio] が watch しているため即座に反映される。

abstract class _$HttpCacheDisabled extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
