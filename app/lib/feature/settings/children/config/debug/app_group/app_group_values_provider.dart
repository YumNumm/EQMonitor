import 'dart:io';

import 'package:eqmonitor/core/provider/app_group_preferences.dart';
import 'package:eqmonitor/core/provider/app_group_settings_writer.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_group_values_provider.g.dart';

typedef AppGroupValues = ({String? apiServerUrl, bool? debugMode});

@riverpod
Future<AppGroupValues> appGroupValues(Ref ref) async {
  if (!Platform.isIOS) {
    return (apiServerUrl: null, debugMode: null);
  }
  final prefs = await ref.watch(appGroupPreferencesProvider.future);
  final apiServerUrl = await prefs.getString(AppGroupKeys.apiServerUrl);
  final debugMode = await prefs.getBool(AppGroupKeys.debugMode);
  return (apiServerUrl: apiServerUrl, debugMode: debugMode);
}
