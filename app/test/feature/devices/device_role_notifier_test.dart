import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/data/preferences/secure/secure_storage.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences.dart'
    as data_prefs;
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/model/environment.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/core/provider/log/talker.dart' as talker_lib;
import 'package:eqmonitor/feature/devices/data/model/device_role.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_role_notifier.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_auth_repository.dart';
import 'package:eqmonitor/feature/settings/features/debug/debug_provider.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/provider/shake_detection_notification_availability_provider.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  talker_lib.talker = Talker(settings: TalkerSettings(useConsoleLogs: false));

  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  group('起動時の取得', () {
    test('保存値がなければ取得せず、ロール不明として扱う', () async {
      final harness = await _Harness.create(serverRole: 'ADMIN');

      expect(await harness.container.read(deviceRoleProvider.future), isNull);
      expect(harness.adapter.paths, isEmpty);
    });

    test('保存値が USER なら取得せず、保存値を返す', () async {
      final harness = await _Harness.create(
        storedRole: 'USER',
        serverRole: 'ADMIN',
      );

      expect(
        await harness.container.read(deviceRoleProvider.future),
        DeviceRole.user,
      );
      expect(harness.adapter.paths, isEmpty);
    });

    test('保存値が ADMIN なら取得して確認する', () async {
      final harness = await _Harness.create(
        storedRole: 'ADMIN',
        serverRole: 'ADMIN',
      );

      expect(
        await harness.container.read(deviceRoleProvider.future),
        DeviceRole.admin,
      );
      expect(harness.adapter.paths, ['/v2/device/me']);
    });

    test('Admin の取り消しを反映し、以後は取得しない', () async {
      final harness = await _Harness.create(
        storedRole: 'ADMIN',
        serverRole: 'USER',
      );

      expect(
        await harness.container.read(deviceRoleProvider.future),
        DeviceRole.user,
      );
      expect(harness.storedRole, 'USER');

      final next = await _Harness.create(
        serverRole: 'ADMIN',
        preferences: harness.preferences,
      );
      expect(
        await next.container.read(deviceRoleProvider.future),
        DeviceRole.user,
      );
      expect(next.adapter.paths, isEmpty);
    });

    test('取得に失敗したら Admin とみなさず、保存値は残して次回に確認する', () async {
      final harness = await _Harness.create(
        storedRole: 'ADMIN',
        statusCode: 500,
      );

      expect(await harness.container.read(deviceRoleProvider.future), isNull);
      expect(harness.storedRole, 'ADMIN');
    });

    test('端末が未登録なら保存値を使わない', () async {
      final harness = await _Harness.create(
        storedRole: 'ADMIN',
        serverRole: 'ADMIN',
        provisioning: DeviceProvisioningStatus.required,
      );

      expect(await harness.container.read(deviceRoleProvider.future), isNull);
      expect(harness.adapter.paths, isEmpty);
    });
  });

  group('refresh', () {
    test('保存値がなくても取得し、結果を保存する', () async {
      final harness = await _Harness.create(serverRole: 'ADMIN');
      await harness.container.read(deviceRoleProvider.future);

      final isRefreshed = await harness.container
          .read(deviceRoleProvider.notifier)
          .refresh();

      expect(isRefreshed, isTrue);
      expect(
        harness.container.read(deviceRoleProvider).value,
        DeviceRole.admin,
      );
      expect(harness.storedRole, 'ADMIN');
      expect(harness.adapter.paths, ['/v2/device/me']);
    });

    test('取得に失敗したら状態と保存値を変えない', () async {
      final harness = await _Harness.create(
        storedRole: 'USER',
        statusCode: 500,
      );
      await harness.container.read(deviceRoleProvider.future);

      final isRefreshed = await harness.container
          .read(deviceRoleProvider.notifier)
          .refresh();

      expect(isRefreshed, isFalse);
      expect(harness.container.read(deviceRoleProvider).value, DeviceRole.user);
      expect(harness.storedRole, 'USER');
      expect(harness.adapter.paths, ['/v2/device/me']);
    });
  });

  test('端末の資格情報を保存・削除すると保存したロールを消す', () async {
    final harness = await _Harness.create(storedRole: 'ADMIN');
    final repository = await harness.container.read(
      deviceAuthRepositoryProvider.future,
    );

    await repository.saveToken(token: 'new-token');
    expect(harness.storedRole, isNull);

    await harness.preferences.setString(
      SharedPreferencesKey.deviceRole.key,
      'ADMIN',
    );
    await repository.clearToken();
    expect(harness.storedRole, isNull);
  });

  group('isShakeDetectionNotificationAvailableProvider', () {
    test('ロールが未取得なら無効と断定せず例外にする', () async {
      final harness = await _Harness.create(serverRole: 'ADMIN');

      await expectLater(
        harness.container.read(
          isShakeDetectionNotificationAvailableProvider.future,
        ),
        throwsStateError,
      );
      expect(harness.adapter.paths, isEmpty);
    });

    test('保存値が USER なら取得せず利用不可とする', () async {
      final harness = await _Harness.create(storedRole: 'USER');

      expect(
        await harness.container.read(
          isShakeDetectionNotificationAvailableProvider.future,
        ),
        isFalse,
      );
      expect(harness.adapter.paths, isEmpty);
    });

    test('保存値が ADMIN で確認できれば利用可とする', () async {
      final harness = await _Harness.create(
        storedRole: 'ADMIN',
        serverRole: 'ADMIN',
      );

      expect(
        await harness.container.read(
          isShakeDetectionNotificationAvailableProvider.future,
        ),
        isTrue,
      );
    });
  });
}

