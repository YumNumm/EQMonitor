import 'dart:async';

import 'package:eqmonitor/app.dart';
import 'package:eqmonitor/core/component/error/fatal_error_screen.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/feature/beta_testing/data/notifier/beta_testing_notifier.dart';
import 'package:eqmonitor/feature/beta_testing/ui/page/beta_testing_warning_page.dart';
import 'package:eqmonitor/feature/changelog/ui/page/changelog_page.dart';
import 'package:eqmonitor/feature/devices/ui/page/debug_device_settings_page.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/earthquake_history_details_page.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/earthquake_history_page.dart';
import 'package:eqmonitor/feature/eew/ui/page/eew_details_by_event_id_page.dart';
import 'package:eqmonitor/feature/eew_history/ui/eew_history_page.dart';
import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:eqmonitor/feature/feed/ui/page/feed_details_page.dart';
import 'package:eqmonitor/feature/feed/ui/page/feed_item_details_page.dart';
import 'package:eqmonitor/feature/feed/ui/page/feed_page.dart';
import 'package:eqmonitor/feature/home/ui/page/home_map_layer_page.dart';
import 'package:eqmonitor/feature/intensity_history/ui/intensity_history_page.dart';
import 'package:eqmonitor/feature/knet_waveform/data/model/knet_station_result.dart';
import 'package:eqmonitor/feature/knet_waveform/ui/knet_waveform_page.dart';
import 'package:eqmonitor/feature/knet_waveform/ui/media/knet_media_page.dart';
import 'package:eqmonitor/feature/knet_waveform/ui/record/knet_record_list_page.dart';
import 'package:eqmonitor/feature/knet_waveform/ui/record/knet_station_waveform_page.dart';
import 'package:eqmonitor/feature/knet_waveform/ui/settings/knet_credentials_settings_page.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/kyoshin_monitor_about_observation_network_page.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/kyoshin_monitor_about_page.dart';
import 'package:eqmonitor/feature/nied/ui/aqua/aqua_catalog_page.dart';
import 'package:eqmonitor/feature/nied/ui/aqua/aqua_page.dart';
import 'package:eqmonitor/feature/nied/ui/fnet/fnet_catalog_page.dart';
import 'package:eqmonitor/feature/nied/ui/fnet/fnet_page.dart';
import 'package:eqmonitor/feature/nied/ui/nied_page.dart';
import 'package:eqmonitor/feature/onboarding/data/notifier/onboarding_notifier.dart';
import 'package:eqmonitor/feature/onboarding/ui/page/onboarding_page.dart';
import 'package:eqmonitor/feature/onboarding/ui/page/onboarding_web_view_page.dart';
import 'package:eqmonitor/feature/seismicity/ui/seismicity_page.dart';
import 'package:eqmonitor/feature/settings/children/application_info/about_this_app.dart';
import 'package:eqmonitor/feature/settings/children/application_info/license_page.dart';
import 'package:eqmonitor/feature/settings/children/application_info/privacy_policy_page.dart';
import 'package:eqmonitor/feature/settings/children/application_info/term_of_service_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/api_endpoint_selector/http_api_endpoint_selector_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/app_group/debug_app_group_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/debug_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/device/debug_device_admin_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/earthquake_history/debug_earthquake_history_card_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/earthquake_history/debug_earthquake_history_list_tile_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/eew/debug_eew_card_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/hinet_seismicity/ui/hinet_seismicity_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/http_cache/debug_http_cache_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/intensity_icon/intensity_icon_debug_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/jma_map/debug_jma_map_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/kyoshin_monitor/debug_kyoshin_monitor.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/navigation/navigation_debug_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/notification/debug_notification_delivery_log_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/playground/playground_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/shake_detection/debug_shake_detection_card_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/shared_preferences/debug_shared_preferences_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/telemetry/debug_telemetry_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/tsunami/debug_tsunami_details_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/tsunami/tsunami_telegram_timeline_debug_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/websocket/debug_websocket_page.dart';
import 'package:eqmonitor/feature/settings/children/config/earthquake_history/earthquake_history_config_page.dart';
import 'package:eqmonitor/feature/settings/features/display_settings/ui/display_settings.dart';
import 'package:eqmonitor/feature/settings/features/display_settings/ui/theme/theme_editor_page.dart';
import 'package:eqmonitor/feature/settings/features/display_settings/ui/theme/theme_settings_page.dart';
import 'package:eqmonitor/feature/settings/features/home_widget_settings/ui/page/home_widget_settings_page.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/notification_settings_page.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/shake_detection_settings_page.dart';
import 'package:eqmonitor/feature/settings/settings_page.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/ui/shake_detection_history_details_page.dart';
import 'package:eqmonitor/feature/shake_detection/ui/shake_detection_history_page.dart';
import 'package:eqmonitor/feature/subscription/ui/page/paywall_page.dart';
import 'package:eqmonitor/feature/subscription/ui/page/subscription_settings_page.dart';
import 'package:eqmonitor/feature/telegram_list/ui/telegram_list_by_event_id_page.dart';
import 'package:eqmonitor/feature/tsunami/ui/tsunami_details_page.dart';
import 'package:eqmonitor/page/home_page.dart';
import 'package:eqmonitor/page/splash_page.dart';
import 'package:eqmonitor/page/talker/talker_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide LicensePage;
import 'package:go_router/go_router.dart';
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
    if (state.matchedLocation == '/splash') {
      return null;
    }

    final isOnboardingCompleted =
        ref.read(onboardingCompletedProvider).value ?? false;
    if (!isOnboardingCompleted) {
      final allowedDuringOnboarding =
          [
            const OnboardingRoute().location,
            const TermOfServiceRoute($extra: null).location,
            const PrivacyPolicyRoute($extra: null).location,
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

    if (isOnboardingCompleted && ref.read(buildConfigProvider).isBetaTesting) {
      final betaAgreed = ref.read(betaTestingAgreedProvider).value ?? false;
      if (!betaAgreed && state.matchedLocation != '/beta-warning') {
        return '/beta-warning';
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

class GoRouterRedirectException implements Exception {
  GoRouterRedirectException(this.message);

  final String message;
}

@TypedGoRoute<SplashRoute>(path: '/splash')
class SplashRoute extends GoRouteData with $SplashRoute {
  const SplashRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SplashPage();
}

@TypedGoRoute<OnboardingRoute>(path: '/onboarding')
class OnboardingRoute extends GoRouteData with $OnboardingRoute {
  const OnboardingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const OnboardingPage();
}

@TypedGoRoute<OnboardingWebViewRoute>(path: '/onboarding/web-view')
class OnboardingWebViewRoute extends GoRouteData with $OnboardingWebViewRoute {
  const OnboardingWebViewRoute({required this.title, required this.url});

  final String title;
  final String url;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      OnboardingWebViewPage(title: title, url: url);
}

@TypedGoRoute<BetaTestingWarningRoute>(path: '/beta-warning')
class BetaTestingWarningRoute extends GoRouteData
    with $BetaTestingWarningRoute {
  const BetaTestingWarningRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const BetaTestingWarningPage();
}

@TypedGoRoute<EarthquakeHistoryRoute>(path: '/earthquake-history')
class EarthquakeHistoryRoute extends GoRouteData with $EarthquakeHistoryRoute {
  const EarthquakeHistoryRoute({this.$extra});

  final EarthquakeHistoryParameter? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      EarthquakeHistoryPage(initialParameter: $extra);
}

@TypedGoRoute<EewHistoryRoute>(path: '/eew-history')
class EewHistoryRoute extends GoRouteData with $EewHistoryRoute {
  const EewHistoryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const EewHistoryPage();
}

@TypedGoRoute<SeismicityRoute>(path: '/seismicity')
class SeismicityRoute extends GoRouteData with $SeismicityRoute {
  const SeismicityRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SeismicityPage();
}

@TypedGoRoute<IntensityHistoryRoute>(path: '/intensity-history')
class IntensityHistoryRoute extends GoRouteData with $IntensityHistoryRoute {
  const IntensityHistoryRoute({this.prefectureCode, this.cityCode});

  final String? prefectureCode;
  final String? cityCode;

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
class EarthquakeHistoryDetailsRoute extends GoRouteData
    with $EarthquakeHistoryDetailsRoute {
  const EarthquakeHistoryDetailsRoute({required this.eventId});

  final String eventId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EarthquakeHistoryDetailsPage(eventId: eventId);
  }
}

@TypedGoRoute<ShakeDetectionHistoryRoute>(path: '/shake-detection-history')
class ShakeDetectionHistoryRoute extends GoRouteData
    with $ShakeDetectionHistoryRoute {
  const ShakeDetectionHistoryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ShakeDetectionHistoryPage();
}

@TypedGoRoute<ShakeDetectionHistoryDetailsRoute>(
  path: '/shake-detection-history-details/:eventId',
)
class ShakeDetectionHistoryDetailsRoute extends GoRouteData
    with $ShakeDetectionHistoryDetailsRoute {
  const ShakeDetectionHistoryDetailsRoute({
    required this.eventId,
    required this.$extra,
  });

  final String eventId;
  final ShakeDetectionEvent $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ShakeDetectionHistoryDetailsPage(event: $extra);
}

@TypedGoRoute<TelegramListByEventIdRoute>(path: '/telegram-list/:eventId')
class TelegramListByEventIdRoute extends GoRouteData
    with $TelegramListByEventIdRoute {
  const TelegramListByEventIdRoute({required this.eventId});

  final String eventId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TelegramListByEventIdPage(eventId: eventId);
  }
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
class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      const MaterialExtendedPage<void>(child: HomePage());
}

class HomeMapLayerRoute extends GoRouteData with $HomeMapLayerRoute {
  const HomeMapLayerRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const HomeMapLayerPage();
}

@TypedGoRoute<TalkerRoute>(path: '/talker')
class TalkerRoute extends GoRouteData with $TalkerRoute {
  const TalkerRoute();

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
        TypedGoRoute<DebugJmaMapRoute>(path: 'jma-map'),
        TypedGoRoute<PlaygroundRoute>(path: 'playground'),
        TypedGoRoute<DebugWebSocketRoute>(path: 'websocket'),
        TypedGoRoute<DebugNotificationDeliveryLogRoute>(
          path: 'notification-delivery-log',
        ),
        TypedGoRoute<DebugDeviceAdminRoute>(path: 'device-admin'),
        TypedGoRoute<DebugDeviceSettingsRoute>(path: 'device-settings'),
        TypedGoRoute<DebugNavigationRoute>(path: 'navigation'),
        TypedGoRoute<DebugAppGroupRoute>(path: 'app-group'),
        TypedGoRoute<DebugSharedPreferencesRoute>(path: 'shared-preferences'),
        TypedGoRoute<DebugHttpCacheRoute>(path: 'http-cache'),
        TypedGoRoute<DebugIntensityIconRoute>(path: 'intensity-icon'),
        TypedGoRoute<DebugTelemetryRoute>(path: 'telemetry'),
        TypedGoRoute<DebugTsunamiDetailsRoute>(
          path: 'tsunami-details',
          routes: [
            TypedGoRoute<DebugTsunamiTimelineRoute>(
              path: 'timeline/:tsunamiId',
            ),
          ],
        ),
        TypedGoRoute<NiedRoute>(
          path: 'nied',
          routes: [
            TypedGoRoute<AquaRoute>(
              path: 'aqua',
              routes: [TypedGoRoute<AquaCatalogRoute>(path: 'catalog')],
            ),
            TypedGoRoute<FnetRoute>(
              path: 'fnet',
              routes: [TypedGoRoute<FnetCatalogRoute>(path: 'catalog')],
            ),
            TypedGoRoute<KnetWaveformRoute>(
              path: 'knet',
              routes: [
                TypedGoRoute<KnetCredentialsSettingsRoute>(path: 'settings'),
                TypedGoRoute<KnetMediaRoute>(path: 'media'),
                TypedGoRoute<KnetRecordListRoute>(path: 'records'),
                TypedGoRoute<KnetStationWaveformRoute>(path: 'waveform'),
              ],
            ),
            TypedGoRoute<HinetSeismicityRoute>(path: 'hinet-seismicity'),
          ],
        ),
      ],
    ),
  ],
)
class SettingsRoute extends GoRouteData with $SettingsRoute {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingsPage();
}

