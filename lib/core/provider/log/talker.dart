// ignore_for_file: overridden_fields

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'talker.g.dart';

@Riverpod(keepAlive: true)
Talker talker(TalkerRef ref) => TalkerFlutter.init(
      logger: TalkerLogger(),
    )..configure(
        observer: CrashlitycsTalkerObserver(),
      );

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

class CrashlitycsTalkerObserver extends TalkerObserver {
  CrashlitycsTalkerObserver();

  @override
  void onError(TalkerError err) {
    FirebaseCrashlytics.instance.recordError(
      err.error,
      err.stackTrace,
      reason: err.message,
    );
  }

  @override
  void onException(TalkerException err) {
    FirebaseCrashlytics.instance.recordError(
      err.exception,
      err.stackTrace,
      reason: err.message,
    );
  }
}

class EstimatedIntensityLog extends TalkerLog {
  EstimatedIntensityLog(super.message);

  @override
  String get title => 'EstimatedIntensity';

  @override
  final pen = AnsiPen()..magenta();
}

class AppLifeCycleLog extends TalkerLog {
  AppLifeCycleLog(super.message);

  @override
  String get title => 'AppLifeCycle';

  @override
  final pen = AnsiPen()..cyan();
}
