// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_monitor_timer_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// `latest.json` でサーバ時刻と端末時計のずれを測る時刻同期エンジン。
///
/// 1. 最初の 1 サンプルが取れた時点でその値を公開し、すぐ画像取得を始められるようにする。
/// 2. 続けて位相をずらした測定を数回行い、1 秒粒度の切り捨て誤差を詰める。
///    確定したら `settledAt` を立て、画像取得による較正
///    (`KyoshinMonitorDelayCalibration`) へ引き継ぐ。
/// 3. 以後の定期測定は見積もりを動かさず、矛盾の検出だけに使う。
///    矛盾した場合 (端末時計の変更・サーバ側の遅延変動) は最初から測り直す。

@ProviderFor(KyoshinMonitorTimerNotifier)
final kyoshinMonitorTimerProvider = KyoshinMonitorTimerNotifierProvider._();

/// `latest.json` でサーバ時刻と端末時計のずれを測る時刻同期エンジン。
///
/// 1. 最初の 1 サンプルが取れた時点でその値を公開し、すぐ画像取得を始められるようにする。
/// 2. 続けて位相をずらした測定を数回行い、1 秒粒度の切り捨て誤差を詰める。
///    確定したら `settledAt` を立て、画像取得による較正
///    (`KyoshinMonitorDelayCalibration`) へ引き継ぐ。
/// 3. 以後の定期測定は見積もりを動かさず、矛盾の検出だけに使う。
///    矛盾した場合 (端末時計の変更・サーバ側の遅延変動) は最初から測り直す。
final class KyoshinMonitorTimerNotifierProvider
    extends
        $StreamNotifierProvider<
          KyoshinMonitorTimerNotifier,
          KyoshinMonitorTimerState
        > {
  /// `latest.json` でサーバ時刻と端末時計のずれを測る時刻同期エンジン。
  ///
  /// 1. 最初の 1 サンプルが取れた時点でその値を公開し、すぐ画像取得を始められるようにする。
  /// 2. 続けて位相をずらした測定を数回行い、1 秒粒度の切り捨て誤差を詰める。
  ///    確定したら `settledAt` を立て、画像取得による較正
  ///    (`KyoshinMonitorDelayCalibration`) へ引き継ぐ。
  /// 3. 以後の定期測定は見積もりを動かさず、矛盾の検出だけに使う。
  ///    矛盾した場合 (端末時計の変更・サーバ側の遅延変動) は最初から測り直す。
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
    r'37d86861d875f569181d0e9c16ed795de93970ad';

/// `latest.json` でサーバ時刻と端末時計のずれを測る時刻同期エンジン。
///
/// 1. 最初の 1 サンプルが取れた時点でその値を公開し、すぐ画像取得を始められるようにする。
/// 2. 続けて位相をずらした測定を数回行い、1 秒粒度の切り捨て誤差を詰める。
///    確定したら `settledAt` を立て、画像取得による較正
///    (`KyoshinMonitorDelayCalibration`) へ引き継ぐ。
/// 3. 以後の定期測定は見積もりを動かさず、矛盾の検出だけに使う。
///    矛盾した場合 (端末時計の変更・サーバ側の遅延変動) は最初から測り直す。

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
