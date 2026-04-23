import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_foundation/shared_preferences_foundation.dart';

part 'app_group_preferences.g.dart';

const _kAppGroupId = 'group.net.yumnumm.eqmonitor';

/// iOS App Groups UserDefaults (suite: group.net.yumnumm.eqmonitor).
/// Widget Extension が同じ suite から設定値を読む。
@Riverpod(keepAlive: true)
Future<SharedPreferencesAsync> appGroupPreferences(Ref ref) async {
  assert(Platform.isIOS, 'App Groups are iOS-only');
  return SharedPreferencesAsync(
    options: SharedPreferencesAsyncFoundationOptions(suiteName: _kAppGroupId),
  );
}
