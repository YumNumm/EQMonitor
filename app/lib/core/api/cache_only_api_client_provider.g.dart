// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'cache_only_api_client_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(cacheOnlyApiClient)
final cacheOnlyApiClientProvider = CacheOnlyApiClientProvider._();

final class CacheOnlyApiClientProvider
    extends
        $FunctionalProvider<
          AsyncValue<ApiClient>,
          ApiClient,
          FutureOr<ApiClient>
        >
    with $FutureModifier<ApiClient>, $FutureProvider<ApiClient> {
  CacheOnlyApiClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cacheOnlyApiClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cacheOnlyApiClientHash();

  @$internal
  @override
  $FutureProviderElement<ApiClient> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<ApiClient> create(Ref ref) {
    return cacheOnlyApiClient(ref);
  }
}

String _$cacheOnlyApiClientHash() =>
    r'f65b45995eba9cf80761f24ce669c576e36bd7c9';
