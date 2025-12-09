// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'periodic_timer.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(periodicTimer)
const periodicTimerProvider = PeriodicTimerFamily._();

final class PeriodicTimerProvider
    extends
        $FunctionalProvider<AsyncValue<DateTime>, DateTime, Stream<DateTime>>
    with $FutureModifier<DateTime>, $StreamProvider<DateTime> {
  const PeriodicTimerProvider._({
    required PeriodicTimerFamily super.from,
    required Duration super.argument,
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
  $StreamProviderElement<DateTime> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<DateTime> create(Ref ref) {
    final argument = this.argument as Duration;
    return periodicTimer(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PeriodicTimerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$periodicTimerHash() => r'ed4a0ae2de687786e5fb1114a76320dee93dca54';

final class PeriodicTimerFamily extends $Family
    with $FunctionalFamilyOverride<Stream<DateTime>, Duration> {
  const PeriodicTimerFamily._()
    : super(
        retry: null,
        name: r'periodicTimerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PeriodicTimerProvider call(Duration interval) =>
      PeriodicTimerProvider._(argument: interval, from: this);

  @override
  String toString() => r'periodicTimerProvider';
}
