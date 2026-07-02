import 'package:eqmonitor/core/data/preferences/shared/shared_preferences.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_shared_preferences_entries_provider.g.dart';

@riverpod
Future<List<({String key, Object? value})>> debugSharedPreferencesEntries(
  Ref ref,
) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  final knownKeys = SharedPreferencesKey.values.map((e) => e.key).toSet();

  final unknown = <String>[];
  final known = <String>[];
  for (final key in prefs.getKeys()) {
    (knownKeys.contains(key) ? known : unknown).add(key);
  }
  unknown.sort();
  known.sort();

  return [
    for (final key in [...unknown, ...known]) (key: key, value: prefs.get(key)),
  ];
}
