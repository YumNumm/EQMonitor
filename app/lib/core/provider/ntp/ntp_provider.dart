import 'dart:async';

import 'package:clock/clock.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/ntp/ntp_config_model.dart';
import 'package:eqmonitor/core/provider/ntp/ntp_config_provider.dart';
import 'package:eqmonitor/core/provider/ntp/ntp_state.dart';
import 'package:flutter/foundation.dart';
import 'package:ntp/ntp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ntp_provider.g.dart';

/// 初回同期に失敗したときの再試行間隔の初期値。
///
/// 失敗ごとに倍にしていき、[NtpConfigModel.interval] で打ち止めにする。
const _initialRetryDelay = Duration(seconds: 5);

@Riverpod(keepAlive: true)
class Ntp extends _$Ntp {
  Timer? _retryTimer;
  Duration _retryDelay = _initialRetryDelay;
  bool _isSyncing = false;

  @override
  Future<NtpState> build() async {
    final config = await ref.watch(ntpConfigProvider.future);

    final timer = Timer.periodic(config.interval, (_) {
      unawaited(sync());
    });
    ref.onDispose(timer.cancel);
    ref.onDispose(() {
      _retryTimer?.cancel();
      _retryTimer = null;
    });

    // 起動直後に一度同期する。
    // ここで同期しないと、次の周期タイマーが発火するまで offset が null のままで、
    // その間 AppClock は端末時計にフォールバックし続けてしまう。
    //
    // `sync()` は `state` の更新を伴うため build 中には使わず、
    // オフセットの取得だけを行う `_resolveOffset` を直接呼ぶ。
    final offset = await _resolveOffset(config);
    if (offset == null) {
      _scheduleRetry();
      return const NtpState();
    }
    return NtpState(offset: offset, updatedAt: clock.now());
  }

  Future<void> sync() async {
    // 全サーバを試すと最悪で数十秒かかるため、周期タイマーと再試行タイマーが
    // 重なって多重に走らないようにする。
    if (_isSyncing) {
      return;
    }
    _isSyncing = true;
    try {
      final config = await ref.read(ntpConfigProvider.future);
      final offset = await _resolveOffset(config);
      if (offset == null) {
        // 同期に失敗しても直前の offset は捨てない。
        // 古い offset のほうが「補正なし」よりは確実に正確なため。
        _scheduleRetry();
        return;
      }

      _cancelRetry();
      final previous = state.value ?? const NtpState();
      state = AsyncData(
        previous.copyWith(offset: offset, updatedAt: clock.now()),
      );
    } finally {
      _isSyncing = false;
    }
  }

  /// 設定されたサーバを順に試し、最初に成功した offset(ミリ秒)を返す。
  ///
  /// すべて失敗した場合は null を返す。
  Future<int?> _resolveOffset(NtpConfigModel config) async {
    for (final address in config.addresses) {
      for (
        var attempt = 1;
        attempt <= config.maxAttemptsPerAddress;
        attempt++
      ) {
        try {
          final offset = await _getNtpOffset(
            config.copyWith(lookUpAddress: address),
          );
          talker.logCustom(
            NtpLog('NTP Time Sync: $address offset ${offset}ms'),
          );
          return offset;
          // ignore: avoid_catches_without_on_clauses
        } catch (e) {
          talker.logCustom(
            NtpLog(
              'NTP Time Sync failed: $address '
              '($attempt/${config.maxAttemptsPerAddress}): $e',
            ),
          );
        }
      }
    }
    talker.logCustom(
      NtpLog(
        'NTP Time Sync failed: all servers exhausted '
        '(${config.addresses.join(', ')})',
      ),
    );
    return null;
  }

  Future<int> _getNtpOffset(NtpConfigModel config) async {
    if (kIsWeb) {
      return NTP.getNtpOffset(
        lookUpAddress: config.lookUpAddress,
        timeout: config.timeout,
      );
    }
    return compute<NtpConfigModel, int>(
      (config) => NTP.getNtpOffset(
        lookUpAddress: config.lookUpAddress,
        timeout: config.timeout,
      ),
      config,
    );
  }

  void _scheduleRetry() {
    _retryTimer?.cancel();
    final delay = _retryDelay;
    _retryTimer = Timer(delay, () {
      _retryTimer = null;
      unawaited(sync());
    });

    final interval =
        ref.read(ntpConfigProvider).value?.interval ?? _initialRetryDelay;
    final next = delay * 2;
    _retryDelay = next > interval ? interval : next;
  }

  void _cancelRetry() {
    _retryTimer?.cancel();
    _retryTimer = null;
    _retryDelay = _initialRetryDelay;
  }

  /// NTP 補正済みの現在時刻。未同期の場合は null。
  DateTime? now() {
    final offset = state.value?.offset;
    if (offset == null) {
      return null;
    }
    return clock.now().add(Duration(milliseconds: offset));
  }

  /// NTP 補正のオフセット。未同期の場合は null。
  Duration? get offset {
    final offset = state.value?.offset;
    return offset == null ? null : Duration(milliseconds: offset);
  }
}
