import 'package:eqmonitor/feature/settings/children/config/debug/hinet_seismicity/data/provider/hinet_credentials_provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('plugins.it_nomads.com/flutter_secure_storage');

  setUp(() {
    // secureStorageProvider は初回起動判定のため sharedPreferences を参照するため、
    // in-memory の SharedPreferences をモックする。
    SharedPreferences.setMockInitialValues({});

    final storage = <String, String>{};
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          switch (call.method) {
            case 'write':
              final args = call.arguments as Map<Object?, Object?>;
              storage[args['key']! as String] = args['value']! as String;
              return null;
            case 'read':
              final args = call.arguments as Map<Object?, Object?>;
              return storage[args['key']! as String];
            case 'delete':
              final args = call.arguments as Map<Object?, Object?>;
              storage.remove(args['key']! as String);
              return null;
            case 'readAll':
              return storage;
            case 'deleteAll':
              storage.clear();
              return null;
            default:
              return null;
          }
        });
  });

  test('保存した認証情報を読み戻せる', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await container
        .read(hinetCredentialsNotifierProvider.notifier)
        .save(userId: 'test-user', password: 'test-pass');

    final credentials = await container.read(
      hinetCredentialsNotifierProvider.future,
    );

    expect(credentials?.userId, 'test-user');
    expect(credentials?.password, 'test-pass');
  });

  test('clearで認証情報が消える', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await container
        .read(hinetCredentialsNotifierProvider.notifier)
        .save(userId: 'test-user', password: 'test-pass');
    await container.read(hinetCredentialsNotifierProvider.notifier).clear();

    final credentials = await container.read(
      hinetCredentialsNotifierProvider.future,
    );
    expect(credentials, isNull);
  });
}
