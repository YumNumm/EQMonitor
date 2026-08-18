// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'jma_region_resolver.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(jmaRegionResolver)
final jmaRegionResolverProvider = JmaRegionResolverProvider._();

final class JmaRegionResolverProvider
    extends
        $FunctionalProvider<
          AsyncValue<JmaRegionResolver>,
          JmaRegionResolver,
          FutureOr<JmaRegionResolver>
        >
    with
        $FutureModifier<JmaRegionResolver>,
        $FutureProvider<JmaRegionResolver> {
  JmaRegionResolverProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'jmaRegionResolverProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$jmaRegionResolverHash();

  @$internal
  @override
  $FutureProviderElement<JmaRegionResolver> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<JmaRegionResolver> create(Ref ref) {
    return jmaRegionResolver(ref);
  }
}

String _$jmaRegionResolverHash() => r'6745c38600afb2e8cf44c9d6226ce3766c6a15a0';
