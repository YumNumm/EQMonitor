import 'dart:async';

import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/ntp/ntp_provider.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_timer_state.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_timer_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/service/kyoshin_monitor_delay_adjust_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_offset_adjustment_notifier.g.dart';

/// 補正量の永続化を間引く間隔。
///
/// 404 は毎秒起きうるため、都度 SharedPreferences へ書くと負荷が高い。
/// メモリ上の値は即時反映し、保存だけ遅延させる。
const _persistDebounce = Duration(seconds: 30);

/// パイプライン別の、`latest.json` 実測値からの補正量。
///
/// 画像取得の 404 / 成功をフィードバックとして受け取り、公開遅延の見積もりを
/// 詰めていく。値は設定へ永続化され、次回起動時は収束済みの状態から始まる。
@Riverpod(keepAlive: true)
class KyoshinMonitorOffsetAdjustment extends _$KyoshinMonitorOffsetAdjustment {
  Timer? _persistTimer;

  @override
  Map<KyoshinMonitorDelayProfile, Duration> build() {
    ref.onDispose(() {
      _persistTimer?.cancel();
      _persistTimer = null;
    });

    final initial = ref
        .read(kyoshinMonitorSettingsProvider)
        .value
        ?.api
        .offsetAdjustments;

    // 設定は非同期に読み込まれるため、このプロバイダが先に構築されると
    // 永続化済みの補正量を取り逃がす。まだ読み込めていない場合は、
    // 読み込み完了時に一度だけ反映する。
    if (initial == null) {
      var seeded = false;
      ref.listen(kyoshinMonitorSettingsProvider, (_, next) {
        if (seeded) {
          return;
        }
        final loaded = next.value?.api.offsetAdjustments;
        if (loaded == null) {
          return;
        }
        seeded = true;
        // すでに 404 フィードバックで動きだしている場合は上書きしない。
        if (loaded.isNotEmpty && state.isEmpty) {
          state = loaded;
        }
      });
    }

    return initial ?? const <KyoshinMonitorDelayProfile, Duration>{};
  }

  Duration of(KyoshinMonitorDelayProfile profile) =>
      state[profile] ?? Duration.zero;

  /// 画像が未公開 (404) だった。
  void onFetchFailed(KyoshinMonitorDelayProfile profile) {
    final api = _api;
    if (api == null || !api.autoOffsetIncrement) {
      return;
    }
    _update(
      profile,
      KyoshinMonitorDelayAdjuster.onFetchFailed(
        adjustment: of(profile),
        config: api.delayAdjustConfig,
      ),
    );
  }

  /// 画像の取得に成功した。
  ///
  /// [targetTime] の秒が 0 のときだけ、オフセットを詰められないか試す。
  void onFetchSucceeded({
    required KyoshinMonitorDelayProfile profile,
    required DateTime targetTime,
  }) {
    final api = _api;
    if (api == null || !api.autoOffsetIncrement) {
      return;
    }
    final timerState = ref.read(kyoshinMonitorTimerProvider).value;
    if (timerState == null) {
      return;
    }
    final ntp = ref.read(ntpProvider).value;
    final publishDelay = timerState.publishDelay(
      ntp?.offset ?? Duration.zero,
    );
    _update(
      profile,
      KyoshinMonitorDelayAdjuster.onFetchSucceeded(
        adjustment: of(profile),
        publishDelay: publishDelay,
        targetTime: targetTime,
        config: api.delayAdjustConfig,
      ),
    );
  }

  KyoshinMonitorSettingsApiModel? get _api =>
      ref.read(kyoshinMonitorSettingsProvider).value?.api;

  void _update(KyoshinMonitorDelayProfile profile, Duration adjustment) {
    if (of(profile) == adjustment) {
      return;
    }
    state = {...state, profile: adjustment};
    talker.logCustom(
      KyoshinMonitorLog(
        'offset adjustment: ${profile.name} '
        '${adjustment.inMilliseconds}ms',
      ),
    );
    _schedulePersist();
  }

  void _schedulePersist() {
    if (_persistTimer != null) {
      return;
    }
    _persistTimer = Timer(_persistDebounce, () {
      _persistTimer = null;
      unawaited(persist());
    });
  }

  /// 現在の補正量を設定へ保存する。
  Future<void> persist() async {
    final settingsNotifier = ref.read(kyoshinMonitorSettingsProvider.notifier);
    final current = ref.read(kyoshinMonitorSettingsProvider).value;
    if (current == null) {
      return;
    }
    if (current.api.offsetAdjustments == state) {
      return;
    }
    await settingsNotifier.save(
      current.copyWith(
        api: current.api.copyWith(offsetAdjustments: state),
      ),
    );
  }
}
