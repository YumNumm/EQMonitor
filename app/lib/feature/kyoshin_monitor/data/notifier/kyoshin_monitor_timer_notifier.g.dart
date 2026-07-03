// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_monitor_timer_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(KyoshinMonitorTimerNotifier)
final kyoshinMonitorTimerProvider = KyoshinMonitorTimerNotifierProvider._();

final class KyoshinMonitorTimerNotifierProvider
    extends
        $StreamNotifierProvider<
          KyoshinMonitorTimerNotifier,
          KyoshinMonitorTimerState
        > {
  KyoshinMonitorTimerNotifierProvider._()
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
    r'1c7cf81d8a764d535b833edabdd547f9a907a578';

abstract class _$KyoshinMonitorTimerNotifier
    extends $StreamNotifier<KyoshinMonitorTimerState> {
  Stream<KyoshinMonitorTimerState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
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
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(_kyoshinMonitorDelayAdujustTiming)
final _kyoshinMonitorDelayAdujustTimingProvider =
    _KyoshinMonitorDelayAdujustTimingProvider._();

final class _KyoshinMonitorDelayAdujustTimingProvider
    extends $FunctionalProvider<AsyncValue<void>, void, Stream<void>>
    with $FutureModifier<void>, $StreamProvider<void> {
  _KyoshinMonitorDelayAdujustTimingProvider._()
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
    r'30ebe12b8a5774dcdbd29f62ae0357147f91d08c';
