import 'dart:async';

import 'package:eqmonitor/app.dart';
import 'package:eqmonitor/core/component/error/fatal_error_screen.dart';
import 'package:eqmonitor/core/component/web_view/app_web_view_page.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/router/material_page_mixin.dart';
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/feature/auth/ui/page/debug_auth_page.dart';
import 'package:eqmonitor/feature/beta_testing/ui/page/beta_testing_warning_page.dart';
import 'package:eqmonitor/feature/changelog/ui/page/changelog_page.dart';
import 'package:eqmonitor/feature/debug/data/model/debug_access_level.dart';
import 'package:eqmonitor/feature/debug/data/provider/debug_access_level_provider.dart';
import 'package:eqmonitor/feature/devices/ui/page/debug_device_settings_page.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_activity_query.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/earthquake_activity_page.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/earthquake_history_details_page.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/earthquake_history_page.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/page/earthquake_history_search_page.dart';
import 'package:eqmonitor/feature/earthquake_replay/ui/page/replay_creation_page.dart';
import 'package:eqmonitor/feature/earthquake_replay/ui/page/replay_open_page.dart';
import 'package:eqmonitor/feature/eew/ui/page/eew_details_by_event_id_page.dart';
import 'package:eqmonitor/feature/eew_history/ui/eew_history_page.dart';
import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:eqmonitor/feature/feed/ui/page/feed_details_page.dart';
import 'package:eqmonitor/feature/feed/ui/page/feed_item_details_page.dart';
import 'package:eqmonitor/feature/feed/ui/page/feed_page.dart';
import 'package:eqmonitor/feature/home/ui/page/home_map_layer_page.dart';
import 'package:eqmonitor/feature/intensity_history/ui/intensity_history_page.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/ui/page/kyoshin_monitor_about_observation_network_page.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/ui/page/kyoshin_monitor_about_page.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/ui/page/kyoshin_monitor_data_type_page.dart';
import 'package:eqmonitor/feature/onboarding/data/notifier/onboarding_notifier.dart';
import 'package:eqmonitor/feature/onboarding/ui/page/onboarding_page.dart';
import 'package:eqmonitor/feature/region_selection/data/model/region_selection_request.dart';
import 'package:eqmonitor/feature/region_selection/ui/page/region_selection_page.dart';
import 'package:eqmonitor/feature/seismicity/ui/seismicity_page.dart';
import 'package:eqmonitor/feature/notification/ui/page/test_notification_page.dart';
import 'package:eqmonitor/feature/settings/children/application_info/about_this_app_page.dart';
import 'package:eqmonitor/feature/settings/children/application_info/license_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/api_endpoint_selector/http_api_endpoint_selector_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/app_group/debug_app_group_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/asset_pack/asset_pack_debug_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/debug_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/device/debug_device_admin_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/earthquake_history/debug_earthquake_history_card_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/earthquake_history/debug_earthquake_history_list_tile_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/eew/debug_eew_card_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/http_cache/debug_http_cache_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/intensity_icon/intensity_icon_debug_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/jma_map/debug_jma_map_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/kyoshin_monitor/debug_kyoshin_monitor.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/navigation/navigation_debug_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/notification/debug_notification_delivery_log_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/notification/debug_notification_webhook_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/playground/playground_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/secure_storage/debug_secure_storage_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/shake_detection/debug_shake_detection_card_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/shake_detection/debug_shake_detection_engine_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/shake_detection/debug_shake_detection_insert_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/shared_preferences/debug_shared_preferences_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/telemetry/debug_telemetry_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/websocket/debug_websocket_page.dart';
import 'package:eqmonitor/feature/settings/children/config/earthquake_history/earthquake_history_config_page.dart';
import 'package:eqmonitor/feature/settings/features/display_settings/ui/display_settings.dart';
import 'package:eqmonitor/feature/settings/features/display_settings/ui/theme/theme_editor_page.dart';
import 'package:eqmonitor/feature/settings/features/display_settings/ui/theme/theme_settings_page.dart';
import 'package:eqmonitor/feature/settings/features/home_widget_settings/ui/page/home_widget_settings_page.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/notification_settings_page.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/shake_detection_settings_page.dart';
import 'package:eqmonitor/feature/settings/settings_page.dart';
import 'package:eqmonitor/feature/subscription/ui/page/paywall_page.dart';
import 'package:eqmonitor/feature/subscription/ui/page/subscription_settings_page.dart';
import 'package:eqmonitor/feature/telegram_list/ui/telegram_list_by_event_id_page.dart';
import 'package:eqmonitor/page/home_page.dart';
import 'package:eqmonitor/page/splash_page.dart';
import 'package:eqmonitor/page/talker/talker_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart' hide LicensePage;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheet/route.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'router.g.dart';

