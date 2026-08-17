import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/provider/firebase/firebase_messaging.dart';
import 'package:eqmonitor/core/provider/notification/os_notification_permission.dart';
import 'package:eqmonitor/core/provider/notification/os_notification_permission_provider.dart';
import 'package:eqmonitor/feature/notification/data/model/general_notification_settings.dart';
import 'package:eqmonitor/feature/notification/data/notifier/general_notification_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_global_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_warning_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/eew_global_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/eew_warning_config_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_preset_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/notification_settings_page.dart';
import 'package:eqmonitor/feature/start/data/notifier/start_notifier.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('EEW warning detail toggles warningEnabled', (tester) async {
    final recorders = await pumpWarningPage(tester);

    await tester.tap(find.text('通知を受け取る'));
    await tester.pumpAndSettle();

    expect(recorders.global.lastWarningEnabled, isFalse);
  });

  testWidgets('iOS shows four current-location interruption levels', (
    tester,
  ) async {
    await pumpWarningPage(tester, platform: TargetPlatform.iOS);

    expect(find.text('現在地の割り込みレベル'), findsOneWidget);
    expect(find.text('パッシブ'), findsOneWidget);
    expect(find.text('アクティブ'), findsOneWidget);
    expect(find.text('タイムセンシティブ'), findsOneWidget);
    expect(find.text('重大な通知'), findsOneWidget);
  });

  testWidgets('nationwide selector has no critical option', (tester) async {
    await pumpWarningPage(
      tester,
      platform: TargetPlatform.iOS,
      isPro: true,
      target: EewWarningTarget.currentLocationAndNationwide,
    );

    expect(find.text('全国の割り込みレベル'), findsOneWidget);
    expect(find.text('タイムセンシティブ'), findsNWidgets(2));
    expect(find.text('重大な通知'), findsOneWidget);
  });

  testWidgets('interruption selectors update current and nationwide levels', (
    tester,
  ) async {
    final recorders = await pumpWarningPage(
      tester,
      platform: TargetPlatform.iOS,
      target: EewWarningTarget.currentLocationAndNationwide,
    );

    await tester.ensureVisible(find.text('タイムセンシティブ').first);
    await tester.tap(find.text('タイムセンシティブ').first);
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('パッシブ').last);
    await tester.tap(find.text('パッシブ').last);
    await tester.pumpAndSettle();

    expect(
      recorders.warning.currentLocationInterruptionLevel,
      InterruptionLevel.timeSensitive,
    );
    expect(
      recorders.warning.nationwideInterruptionLevel,
      InterruptionLevel.passive,
    );
  });

  testWidgets('shows critical permission card only for enabled critical iOS', (
    tester,
  ) async {
    await pumpWarningPage(
      tester,
      platform: TargetPlatform.iOS,
      currentLevel: InterruptionLevel.critical,
      criticalAlert: AppleNotificationSetting.disabled,
    );

    expect(find.text('重大な通知を許可'), findsOneWidget);
    expect(
      find.text(
        '現在地が緊急地震速報（警報）の対象になった場合に、'
        '消音モード中でも通知するには重大な通知の許可が必要です。',
      ),
      findsOneWidget,
    );
  });

  testWidgets(
    'critical permission card follows master control before target header',
    (tester) async {
      await pumpWarningPage(
        tester,
        platform: TargetPlatform.iOS,
        currentLevel: InterruptionLevel.critical,
        criticalAlert: AppleNotificationSetting.disabled,
      );

      final texts = find
          .descendant(of: find.byType(ListView), matching: find.byType(Text))
          .evaluate()
          .map((element) => (element.widget as Text).data)
          .toList();
      final masterIndex = texts.indexOf('通知を受け取る');
      final cardIndex = texts.indexOf('重大な通知を許可');
      final targetHeaderIndex = texts.indexOf('通知対象');

      expect(masterIndex, isNonNegative);
      expect(cardIndex, greaterThan(masterIndex));
      expect(cardIndex, lessThan(targetHeaderIndex));
    },
  );

  testWidgets('hides critical permission card unless every condition is met', (
    tester,
  ) async {
    const cases = [
      (
        name: 'warning disabled',
        warningEnabled: false,
        currentLevel: InterruptionLevel.critical,
        criticalAlert: AppleNotificationSetting.disabled,
      ),
      (
        name: 'current level is not critical',
        warningEnabled: true,
        currentLevel: InterruptionLevel.active,
        criticalAlert: AppleNotificationSetting.disabled,
      ),
      (
        name: 'critical permission granted',
        warningEnabled: true,
        currentLevel: InterruptionLevel.critical,
        criticalAlert: AppleNotificationSetting.enabled,
      ),
      (
        name: 'critical permission unsupported',
        warningEnabled: true,
        currentLevel: InterruptionLevel.critical,
        criticalAlert: AppleNotificationSetting.notSupported,
      ),
    ];

    for (final testCase in cases) {
      await pumpWarningPage(
        tester,
        platform: TargetPlatform.iOS,
        warningEnabled: testCase.warningEnabled,
        currentLevel: testCase.currentLevel,
        criticalAlert: testCase.criticalAlert,
      );
      expect(find.text('重大な通知を許可'), findsNothing, reason: testCase.name);
    }
  });

  testWidgets('critical permission card opens the existing dialog', (
    tester,
  ) async {
    await pumpWarningPage(
      tester,
      platform: TargetPlatform.iOS,
      currentLevel: InterruptionLevel.critical,
      criticalAlert: AppleNotificationSetting.disabled,
    );

    await tester.ensureVisible(find.text('重大な通知を許可'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('重大な通知を許可'));
    await tester.pumpAndSettle();

    expect(find.text('重大な通知が許可されていません'), findsOneWidget);
  });

  testWidgets('Android hides interruption selectors and shows OS settings', (
    tester,
  ) async {
    await pumpWarningPage(tester, platform: TargetPlatform.android);

    expect(find.text('現在地の割り込みレベル'), findsNothing);
    expect(find.text('全国の割り込みレベル'), findsNothing);
    expect(find.text('Androidの通知設定'), findsOneWidget);
  });

  testWidgets(
    'reselecting nationwide target preserves its interruption level',
    (tester) async {
      final recorders = await pumpWarningPage(
        tester,
        platform: TargetPlatform.iOS,
        isPro: true,
        target: EewWarningTarget.currentLocationAndNationwide,
        nationwideLevel: InterruptionLevel.timeSensitive,
      );

      await tester.ensureVisible(find.text('現在地 + 全国'));
      await tester.tap(find.text('現在地 + 全国'));
      await tester.pumpAndSettle();

      expect(recorders.warning.updateConfigCallCount, 0);
      expect(recorders.warning.target, isNull);
      expect(recorders.warning.nationwideInterruptionLevel, isNull);
    },
  );
}

