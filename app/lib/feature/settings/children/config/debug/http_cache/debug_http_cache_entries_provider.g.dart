// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'debug_http_cache_entries_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(debugHttpCacheEntries)
final debugHttpCacheEntriesProvider = DebugHttpCacheEntriesProvider._();

final class DebugHttpCacheEntriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<HttpCacheEntrySummary>>,
          List<HttpCacheEntrySummary>,
          FutureOr<List<HttpCacheEntrySummary>>
        >
    with
        $FutureModifier<List<HttpCacheEntrySummary>>,
        $FutureProvider<List<HttpCacheEntrySummary>> {
  DebugHttpCacheEntriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debugHttpCacheEntriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debugHttpCacheEntriesHash();

  @$internal
  @override
  $FutureProviderElement<List<HttpCacheEntrySummary>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<HttpCacheEntrySummary>> create(Ref ref) {
    return debugHttpCacheEntries(ref);
  }
}

String _$debugHttpCacheEntriesHash() =>
    r'846e5636a7e289a85a1b340e64572ba12967cc7a';
