import 'package:eqapi_types/eqapi_types.dart';
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
    ref.listenSelf((_, __) => _save());
    return list ?? [];
  }

  static const String _prefsKey = 'fcmTopicManager';

  /// デフォルトで購読すべきトピックを登録する
  Future<void> setup() async {
    final futures = <Future<void>>[];
    final requireTopics = [
      FcmBasicTopic(FcmTopics.all),
    ];
    for (final topic in requireTopics) {
      futures.add(registerToTopic(topic));
    }
    final shouldBeUnregisteredTopics = [
      'earthquake',
      'eew',
      'everyone',
    ];
    final messaging = ref.read(firebaseMessagingProvider);
    for (final topic in shouldBeUnregisteredTopics) {
      // bypass prefs check
      futures.add(messaging.unsubscribeFromTopic(topic));
    }
    await futures.wait;
  }

  Future<void> _save() async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setStringList(_prefsKey, state);
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

class FcmEewIntensityTopic implements FcmTopic, FcmEewTopic {
  const FcmEewIntensityTopic(this.intensity);

  final JmaIntensity intensity;

  @override
  String get topic =>
      'eew${intensity.type.replaceAll("-", "lower").replaceAll("+", "upper")}';
}

class FcmEewAllTopic implements FcmTopic, FcmEewTopic {
  const FcmEewAllTopic();

  @override
  String get topic => 'eew_all';
}

class FcmEewLowAccuracyTopic implements FcmTopic, FcmEewTopic {
  const FcmEewLowAccuracyTopic();

  @override
  String get topic => 'eew_low_accuracy';
}

class FcmEarthquakeTopic implements FcmTopic {
  const FcmEarthquakeTopic(this.intensity);

  final JmaIntensity? intensity;

  @override
  // ignore: lines_longer_than_80_chars
  String get topic {
    final suffix =
        intensity?.type.replaceAll('-', 'lower').replaceAll('+', 'upper') ??
            'all';
    return 'earthquake_$suffix';
  }
}

enum FcmTopics {
  all('all'),
  notice('notice'),
  vzse40('vzse40'),
  ;

  const FcmTopics(this.topic);
  final String topic;
}

class FcmBasicTopic implements FcmTopic {
  FcmBasicTopic(this._topic);

  final FcmTopics _topic;

  @override
  String get topic => 'basic_${_topic.topic}';
}

sealed class FcmTopic {
  String get topic;
}

sealed class FcmEewTopic implements FcmTopic {
  @override
  String get topic;
}
