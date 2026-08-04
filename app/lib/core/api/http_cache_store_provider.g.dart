// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'http_cache_store_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(httpCacheStore)
final httpCacheStoreProvider = HttpCacheStoreProvider._();

final class HttpCacheStoreProvider
    extends
        $FunctionalProvider<
          AsyncValue<HttpCacheStore>,
          HttpCacheStore,
          FutureOr<HttpCacheStore>
        >
    with $FutureModifier<HttpCacheStore>, $FutureProvider<HttpCacheStore> {
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

String _$httpCacheStoreHash() => r'f0f302817a88ec97568ac7cc32b654eb99981d07';
