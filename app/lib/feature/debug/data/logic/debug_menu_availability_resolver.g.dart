// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'debug_menu_availability_resolver.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(debugMenuAvailabilityResolver)
final debugMenuAvailabilityResolverProvider =
    DebugMenuAvailabilityResolverProvider._();

final class DebugMenuAvailabilityResolverProvider
    extends
        $FunctionalProvider<
          DebugMenuAvailabilityResolver,
          DebugMenuAvailabilityResolver,
          DebugMenuAvailabilityResolver
        >
    with $Provider<DebugMenuAvailabilityResolver> {
  DebugMenuAvailabilityResolverProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debugMenuAvailabilityResolverProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debugMenuAvailabilityResolverHash();

  @$internal
  @override
  $ProviderElement<DebugMenuAvailabilityResolver> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DebugMenuAvailabilityResolver create(Ref ref) {
    return debugMenuAvailabilityResolver(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DebugMenuAvailabilityResolver value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DebugMenuAvailabilityResolver>(
        value,
      ),
    );
  }
}

String _$debugMenuAvailabilityResolverHash() =>
    r'6fc9fb3f207548489f397ee6fd7537e266e676cf';
