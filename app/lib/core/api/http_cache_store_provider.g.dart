// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'http_cache_store_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// API 層横断の ETag/304 HTTP キャッシュストア。
///
/// `DriftCacheStore` が絶対パス (`databasePath`) を要求するため、
/// `getApplicationSupportDirectory()` を await する非同期 Provider。
/// 計画D は `ref.watch(httpCacheStoreProvider.future)` で消費する。

@ProviderFor(httpCacheStore)
final httpCacheStoreProvider = HttpCacheStoreProvider._();

/// API 層横断の ETag/304 HTTP キャッシュストア。
///
/// `DriftCacheStore` が絶対パス (`databasePath`) を要求するため、
/// `getApplicationSupportDirectory()` を await する非同期 Provider。
/// 計画D は `ref.watch(httpCacheStoreProvider.future)` で消費する。

final class HttpCacheStoreProvider
    extends
        $FunctionalProvider<
          AsyncValue<HttpCacheStore>,
          HttpCacheStore,
          FutureOr<HttpCacheStore>
        >
    with $FutureModifier<HttpCacheStore>, $FutureProvider<HttpCacheStore> {
  /// API 層横断の ETag/304 HTTP キャッシュストア。
  ///
  /// `DriftCacheStore` が絶対パス (`databasePath`) を要求するため、
  /// `getApplicationSupportDirectory()` を await する非同期 Provider。
  /// 計画D は `ref.watch(httpCacheStoreProvider.future)` で消費する。
  HttpCacheStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'httpCacheStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$httpCacheStoreHash();

  @$internal
  @override
  $FutureProviderElement<HttpCacheStore> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<HttpCacheStore> create(Ref ref) {
    return httpCacheStore(ref);
  }
}

String _$httpCacheStoreHash() => r'3ee1a831990ec98213c0a23bab2060a5a215697f';