@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) => GoRouter(
  routes: $appRoutes,
  navigatorKey: App.navigatorKey,
  initialLocation: const SplashRoute().location,
  redirect: (context, state) {
    if (state.matchedLocation == SplashRoute().location) {
      return null;
    }

    final buildConfig = ref.read(buildConfigProvider);
    if (buildConfig.isProduction &&
        state.matchedLocation.startsWith(
          const DebugTelemetryRoute().location,
        )) {
      return const HomeRoute().location;
    }
    final isOnboardingCompleted =
        ref.read(onboardingCompletedProvider).value ?? false;
    final debugRouteRedirect = DebugMenuRouteGuard.redirect(
      accessLevel: ref.read(debugAccessLevelProvider),
      matchedLocation: state.matchedLocation,
      isOnboardingCompleted: isOnboardingCompleted,
    );
    if (debugRouteRedirect != null) {
      return debugRouteRedirect;
    }
    if (!buildConfig.isShakeDetectionEnabled &&
        [
          const ShakeDetectionSettingsRoute().location,
          const DebugShakeDetectionCardRoute().location,
          const DebugShakeDetectionInsertRoute().location,
        ].any(state.matchedLocation.startsWith)) {
      return const HomeRoute().location;
    }

    if (!isOnboardingCompleted) {
      final allowedDuringOnboarding =
          [
            const OnboardingRoute().location,
            const TermOfServiceRoute().location,
            const PrivacyPolicyRoute().location,
            const LicenseRoute().location,
          ].contains(state.matchedLocation) ||
          state.matchedLocation == '/onboarding/web-view' ||
          state.matchedLocation.startsWith(const DebugRoute().location);
      if (allowedDuringOnboarding) {
        return null;
      } else {
        return const OnboardingRoute().location;
      }
    }

    return null;
  },
  observers: [
    _NavigatorObserver(talker),
    FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
  ],
  debugLogDiagnostics: kDebugMode,
  errorBuilder: (context, state) => FatalErrorScreen(error: state.error),
);

class GoRouterRedirectException(final String message) implements Exception;

@TypedGoRoute<SplashRoute>(path: '/splash')
class const SplashRoute()
    extends GoRouteData
    with $SplashRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) => const SplashPage();
}

@TypedGoRoute<OnboardingRoute>(path: '/onboarding')
class const OnboardingRoute()
    extends GoRouteData
    with $OnboardingRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const OnboardingPage();
}

@TypedGoRoute<OnboardingWebViewRoute>(path: '/onboarding/web-view')
class const OnboardingWebViewRoute({
  required final String title,
  required final String url,
}) extends GoRouteData with $OnboardingWebViewRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      AppWebViewPage(title: title, url: url);
}

@TypedGoRoute<BetaTestingWarningRoute>(path: '/beta-warning')
class const BetaTestingWarningRoute()
    extends GoRouteData
    with $BetaTestingWarningRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const BetaTestingWarningPage();
}

@TypedGoRoute<EarthquakeHistoryRoute>(path: '/earthquake-history')
class const EarthquakeHistoryRoute({final EarthquakeHistoryParameter? $extra})
    extends GoRouteData
    with $EarthquakeHistoryRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      EarthquakeHistoryPage(initialParameter: $extra);
}

@TypedGoRoute<EarthquakeHistorySearchRoute>(path: '/earthquake-history/search')
class const EarthquakeHistorySearchRoute({final String query = ''})
    extends GoRouteData
    with $EarthquakeHistorySearchRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      EarthquakeHistorySearchPage(key: ValueKey(query), initialQuery: query);
}

@TypedGoRoute<RegionSelectionRoute>(path: '/region-selection')
class const RegionSelectionRoute({final RegionSelectionRequest? $extra})
    extends GoRouteData
    with $RegionSelectionRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      RegionSelectionPage(request: $extra ?? const RegionSelectionRequest());
}

