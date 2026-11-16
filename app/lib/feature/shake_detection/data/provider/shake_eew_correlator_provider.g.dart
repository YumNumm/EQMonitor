// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_eew_correlator_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(shakeEewCorrelator)
final shakeEewCorrelatorProvider = ShakeEewCorrelatorProvider._();

final class ShakeEewCorrelatorProvider
    extends
        $FunctionalProvider<
          AsyncValue<ShakeEewCorrelator>,
          ShakeEewCorrelator,
          FutureOr<ShakeEewCorrelator>
        >
    with
        $FutureModifier<ShakeEewCorrelator>,
        $FutureProvider<ShakeEewCorrelator> {
  ShakeEewCorrelatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shakeEewCorrelatorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shakeEewCorrelatorHash();

  @$internal
  @override
  $FutureProviderElement<ShakeEewCorrelator> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ShakeEewCorrelator> create(Ref ref) {
    return shakeEewCorrelator(ref);
  }
}

String _$shakeEewCorrelatorHash() =>
    r'be3c9be470b15f3f22627751d55dc56f297f22bf';
