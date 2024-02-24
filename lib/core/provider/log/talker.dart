// ignore_for_file: overridden_fields

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'talker.g.dart';

@Riverpod(keepAlive: true)
Talker talker(TalkerRef ref) => throw UnimplementedError();

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

class KmoniLog extends TalkerLog {
  KmoniLog(super.message);

  @override
  String get title => 'Kmoni';

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

class CrashlyticsTalkerObserver implements TalkerObserver {
  CrashlyticsTalkerObserver();

  @override
  void onError(TalkerError err) => FirebaseCrashlytics.instance.log(
        'Error: ${err.message}, ${err.exception}, ${err.stackTrace}',
      );

  @override
  void onException(TalkerException err) => FirebaseCrashlytics.instance.log(
        'Exception: ${err.message}, ${err.exception}, ${err.stackTrace}',
      );

  @override
  void onLog(TalkerDataInterface log) => FirebaseCrashlytics.instance.log(
        log.message.toString(),
      );
}
