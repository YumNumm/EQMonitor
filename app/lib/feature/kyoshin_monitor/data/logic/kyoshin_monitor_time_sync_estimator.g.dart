// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_monitor_time_sync_estimator.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(kyoshinMonitorTimeSyncEstimator)
final kyoshinMonitorTimeSyncEstimatorProvider =
    KyoshinMonitorTimeSyncEstimatorProvider._();

final class KyoshinMonitorTimeSyncEstimatorProvider
    extends
        $FunctionalProvider<
          KyoshinMonitorTimeSyncEstimator,
          KyoshinMonitorTimeSyncEstimator,
          KyoshinMonitorTimeSyncEstimator
        >
    with $Provider<KyoshinMonitorTimeSyncEstimator> {
  KyoshinMonitorTimeSyncEstimatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinMonitorTimeSyncEstimatorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kyoshinMonitorTimeSyncEstimatorHash();

  @$internal
  @override
  $ProviderElement<KyoshinMonitorTimeSyncEstimator> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  KyoshinMonitorTimeSyncEstimator create(Ref ref) {
    return kyoshinMonitorTimeSyncEstimator(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(KyoshinMonitorTimeSyncEstimator value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<KyoshinMonitorTimeSyncEstimator>(
        value,
      ),
    );
  }
}

String _$kyoshinMonitorTimeSyncEstimatorHash() =>
    r'9edcdaeae1837c6f80f60a8521461adb3aef0cb2';
