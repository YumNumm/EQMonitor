import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/model/environment.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/core/provider/firebase/firebase_messaging.dart';
import 'package:eqmonitor/core/provider/notification/os_notification_permission.dart';
import 'package:eqmonitor/core/provider/notification/os_notification_permission_provider.dart';
import 'package:eqmonitor/feature/notification/data/model/general_notification_settings.dart';
import 'package:eqmonitor/feature/notification/data/notifier/general_notification_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/earthquake_global_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_global_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_warning_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/earthquake_global_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/eew_global_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/eew_warning_config_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_preset_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/notification_settings_page.dart';
import 'package:eqmonitor/feature/start/data/notifier/start_notifier.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('custom settings shows slot summaries and remaining settings', (
    tester,
  ) async {
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
            _FakeEewGlobalSettingsNotifier.new,
          ),
          earthquakeGlobalSettingsProvider.overrideWith(
            _FakeEarthquakeGlobalSettingsNotifier.new,
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

    expect(find.textContaining('EQMonitor Proにすると'), findsNothing);
    expect(find.text('Live Activity'), findsNothing);
    expect(find.text('推計震度分布図'), findsOneWidget);
    expect(find.text('通知音・割り込みレベル'), findsOneWidget);
    expect(find.text('震度別の音設定'), findsOneWidget);
    expect(find.text('低精度の緊急地震速報'), findsOneWidget);
    expect(find.byIcon(Icons.my_location), findsOneWidget);
    expect(find.byIcon(Icons.public), findsOneWidget);
    expect(find.byIcon(Icons.location_on), findsOneWidget);
    expect(
      find.text(
        '緊急地震速報(予報): 震度4以上\n'
        '緊急地震速報(警報): 有効\n'
        '地震情報: 震度1以上',
      ),
      findsOneWidget,
    );
    expect(
      find.text(
        '緊急地震速報(予報): 震度5-以上\n'
        '緊急地震速報(警報): 有効\n'
        '地震情報: 震度3以上',
      ),
      findsOneWidget,
    );
    expect(find.text('緊急地震速報(予報): 無効\n地震情報: 無効'), findsOneWidget);
  });
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
  Future<List<NotificationSlot>> build() async => const [
    NotificationSlot(
      id: 'current',
      slotType: NotificationSlotType.currentLocation,
      regionId: null,
      regionName: null,
      cityCode: null,
      cityName: null,
      displayOrder: 0,
      eewEnabled: true,
      eewMinIntensity: JmaIntensity.four,
      eewOverrides: null,
      earthquakeEnabled: true,
      earthquakeMinIntensity: JmaIntensity.one,
      earthquakeOverrides: null,
    ),
    NotificationSlot(
      id: 'nationwide',
      slotType: NotificationSlotType.nationwide,
      regionId: null,
      regionName: null,
      cityCode: null,
      cityName: null,
      displayOrder: 1,
      eewEnabled: true,
      eewMinIntensity: JmaIntensity.fiveLower,
      eewOverrides: null,
      earthquakeEnabled: true,
      earthquakeMinIntensity: JmaIntensity.three,
      earthquakeOverrides: null,
    ),
    NotificationSlot(
      id: 'region',
      slotType: NotificationSlotType.region,
      regionId: 130000,
      regionName: '東京都',
      cityCode: null,
      cityName: null,
      displayOrder: 2,
      eewEnabled: false,
      eewMinIntensity: JmaIntensity.four,
      eewOverrides: null,
      earthquakeEnabled: false,
      earthquakeMinIntensity: JmaIntensity.one,
      earthquakeOverrides: null,
    ),
  ];
}

class _FakeEewGlobalSettingsNotifier extends EewGlobalSettingsNotifier {
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

class _FakeEarthquakeGlobalSettingsNotifier
    extends EarthquakeGlobalSettingsNotifier {
  @override
  Future<EarthquakeGlobalSettings> build() async =>
      const EarthquakeGlobalSettings(
        enabled: true,
        defaultSound: 'default',
        defaultInterruptionLevel: InterruptionLevel.active,
        estimatedIntensityEnabled: true,
        collapseNotification: true,
      );
}

class _FakeEewWarningConfigNotifier extends EewWarningConfigNotifier {
  @override
  Future<EewWarningSettings> build() async => const EewWarningSettings(
    target: EewWarningTarget.currentLocationAndNationwide,
    nationwideInterruptionLevel: InterruptionLevel.active,
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
  eewWarningNationwide: true,
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
  const new({required this.home});

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
  new(this._settings);

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
