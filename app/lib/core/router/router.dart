import 'dart:async';

import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/app.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/donation/ui/donation_executed_screen.dart';
import 'package:eqmonitor/feature/donation/ui/donation_screen.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/earthquake_history_details_page.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/earthquake_history_page.dart';
import 'package:eqmonitor/feature/earthquake_history_early/ui/earthquake_history_early_details_screen.dart';
import 'package:eqmonitor/feature/earthquake_history_early/ui/earthquake_history_early_screen.dart';
import 'package:eqmonitor/feature/eew/ui/screen/eew_details_by_event_id_page.dart';
import 'package:eqmonitor/feature/information_history/page/information_history_page.dart';
import 'package:eqmonitor/feature/information_history_details/information_history_details_page.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/kyoshin_monitor_about_observation_network_page.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/kyoshin_monitor_about_page.dart';
import 'package:eqmonitor/feature/settings/children/application_info/about_this_app.dart';
import 'package:eqmonitor/feature/settings/children/application_info/license_page.dart';
import 'package:eqmonitor/feature/settings/children/application_info/privacy_policy_screen.dart';
import 'package:eqmonitor/feature/settings/children/application_info/term_of_service_screen.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/api_endpoint_selector/http_api_endpoint_selector_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/api_endpoint_selector/websocket_api_endpoint_selector_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/debug_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/jma_map/debug_jma_map_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/kyoshin_monitor/debug_kyoshin_monitor.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/playground/playground_page.dart';
import 'package:eqmonitor/feature/settings/children/config/earthquake_history/earthquake_history_config_page.dart';
import 'package:eqmonitor/feature/settings/features/display_settings/color_scheme/color_scheme_config_page.dart';
import 'package:eqmonitor/feature/settings/features/display_settings/ui/display_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/ui/notification_remote_settings_page.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/ui/pages/notification_remote_settings_earthquake_page.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/ui/pages/notification_remote_settings_eew_page.dart';
import 'package:eqmonitor/feature/settings/settings_screen.dart';
import 'package:eqmonitor/feature/setup/screen/setup_screen.dart';
import 'package:eqmonitor/feature/tsunami_history/data/models/tsunami_models.dart';
import 'package:eqmonitor/feature/tsunami_history/page/tsunami_details_page.dart';
import 'package:eqmonitor/feature/tsunami_history/page/tsunami_history_page.dart';
import 'package:eqmonitor/page/home_page.dart';
import 'package:eqmonitor/page/talker/talker_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide LicensePage;
import 'package:go_router/go_router.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheet/route.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'router.g.dart';

@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) => GoRouter(
  routes: $appRoutes,
  navigatorKey: App.navigatorKey,
  initialLocation: const HomeRoute().location,
  observers: [
    _NavigatorObserver(talker),
    FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
  ],
  debugLogDiagnostics: kDebugMode,
);

class GoRouterRedirectException implements Exception {
  GoRouterRedirectException(this.message);

  final String message;
}

@TypedGoRoute<SetupRoute>(path: '/setup')
class SetupRoute extends GoRouteData with _$SetupRoute {
  const SetupRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SetupScreen();
}

@TypedGoRoute<EarthquakeHistoryRoute>(path: '/earthquake-history')
class EarthquakeHistoryRoute extends GoRouteData with _$EarthquakeHistoryRoute {
  const EarthquakeHistoryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const EarthquakeHistoryPage();
}

@TypedGoRoute<EarthquakeHistoryDetailsRoute>(
  path: '/earthquake-history-details/:eventId',
)
class EarthquakeHistoryDetailsRoute extends GoRouteData
    with _$EarthquakeHistoryDetailsRoute {
  const EarthquakeHistoryDetailsRoute({required this.eventId});

  final int eventId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EarthquakeHistoryDetailsPage(eventId: eventId);
  }
}

@TypedGoRoute<InformationHistoryRoute>(path: '/information-history')
class InformationHistoryRoute extends GoRouteData
    with _$InformationHistoryRoute {
  const InformationHistoryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const InformationHistoryPage();
}

