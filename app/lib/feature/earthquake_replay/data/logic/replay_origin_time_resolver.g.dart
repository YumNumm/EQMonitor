// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_origin_time_resolver.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(replayOriginTimeResolver)
final replayOriginTimeResolverProvider = ReplayOriginTimeResolverProvider._();

final class ReplayOriginTimeResolverProvider
    extends
        $FunctionalProvider<
          ReplayOriginTimeResolver,
          ReplayOriginTimeResolver,
          ReplayOriginTimeResolver
        >
    with $Provider<ReplayOriginTimeResolver> {
  ReplayOriginTimeResolverProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replayOriginTimeResolverProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replayOriginTimeResolverHash();

  @$internal
  @override
  $ProviderElement<ReplayOriginTimeResolver> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReplayOriginTimeResolver create(Ref ref) {
    return replayOriginTimeResolver(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReplayOriginTimeResolver value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReplayOriginTimeResolver>(value),
    );
  }
}

String _$replayOriginTimeResolverHash() =>
    r'cfb25a90061aacbc1eb2ed759adc718da5b11a59';
