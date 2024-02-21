import 'dart:async';

import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/ntp/ntp_config_provider.dart';
import 'package:eqmonitor/core/provider/ntp/ntp_state_model.dart';
import 'package:ntp/ntp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ntp_provider.g.dart';

@Riverpod(keepAlive: true)
class Ntp extends _$Ntp {
  @override
  NtpStateModel build() {
    final config = ref.watch(ntpConfigProvider);
    final interval = config.interval;

    // intervalごとにsyncを実行する
    _stream = Stream<void>.periodic(interval).listen((_) => sync());
    unawaited(sync());
    ref.onDispose(_stream.cancel);

    return const NtpStateModel();
  }

  late StreamSubscription<void> _stream;

  Future<void> sync() async {
    final talker = ref.read(talkerProvider)..logTyped(NtpLog('sync start'));
    final config = ref.read(ntpConfigProvider);

    final localTime = DateTime.now();
    final offset = await NTP.getNtpOffset(
      lookUpAddress: config.lookUpAddress,
      timeout: config.timeout,
    );
    state = state.copyWith(
      offset: offset,
      updatedAt: localTime,
    );
    talker.logTyped(NtpLog('sync end: ${offset}ms'));
  }

  DateTime? now() {
    final offset = state.offset;
    if (offset == null) {
      return null;
    }
    final localTime = DateTime.now();
    return localTime.add(Duration(milliseconds: offset));
  }
}