Future<_WarningPageRecorders> pumpWarningPage(
  WidgetTester tester, {
  bool warningEnabled = true,
  InterruptionLevel currentLevel = InterruptionLevel.active,
  EewWarningTarget target = EewWarningTarget.currentLocationOnly,
  InterruptionLevel? nationwideLevel,
  AppleNotificationSetting criticalAlert =
      AppleNotificationSetting.notSupported,
  TargetPlatform platform = TargetPlatform.android,
  bool isPro = false,
}) async {
  final globalRecorder = _EewGlobalSettingsRecorder();
  final warningRecorder = _EewWarningConfigRecorder();
  final notificationSettings = _notificationSettings(
    authorizationStatus: AuthorizationStatus.authorized,
    criticalAlert: criticalAlert,
  );
  final warningSettings = EewWarningSettings(
    target: target,
    currentLocationInterruptionLevel: currentLevel,
    nationwideInterruptionLevel:
        target == EewWarningTarget.currentLocationAndNationwide
        ? nationwideLevel ?? InterruptionLevel.active
        : null,
  );

  await tester.pumpWidget(
    ProviderScope(
      key: UniqueKey(),
      overrides: [
        firebaseMessagingProvider.overrideWithValue(
          _FakeFirebaseMessaging(notificationSettings),
        ),
        osNotificationPermissionProvider.overrideWith(
          (ref) async => OsNotificationPermission.fromNotificationSettings(
            notificationSettings,
          ),
        ),
        startProvider.overrideWith(() => _FakeStartNotifier(isPro: isPro)),
        notificationPresetProvider.overrideWith(
          _FakeNotificationPresetNotifier.new,
        ),
        generalNotificationSettingsProvider.overrideWith(
          _FakeGeneralNotificationSettingsNotifier.new,
        ),
        notificationSlotsProvider.overrideWith(
          _FakeNotificationSlotsNotifier.new,
        ),
        eewGlobalSettingsProvider.overrideWith(
          () => _FakeEewGlobalSettingsNotifier(
            recorder: globalRecorder,
            warningEnabled: warningEnabled,
          ),
        ),
        eewWarningConfigProvider.overrideWith(
          () => _FakeEewWarningConfigNotifier(
            initialSettings: warningSettings,
            recorder: warningRecorder,
          ),
        ),
      ],
      child: _TestApp(
        home: const NotificationSettingsPage(),
        platform: platform,
      ),
    ),
  );
  await tester.pumpAndSettle();

  await tester.tap(find.byTooltip('カスタム設定'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('緊急地震速報(警報)'));
  await tester.pumpAndSettle();

  return _WarningPageRecorders(
    global: globalRecorder,
    warning: warningRecorder,
  );
}

final class _WarningPageRecorders {
  const _WarningPageRecorders({required this.global, required this.warning});

  final _EewGlobalSettingsRecorder global;
  final _EewWarningConfigRecorder warning;
}

final class _EewGlobalSettingsRecorder {
  bool? lastWarningEnabled;
}

class _FakeStartNotifier extends StartNotifier {
  _FakeStartNotifier({required this.isPro});

  final bool isPro;

  @override
  Future<api.StartResponse> build() async => api.StartResponse(
    flags: const api.StartFlags(
      adsEnabled: false,
      maintenance: api.MaintenanceInfo(enabled: false),
    ),
    app: const api.StartApp(
      version: api.StartAppVersion(
        requiredVersions: [api.RequiredVersion(version: '0.0.0')],
      ),
      storeUrl: api.StoreUrl(
        ios: 'https://apps.apple.com',
        android: 'https://play.google.com',
      ),
    ),
    planConstraints: api.PlanConstraintVariants(
      free: isPro ? _subscriptionConstraints : _freeConstraints,
      subscription: _subscriptionConstraints,
    ),
  );
}

class _FakeNotificationPresetNotifier extends NotificationPresetNotifier {
  @override
  Future<NotificationPreset> build() async => NotificationPreset.custom;
}

class _FakeGeneralNotificationSettingsNotifier
    extends GeneralNotificationSettingsNotifier {
  @override
  Future<GeneralNotificationSettings> build() async =>
      const GeneralNotificationSettings(
        notificationEnabled: true,
        tsunamiEnabled: true,
        trainingEnabled: true,
        nankaiExtraordinaryEnabled: true,
        nankaiRegularEnabled: true,
        vyse60Enabled: true,
        earthquakeNoticeEnabled: true,
      );
}

class _FakeNotificationSlotsNotifier extends NotificationSlotsNotifier {
  @override
  Future<List<NotificationSlot>> build() async => const [];
}

class _FakeEewGlobalSettingsNotifier extends EewGlobalSettingsNotifier {
  _FakeEewGlobalSettingsNotifier({
    required _EewGlobalSettingsRecorder recorder,
    required this.warningEnabled,
  }) : _recorder = recorder;

  final _EewGlobalSettingsRecorder _recorder;
  final bool warningEnabled;

  @override
  Future<EewGlobalSettings> build() async => EewGlobalSettings(
    enabled: true,
    defaultSound: 'default',
    defaultInterruptionLevel: InterruptionLevel.active,
    startLiveActivity: true,
    collapseNotification: true,
    warningEnabled: warningEnabled,
  );

  @override
  Future<void> updateSettings({
    bool? enabled,
    String? defaultSound,
    InterruptionLevel? defaultInterruptionLevel,
    bool? startLiveActivity,
    bool? collapseNotification,
    bool? warningEnabled,
  }) async {
    _recorder.lastWarningEnabled = warningEnabled;
    final current = state.requireValue;
    state = AsyncData(
      current.copyWith(
        enabled: enabled ?? current.enabled,
        defaultSound: defaultSound ?? current.defaultSound,
        defaultInterruptionLevel:
            defaultInterruptionLevel ?? current.defaultInterruptionLevel,
        startLiveActivity: startLiveActivity ?? current.startLiveActivity,
        collapseNotification:
            collapseNotification ?? current.collapseNotification,
        warningEnabled: warningEnabled ?? current.warningEnabled,
      ),
    );
  }
}

final class _EewWarningConfigRecorder {
  int updateConfigCallCount = 0;
  EewWarningTarget? target;
  InterruptionLevel? currentLocationInterruptionLevel;
  InterruptionLevel? nationwideInterruptionLevel;
}

class _FakeEewWarningConfigNotifier extends EewWarningConfigNotifier {
  _FakeEewWarningConfigNotifier({
    required this.initialSettings,
    required this.recorder,
  });

  final EewWarningSettings initialSettings;
  final _EewWarningConfigRecorder recorder;

  @override
  Future<EewWarningSettings> build() async => initialSettings;

  @override
  Future<void> updateConfig({
    EewWarningTarget? target,
    InterruptionLevel? currentLocationInterruptionLevel,
    InterruptionLevel? nationwideInterruptionLevel,
  }) async {
    recorder.updateConfigCallCount = recorder.updateConfigCallCount + 1;
    recorder.target = target;
    if (currentLocationInterruptionLevel != null) {
      recorder.currentLocationInterruptionLevel =
          currentLocationInterruptionLevel;
    }
    if (nationwideInterruptionLevel != null) {
      recorder.nationwideInterruptionLevel = nationwideInterruptionLevel;
    }
    final current = state.requireValue;
    state = AsyncData(
      current.copyWith(
        target: target ?? current.target,
        currentLocationInterruptionLevel:
            currentLocationInterruptionLevel ??
            current.currentLocationInterruptionLevel,
        nationwideInterruptionLevel:
            nationwideInterruptionLevel ?? current.nationwideInterruptionLevel,
      ),
    );
  }
}

const _freeConstraints = api.PlanConstraints(
  isPro: false,
  maxRegions: 1,
  eewWarningNationwide: false,
  shakeDetection: false,
  overridesAllowed: false,
  earthquakeDefaultInterruptionLevel: 'active',
  eewDefaultInterruptionLevel: 'active',
);

const _subscriptionConstraints = api.PlanConstraints(
  isPro: true,
  maxRegions: 10,
  eewWarningNationwide: true,
  shakeDetection: true,
  overridesAllowed: true,
  earthquakeDefaultInterruptionLevel: 'timeSensitive',
  eewDefaultInterruptionLevel: 'timeSensitive',
);

class _TestApp extends StatelessWidget {
  const _TestApp({required this.home, required this.platform});

  final Widget home;
  final TargetPlatform platform;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData.light().copyWith(
      platform: platform,
      extensions: [DesignSystemThemeExtension.light()],
    );
    return MaterialApp(theme: theme, home: home);
  }
}

class _FakeFirebaseMessaging extends Fake implements FirebaseMessaging {
  _FakeFirebaseMessaging(this._settings);

  final NotificationSettings _settings;

  @override
  Future<NotificationSettings> getNotificationSettings() async => _settings;
}

NotificationSettings _notificationSettings({
  AuthorizationStatus authorizationStatus = AuthorizationStatus.notDetermined,
  AppleNotificationSetting criticalAlert =
      AppleNotificationSetting.notSupported,
}) {
  return NotificationSettings(
    alert: AppleNotificationSetting.notSupported,
    announcement: AppleNotificationSetting.notSupported,
    authorizationStatus: authorizationStatus,
    badge: AppleNotificationSetting.notSupported,
    carPlay: AppleNotificationSetting.notSupported,
    lockScreen: AppleNotificationSetting.notSupported,
    notificationCenter: AppleNotificationSetting.notSupported,
    showPreviews: AppleShowPreviewSetting.notSupported,
    timeSensitive: AppleNotificationSetting.notSupported,
    criticalAlert: criticalAlert,
    sound: AppleNotificationSetting.notSupported,
    providesAppNotificationSettings: AppleNotificationSetting.notSupported,
  );
}
