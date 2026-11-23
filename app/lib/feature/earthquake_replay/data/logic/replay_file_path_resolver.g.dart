// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_file_path_resolver.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(replayFilePathResolver)
final replayFilePathResolverProvider = ReplayFilePathResolverProvider._();

final class ReplayFilePathResolverProvider
    extends
        $FunctionalProvider<
          ReplayFilePathResolver,
          ReplayFilePathResolver,
          ReplayFilePathResolver
        >
    with $Provider<ReplayFilePathResolver> {
  ReplayFilePathResolverProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replayFilePathResolverProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replayFilePathResolverHash();

  @$internal
  @override
  $ProviderElement<ReplayFilePathResolver> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReplayFilePathResolver create(Ref ref) {
    return replayFilePathResolver(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReplayFilePathResolver value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReplayFilePathResolver>(value),
    );
  }
}

String _$replayFilePathResolverHash() =>
    r'8f0a733c6cb20afeb46d3f85b9cd2a90b705df82';
