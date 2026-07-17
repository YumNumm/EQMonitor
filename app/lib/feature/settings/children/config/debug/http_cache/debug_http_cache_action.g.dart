// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'debug_http_cache_action.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(debugHttpCacheAction)
final debugHttpCacheActionProvider = DebugHttpCacheActionProvider._();

final class DebugHttpCacheActionProvider
    extends
        $FunctionalProvider<
          DebugHttpCacheAction,
          DebugHttpCacheAction,
          DebugHttpCacheAction
        >
    with $Provider<DebugHttpCacheAction> {
  DebugHttpCacheActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debugHttpCacheActionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debugHttpCacheActionHash();

  @$internal
  @override
  $ProviderElement<DebugHttpCacheAction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DebugHttpCacheAction create(Ref ref) {
    return debugHttpCacheAction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DebugHttpCacheAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DebugHttpCacheAction>(value),
    );
  }
}

String _$debugHttpCacheActionHash() =>
    r'3ca1d673089bd49dde88c56fcc421e6cb9eab454';