class DisplayRoute extends GoRouteData with $DisplayRoute {
  const DisplayRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DisplaySettingsPage();
}

class ThemeSettingsRoute extends GoRouteData with $ThemeSettingsRoute {
  const ThemeSettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ThemeSettingsPage();
}

class ThemeEditorRoute extends GoRouteData with $ThemeEditorRoute {
  const ThemeEditorRoute({required this.mode});

  final String mode;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final brightnessMode = ThemeBrightnessMode.values.firstWhere(
      (e) => e.name == mode,
      orElse: () => ThemeBrightnessMode.light,
    );
    return ThemeEditorPage(mode: brightnessMode);
  }
}

class NotificationSettingsRoute extends GoRouteData
    with $NotificationSettingsRoute {
  const NotificationSettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const NotificationSettingsPage();
}

class HomeWidgetSettingsRoute extends GoRouteData
    with $HomeWidgetSettingsRoute {
  const HomeWidgetSettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const HomeWidgetSettingsPage();
}

class ShakeDetectionSettingsRoute extends GoRouteData
    with $ShakeDetectionSettingsRoute {
  const ShakeDetectionSettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ShakeDetectionSettingsPage();
}

class NotificationHistoryRoute extends GoRouteData
    with $NotificationHistoryRoute {
  const NotificationHistoryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DebugNotificationDeliveryLogPage();
}

