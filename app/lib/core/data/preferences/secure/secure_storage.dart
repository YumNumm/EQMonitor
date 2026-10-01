import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage_initializer.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_storage.g.dart';

@Riverpod(keepAlive: true)
Future<FlutterSecureStorage> secureStorage(Ref ref) async {
  const storage = FlutterSecureStorage(
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
      groupId: 'group.net.yumnumm.eqmonitor',
    ),
  );

  final sharedPreferences = await ref.read(
    sharedPreferencesDataSourceProvider.future,
  );
  await SecureStorageInitializer(
    sharedPreferences: sharedPreferences,
    securePreferences: SecurePreferencesDataSource(secureStorage: storage),
  ).initialize();
  return storage;
}
