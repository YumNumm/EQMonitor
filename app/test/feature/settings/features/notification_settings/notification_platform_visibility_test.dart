import 'dart:async';

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
import 'package:eqmonitor/feature/settings/features/notification_settings/data/provider/notification_plan_constraints_provider.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/notification_settings_page.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/slot_detail_page.dart';
import 'package:eqmonitor/feature/start/data/notifier/start_notifier.dart';
import 'package:eqmonitor/feature/subscription/data/model/subscription_status.dart';
import 'package:eqmonitor/feature/subscription/data/notifier/subscription_notifier.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets(
    'open custom settings follows Free -> Pro -> Free without deleting regions',
    (tester) async {
      Future<SubscriptionStatus>? nextSubscription;
      final slots = [
        for (var index = 0; index < 2; index++)
          _slot.copyWith(
            id: 'region-$index',
            slotType: NotificationSlotType.region,
            regionId: 130000 + index,
            regionName: '地域$index',
            displayOrder: index,
          ),
      ];
      await pumpCustomSettings(
        tester,
        platform: TargetPlatform.iOS,
        isPro: false,
        slots: slots,
        loadSubscription: () => nextSubscription,
      );
      final container = ProviderScope.containerOf(
        tester.element(
          find.byType(NotificationSettingsPage, skipOffstage: false),
        ),
      );
      final notifier = container.read(
        subscriptionProvider.notifier,
      ) as _FakeSubscriptionNotifier;
      final addButton = regionAddButton('地域を追加（2/1）');
      expect(tester.widget<M3EFilledButton>(addButton).onPressed, isNull);
      expect(
        tester.widget<ListTile>(find.widgetWithText(ListTile, '地域1')).enabled,
        isFalse,
      );

      notifier.publish(
        const AsyncData(SubscriptionStatus.active(productId: 'pro')),
      );
      await tester.pumpAndSettle();
      expect(
        tester
            .widget<M3EFilledButton>(
              regionAddButton('地域を追加（2/10）'),
            )
            .onPressed,
        isNotNull,
      );
      expect(
        tester.widget<ListTile>(find.widgetWithText(ListTile, '地域1')).enabled,
        isTrue,
      );

      final start = await container.read(startProvider.future);
      container
          .read(startProvider.notifier)
          .setDebugOverride(
            start.copyWith(
              planConstraints: start.planConstraints.copyWith(
                subscription: _subscriptionConstraints.copyWith(maxRegions: 2),
              ),
            ),
          );
      await tester.pumpAndSettle();
      expect(
        tester
            .widget<M3EFilledButton>(
              regionAddButton('地域を追加（2/2）'),
            )
            .onPressed,
        isNull,
      );

      final pending = Completer<SubscriptionStatus>();
      nextSubscription = pending.future;
      container.invalidate(subscriptionProvider);
      await tester.pump();
      expect(find.textContaining('地域を追加'), findsNothing);
      pending.complete(const SubscriptionStatus.inactive());
      await tester.pumpAndSettle();
      expect(tester.widget<M3EFilledButton>(addButton).onPressed, isNull);
      expect(
        tester.widget<ListTile>(find.widgetWithText(ListTile, '地域1')).enabled,
        isFalse,
      );
      expect(container.read(notificationSlotsProvider).value, slots);
    },
  );

  testWidgets('unknown subscription shows loading, then error and retry', (
    tester,
  ) async {
    final pending = Completer<SubscriptionStatus>();
    await pumpNotificationSettings(
      tester,
      platform: TargetPlatform.iOS,
      isPro: false,
      initialSubscription: pending.future,
    );
    await tester.tap(find.byTooltip('カスタム設定'));
    await tester.pump(const Duration(seconds: 1));
    final container = ProviderScope.containerOf(
      tester.element(
        find.byType(NotificationSettingsPage, skipOffstage: false),
      ),
    );
    expect(
      container.read(notificationPlanConstraintsProvider).isLoading,
      isTrue,
    );
    expect(find.textContaining('地域を追加'), findsNothing);
    pending.completeError(StateError('unavailable'));
    await tester.pumpAndSettle();
    expect(find.text('通知設定の利用条件を確認できませんでした'), findsOneWidget);
    expect(find.text('再試行'), findsOneWidget);
    expect(find.textContaining('地域を追加'), findsNothing);
  });

  testWidgets(
    'unknown start constraints do not invent a region limit and retry recovers',
    (tester) async {
      Future<api.StartResponse>? nextStart;
      await pumpCustomSettings(
        tester,
        platform: TargetPlatform.iOS,
        isPro: false,
        loadStart: () => nextStart,
      );
      final container = ProviderScope.containerOf(
        tester.element(
          find.byType(NotificationSettingsPage, skipOffstage: false),
        ),
      );
      final pending = Completer<api.StartResponse>();
      nextStart = pending.future;
      container.invalidate(startProvider);
      await tester.pump();
      expect(find.textContaining('地域を追加'), findsNothing);
      pending.completeError(StateError('unavailable'));
      await tester.pumpAndSettle();
      expect(find.text('通知設定の利用条件を確認できませんでした'), findsOneWidget);
      nextStart = null;
      await tester.tap(find.text('再試行'));
      await tester.pumpAndSettle();
      expect(find.text('地域を追加（0/1）'), findsOneWidget);
    },
  );

  testWidgets('flag off keeps Free settings without loading subscription', (
    tester,
  ) async {
    await pumpNotificationSettings(
      tester,
      platform: TargetPlatform.iOS,
      isPro: true,
      proFeaturesEnabled: false,
    );
    await tester.tap(find.byTooltip('カスタム設定'));
    await tester.pumpAndSettle();
    final container = ProviderScope.containerOf(
      tester.element(
        find.byType(NotificationSettingsPage, skipOffstage: false),
      ),
    );
    expect(
      container
          .read(notificationPlanConstraintsProvider)
          .requireValue
          .maxRegions,
      1,
    );
    expect(container.exists(subscriptionProvider), isFalse);
    expect(find.text('地域を追加（0/1）'), findsOneWidget);
  });

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
  List<NotificationSlot> slots = const [_slot],
  Future<SubscriptionStatus>? Function()? loadSubscription,
  Future<api.StartResponse>? Function()? loadStart,
}) async {
  await pumpNotificationSettings(
    tester,
    platform: platform,
    isPro: isPro,
    slots: slots,
    loadSubscription: loadSubscription,
    loadStart: loadStart,
  );
  await tester.tap(find.byTooltip('カスタム設定'));
  await tester.pumpAndSettle();
}

