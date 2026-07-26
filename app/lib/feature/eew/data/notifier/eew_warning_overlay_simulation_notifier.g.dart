// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_warning_overlay_simulation_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EewWarningOverlaySimulation)
final eewWarningOverlaySimulationProvider =
    EewWarningOverlaySimulationProvider._();

final class EewWarningOverlaySimulationProvider
    extends
        $NotifierProvider<
          EewWarningOverlaySimulation,
          EewWarningOverlayDisplayModel?
        > {
  EewWarningOverlaySimulationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eewWarningOverlaySimulationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eewWarningOverlaySimulationHash();

  @$internal
  @override
  EewWarningOverlaySimulation create() => EewWarningOverlaySimulation();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EewWarningOverlayDisplayModel? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EewWarningOverlayDisplayModel?>(
        value,
      ),
    );
  }
}

String _$eewWarningOverlaySimulationHash() =>
    r'40a3810f42241ec519f80046f87d6853aab518ae';

abstract class _$EewWarningOverlaySimulation
    extends $Notifier<EewWarningOverlayDisplayModel?> {
  EewWarningOverlayDisplayModel? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              EewWarningOverlayDisplayModel?,
              EewWarningOverlayDisplayModel?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                EewWarningOverlayDisplayModel?,
                EewWarningOverlayDisplayModel?
              >,
              EewWarningOverlayDisplayModel?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
