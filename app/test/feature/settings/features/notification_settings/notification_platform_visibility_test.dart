import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
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
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/slot_detail_page.dart';
import 'package:eqmonitor/feature/start/data/notifier/start_notifier.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('Android hides sound and per-intensity settings', (tester) async {
    await pumpCustomSettings(
      tester,
      platform: TargetPlatform.android,
      isPro: true,
    );

    expect(find.text('通知音・割り込みレベル'), findsNothing);
    expect(find.text('震度別の音設定'), findsNothing);
  });

  testWidgets('iOS keeps sound and per-intensity settings', (tester) async {
    await pumpCustomSettings(tester, platform: TargetPlatform.iOS, isPro: true);

    expect(find.text('通知音・割り込みレベル'), findsOneWidget);
    expect(find.text('震度別の音設定'), findsOneWidget);
  });

  testWidgets('does not show downgrade retention copy', (tester) async {
    await pumpCustomSettings(
      tester,
      platform: TargetPlatform.android,
      isPro: false,
    );

    expect(find.textContaining('ダウングレード時も設定は保持され'), findsNothing);
  });

  testWidgets('Android hides per-intensity slot settings', (tester) async {
    await pumpSlotDetail(tester, platform: TargetPlatform.android);

    expect(find.text('震度別設定'), findsNothing);
  });

  testWidgets('iOS keeps per-intensity slot settings', (tester) async {
    await pumpSlotDetail(tester, platform: TargetPlatform.iOS);

    expect(find.text('震度別設定'), findsWidgets);
  });

  testWidgets('Android keeps the notification channel settings entry', (
    tester,
  ) async {
    await pumpNotificationSettings(
      tester,
      platform: TargetPlatform.android,
      isPro: true,
    );

    expect(find.text('Android 通知チャンネル設定'), findsOneWidget);
  });
}

Future<void> pumpCustomSettings(
  WidgetTester tester, {
  required TargetPlatform platform,
  required bool isPro,
}) async {
  await pumpNotificationSettings(tester, platform: platform, isPro: isPro);
  await tester.tap(find.byTooltip('カスタム設定'));
  await tester.pumpAndSettle();
}

Future<void> pumpNotificationSettings(
  WidgetTester tester, {
  required TargetPlatform platform,
  required bool isPro,
}) async {
  await tester.binding.setSurfaceSize(const Size(800, 6000));
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        firebaseMessagingProvider.overrideWithValue(
          _FakeFirebaseMessaging(_notificationSettings),
        ),
        osNotificationPermissionProvider.overrideWith(
          (ref) async => OsNotificationPermission.fromNotificationSettings(
            _notificationSettings,
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
          _FakeEewGlobalSettingsNotifier.new,
        ),
        eewWarningConfigProvider.overrideWith(
          _FakeEewWarningConfigNotifier.new,
        ),
      ],
      child: _TestApp(
        platform: platform,
        home: const NotificationSettingsPage(),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> pumpSlotDetail(
  WidgetTester tester, {
  required TargetPlatform platform,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        notificationSlotsProvider.overrideWith(
          _FakeNotificationSlotsNotifier.new,
        ),
      ],
      child: _TestApp(
        platform: platform,
        home: const SlotDetailPage(slotId: 'current', isPro: true),
      ),
    ),
  );
  await tester.pumpAndSettle();
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
      free: api.PlanConstraints(
        isPro: isPro,
        maxRegions: isPro ? 10 : 1,
        eewWarningNationwide: isPro,
        shakeDetection: isPro,
        overridesAllowed: isPro,
        earthquakeDefaultInterruptionLevel: 'active',
        eewDefaultInterruptionLevel: 'active',
      ),
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
  Future<List<NotificationSlot>> build() async => const [_slot];
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
}

class _FakeEewWarningConfigNotifier extends EewWarningConfigNotifier {
  @override
  Future<EewWarningSettings> build() async => const EewWarningSettings(
    target: EewWarningTarget.currentLocationOnly,
    currentLocationInterruptionLevel: InterruptionLevel.critical,
    nationwideInterruptionLevel: null,
  );
}

class _FakeFirebaseMessaging extends Fake implements FirebaseMessaging {
  _FakeFirebaseMessaging(this.settings);

  final NotificationSettings settings;

  @override
  Future<NotificationSettings> getNotificationSettings() async => settings;
}

class _TestApp extends StatelessWidget {
  const _TestApp({required this.platform, required this.home});

  final TargetPlatform platform;
  final Widget home;

  @override
  Widget build(BuildContext context) => MaterialApp(
    theme: ThemeData.light().copyWith(
      platform: platform,
      extensions: [DesignSystemThemeExtension.light()],
    ),
    home: home,
  );
}

const _subscriptionConstraints = api.PlanConstraints(
  isPro: true,
  maxRegions: 10,
  eewWarningNationwide: true,
  shakeDetection: true,
  overridesAllowed: true,
  earthquakeDefaultInterruptionLevel: 'timeSensitive',
  eewDefaultInterruptionLevel: 'timeSensitive',
);

const _slot = NotificationSlot(
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
  earthquakeMinIntensity: JmaIntensity.three,
  earthquakeOverrides: null,
);

const _notificationSettings = NotificationSettings(
  alert: AppleNotificationSetting.notSupported,
  announcement: AppleNotificationSetting.notSupported,
  authorizationStatus: AuthorizationStatus.authorized,
  badge: AppleNotificationSetting.notSupported,
  carPlay: AppleNotificationSetting.notSupported,
  lockScreen: AppleNotificationSetting.notSupported,
  notificationCenter: AppleNotificationSetting.notSupported,
  showPreviews: AppleShowPreviewSetting.notSupported,
  timeSensitive: AppleNotificationSetting.notSupported,
  criticalAlert: AppleNotificationSetting.notSupported,
  sound: AppleNotificationSetting.notSupported,
  providesAppNotificationSettings: AppleNotificationSetting.notSupported,
);
