import 'package:eqmonitor/core/provider/app_group_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_app_group_preferences_entries_provider.g.dart';

@riverpod
Future<List<({String key, Object? value})>> debugAppGroupPreferencesEntries(
  Ref ref,
) async {
  final prefs = await ref.watch(appGroupPreferencesProvider.future);
  final all = await prefs.getAll();
  final keys = all.keys.toList()..sort();
  return [
    for (final key in keys) (key: key, value: all[key]),
  ];
}
