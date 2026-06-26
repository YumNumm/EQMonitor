import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telemetry_store/src/database/telemetry_database.dart';
import 'package:telemetry_store/src/recorder/app_launch_recorder.dart';
import 'package:telemetry_store/src/recorder/telemetry_recorder.dart';

void main() {
  late TelemetryDatabase db;
  late TelemetryRecorder recorder;

  setUp(() {
    db = TelemetryDatabase(NativeDatabase.memory());
    recorder = TelemetryRecorder(db: db);
    SharedPreferences.setMockInitialValues({});
  });

  tearDown(() async {
    await db.close();
  });

  AppLaunchRecorder makeRecorder(SharedPreferences prefs) =>
      AppLaunchRecorder(recorder, prefs);

  /// Minimal iOS-like args (android-specific fields omitted/null).
  Future<bool> recordIos(
    AppLaunchRecorder r, {
    String launchType = 'cold_start',
  }) => r.record(
    launchType: launchType,
    appVersion: '1.0.0',
    buildNumber: 100,
    platform: 'ios',
    osVersion: '17.0',
    deviceModel: 'iPhone 15',
    locale: 'ja_JP',
    isPhysicalDevice: true,
    physicalRamMb: 6144,
    cpuCores: 6,
    manufacturer: 'Apple',
    // Android-specific fields are omitted (null by default) for iOS.
  );

  /// Android-specific args — all fields populated.
  Future<bool> recordAndroid(
    AppLaunchRecorder r, {
    String launchType = 'cold_start',
  }) => r.record(
    launchType: launchType,
    appVersion: '1.0.0',
    buildNumber: 100,
    platform: 'android',
    osVersion: '14',
    deviceModel: 'Pixel 8',
    locale: 'ja_JP',
    isPhysicalDevice: true,
    physicalRamMb: 8192,
    cpuCores: 8,
    manufacturer: 'Google',
    androidSdkInt: 34,
    securityPatch: '2024-01-01',
    isLowRamDevice: false,
    installerStore: 'com.android.vending',
  );

  group('debounce logic', () {
    test(
      'records event when no previous timestamp exists (first launch)',
      () async {
        final prefs = await SharedPreferences.getInstance();
        final r = makeRecorder(prefs);

        final result = await recordIos(r);

        expect(result, isTrue);
        final rows = await db.getUnsyncedEvents();
        expect(rows, hasLength(1));
        expect(rows.first.eventType, 'app_launch');
      },
    );

    test(
      'records event when >30 seconds have elapsed since last send',
      () async {
        final prefs = await SharedPreferences.getInstance();
        // Simulate a last-sent timestamp 31 seconds in the past.
        final oldTimestamp = DateTime.now().millisecondsSinceEpoch - 31 * 1000;
        await prefs.setInt('app_launch_last_sent_ms', oldTimestamp);
        final r = makeRecorder(prefs);

        final result = await recordIos(r);

        expect(result, isTrue);
        final rows = await db.getUnsyncedEvents();
        expect(rows, hasLength(1));
      },
    );

    test(
      'does NOT record when <30 seconds have elapsed since last send',
      () async {
        final prefs = await SharedPreferences.getInstance();
        // Simulate a last-sent timestamp only 5 seconds ago.
        final recentTimestamp =
            DateTime.now().millisecondsSinceEpoch - 5 * 1000;
        await prefs.setInt('app_launch_last_sent_ms', recentTimestamp);
        final r = makeRecorder(prefs);

        final result = await recordIos(r);

        expect(result, isFalse);
        final rows = await db.getUnsyncedEvents();
        expect(rows, isEmpty);
      },
    );

    test(
      'does NOT record when well within debounce window (15 s elapsed)',
      () async {
        final prefs = await SharedPreferences.getInstance();
        // 15 seconds ago — clearly within the 30-second debounce window.
        final recent = DateTime.now().millisecondsSinceEpoch - 15 * 1000;
        await prefs.setInt('app_launch_last_sent_ms', recent);
        final r = makeRecorder(prefs);

        final result = await recordIos(r);

        expect(result, isFalse);
      },
    );
  });

  group('iOS launch — Android-specific fields are null', () {
    test('event payload omits android-specific fields', () async {
      final prefs = await SharedPreferences.getInstance();
      final r = makeRecorder(prefs);

      await recordIos(r);

      final rows = await db.getUnsyncedEvents();
      expect(rows, hasLength(1));
      final payload = rows.first.payload;

      // iOS-specific fields must be present.
      expect(payload, contains('"platform":"ios"'));
      expect(payload, contains('"device_model":"iPhone 15"'));
      expect(payload, contains('"manufacturer":"Apple"'));

      // Android-specific fields must be absent (null-omitted).
      expect(payload, isNot(contains('android_sdk_int')));
      expect(payload, isNot(contains('security_patch')));
      expect(payload, isNot(contains('is_low_ram_device')));
      expect(payload, isNot(contains('installer_store')));
    });
  });

  group('Android launch — all fields populated', () {
    test('event payload contains all Android-specific fields', () async {
      final prefs = await SharedPreferences.getInstance();
      final r = makeRecorder(prefs);

      await recordAndroid(r);

      final rows = await db.getUnsyncedEvents();
      expect(rows, hasLength(1));
      final payload = rows.first.payload;

      expect(payload, contains('"platform":"android"'));
      expect(payload, contains('"device_model":"Pixel 8"'));
      expect(payload, contains('"manufacturer":"Google"'));
      expect(payload, contains('"android_sdk_int":34'));
      expect(payload, contains('"security_patch":"2024-01-01"'));
      expect(payload, contains('"is_low_ram_device":false'));
      expect(payload, contains('"installer_store":"com.android.vending"'));
    });
  });

  group('launch type distinction', () {
    test('records cold_start launch type correctly', () async {
      final prefs = await SharedPreferences.getInstance();
      final r = makeRecorder(prefs);

      await recordIos(r);

      final rows = await db.getUnsyncedEvents();
      expect(rows.first.payload, contains('"launch_type":"cold_start"'));
    });

    test('records resume launch type correctly', () async {
      final prefs = await SharedPreferences.getInstance();
      final r = makeRecorder(prefs);

      await recordIos(r, launchType: 'resume');

      final rows = await db.getUnsyncedEvents();
      expect(rows.first.payload, contains('"launch_type":"resume"'));
    });

    test(
      'second call with resume within debounce window is debounced',
      () async {
        final prefs = await SharedPreferences.getInstance();
        final r = makeRecorder(prefs);

        final first = await recordIos(r);
        final second = await recordIos(r, launchType: 'resume');

        expect(first, isTrue);
        expect(second, isFalse);
        // Only the first event was recorded.
        expect(await db.getUnsyncedEvents(), hasLength(1));
      },
    );
  });

  group('timestamp updated after successful record', () {
    test(
      'updates stored timestamp so next immediate call is debounced',
      () async {
        final prefs = await SharedPreferences.getInstance();
        final r = makeRecorder(prefs);

        await recordIos(r);
        // Immediately call again — should be debounced.
        final result = await recordIos(r);

        expect(result, isFalse);
      },
    );
  });
}
