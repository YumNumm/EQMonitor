// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'periodic_timer.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(PeriodicTimer)
const periodicTimerProvider = PeriodicTimerFamily._();

final class PeriodicTimerProvider
    extends $StreamNotifierProvider<PeriodicTimer, void> {
  const PeriodicTimerProvider._({
    required PeriodicTimerFamily super.from,
    required Key super.argument,
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

String _$periodicTimerHash() => r'ccbdf0ca8ab4731c7d49afc78ae8685e7f0ddabc';

final class PeriodicTimerFamily extends $Family
    with
        $ClassFamilyOverride<
          PeriodicTimer,
          AsyncValue<void>,
          void,
          Stream<void>,
          Key
        > {
  const PeriodicTimerFamily._()
    : super(
        retry: null,
        name: r'periodicTimerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PeriodicTimerProvider call(Key key) =>
      PeriodicTimerProvider._(argument: key, from: this);

  @override
  String toString() => r'periodicTimerProvider';
}

abstract class _$PeriodicTimer extends $StreamNotifier<void> {
  late final _$args = ref.$arg as Key;
  Key get key => _$args;

  Stream<void> build(Key key);
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

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
