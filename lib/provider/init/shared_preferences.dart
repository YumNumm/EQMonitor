import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvder = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('SharedPreferencesが読み込まれていません'),
);
