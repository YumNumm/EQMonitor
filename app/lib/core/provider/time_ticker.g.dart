// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'time_ticker.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(timeTicker)
const timeTickerProvider = TimeTickerFamily._();

final class TimeTickerProvider
    extends
        $FunctionalProvider<AsyncValue<DateTime>, DateTime, Stream<DateTime>>
    with $FutureModifier<DateTime>, $StreamProvider<DateTime> {
  const TimeTickerProvider._({
    required TimeTickerFamily super.from,
    required Duration super.argument,
  }) : super(
         retry: null,
         name: r'timeTickerProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$timeTickerHash();

  @override
  String toString() {
    return r'timeTickerProvider'
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
    return timeTicker(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TimeTickerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$timeTickerHash() => r'b6558f45ff8da20b7a1b356a6b43ccd6c0d6d89f';

final class TimeTickerFamily extends $Family
    with $FunctionalFamilyOverride<Stream<DateTime>, Duration> {
  const TimeTickerFamily._()
    : super(
        retry: null,
        name: r'timeTickerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  TimeTickerProvider call([Duration duration = const Duration(seconds: 1)]) =>
      TimeTickerProvider._(argument: duration, from: this);

  @override
  String toString() => r'timeTickerProvider';
}
