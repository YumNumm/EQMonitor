// ignore_for_file: overridden_fields

import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:talker_flutter/talker_flutter.dart';

late final Talker talker;

class RealtimeSseLog(super.message) extends TalkerLog {
  @override
  String get title => 'RealtimeSse';

  @override
  final pen = AnsiPen()..green();
}

class DioLog(super.message) extends TalkerLog {
  @override
  String get title => 'Dio';

  @override
  final pen = AnsiPen()..blue();
}

class KyoshinMonitorLog(super.message) extends TalkerLog {
  @override
  String get title => 'KyoshinMonitor';

  @override
  final pen = AnsiPen()..yellow();
}

class AppLifeCycleLog(super.message) extends TalkerLog {
  @override
  String get title => 'AppLifeCycle';

  @override
  final pen = AnsiPen()..cyan();
}

class NtpLog(super.message) extends TalkerLog {
  @override
  String get title => 'NTP';

  @override
  final pen = AnsiPen()..red();
}

class GoRouterLog(super.message) extends TalkerLog {
  @override
  String get title => 'GoRouter';

  @override
  final pen = AnsiPen()..magenta();
}

class HttpCacheLog(super.message) extends TalkerLog {
  @override
  String get title => 'HttpCache';

  @override
  final pen = AnsiPen()..blue();
}

class CrashlyticsTalkerObserver() implements TalkerObserver {
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
    if (log.title == RealtimeSseLog('').title) {
      return;
    }
    unawaited(FirebaseCrashlytics.instance.log(log.message.toString()));
  }
}
