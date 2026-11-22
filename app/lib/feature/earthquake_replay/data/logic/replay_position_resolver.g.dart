// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_position_resolver.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(replayPositionResolver)
final replayPositionResolverProvider = ReplayPositionResolverProvider._();

final class ReplayPositionResolverProvider
    extends
        $FunctionalProvider<
          ReplayPositionResolver,
          ReplayPositionResolver,
          ReplayPositionResolver
        >
    with $Provider<ReplayPositionResolver> {
  ReplayPositionResolverProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replayPositionResolverProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replayPositionResolverHash();

  @$internal
  @override
  $ProviderElement<ReplayPositionResolver> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReplayPositionResolver create(Ref ref) {
    return replayPositionResolver(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReplayPositionResolver value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReplayPositionResolver>(value),
    );
  }
}

String _$replayPositionResolverHash() =>
    r'f29c56c6bf395a5aa7dfca00462194d022b4bc07';