@TypedGoRoute<EewHistoryRoute>(path: '/eew-history')
class const EewHistoryRoute()
    extends GoRouteData
    with $EewHistoryRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const EewHistoryPage();
}

@TypedGoRoute<SeismicityRoute>(path: '/seismicity')
class const SeismicityRoute()
    extends GoRouteData
    with $SeismicityRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SeismicityPage();
}

@TypedGoRoute<IntensityHistoryRoute>(path: '/intensity-history')
class const IntensityHistoryRoute({
  final String? prefectureCode,
  final String? cityCode,
}) extends GoRouteData with $IntensityHistoryRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      IntensityHistoryPage(
        initialPrefectureCode: prefectureCode,
        initialCityCode: cityCode,
      );
}

@TypedGoRoute<EarthquakeHistoryDetailsRoute>(
  path: '/earthquake-history-details/:eventId',
)
class const EarthquakeHistoryDetailsRoute({required final String eventId})
    extends GoRouteData
    with $EarthquakeHistoryDetailsRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EarthquakeHistoryDetailsPage(eventId: eventId);
  }
}

@TypedGoRoute<EarthquakeActivityRoute>(path: '/earthquake-activity')
class const EarthquakeActivityRoute({
  required final EarthquakeActivityQuery $extra,
}) extends GoRouteData with $EarthquakeActivityRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      EarthquakeActivityPage(initialQuery: $extra);
}

@TypedGoRoute<TelegramListByEventIdRoute>(path: '/telegram-list/:eventId')
class const TelegramListByEventIdRoute({required final String eventId})
    extends GoRouteData
    with $TelegramListByEventIdRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TelegramListByEventIdPage(eventId: eventId);
  }
}

@TypedGoRoute<ReplayOpenRoute>(path: '/replay/open')
class const ReplayOpenRoute({required final String source})
    extends GoRouteData
    with $ReplayOpenRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ReplayOpenPage(source: source);
}

@TypedGoRoute<HomeRoute>(
  path: '/',
  routes: [
    TypedGoRoute<HomeMapLayerRoute>(path: 'map-layer'),
    TypedGoRoute<EewDetailsByEventIdRoute>(
      path: 'eew-details-by-event-id/:eventId',
    ),
  ],
)
class const HomeRoute() extends GoRouteData with $HomeRoute {
  /// `sheet` パッケージのシートと secondary transition を連携させるため、
  /// [MaterialPageMixin] ではなく [MaterialExtendedPage] を使う。
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      MaterialExtendedPage<void>(
        key: state.pageKey,
        name: state.name ?? state.path,
        restorationId: state.pageKey.value,
        child: const HomePage(),
      );
}

class const HomeMapLayerRoute()
    extends GoRouteData
    with $HomeMapLayerRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const HomeMapLayerPage();
}

@TypedGoRoute<TalkerRoute>(path: '/talker')
class const TalkerRoute()
    extends GoRouteData
    with $TalkerRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) => const TalkerPage();
}