@TypedGoRoute<InformationHistoryDetailsRoute>(
  path: '/information-history-details',
)
class InformationHistoryDetailsRoute extends GoRouteData
    with _$InformationHistoryDetailsRoute {
  const InformationHistoryDetailsRoute({required this.$extra});

  final InformationV3 $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      InformationHistoryDetailsPage(data: $extra);
}

@TypedGoRoute<TsunamiHistoryRoute>(path: '/tsunami-history')
class TsunamiHistoryRoute extends GoRouteData with _$TsunamiHistoryRoute {
  const TsunamiHistoryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const TsunamiHistoryPage();
}

@TypedGoRoute<TsunamiDetailsRoute>(
  path: '/tsunami-details',
)
class TsunamiDetailsRoute extends GoRouteData with _$TsunamiDetailsRoute {
  const TsunamiDetailsRoute({required this.$extra});

  final TsunamiEvent $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      TsunamiDetailsPage(event: $extra);
}

@TypedGoRoute<HomeRoute>(
  path: '/',
  routes: [
    TypedGoRoute<EarthquakeHistoryEarlyRoute>(
      path: 'earthquake-history-early',
      routes: [
        TypedGoRoute<EarthquakeHistoryEarlyDetailsRoute>(path: 'details/:id'),
      ],
    ),
    TypedGoRoute<EewDetailsByEventIdRoute>(
      path: 'eew-details-by-event-id/:eventId',
    ),
  ],
)
class HomeRoute extends GoRouteData with _$HomeRoute {
  const HomeRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      const MaterialExtendedPage<void>(child: HomePage());
}

@TypedGoRoute<TalkerRoute>(path: '/talker')
class TalkerRoute extends GoRouteData with _$TalkerRoute {
  const TalkerRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const TalkerPage();
}

