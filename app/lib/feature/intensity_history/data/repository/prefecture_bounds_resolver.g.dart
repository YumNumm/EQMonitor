// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'prefecture_bounds_resolver.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(prefectureBoundsResolver)
final prefectureBoundsResolverProvider = PrefectureBoundsResolverProvider._();

final class PrefectureBoundsResolverProvider
    extends
        $FunctionalProvider<
          PrefectureBoundsResolver,
          PrefectureBoundsResolver,
          PrefectureBoundsResolver
        >
    with $Provider<PrefectureBoundsResolver> {
  PrefectureBoundsResolverProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'prefectureBoundsResolverProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$prefectureBoundsResolverHash();

  @$internal
  @override
  $ProviderElement<PrefectureBoundsResolver> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PrefectureBoundsResolver create(Ref ref) {
    return prefectureBoundsResolver(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PrefectureBoundsResolver value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PrefectureBoundsResolver>(value),
    );
  }
}

String _$prefectureBoundsResolverHash() =>
    r'de74e06bfdf0536e3c7ef7d9badcf4dc637fa5ce';