@TypedGoRoute<SettingsRoute>(
  path: '/settings',
  routes: [
    TypedGoRoute<DisplayRoute>(
      path: 'display',
      routes: [
        TypedGoRoute<ThemeSettingsRoute>(
          path: 'theme',
          routes: [TypedGoRoute<ThemeEditorRoute>(path: 'editor/:mode')],
        ),
      ],
    ),
    TypedGoRoute<KyoshinMonitorAboutRoute>(
      path: 'kyoshin-monitor-about',
      routes: [
        TypedGoRoute<KyoshinMonitorAboutObservationNetworkRoute>(
          path: 'observation-network',
        ),
        TypedGoRoute<KyoshinMonitorDataTypeRoute>(path: 'data-type'),
      ],
    ),
    TypedGoRoute<TermOfServiceRoute>(path: 'term-of-service'),
    TypedGoRoute<PrivacyPolicyRoute>(path: 'privacy-policy'),
    TypedGoRoute<LicenseRoute>(path: 'license'),
    TypedGoRoute<NotificationSettingsRoute>(
      path: 'notification',
      routes: [
        TypedGoRoute<ShakeDetectionSettingsRoute>(path: 'shake'),
        TypedGoRoute<NotificationHistoryRoute>(path: 'history'),
        TypedGoRoute<TestNotificationRoute>(path: 'test'),
      ],
    ),
    TypedGoRoute<EarthquakeHistoryConfigRoute>(path: 'earthquake-history'),
    TypedGoRoute<HomeWidgetSettingsRoute>(path: 'home-widget'),
    TypedGoRoute<AboutThisAppRoute>(path: 'about-this-app'),
    TypedGoRoute<ChangelogRoute>(path: 'changelog'),
    TypedGoRoute<DebugRoute>(
      path: 'debug',
      routes: [
        TypedGoRoute<HttpApiEndpointSelectorRoute>(
          path: 'api-endpoint-selector',
        ),
        TypedGoRoute<DebugAuthRoute>(path: 'auth'),
        TypedGoRoute<DebugKyoshinMonitorRoute>(path: 'kyoshin-monitor'),
        TypedGoRoute<DebugEewCardRoute>(path: 'eew-card'),
        TypedGoRoute<DebugEarthquakeHistoryCardRoute>(
          path: 'earthquake-history-card',
        ),
        TypedGoRoute<DebugEarthquakeHistoryListTileRoute>(
          path: 'earthquake-history-list-tile',
        ),
        TypedGoRoute<DebugShakeDetectionCardRoute>(
          path: 'shake-detection-card',
        ),
        TypedGoRoute<DebugShakeDetectionSettingsRoute>(
          path: 'shake-detection-settings',
        ),
        TypedGoRoute<DebugShakeDetectionInsertRoute>(
          path: 'shake-detection-insert',
        ),
        TypedGoRoute<DebugShakeDetectionEngineRoute>(
          path: 'shake-detection-engine',
        ),
        TypedGoRoute<DebugJmaMapRoute>(path: 'jma-map'),
        TypedGoRoute<PlaygroundRoute>(path: 'playground'),
        TypedGoRoute<DebugWebSocketRoute>(path: 'websocket'),
        TypedGoRoute<DebugNotificationDeliveryLogRoute>(
          path: 'notification-delivery-log',
        ),
        TypedGoRoute<DebugNotificationWebhookRoute>(
          path: 'notification-webhooks',
        ),
        TypedGoRoute<DebugDeviceAdminRoute>(path: 'device-admin'),
        TypedGoRoute<DebugDeviceSettingsRoute>(path: 'device-settings'),
        TypedGoRoute<DebugNavigationRoute>(path: 'navigation'),
        TypedGoRoute<DebugAppGroupRoute>(path: 'app-group'),
        TypedGoRoute<AssetPackDebugRoute>(path: 'asset-pack'),
        TypedGoRoute<DebugSharedPreferencesRoute>(path: 'shared-preferences'),
        TypedGoRoute<DebugSecureStorageRoute>(path: 'secure-storage'),
        TypedGoRoute<DebugHttpCacheRoute>(path: 'http-cache'),
        TypedGoRoute<DebugReplayCreationRoute>(path: 'replay-creation'),
        TypedGoRoute<DebugIntensityIconRoute>(path: 'intensity-icon'),
        TypedGoRoute<DebugTelemetryRoute>(path: 'telemetry'),
      ],
    ),
  ],
)
class const SettingsRoute()
    extends GoRouteData
    with $SettingsRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingsPage();
}

class const DisplayRoute()
    extends GoRouteData
    with $DisplayRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DisplaySettingsPage();
}

class const ThemeSettingsRoute()
    extends GoRouteData
    with $ThemeSettingsRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ThemeSettingsPage();
}

class const ThemeEditorRoute({required final String mode})
    extends GoRouteData
    with $ThemeEditorRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    final brightnessMode = ThemeBrightnessMode.values.firstWhere(
      (e) => e.name == mode,
      orElse: () => ThemeBrightnessMode.light,
    );
    return ThemeEditorPage(mode: brightnessMode);
  }
}

class const TestNotificationRoute()
    extends GoRouteData
    with $TestNotificationRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const TestNotificationPage();
}

class const NotificationSettingsRoute()
    extends GoRouteData
    with $NotificationSettingsRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const NotificationSettingsPage();
}

class const HomeWidgetSettingsRoute()
    extends GoRouteData
    with $HomeWidgetSettingsRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const HomeWidgetSettingsPage();
}

class const ShakeDetectionSettingsRoute()
    extends GoRouteData
    with $ShakeDetectionSettingsRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ShakeDetectionSettingsPage();
}

class const NotificationHistoryRoute()
    extends GoRouteData
    with $NotificationHistoryRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DebugNotificationDeliveryLogPage();
}

