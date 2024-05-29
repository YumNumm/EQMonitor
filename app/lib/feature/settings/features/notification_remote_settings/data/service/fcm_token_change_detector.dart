import 'package:eqmonitor/core/provider/notification_token.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fcm_token_change_detector.g.dart';

@Riverpod(keepAlive: true)
class FcmTokenChangeDetector extends _$FcmTokenChangeDetector {
  @override
  Future<bool> build() async {
    final token = await ref.read(notificationTokenProvider.future);
    final savedFcmToken = _load();
    if (token.fcmToken != savedFcmToken) {
      return false;
    }
    return true;
  }

  static const String _prefsKey = 'fcmTokenChangeDetector';

  String? _load() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getString(_prefsKey);
  }

  Future<void> save(String fcmToken) async {
    final prefs = ref.watch(sharedPreferencesProvider);
    await prefs.setString(_prefsKey, fcmToken);
  }
}
