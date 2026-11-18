// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'debug_access_level_resolver.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(debugAccessLevelResolver)
final debugAccessLevelResolverProvider = DebugAccessLevelResolverProvider._();

final class DebugAccessLevelResolverProvider
    extends
        $FunctionalProvider<
          DebugAccessLevelResolver,
          DebugAccessLevelResolver,
          DebugAccessLevelResolver
        >
    with $Provider<DebugAccessLevelResolver> {
  DebugAccessLevelResolverProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debugAccessLevelResolverProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debugAccessLevelResolverHash();

  @$internal
  @override
  $ProviderElement<DebugAccessLevelResolver> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DebugAccessLevelResolver create(Ref ref) {
    return debugAccessLevelResolver(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DebugAccessLevelResolver value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DebugAccessLevelResolver>(value),
    );
  }
}

String _$debugAccessLevelResolverHash() =>
    r'9434f0fb084b77e837001167b513cb51d994c136';
