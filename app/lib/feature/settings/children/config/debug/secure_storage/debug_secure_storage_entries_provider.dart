import 'package:eqmonitor/core/data/preferences/secure/secure_storage.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_key.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_secure_storage_entries_provider.g.dart';

@riverpod
Future<List<({String key, String value})>> debugSecureStorageEntries(
  Ref ref,
) async {
  final storage = await ref.watch(secureStorageProvider.future);
  final all = await storage.readAll();
  final knownKeys = SecureStorageKey.values.map((e) => e.key).toSet();

  final unknown = <String>[];
  final known = <String>[];
  for (final key in all.keys) {
    (knownKeys.contains(key) ? known : unknown).add(key);
  }
  unknown.sort();
  known.sort();

  return [
    for (final key in [...unknown, ...known])
      (key: key, value: all[key] ?? ''),
  ];
}
