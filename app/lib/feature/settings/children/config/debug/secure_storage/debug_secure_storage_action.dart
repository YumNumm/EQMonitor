import 'package:eqmonitor/core/data/preferences/secure/secure_storage.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/secure_storage/debug_secure_storage_entries_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_secure_storage_action.g.dart';

@riverpod
DebugSecureStorageAction debugSecureStorageAction(Ref ref) =>
    DebugSecureStorageAction();

class DebugSecureStorageAction {
  Future<void> write(
    WidgetRef ref, {
    required String key,
    required String value,
  }) async {
    final storage = await ref.read(secureStorageProvider.future);
    await storage.write(key: key, value: value);
    ref.invalidate(debugSecureStorageEntriesProvider);
  }

  Future<void> remove(WidgetRef ref, {required String key}) async {
    final storage = await ref.read(secureStorageProvider.future);
    await storage.delete(key: key);
    ref.invalidate(debugSecureStorageEntriesProvider);
  }
}
