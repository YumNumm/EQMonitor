import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// 初期化時のログ
class InitializationEventLog extends FlutterTalkerLog {
  InitializationEventLog(super.message);

  @override
  String get title => 'Initialization';

  @override
  Color get color => Colors.blue;
}

/// GoRouterのログ
class GoRouterLog extends FlutterTalkerLog {
  GoRouterLog(super.message);

  @override
  String get title => 'GoRouter';

  @override
  Color get color => Colors.green;
}

/// Firebase Performanceのログ
class FirebasePerformanceLog extends FlutterTalkerLog {
  FirebasePerformanceLog(super.message);

  @override
  String get title => 'Firebase Performance';

  @override
  Color get color => Colors.orange;
}

/// Firebase Cloud Messagingのログ
class FirebaseCloudMessagingLog extends FlutterTalkerLog {
  FirebaseCloudMessagingLog(super.message);

  @override
  String get title => 'Firebase Messaging';

  @override
  Color get color => Colors.orange;
}

/// KyoshinImageParserのログ
class KyoshinImageParserLog extends FlutterTalkerLog {
  KyoshinImageParserLog(super.message);

  @override
  String get title => 'KyoshinImageParser';

  @override
  Color get color => Colors.purple;
}

/// EewProviderのログ
class EewProviderLog extends FlutterTalkerLog {
  EewProviderLog(super.message);

  @override
  String get title => 'EewProvider';

  @override
  Color get color => Colors.blueAccent;
}

/// EarthquakeHistory関連のログ
class EarthquakeHistoryLog extends FlutterTalkerLog {
  EarthquakeHistoryLog(super.message);

  @override
  String get title => 'EarthquakeHistory';

  @override
  Color get color => Colors.lightBlueAccent;
}


/// AppLifeCycle
class AppLifecycleLog extends FlutterTalkerLog {
  AppLifecycleLog(super.message);

  @override
  String get title => 'AppLifecycle';

  @override
  Color get color => Colors.lightBlueAccent;
}