@TypedGoRoute<SettingsRoute>(
  path: '/settings',
  routes: [
    TypedGoRoute<NotificationRoute>(
      path: 'notification',
      routes: [
        TypedGoRoute<NotificationEarthquakeRoute>(path: 'earthquake'),
        TypedGoRoute<NotificationEewRoute>(path: 'eew'),
      ],
    ),
    TypedGoRoute<DisplayRoute>(
      path: 'display',
      routes: [TypedGoRoute<ColorSchemeConfigRoute>(path: 'color-schema')],
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
    TypedGoRoute<EarthquakeHistoryConfigRoute>(path: 'earthquake-history'),
    TypedGoRoute<AboutThisAppRoute>(path: 'about-this-app'),
    TypedGoRoute<DonationRoute>(
      path: 'donation',
      routes: [TypedGoRoute<DonationExecutedRoute>(path: 'executed')],
    ),
    TypedGoRoute<DebugRoute>(
      path: 'debug',
      routes: [
        TypedGoRoute<HttpApiEndpointSelectorRoute>(
          path: 'api-endpoint-selector',
        ),
        TypedGoRoute<WebsocketEndpointSelectorRoute>(
          path: 'websocket-api-endpoint-selector',
        ),
        TypedGoRoute<DebugKyoshinMonitorRoute>(path: 'kyoshin-monitor'),
        TypedGoRoute<DebugJmaMapRoute>(path: 'jma-map'),
        TypedGoRoute<PlaygroundRoute>(path: 'playground'),
      ],
    ),
  ],
)
class SettingsRoute extends GoRouteData with _$SettingsRoute {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingsScreen();
}

class NotificationRoute extends GoRouteData with _$NotificationRoute {
  const NotificationRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const NotificationRemoteSettingsPage();
}

class DisplayRoute extends GoRouteData with _$DisplayRoute {
  const DisplayRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DisplaySettingsScreen();
}

class NotificationEarthquakeRoute extends GoRouteData
    with _$NotificationEarthquakeRoute {
  const NotificationEarthquakeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const NotificationRemoteSettingsEarthquakePage();
}

class NotificationEewRoute extends GoRouteData with _$NotificationEewRoute {
  const NotificationEewRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const NotificationRemoteSettingsEewPage();
}

class DebugRoute extends GoRouteData with _$DebugRoute {
  const DebugRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const DebugPage();
}

class HttpApiEndpointSelectorRoute extends GoRouteData
    with _$HttpApiEndpointSelectorRoute {
  const HttpApiEndpointSelectorRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const HttpApiEndpointSelectorPage();
}

class WebsocketEndpointSelectorRoute extends GoRouteData
    with _$WebsocketEndpointSelectorRoute {
  const WebsocketEndpointSelectorRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const WebSocketApiEndpointSelectorPage();
}

class EarthquakeHistoryConfigRoute extends GoRouteData
    with _$EarthquakeHistoryConfigRoute {
  const EarthquakeHistoryConfigRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const EarthquakeHistoryConfigPage();
}

class TermOfServiceRoute extends GoRouteData with _$TermOfServiceRoute {
  const TermOfServiceRoute({
    required this.$extra,
    this.showAcceptButton = false,
  });

  final void Function({bool isAccepted})? $extra;
  final bool showAcceptButton;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      TermOfServiceScreen(onResult: $extra, showAcceptButton: showAcceptButton);
}

class ColorSchemeConfigRoute extends GoRouteData with _$ColorSchemeConfigRoute {
  const ColorSchemeConfigRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ColorSchemeConfigPage();
}

class PrivacyPolicyRoute extends GoRouteData with _$PrivacyPolicyRoute {
  const PrivacyPolicyRoute({
    required this.$extra,
    this.showAcceptButton = false,
  });

  final void Function({bool isAccepted})? $extra;
  final bool showAcceptButton;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      PrivacyPolicyScreen(onResult: $extra, showAcceptButton: showAcceptButton);
}

class LicenseRoute extends GoRouteData with _$LicenseRoute {
  const LicenseRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const LicensePage();
}

class AboutThisAppRoute extends GoRouteData with _$AboutThisAppRoute {
  const AboutThisAppRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AboutThisAppScreen();
}

class DonationRoute extends GoRouteData with _$DonationRoute {
  const DonationRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      CustomTransitionPage(
        child: const DonationScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      );
}

typedef DonationExecutedRouteExtra = (StoreProduct, CustomerInfo);

class DonationExecutedRoute extends GoRouteData with _$DonationExecutedRoute {
  const DonationExecutedRoute({required this.$extra});

  final DonationExecutedRouteExtra $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      DonationExecutedScreen(result: $extra);
}

class EarthquakeHistoryEarlyDetailsRoute extends GoRouteData
    with _$EarthquakeHistoryEarlyDetailsRoute {
  const EarthquakeHistoryEarlyDetailsRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EarthquakeHistoryEarlyDetailsScreen(id: id);
  }
}

class EewDetailsByEventIdRoute extends GoRouteData
    with _$EewDetailsByEventIdRoute {
  const EewDetailsByEventIdRoute({required this.eventId});

  final String eventId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EewDetailsByEventIdPage(eventId: eventId);
  }
}

class EarthquakeHistoryEarlyRoute extends GoRouteData
    with _$EarthquakeHistoryEarlyRoute {
  const EarthquakeHistoryEarlyRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const EarthquakeHistoryEarlyScreen();
  }
}

class KyoshinMonitorAboutObservationNetworkRoute extends GoRouteData
    with _$KyoshinMonitorAboutObservationNetworkRoute {
  const KyoshinMonitorAboutObservationNetworkRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const KyoshinMonitorAboutObservationNetworkPage();
  }
}

class DebugJmaMapRoute extends GoRouteData with _$DebugJmaMapRoute {
  const DebugJmaMapRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugJmaMapPage();
  }
}

class DebugKyoshinMonitorRoute extends GoRouteData
    with _$DebugKyoshinMonitorRoute {
  const DebugKyoshinMonitorRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugKyoshinMonitorPage();
  }
}

class PlaygroundRoute extends GoRouteData with _$PlaygroundRoute {
  const PlaygroundRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PlaygroundPage();
  }
}

class KyoshinMonitorAboutRoute extends GoRouteData
    with _$KyoshinMonitorAboutRoute {
  const KyoshinMonitorAboutRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const KyoshinMonitorAboutPage();
  }
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
