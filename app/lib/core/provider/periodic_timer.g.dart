// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'periodic_timer.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PeriodicTimer)
const periodicTimerProvider = PeriodicTimerFamily._();

final class PeriodicTimerProvider
    extends $StreamNotifierProvider<PeriodicTimer, void> {
  const PeriodicTimerProvider._({
    required PeriodicTimerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'periodicTimerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$periodicTimerHash();

  @override
  String toString() {
    return r'periodicTimerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PeriodicTimer create() => PeriodicTimer();

  @override
  bool operator ==(Object other) {
    return other is PeriodicTimerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$periodicTimerHash() => r'4ae81efeee3972e537dbcab72d6beb423a755031';

final class PeriodicTimerFamily extends $Family
    with
        $ClassFamilyOverride<
          PeriodicTimer,
          AsyncValue<void>,
          void,
          Stream<void>,
          String
        > {
  const PeriodicTimerFamily._()
    : super(
        retry: null,
        name: r'periodicTimerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PeriodicTimerProvider call(String key) =>
      PeriodicTimerProvider._(argument: key, from: this);

  @override
  String toString() => r'periodicTimerProvider';
}

abstract class _$PeriodicTimer extends $StreamNotifier<void> {
  late final _$args = ref.$arg as String;
  String get key => _$args;

  Stream<void> build(String key);
  @$mustCallSuper
  @override
  void runBuild() {
    build(_$args);
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
