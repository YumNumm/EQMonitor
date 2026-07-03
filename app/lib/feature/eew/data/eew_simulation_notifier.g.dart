// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_simulation_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EewSimulation)
final eewSimulationProvider = EewSimulationProvider._();

final class EewSimulationProvider
    extends $NotifierProvider<EewSimulation, EewSimulationState?> {
  EewSimulationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eewSimulationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eewSimulationHash();

  @$internal
  @override
  EewSimulation create() => EewSimulation();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EewSimulationState? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EewSimulationState?>(value),
    );
  }
}

String _$eewSimulationHash() => r'4605b25bac107f08d347d8926939cb2b21e1a288';

abstract class _$EewSimulation extends $Notifier<EewSimulationState?> {
  EewSimulationState? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<EewSimulationState?, EewSimulationState?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EewSimulationState?, EewSimulationState?>,
              EewSimulationState?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
