import 'dart:async';

import 'package:clock/clock.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/ntp/ntp_config_model.dart';
import 'package:eqmonitor/core/provider/ntp/ntp_config_provider.dart';
import 'package:eqmonitor/core/provider/ntp/ntp_state.dart';
import 'package:ntp/ntp.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ntp_provider.g.dart';

@Riverpod(keepAlive: true)
class Ntp extends _$Ntp {
  @override
  Future<NtpState> build() async {
    final config = await ref.watch(ntpConfigProvider.future);

    final timer = Timer.periodic(config.interval, (_) async {
      syncMutation.run(ref, (trx) => _sync());
    });
    ref.onDispose(timer.cancel);
    final result = await _resolveOffset(config);
    final offset = result.unwrap();
    return NtpState(
      offset: offset,
      updatedAt: clock.now(),
    );
  }

  static final syncMutation = Mutation<void>();

  Future<void> _sync() async {
    final config = await ref.read(ntpConfigProvider.future);
    final offset = await _resolveOffset(config);

    state = AsyncData(
      NtpState(
        offset: offset.unwrap(),
        updatedAt: clock.now(),
      ),
    );
  }

  /// 設定されたサーバを順に試し、最初に成功した offset を返す
  Future<Result<Duration, NtpException>> _resolveOffset(
    NtpConfigModel config,
  ) async {
    for (final address in config.addresses) {
      for (
        var attempt = 1;
        attempt <= config.maxAttemptsPerAddress;
        attempt++
      ) {
        try {
          final timeout = config.timeout;
          final offset = await NTP.getNtpOffset(
            lookUpAddress: address,
            timeout: timeout,
          );
          talker.logCustom(
            NtpLog('NTP Time Sync: $address offset ${offset}ms'),
          );
          return Success(Duration(milliseconds: offset));
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
    return Failure(NtpException());
  }
}

final class const NtpException() implements Exception;
