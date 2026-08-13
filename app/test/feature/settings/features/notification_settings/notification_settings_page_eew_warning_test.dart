import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/model/environment.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
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
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('EEW warning detail toggles warningEnabled', (tester) async {
    final recorder = _EewGlobalSettingsRecorder();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          buildConfigProvider.overrideWithValue(_buildConfig),
          firebaseMessagingProvider.overrideWithValue(
            _FakeFirebaseMessaging(
              _notificationSettings(
                authorizationStatus: AuthorizationStatus.authorized,
              ),
            ),
          ),
          osNotificationPermissionProvider.overrideWith(
            (ref) async => OsNotificationPermission.fromNotificationSettings(
              _notificationSettings(
                authorizationStatus: AuthorizationStatus.authorized,
              ),
            ),
          ),
          startProvider.overrideWith(_FakeStartNotifier.new),
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
            () => _FakeEewGlobalSettingsNotifier(recorder),
          ),
          eewWarningConfigProvider.overrideWith(
            _FakeEewWarningConfigNotifier.new,
          ),
        ],
        child: const _TestApp(home: NotificationSettingsPage()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('カスタム設定'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('緊急地震速報(警報)'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('通知を受け取る'));
    await tester.pumpAndSettle();

    expect(recorder.lastWarningEnabled, isFalse);
  });
}

final class _EewGlobalSettingsRecorder {
  bool? lastWarningEnabled;
}

class _FakeStartNotifier extends StartNotifier {
  @override
  Future<api.StartResponse> build() async => const api.StartResponse(
    flags: api.StartFlags(
      adsEnabled: false,
      maintenance: api.MaintenanceInfo(enabled: false),
    ),
    app: api.StartApp(
      version: api.StartAppVersion(
        requiredVersions: [api.RequiredVersion(version: '0.0.0')],
      ),
      storeUrl: api.StoreUrl(
        ios: 'https://apps.apple.com',
        android: 'https://play.google.com',
      ),
    ),
    planConstraints: api.PlanConstraintVariants(
      free: _freeConstraints,
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
  _FakeEewGlobalSettingsNotifier(this._recorder);

  final _EewGlobalSettingsRecorder _recorder;

  @override
  Future<EewGlobalSettings> build() async => const EewGlobalSettings(
    enabled: true,
    defaultSound: 'default',
    defaultInterruptionLevel: InterruptionLevel.active,
    startLiveActivity: true,
    collapseNotification: true,
    warningEnabled: true,
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

class _FakeEewWarningConfigNotifier extends EewWarningConfigNotifier {
  @override
  Future<EewWarningSettings> build() async => const EewWarningSettings(
    target: EewWarningTarget.currentLocationOnly,
    nationwideInterruptionLevel: null,
  );
}

const _buildConfig = BuildConfig(
  restApiUrl: '',
  appIdSuffix: '',
  appName: 'EQMonitor',
  commitInformation: 'test',
  flavor: Flavor.dev,
  wsApiUrl: '',
  googleIosClientId: '',
  googleAndroidClientId: '',
  buildTimestamp: '',
  buildCommitMessage: '',
  revenueCatApiKeyIos: '',
  revenueCatApiKeyAndroid: '',
);

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
  const _TestApp({required this.home});

  final Widget home;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData.light().copyWith(
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
