// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'ads_opt_out_flow.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(adsOptOutFlow)
final adsOptOutFlowProvider = AdsOptOutFlowProvider._();

final class AdsOptOutFlowProvider
    extends $FunctionalProvider<AdsOptOutFlow, AdsOptOutFlow, AdsOptOutFlow>
    with $Provider<AdsOptOutFlow> {
  AdsOptOutFlowProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adsOptOutFlowProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adsOptOutFlowHash();

  @$internal
  @override
  $ProviderElement<AdsOptOutFlow> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AdsOptOutFlow create(Ref ref) {
    return adsOptOutFlow(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdsOptOutFlow value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdsOptOutFlow>(value),
    );
  }
}

String _$adsOptOutFlowHash() => r'e4fc4ed9cb28ce6fb2583eefcb9ada13c16c878f';
