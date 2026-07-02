// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'http_cache_size_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// HTTPキャッシュDBファイルの実サイズ(バイト)。ファイル未作成時は 0。

@ProviderFor(httpCacheSize)
final httpCacheSizeProvider = HttpCacheSizeProvider._();

/// HTTPキャッシュDBファイルの実サイズ(バイト)。ファイル未作成時は 0。

final class HttpCacheSizeProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  /// HTTPキャッシュDBファイルの実サイズ(バイト)。ファイル未作成時は 0。
  HttpCacheSizeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'httpCacheSizeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$httpCacheSizeHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return httpCacheSize(ref);
  }
}

String _$httpCacheSizeHash() => r'50b8147f1bd28da18c2302f6caa0f64d4affd5bf';
