import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'user_id_provider.g.dart';

@Riverpod(keepAlive: true)
class UserId extends _$UserId {
  @override
  String build() {
    final previousUserId = _load();
    if (previousUserId != null) {
      return previousUserId;
    }
    final newUserId = const Uuid().v8();
    save(newUserId);
    return newUserId;
  }

  String? _load() {
    final prefs = ref.read(sharedPreferencesProvider);
    return prefs.getString(_prefsKey);
  }

  Future<void> save(String userId) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(_prefsKey, userId);
  }

  static const String _prefsKey = 'user_id';
}
