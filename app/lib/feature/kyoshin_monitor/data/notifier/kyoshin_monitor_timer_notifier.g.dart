// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_monitor_timer_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(KyoshinMonitorTimerNotifier)
const kyoshinMonitorTimerProvider = KyoshinMonitorTimerNotifierProvider._();

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
        name: r'kyoshinMonitorTimerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kyoshinMonitorTimerNotifierHash();

  @$internal
  @override
  KyoshinMonitorTimerNotifier create() => KyoshinMonitorTimerNotifier();
}

String _$kyoshinMonitorTimerNotifierHash() =>
    r'3ea60c4fc259d3acb3613b1527588bd19fc5a104';

abstract class _$KyoshinMonitorTimerNotifier
    extends $StreamNotifier<KyoshinMonitorTimerState> {
  Stream<KyoshinMonitorTimerState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<KyoshinMonitorTimerState>,
              KyoshinMonitorTimerState
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<KyoshinMonitorTimerState>,
                KyoshinMonitorTimerState
              >,
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
    extends $FunctionalProvider<AsyncValue<void>, void, Stream<void>>
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
  String debugGetCreateSourceHash() =>
      _$_kyoshinMonitorDelayAdujustTimingHash();

  @$internal
  @override
  $StreamProviderElement<void> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<void> create(Ref ref) {
    return _kyoshinMonitorDelayAdujustTiming(ref);
  }
}

String _$_kyoshinMonitorDelayAdujustTimingHash() =>
    r'22076cb0817ae86324e077e4b874977f1d4fb9f1';