class DebugRoute extends GoRouteData with $DebugRoute {
  const DebugRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const DebugPage();
}

class HttpApiEndpointSelectorRoute extends GoRouteData
    with $HttpApiEndpointSelectorRoute {
  const HttpApiEndpointSelectorRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const HttpApiEndpointSelectorPage();
}

class EarthquakeHistoryConfigRoute extends GoRouteData
    with $EarthquakeHistoryConfigRoute {
  const EarthquakeHistoryConfigRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const EarthquakeHistoryConfigPage();
}

class TermOfServiceRoute extends GoRouteData with $TermOfServiceRoute {
  const TermOfServiceRoute({
    required this.$extra,
    this.showAcceptButton = false,
  });

  final void Function({bool isAccepted})? $extra;
  final bool showAcceptButton;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      TermOfServicePage(onResult: $extra, showAcceptButton: showAcceptButton);
}

class PrivacyPolicyRoute extends GoRouteData with $PrivacyPolicyRoute {
  const PrivacyPolicyRoute({
    required this.$extra,
    this.showAcceptButton = false,
  });

  final void Function({bool isAccepted})? $extra;
  final bool showAcceptButton;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      PrivacyPolicyPage(onResult: $extra, showAcceptButton: showAcceptButton);
}

class LicenseRoute extends GoRouteData with $LicenseRoute {
  const LicenseRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const LicensePage();
}

