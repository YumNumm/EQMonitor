import 'dart:async';

import 'package:eqmonitor/core/data/preferences/shared/shared_preferences.dart'
    as data_prefs;
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/model/environment.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/core/provider/log/talker.dart' as talker_lib;
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart' as app_prefs;
import 'package:eqmonitor/feature/devices/data/model/device_role.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_role_notifier.dart';
import 'package:eqmonitor/feature/settings/settings_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  talker_lib.talker = Talker(settings: TalkerSettings(useConsoleLogs: false));

  testWidgets('アプリアイコンのダブルタップでロールを取得し直し、取得できたことを触覚で知らせる', (
    tester,
  ) async {
    final role = _RecordingDeviceRole();
    final haptics = _recordHaptics(tester);
    await _pumpSettings(tester, role: role);
    final texts = tester.widgetList<Text>(find.byType(Text)).length;

    await _doubleTapAppIcon(tester);

    expect(role.refreshCount, 1);
    expect(haptics, ['HapticFeedbackType.mediumImpact']);
    expect(find.byType(SnackBar), findsNothing);
    expect(find.byType(Dialog), findsNothing);
    expect(tester.widgetList<Text>(find.byType(Text)).length, texts);
  });

  testWidgets('取得が終わるまでは触覚を返さない', (tester) async {
    final pending = Completer<void>();
    final role = _RecordingDeviceRole(pending: pending);
    final haptics = _recordHaptics(tester);
    await _pumpSettings(tester, role: role);

    await _doubleTapAppIcon(tester);
    expect(role.refreshCount, 1);
    expect(haptics, isEmpty);

    pending.complete();
    await tester.pump();
    await tester.pump();

    expect(haptics, ['HapticFeedbackType.mediumImpact']);
  });

  testWidgets('取得中に例外が起きた場合は、画面にも触覚にも何も返さない', (tester) async {
    final role = _RecordingDeviceRole(error: StateError('offline'));
    final haptics = _recordHaptics(tester);
    await _pumpSettings(tester, role: role);

    await _doubleTapAppIcon(tester);

    expect(role.refreshCount, 1);
    expect(haptics, isEmpty);
    expect(find.byType(SnackBar), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('ロールを取得できなかった場合は、画面にも触覚にも何も返さない', (tester) async {
    final role = _RecordingDeviceRole(isRefreshed: false);
    final haptics = _recordHaptics(tester);
    await _pumpSettings(tester, role: role);

    await _doubleTapAppIcon(tester);

    expect(role.refreshCount, 1);
    expect(haptics, isEmpty);
    expect(find.byType(SnackBar), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('1 回のタップでは取得しない', (tester) async {
    final role = _RecordingDeviceRole();
    final haptics = _recordHaptics(tester);
    await _pumpSettings(tester, role: role);

    await tester.tap(find.byType(Image).first);
    await tester.pump(const Duration(seconds: 1));

    expect(role.refreshCount, 0);
    expect(haptics, isEmpty);
  });
}

Future<void> _doubleTapAppIcon(WidgetTester tester) async {
  final icon = find.byType(Image).first;
  await tester.tap(icon);
  await tester.pump(const Duration(milliseconds: 50));
  await tester.tap(icon);
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
}

List<String> _recordHaptics(WidgetTester tester) {
  final haptics = <String>[];
  tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
    SystemChannels.platform,
    (call) async {
      if (call.method == 'HapticFeedback.vibrate') {
        haptics.add(call.arguments as String);
      }
      return null;
    },
  );
  addTearDown(
    () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      null,
    ),
  );
  return haptics;
}

Future<void> _pumpSettings(
  WidgetTester tester, {
  required _RecordingDeviceRole role,
}) async {
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        data_prefs.sharedPreferencesProvider.overrideWithValue(
          AsyncValue.data(prefs),
        ),
        app_prefs.sharedPreferencesProvider.overrideWithValue(
          app_prefs.SharedPreferencesAsync(prefs),
        ),
        buildConfigProvider.overrideWithValue(_buildConfig),
        packageInfoProvider.overrideWithValue(_packageInfo),
        deviceRoleProvider.overrideWith(() => role),
      ],
      child: MaterialApp(
        theme: ThemeData.light().copyWith(
          extensions: [DesignSystemThemeExtension.light()],
        ),
        home: const SettingsPage(),
      ),
    ),
  );
  await tester.pump();
}

class _RecordingDeviceRole({
  final Object? error,
  final Completer<void>? pending,
  final bool isRefreshed = true,
}) extends DeviceRoleNotifier {
  var refreshCount = 0;

  @override
  Future<DeviceRole?> build() async => null;

  @override
  Future<bool> refresh() async {
    refreshCount += 1;
    await pending?.future;
    final error = this.error;
    if (error != null) {
      throw error;
    }
    return isRefreshed;
  }
}

const _buildConfig = BuildConfig(
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

final _packageInfo = PackageInfo(
  appName: 'EQMonitor',
  packageName: 'net.yumnumm.eqmonitor',
  version: '1.2.3',
  buildNumber: '456',
);