final class _Harness._({
  required final ProviderContainer container,
  required final _DeviceMeAdapter adapter,
  required final SharedPreferences preferences,
}) {
  String? get storedRole =>
      preferences.getString(SharedPreferencesKey.deviceRole.key);

  static Future<_Harness> create({
    String? storedRole,
    String? serverRole,
    int statusCode = 200,
    DeviceProvisioningStatus provisioning =
        DeviceProvisioningStatus.notRequired,
    SharedPreferences? preferences,
  }) async {
    if (preferences == null) {
      SharedPreferences.setMockInitialValues({
        SharedPreferencesKey.deviceRole.key: ?storedRole,
        SharedPreferencesKey.debug.key: true,
      });
    }
    FlutterSecureStorage.setMockInitialValues({});
    final prefs = preferences ?? await SharedPreferences.getInstance();
    final adapter = _DeviceMeAdapter(role: serverRole, statusCode: statusCode);
    final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = adapter;
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        data_prefs.sharedPreferencesProvider.overrideWithValue(
          AsyncValue.data(prefs),
        ),
        secureStorageProvider.overrideWith(
          (ref) async => const FlutterSecureStorage(),
        ),
        apiClientProvider.overrideWith((ref) async => api.ApiClient(dio)),
        deviceIdProvider.overrideWith((ref) async => 'device-1'),
        deviceProvisioningProvider.overrideWith(
          () => _FixedProvisioning(provisioning),
        ),
        debugProvider.overrideWith(_DebugEnabled.new),
        buildConfigProvider.overrideWithValue(_productionBuildConfig),
      ],
    );
    addTearDown(container.dispose);
    return _Harness._(
      container: container,
      adapter: adapter,
      preferences: prefs,
    );
  }
}

const _productionBuildConfig = BuildConfig(
  restApiUrl: '',
  appIdSuffix: '',
  appName: 'EQMonitor',
  commitInformation: 'test',
  flavor: Flavor.prod,
  wsApiUrl: '',
  googleIosClientId: '',
  googleAndroidClientId: '',
  buildTimestamp: '',
  buildCommitMessage: '',
  revenueCatApiKeyIos: '',
  revenueCatApiKeyAndroid: '',
  isProduction: true,
);

class _FixedProvisioning(final DeviceProvisioningStatus status)
    extends DeviceProvisioningNotifier {
  @override
  Future<DeviceProvisioningStatus> build() async => status;
}

class _DebugEnabled extends Debug {
  @override
  Future<bool> build() async => true;
}

final class _DeviceMeAdapter({
  required final String? role,
  required final int statusCode,
}) implements HttpClientAdapter {
  final paths = <String>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    paths.add(options.path);
    if (statusCode != 200) {
      return ResponseBody.fromString('', statusCode);
    }
    return ResponseBody.fromString(
      jsonEncode({
        'id': 'server-device-id',
        'type': 'IOS',
        'locale': 'ja',
        'registrationType': 'APP_CHECK',
        'userId': null,
        'is_pro': false,
        'role': ?role,
        'createdAt': '2026-08-14T00:00:00.000Z',
        'updatedAt': '2026-08-14T00:00:00.000Z',
      }),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