class AboutThisAppRoute extends GoRouteData with $AboutThisAppRoute {
  const AboutThisAppRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AboutThisAppScreen();
}

class EewDetailsByEventIdRoute extends GoRouteData
    with $EewDetailsByEventIdRoute {
  const EewDetailsByEventIdRoute({required this.eventId});

  final String eventId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EewDetailsByEventIdPage(eventId: eventId);
  }
}

class KyoshinMonitorAboutObservationNetworkRoute extends GoRouteData
    with $KyoshinMonitorAboutObservationNetworkRoute {
  const KyoshinMonitorAboutObservationNetworkRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const KyoshinMonitorAboutObservationNetworkPage();
  }
}

class DebugEewCardRoute extends GoRouteData with $DebugEewCardRoute {
  const DebugEewCardRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugEewCardPage();
  }
}

class DebugEarthquakeHistoryCardRoute extends GoRouteData
    with $DebugEarthquakeHistoryCardRoute {
  const DebugEarthquakeHistoryCardRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugEarthquakeHistoryCardPage();
  }
}

class DebugEarthquakeHistoryListTileRoute extends GoRouteData
    with $DebugEarthquakeHistoryListTileRoute {
  const DebugEarthquakeHistoryListTileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugEarthquakeHistoryListTilePage();
  }
}

