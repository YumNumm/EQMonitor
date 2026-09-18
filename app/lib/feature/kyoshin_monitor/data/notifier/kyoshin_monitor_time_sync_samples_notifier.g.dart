// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_monitor_time_sync_samples_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(KyoshinMonitorTimeSyncSamplesNotifier)
final kyoshinMonitorTimeSyncSamplesProvider =
    KyoshinMonitorTimeSyncSamplesNotifierProvider._();

final class KyoshinMonitorTimeSyncSamplesNotifierProvider
    extends
        $NotifierProvider<
          KyoshinMonitorTimeSyncSamplesNotifier,
          KyoshinMonitorTimeSyncSamples
        > {
  KyoshinMonitorTimeSyncSamplesNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinMonitorTimeSyncSamplesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$kyoshinMonitorTimeSyncSamplesNotifierHash();

  @$internal
  @override
  KyoshinMonitorTimeSyncSamplesNotifier create() =>
      KyoshinMonitorTimeSyncSamplesNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(KyoshinMonitorTimeSyncSamples value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<KyoshinMonitorTimeSyncSamples>(
        value,
      ),
    );
  }
}

String _$kyoshinMonitorTimeSyncSamplesNotifierHash() =>
    r'448b1b84139a04b8cb6e5d60a3e5ebf76cd830d1';

abstract class _$KyoshinMonitorTimeSyncSamplesNotifier
    extends $Notifier<KyoshinMonitorTimeSyncSamples> {
  KyoshinMonitorTimeSyncSamples build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              KyoshinMonitorTimeSyncSamples,
              KyoshinMonitorTimeSyncSamples
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                KyoshinMonitorTimeSyncSamples,
                KyoshinMonitorTimeSyncSamples
              >,
              KyoshinMonitorTimeSyncSamples,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
