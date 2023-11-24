import 'package:eqapi_schema/eqapi_schema.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/firebase/firebase_crashlytics.dart';
import 'package:eqmonitor/core/provider/firebase/firebase_messaging.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fcm_topic_manager.g.dart';

@Riverpod(keepAlive: true)
class FcmTopicManager extends _$FcmTopicManager {
  @override
  List<String> build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final list = prefs.getStringList(_prefsKey);
    return list ?? [];
  }

  static const String _prefsKey = 'fcmTopicManager';

  /// デフォルトで購読すべきトピックを登録する
  Future<void> setup() async {
    final requireTopics = [
      FcmBasicTopic(FcmTopics.all),
    ];
    for (final topic in requireTopics) {
      await registerToTopic(topic);
    }
  }

  Future<Result<void, Exception>> registerToTopic(FcmTopic topic) async {
    // 既に登録済みの場合は何もしない
    if (state.contains(topic.topic)) {
      return const Result.success(null);
    }
    final messaging = ref.read(firebaseMessagingProvider);
    try {
      await messaging.subscribeToTopic(topic.topic);
      state = [...state, topic.topic];
      return const Result.success(null);
    } on Exception catch (error, stackTrace) {
      await ref.read(firebaseCrashlyticsProvider).recordError(
            error,
            stackTrace,
          );
      return Result.failure(error);
    }
  }

  Future<Result<void, Exception>> unregisterFromTopic(FcmTopic topic) async {
    // 登録されていない場合は何もしない
    if (!state.contains(topic.topic)) {
      return const Result.success(null);
    }
    final messaging = ref.read(firebaseMessagingProvider);
    try {
      await messaging.unsubscribeFromTopic(topic.topic);
      state = [...state]..remove(topic.topic);
      return const Result.success(null);
    } on Exception catch (error, stackTrace) {
      await ref.read(firebaseCrashlyticsProvider).recordError(
            error,
            stackTrace,
          );
      return Result.failure(error);
    }
  }
}

class FcmEewTopic implements FcmTopic {
  const FcmEewTopic(this.area);

  final AreaForecastLocalEew area;

  @override
  String get topic => 'eew_${area.code}';
}

class FcmEarthquakeTopic implements FcmTopic {
  const FcmEarthquakeTopic(this.intensity);

  final JmaIntensity? intensity;

  @override
  // ignore: lines_longer_than_80_chars
  String get topic =>
      'earthquake_${intensity?.type.replaceAll("-", "l").replaceAll("+", "p") ?? "all"}';
}

enum FcmTopics {
  all('all'),
  allEew('all_eew'),
  allEarthquake('all_earthquake'),
  notice('notice'),
  noticeFromJma('notice_from_jma'),
  ;

  const FcmTopics(this.topic);
  final String topic;
}

class FcmBasicTopic implements FcmTopic {
  FcmBasicTopic(this._topic);

  final FcmTopics _topic;

  @override
  String get topic => _topic.topic;
}

sealed class FcmTopic {
  String get topic;
}