class DebugShakeDetectionCardRoute extends GoRouteData
    with $DebugShakeDetectionCardRoute {
  const DebugShakeDetectionCardRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugShakeDetectionCardPage();
  }
}

class DebugJmaMapRoute extends GoRouteData with $DebugJmaMapRoute {
  const DebugJmaMapRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugJmaMapPage();
  }
}

class DebugKyoshinMonitorRoute extends GoRouteData
    with $DebugKyoshinMonitorRoute {
  const DebugKyoshinMonitorRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugKyoshinMonitorPage();
  }
}

class PlaygroundRoute extends GoRouteData with $PlaygroundRoute {
  const PlaygroundRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PlaygroundPage();
  }
}

class DebugWebSocketRoute extends GoRouteData with $DebugWebSocketRoute {
  const DebugWebSocketRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugWebSocketPage();
  }
}

class DebugNotificationDeliveryLogRoute extends GoRouteData
    with $DebugNotificationDeliveryLogRoute {
  const DebugNotificationDeliveryLogRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugNotificationDeliveryLogPage();
  }
}

class DebugDeviceAdminRoute extends GoRouteData with $DebugDeviceAdminRoute {
  const DebugDeviceAdminRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugDeviceAdminPage();
  }
}

class DebugDeviceSettingsRoute extends GoRouteData
    with $DebugDeviceSettingsRoute {
  const DebugDeviceSettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugDeviceSettingsPage();
  }
}

class DebugNavigationRoute extends GoRouteData with $DebugNavigationRoute {
  const DebugNavigationRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const NavigationDebugPage();
  }
}

class DebugAppGroupRoute extends GoRouteData with $DebugAppGroupRoute {
  const DebugAppGroupRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugAppGroupPage();
  }
}

class DebugSharedPreferencesRoute extends GoRouteData
    with $DebugSharedPreferencesRoute {
  const DebugSharedPreferencesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugSharedPreferencesPage();
  }
}

class DebugHttpCacheRoute extends GoRouteData with $DebugHttpCacheRoute {
  const DebugHttpCacheRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugHttpCachePage();
  }
}

class DebugIntensityIconRoute extends GoRouteData
    with $DebugIntensityIconRoute {
  const DebugIntensityIconRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const IntensityIconDebugPage();
  }
}

class DebugTelemetryRoute extends GoRouteData with $DebugTelemetryRoute {
  const DebugTelemetryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugTelemetryPage();
  }
}

class DebugTsunamiDetailsRoute extends GoRouteData
    with $DebugTsunamiDetailsRoute {
  const DebugTsunamiDetailsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugTsunamiDetailsPage();
  }
}

class DebugTsunamiTimelineRoute extends GoRouteData
    with $DebugTsunamiTimelineRoute {
  const DebugTsunamiTimelineRoute({required this.tsunamiId});

  final String tsunamiId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TsunamiTelegramTimelineDebugPage(tsunamiId: tsunamiId);
  }
}

class NiedRoute extends GoRouteData with $NiedRoute {
  const NiedRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const NiedPage();
  }
}