class const DebugShakeDetectionSettingsRoute()
    extends GoRouteData
    with $DebugShakeDetectionSettingsRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ShakeDetectionSettingsPage();
}

class const DebugRoute()
    extends GoRouteData
    with $DebugRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) => const DebugPage();
}

final class const DebugMenuRouteGuard() {
  static String? redirect({
    required DebugAccessLevel accessLevel,
    required String matchedLocation,
    required bool isOnboardingCompleted,
  }) {
    if (accessLevel == DebugAccessLevel.none &&
        matchedLocation.startsWith(const DebugRoute().location)) {
      return const HomeRoute().location;
    }
    if (accessLevel == DebugAccessLevel.full) {
      return null;
    }
    final isAdminOnly =
        [
          const TalkerRoute().location,
          const HttpApiEndpointSelectorRoute().location,
          const DebugAuthRoute().location,
          const DebugAppGroupRoute().location,
          const DebugSharedPreferencesRoute().location,
          const DebugSecureStorageRoute().location,
          const DebugHttpCacheRoute().location,
          const DebugWebSocketRoute().location,
          const DebugNavigationRoute().location,
          const DebugDeviceSettingsRoute().location,
          const DebugNotificationWebhookRoute().location,
          const DebugDeviceAdminRoute().location,
        ].any(matchedLocation.startsWith) ||
        (isOnboardingCompleted &&
            matchedLocation.startsWith(const OnboardingRoute().location));
    if (!isAdminOnly) {
      return null;
    }
    return accessLevel == DebugAccessLevel.none
        ? const HomeRoute().location
        : const DebugRoute().location;
  }
}

class const DebugAuthRoute()
    extends GoRouteData
    with $DebugAuthRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DebugAuthPage();
}

class const HttpApiEndpointSelectorRoute()
    extends GoRouteData
    with $HttpApiEndpointSelectorRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const HttpApiEndpointSelectorPage();
}

class const EarthquakeHistoryConfigRoute()
    extends GoRouteData
    with $EarthquakeHistoryConfigRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const EarthquakeHistoryConfigPage();
}

class const TermOfServiceRoute()
    extends GoRouteData
    with $TermOfServiceRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AppWebViewPage(
        title: '利用規約',
        url: 'https://eqmonitor.app/term_of_service',
      );
}

class const PrivacyPolicyRoute()
    extends GoRouteData
    with $PrivacyPolicyRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AppWebViewPage(
        title: 'プライバシーポリシー',
        url: 'https://eqmonitor.app/privacy_policy',
      );
}

class const LicenseRoute()
    extends GoRouteData
    with $LicenseRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const LicensePage();
}

class const AboutThisAppRoute()
    extends GoRouteData
    with $AboutThisAppRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AboutThisAppPage();
}

class const EewDetailsByEventIdRoute({
  required final String eventId,
  final bool useSheet = false,
}) extends GoRouteData with $EewDetailsByEventIdRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EewDetailsByEventIdPage(eventId: eventId, useSheet: useSheet);
  }
}

class const KyoshinMonitorAboutObservationNetworkRoute()
    extends GoRouteData
    with $KyoshinMonitorAboutObservationNetworkRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const KyoshinMonitorAboutObservationNetworkPage();
  }
}

class const KyoshinMonitorDataTypeRoute()
    extends GoRouteData
    with $KyoshinMonitorDataTypeRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const KyoshinMonitorDataTypePage();
  }
}

class const DebugEewCardRoute()
    extends GoRouteData
    with $DebugEewCardRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugEewCardPage();
  }
}

class const DebugEarthquakeHistoryCardRoute()
    extends GoRouteData
    with $DebugEarthquakeHistoryCardRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugEarthquakeHistoryCardPage();
  }
}

class const DebugEarthquakeHistoryListTileRoute()
    extends GoRouteData
    with $DebugEarthquakeHistoryListTileRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugEarthquakeHistoryListTilePage();
  }
}

class const DebugShakeDetectionCardRoute()
    extends GoRouteData
    with $DebugShakeDetectionCardRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugShakeDetectionCardPage();
  }
}

class const DebugShakeDetectionInsertRoute()
    extends GoRouteData
    with $DebugShakeDetectionInsertRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugShakeDetectionInsertPage();
  }
}

class const DebugShakeDetectionEngineRoute()
    extends GoRouteData
    with $DebugShakeDetectionEngineRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugShakeDetectionEnginePage();
  }
}

