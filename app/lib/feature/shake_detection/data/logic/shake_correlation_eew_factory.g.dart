// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_correlation_eew_factory.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(shakeCorrelationEewFactory)
final shakeCorrelationEewFactoryProvider =
    ShakeCorrelationEewFactoryProvider._();

final class ShakeCorrelationEewFactoryProvider
    extends
        $FunctionalProvider<
          ShakeCorrelationEewFactory,
          ShakeCorrelationEewFactory,
          ShakeCorrelationEewFactory
        >
    with $Provider<ShakeCorrelationEewFactory> {
  ShakeCorrelationEewFactoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shakeCorrelationEewFactoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shakeCorrelationEewFactoryHash();

  @$internal
  @override
  $ProviderElement<ShakeCorrelationEewFactory> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ShakeCorrelationEewFactory create(Ref ref) {
    return shakeCorrelationEewFactory(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ShakeCorrelationEewFactory value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ShakeCorrelationEewFactory>(value),
    );
  }
}

String _$shakeCorrelationEewFactoryHash() =>
    r'5e8f41e2bb0651420700410372ce1fb15e2d6ad1';