class AquaRoute extends GoRouteData with $AquaRoute {
  const AquaRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AquaPage();
  }
}

class AquaCatalogRoute extends GoRouteData with $AquaCatalogRoute {
  const AquaCatalogRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AquaCatalogPage();
  }
}

class FnetRoute extends GoRouteData with $FnetRoute {
  const FnetRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const FnetPage();
  }
}

class FnetCatalogRoute extends GoRouteData with $FnetCatalogRoute {
  const FnetCatalogRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const FnetCatalogPage();
  }
}

class KnetWaveformRoute extends GoRouteData with $KnetWaveformRoute {
  const KnetWaveformRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const KnetWaveformPage();
}

class KnetCredentialsSettingsRoute extends GoRouteData
    with $KnetCredentialsSettingsRoute {
  const KnetCredentialsSettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const KnetCredentialsSettingsPage();
}

class KnetMediaRoute extends GoRouteData with $KnetMediaRoute {
  const KnetMediaRoute({required this.$extra});

  /// 地震発生時刻（JST）
  final DateTime $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      KnetMediaPage(eventTime: $extra);
}

class KnetRecordListRoute extends GoRouteData with $KnetRecordListRoute {
  const KnetRecordListRoute({required this.$extra});

  /// 地震発生時刻（JST）
  final DateTime $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      KnetRecordListPage(eventTime: $extra);
}

class KnetStationWaveformRoute extends GoRouteData
    with $KnetStationWaveformRoute {
  const KnetStationWaveformRoute({required this.$extra});

  final KnetStationResult $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      KnetStationWaveformPage(result: $extra);
}

class HinetSeismicityRoute extends GoRouteData with $HinetSeismicityRoute {
  const HinetSeismicityRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HinetSeismicityPage();
  }
}

class KyoshinMonitorAboutRoute extends GoRouteData
    with $KyoshinMonitorAboutRoute {
  const KyoshinMonitorAboutRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const KyoshinMonitorAboutPage();
  }
}

class ChangelogRoute extends GoRouteData with $ChangelogRoute {
  const ChangelogRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ChangelogPage();
}

@TypedGoRoute<FeedRoute>(path: '/feed')
class FeedRoute extends GoRouteData with $FeedRoute {
  const FeedRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const FeedPage();
}

@TypedGoRoute<FeedDetailsRoute>(path: '/feed/source/:telegramHash')
class FeedDetailsRoute extends GoRouteData with $FeedDetailsRoute {
  const FeedDetailsRoute({required this.telegramHash});

  final String telegramHash;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      FeedDetailsPage(telegramHash: telegramHash);
}

@TypedGoRoute<FeedItemDetailsRoute>(path: '/feed/detail/:id')
class FeedItemDetailsRoute extends GoRouteData with $FeedItemDetailsRoute {
  const FeedItemDetailsRoute({required this.id, this.$extra});

  final String id;
  final FeedItem? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      FeedItemDetailsPage(id: id, item: $extra);
}

@TypedGoRoute<TsunamiDetailsRoute>(path: '/tsunami/:tsunamiId')
class TsunamiDetailsRoute extends GoRouteData with $TsunamiDetailsRoute {
  const TsunamiDetailsRoute({required this.tsunamiId});

  final String tsunamiId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TsunamiDetailsPage(tsunamiId: tsunamiId);
  }
}

@TypedGoRoute<PaywallRoute>(path: '/subscription/paywall')
class PaywallRoute extends GoRouteData with $PaywallRoute {
  const PaywallRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const PaywallPage();
}

@TypedGoRoute<SubscriptionSettingsRoute>(path: '/subscription/settings')
class SubscriptionSettingsRoute extends GoRouteData
    with $SubscriptionSettingsRoute {
  const SubscriptionSettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SubscriptionSettingsPage();
}

class _NavigatorObserver extends NavigatorObserver {
  _NavigatorObserver(this.talker);

  final Talker talker;
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
