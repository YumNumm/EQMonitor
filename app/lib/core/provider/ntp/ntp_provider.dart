import 'dart:async';

import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/ntp/ntp_config_model.dart';
import 'package:eqmonitor/core/provider/ntp/ntp_config_provider.dart';
import 'package:eqmonitor/core/provider/ntp/ntp_state.dart';
import 'package:flutter/foundation.dart';
import 'package:ntp/ntp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ntp_provider.g.dart';

@Riverpod(keepAlive: true)
class Ntp extends _$Ntp {
  @override
  Future<NtpState> build() async {
    final config = await ref.watch(ntpConfigProvider.future);
    final interval = config.interval;

    final timer = Timer.periodic(interval, (_) async {
      await sync();
    });
    ref.onDispose(timer.cancel);

    return const NtpState();
  }

  Future<void> sync() async {
    final config = ref.read(ntpConfigProvider).requireValue;
    final int offset;
    if (kIsWeb) {
      offset = await NTP.getNtpOffset(
        lookUpAddress: config.lookUpAddress,
        timeout: config.timeout,
      );
    } else {
      offset = await compute<NtpConfigModel, int>(
        (config) => NTP.getNtpOffset(
          lookUpAddress: config.lookUpAddress,
          timeout: config.timeout,
        ),
        config,
      );
    }

    final previous = await future;

    state = AsyncData(
      previous.copyWith(
        offset: offset,
        updatedAt: DateTime.now(),
      ),
    );

    talker.logCustom(NtpLog('NTP Time Sync: offset ${offset}ms'));
  }

  DateTime? now() {
    final offset = state.value?.offset;
    if (offset == null) {
      return null;
    }
    final localTime = DateTime.now();
    return localTime.add(Duration(milliseconds: offset));
  }
}