Future<void> pumpNotificationSettings(
  WidgetTester tester, {
  required TargetPlatform platform,
  required bool isPro,
  bool proFeaturesEnabled = true,
  Future<SubscriptionStatus>? initialSubscription,
  Future<SubscriptionStatus>? Function()? loadSubscription,
  Future<api.StartResponse>? Function()? loadStart,
  List<NotificationSlot> slots = const [_slot],
}) async {
  await tester.binding.setSurfaceSize(const Size(800, 6000));
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        buildConfigProvider.overrideWithValue(
          _buildConfig.copyWith(isProFeaturesEnabled: proFeaturesEnabled),
        ),
        subscriptionProvider.overrideWith(
          () => _FakeSubscriptionNotifier(
            isPro: isPro,
            initial: initialSubscription,
            load: loadSubscription,
          ),
        ),
        firebaseMessagingProvider.overrideWithValue(
          _FakeFirebaseMessaging(_notificationSettings),
        ),
        osNotificationPermissionProvider.overrideWith(
          (ref) async => OsNotificationPermission.fromNotificationSettings(
            _notificationSettings,
          ),
        ),
        startProvider.overrideWith(() => _FakeStartNotifier(load: loadStart)),
        notificationPresetProvider.overrideWith(
          _FakeNotificationPresetNotifier.new,
        ),
        generalNotificationSettingsProvider.overrideWith(
          _FakeGeneralNotificationSettingsNotifier.new,
        ),
        notificationSlotsProvider.overrideWith(
          () => _FakeNotificationSlotsNotifier(slots: slots),
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
        eewGlobalSettingsProvider.overrideWith(
          _FakeEewGlobalSettingsNotifier.new,
        ),
        eewWarningConfigProvider.overrideWith(
          _FakeEewWarningConfigNotifier.new,
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

class _FakeSubscriptionNotifier extends SubscriptionNotifier {
  new({required this.isPro, this.initial, this.load});

  final bool isPro;
  final Future<SubscriptionStatus>? initial;
  final Future<SubscriptionStatus>? Function()? load;

  @override
  Future<SubscriptionStatus> build() async =>
      load?.call() ??
      initial ??
      (isPro
          ? const SubscriptionStatus.active(productId: 'pro')
          : const SubscriptionStatus.inactive());

  void publish(AsyncValue<SubscriptionStatus> value) => state = value;
}

class _FakeStartNotifier extends StartNotifier {
  new({this.load});

  final Future<api.StartResponse>? Function()? load;

  @override
  Future<api.StartResponse> build() async =>
      load?.call() ??
      api.StartResponse(
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
            isPro: false,
            maxRegions: 1,
            eewWarningNationwide: false,
            shakeDetection: false,
            overridesAllowed: false,
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
  new({this.slots = const [_slot]});

  final List<NotificationSlot> slots;

  @override
  Future<List<NotificationSlot>> build() async => slots;
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
    target: EewWarningTarget.currentLocationOnly,
    currentLocationInterruptionLevel: InterruptionLevel.critical,
    nationwideInterruptionLevel: null,
  );
}

class _FakeFirebaseMessaging extends Fake implements FirebaseMessaging {
  new(this.settings);

  final NotificationSettings settings;

  @override
  Future<NotificationSettings> getNotificationSettings() async => settings;
}

class _TestApp extends StatelessWidget {
  const new({required this.platform, required this.home});

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
  eewMinIntensity: JmaIntensity.zero,
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

Finder regionAddButton(String label) => find.ancestor(
  of: find.text(label),
  matching: find.byWidgetPredicate((widget) => widget is M3EFilledButton),
);
