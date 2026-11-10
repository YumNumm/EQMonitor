// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_monitor_delay_calibration_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 時刻同期の確定後、画像取得で公開遅延を較正する。
///
/// `latest.json` から求まるのは強震モニタのパイプラインの 1 秒粒度の時刻で、
/// 実際に画像が公開されるタイミングとは 1 秒未満のずれがある。
/// 表示用の取得とは別に数回だけ画像を取りに行き、公開の境目を二分探索で
/// 求めて補正量へ反映する。表示用の取得は較正中も現在の遅延で続く。
/// 以後も一定間隔でやり直し、遅延の変化に追従する。

@ProviderFor(KyoshinMonitorDelayCalibration)
final kyoshinMonitorDelayCalibrationProvider =
    KyoshinMonitorDelayCalibrationProvider._();

/// 時刻同期の確定後、画像取得で公開遅延を較正する。
///
/// `latest.json` から求まるのは強震モニタのパイプラインの 1 秒粒度の時刻で、
/// 実際に画像が公開されるタイミングとは 1 秒未満のずれがある。
/// 表示用の取得とは別に数回だけ画像を取りに行き、公開の境目を二分探索で
/// 求めて補正量へ反映する。表示用の取得は較正中も現在の遅延で続く。
/// 以後も一定間隔でやり直し、遅延の変化に追従する。
final class KyoshinMonitorDelayCalibrationProvider
    extends
        $NotifierProvider<
          KyoshinMonitorDelayCalibration,
          KyoshinMonitorDelayCalibrationStatus
        > {
  /// 時刻同期の確定後、画像取得で公開遅延を較正する。
  ///
  /// `latest.json` から求まるのは強震モニタのパイプラインの 1 秒粒度の時刻で、
  /// 実際に画像が公開されるタイミングとは 1 秒未満のずれがある。
  /// 表示用の取得とは別に数回だけ画像を取りに行き、公開の境目を二分探索で
  /// 求めて補正量へ反映する。表示用の取得は較正中も現在の遅延で続く。
  /// 以後も一定間隔でやり直し、遅延の変化に追従する。
  KyoshinMonitorDelayCalibrationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinMonitorDelayCalibrationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kyoshinMonitorDelayCalibrationHash();

  @$internal
  @override
  KyoshinMonitorDelayCalibration create() => KyoshinMonitorDelayCalibration();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(KyoshinMonitorDelayCalibrationStatus value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<KyoshinMonitorDelayCalibrationStatus>(value),
    );
  }
}

String _$kyoshinMonitorDelayCalibrationHash() =>
    r'f8f015926debddcfebf662417c911a5575eb8a0c';

/// 時刻同期の確定後、画像取得で公開遅延を較正する。
///
/// `latest.json` から求まるのは強震モニタのパイプラインの 1 秒粒度の時刻で、
/// 実際に画像が公開されるタイミングとは 1 秒未満のずれがある。
/// 表示用の取得とは別に数回だけ画像を取りに行き、公開の境目を二分探索で
/// 求めて補正量へ反映する。表示用の取得は較正中も現在の遅延で続く。
/// 以後も一定間隔でやり直し、遅延の変化に追従する。

abstract class _$KyoshinMonitorDelayCalibration
    extends $Notifier<KyoshinMonitorDelayCalibrationStatus> {
  KyoshinMonitorDelayCalibrationStatus build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              KyoshinMonitorDelayCalibrationStatus,
              KyoshinMonitorDelayCalibrationStatus
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                KyoshinMonitorDelayCalibrationStatus,
                KyoshinMonitorDelayCalibrationStatus
              >,
              KyoshinMonitorDelayCalibrationStatus,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
