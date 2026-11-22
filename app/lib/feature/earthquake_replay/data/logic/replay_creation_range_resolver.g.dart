// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_creation_range_resolver.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(replayCreationRangeResolver)
final replayCreationRangeResolverProvider =
    ReplayCreationRangeResolverProvider._();

final class ReplayCreationRangeResolverProvider
    extends
        $FunctionalProvider<
          ReplayCreationRangeResolver,
          ReplayCreationRangeResolver,
          ReplayCreationRangeResolver
        >
    with $Provider<ReplayCreationRangeResolver> {
  ReplayCreationRangeResolverProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replayCreationRangeResolverProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replayCreationRangeResolverHash();

  @$internal
  @override
  $ProviderElement<ReplayCreationRangeResolver> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReplayCreationRangeResolver create(Ref ref) {
    return replayCreationRangeResolver(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReplayCreationRangeResolver value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReplayCreationRangeResolver>(value),
    );
  }
}

String _$replayCreationRangeResolverHash() =>
    r'b7df30cbe50a6bbab0d348f4abb4bf8dda5b045d';
