// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'kyoshin_monitor_timer_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(KyoshinMonitorTimerNotifier)
const kyoshinMonitorTimerNotifierProvider =
    KyoshinMonitorTimerNotifierProvider._();

final class KyoshinMonitorTimerNotifierProvider
    extends
        $StreamNotifierProvider<
          KyoshinMonitorTimerNotifier,
          KyoshinMonitorTimerState
        > {
  const KyoshinMonitorTimerNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinMonitorTimerNotifierProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kyoshinMonitorTimerNotifierHash();

  @$internal
  @override
  KyoshinMonitorTimerNotifier create() => KyoshinMonitorTimerNotifier();

  @$internal
  @override
  $StreamNotifierProviderElement<
    KyoshinMonitorTimerNotifier,
    KyoshinMonitorTimerState
  >
  $createElement($ProviderPointer pointer) =>
      $StreamNotifierProviderElement(pointer);
}

String _$kyoshinMonitorTimerNotifierHash() =>
    r'344b38935163fac1cce8de724e781381158eb1db';

abstract class _$KyoshinMonitorTimerNotifier
    extends $StreamNotifier<KyoshinMonitorTimerState> {
  Stream<KyoshinMonitorTimerState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<KyoshinMonitorTimerState>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<KyoshinMonitorTimerState>>,
              AsyncValue<KyoshinMonitorTimerState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(_kyoshinMonitorDelayAdujustTiming)
const _kyoshinMonitorDelayAdujustTimingProvider =
    _KyoshinMonitorDelayAdujustTimingProvider._();

final class _KyoshinMonitorDelayAdujustTimingProvider
    extends $FunctionalProvider<AsyncValue<void>, Stream<void>>
    with $FutureModifier<void>, $StreamProvider<void> {
  const _KyoshinMonitorDelayAdujustTimingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_kyoshinMonitorDelayAdujustTimingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kyoshinMonitorDelayAdujustTimingHash();

  @$internal
  @override
  $StreamProviderElement<void> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<void> create(Ref ref) {
    return _kyoshinMonitorDelayAdujustTiming(ref);
  }
}

String _$kyoshinMonitorDelayAdujustTimingHash() =>
    r'9596c780015c7ef05f31704d32976671e7500925';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
