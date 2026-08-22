// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_monitor_time_sample_calculator.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(kyoshinMonitorTimeSampleCalculator)
final kyoshinMonitorTimeSampleCalculatorProvider =
    KyoshinMonitorTimeSampleCalculatorProvider._();

final class KyoshinMonitorTimeSampleCalculatorProvider
    extends
        $FunctionalProvider<
          KyoshinMonitorTimeSampleCalculator,
          KyoshinMonitorTimeSampleCalculator,
          KyoshinMonitorTimeSampleCalculator
        >
    with $Provider<KyoshinMonitorTimeSampleCalculator> {
  KyoshinMonitorTimeSampleCalculatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinMonitorTimeSampleCalculatorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$kyoshinMonitorTimeSampleCalculatorHash();

  @$internal
  @override
  $ProviderElement<KyoshinMonitorTimeSampleCalculator> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  KyoshinMonitorTimeSampleCalculator create(Ref ref) {
    return kyoshinMonitorTimeSampleCalculator(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(KyoshinMonitorTimeSampleCalculator value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<KyoshinMonitorTimeSampleCalculator>(
        value,
      ),
    );
  }
}

String _$kyoshinMonitorTimeSampleCalculatorHash() =>
    r'444bdff6a0e9b5c1f2cce908fd4a737aaf9f723e';
