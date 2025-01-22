// ignore_for_file: overridden_fields

import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:talker_flutter/talker_flutter.dart';

late final Talker talker;

class TelegramWebSocketLog extends TalkerLog {
  TelegramWebSocketLog(super.message);

  @override
  String get title => 'TelegramWebSocket';

  @override
  final pen = AnsiPen()..green();
}

class DioLog extends TalkerLog {
  DioLog(super.message);

  @override
  String get title => 'Dio';

  @override
  final pen = AnsiPen()..blue();
}

class KyoshinMonitorLog extends TalkerLog {
  KyoshinMonitorLog(super.message);

  @override
  String get title => 'KyoshinMonitor';

  @override
  final pen = AnsiPen()..yellow();
}

class AppLifeCycleLog extends TalkerLog {
  AppLifeCycleLog(super.message);

  @override
  String get title => 'AppLifeCycle';

  @override
  final pen = AnsiPen()..cyan();
}

class NtpLog extends TalkerLog {
  NtpLog(super.message);

  @override
  String get title => 'NTP';

  @override
  final pen = AnsiPen()..red();
}

class GoRouterLog extends TalkerLog {
  GoRouterLog(super.message);

  @override
  String get title => 'GoRouter';

  @override
  final pen = AnsiPen()..magenta();
}

class CrashlyticsTalkerObserver implements TalkerObserver {
  CrashlyticsTalkerObserver();

  @override
  void onError(TalkerError err) => unawaited(
        FirebaseCrashlytics.instance.log(
          'Error: ${err.message}, ${err.exception}, ${err.stackTrace}',
        ),
      );

  @override
  void onException(TalkerException err) => unawaited(
        FirebaseCrashlytics.instance.log(
          'Exception: ${err.message}, ${err.exception}, ${err.stackTrace}',
        ),
      );

  @override
  void onLog(TalkerData log) {
    if (log.title == TelegramWebSocketLog('').title) {
      return;
    }
    unawaited(
      FirebaseCrashlytics.instance.log(
        log.message.toString(),
      ),
    );
  }
}