class const DebugJmaMapRoute()
    extends GoRouteData
    with $DebugJmaMapRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugJmaMapPage();
  }
}

class const DebugKyoshinMonitorRoute()
    extends GoRouteData
    with $DebugKyoshinMonitorRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugKyoshinMonitorPage();
  }
}

class const PlaygroundRoute()
    extends GoRouteData
    with $PlaygroundRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PlaygroundPage();
  }
}

class const DebugWebSocketRoute()
    extends GoRouteData
    with $DebugWebSocketRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugWebSocketPage();
  }
}

class const DebugNotificationDeliveryLogRoute()
    extends GoRouteData
    with $DebugNotificationDeliveryLogRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugNotificationDeliveryLogPage();
  }
}

class const DebugNotificationWebhookRoute()
    extends GoRouteData
    with $DebugNotificationWebhookRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugNotificationWebhookPage();
  }
}

class const DebugDeviceAdminRoute()
    extends GoRouteData
    with $DebugDeviceAdminRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugDeviceAdminPage();
  }
}

class const DebugDeviceSettingsRoute()
    extends GoRouteData
    with $DebugDeviceSettingsRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugDeviceSettingsPage();
  }
}

class const DebugNavigationRoute()
    extends GoRouteData
    with $DebugNavigationRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const NavigationDebugPage();
  }
}

class const DebugAppGroupRoute()
    extends GoRouteData
    with $DebugAppGroupRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugAppGroupPage();
  }
}

class const AssetPackDebugRoute()
    extends GoRouteData
    with $AssetPackDebugRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AssetPackDebugPage();
  }
}

class const DebugSharedPreferencesRoute()
    extends GoRouteData
    with $DebugSharedPreferencesRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugSharedPreferencesPage();
  }
}

class const DebugSecureStorageRoute()
    extends GoRouteData
    with $DebugSecureStorageRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugSecureStoragePage();
  }
}

class const DebugHttpCacheRoute()
    extends GoRouteData
    with $DebugHttpCacheRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugHttpCachePage();
  }
}

class const DebugReplayCreationRoute()
    extends GoRouteData
    with $DebugReplayCreationRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ReplayCreationPage();
  }
}

class const DebugIntensityIconRoute()
    extends GoRouteData
    with $DebugIntensityIconRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const IntensityIconDebugPage();
  }
}

class const DebugTelemetryRoute()
    extends GoRouteData
    with $DebugTelemetryRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugTelemetryPage();
  }
}

class const KyoshinMonitorAboutRoute()
    extends GoRouteData
    with $KyoshinMonitorAboutRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const KyoshinMonitorAboutPage();
  }
}

class const ChangelogRoute()
    extends GoRouteData
    with $ChangelogRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ChangelogPage();
}

@TypedGoRoute<FeedRoute>(path: '/feed')
class const FeedRoute() extends GoRouteData with $FeedRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) => const FeedPage();
}

@TypedGoRoute<FeedDetailsRoute>(path: '/feed/source/:telegramHash')
class const FeedDetailsRoute({required final String telegramHash})
    extends GoRouteData
    with $FeedDetailsRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      FeedDetailsPage(telegramHash: telegramHash);
}

@TypedGoRoute<FeedItemDetailsRoute>(path: '/feed/detail/:id')
class const FeedItemDetailsRoute({
  required final String id,
  final FeedItem? $extra,
}) extends GoRouteData with $FeedItemDetailsRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      FeedItemDetailsPage(id: id, item: $extra);
}

@TypedGoRoute<PaywallRoute>(path: '/subscription/paywall')
class const PaywallRoute()
    extends GoRouteData
    with $PaywallRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const PaywallPage();
}

@TypedGoRoute<SubscriptionSettingsRoute>(path: '/subscription/settings')
class const SubscriptionSettingsRoute()
    extends GoRouteData
    with $SubscriptionSettingsRoute, MaterialPageMixin {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SubscriptionSettingsPage();
}

class _NavigatorObserver(final Talker talker) extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route is PageRoute) {
      final page = route.settings.name;
      talker.logCustom(GoRouterLog('push to $page'));
      if (kIsWeb) {
        return;
      }
      unawaited(FirebaseAnalytics.instance.logScreenView(screenName: page));
    }
  }
}
