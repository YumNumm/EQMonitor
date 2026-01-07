import 'dart:async';

import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/app.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/earthquake_history_details_page.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/earthquake_history_page.dart';
import 'package:eqmonitor/feature/earthquake_replay/ui/earthquake_replay_page.dart';
import 'package:eqmonitor/feature/earthquake_search/data/model/earthquake_search_parameter.dart';
import 'package:eqmonitor/feature/earthquake_search/ui/earthquake_search_result_page.dart';
import 'package:eqmonitor/feature/earthquake_search/ui/earthquake_search_selection_page.dart';
import 'package:eqmonitor/feature/eew/ui/screen/eew_details_by_event_id_page.dart';
import 'package:eqmonitor/feature/information_history/page/information_history_page.dart';
import 'package:eqmonitor/feature/information_history_details/information_history_details_page.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/kyoshin_monitor_about_observation_network_page.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/kyoshin_monitor_about_page.dart';
import 'package:eqmonitor/feature/nied/ui/aqua/aqua_catalog_page.dart';
import 'package:eqmonitor/feature/nied/ui/aqua/aqua_page.dart';
import 'package:eqmonitor/feature/nied/ui/fnet/fnet_catalog_page.dart';
import 'package:eqmonitor/feature/nied/ui/fnet/fnet_page.dart';
import 'package:eqmonitor/feature/nied/ui/nied_page.dart';
import 'package:eqmonitor/feature/settings/children/application_info/about_this_app.dart';
import 'package:eqmonitor/feature/settings/children/application_info/license_page.dart';
import 'package:eqmonitor/feature/settings/children/application_info/privacy_policy_screen.dart';
import 'package:eqmonitor/feature/settings/children/application_info/term_of_service_screen.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/api_endpoint_selector/http_api_endpoint_selector_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/api_endpoint_selector/websocket_api_endpoint_selector_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/debug_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/device_api/debug_device_api_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/jma_map/debug_jma_map_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/kyoshin_monitor/debug_kyoshin_monitor.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/playground/playground_page.dart';
import 'package:eqmonitor/feature/settings/children/config/earthquake_history/earthquake_history_config_page.dart';
import 'package:eqmonitor/feature/settings/features/display_settings/color_scheme/color_scheme_config_page.dart';
import 'package:eqmonitor/feature/settings/features/display_settings/ui/display_settings.dart';
import 'package:eqmonitor/feature/settings/settings_screen.dart';
import 'package:eqmonitor/feature/telegram_list/ui/telegram_list_by_event_id_page.dart';
import 'package:eqmonitor/page/home_page.dart';
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

@TypedGoRoute<EarthquakeHistoryRoute>(path: '/earthquake-history')
class EarthquakeHistoryRoute extends GoRouteData with $EarthquakeHistoryRoute {
  const EarthquakeHistoryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const EarthquakeHistoryPage();
}

@TypedGoRoute<EarthquakeSearchSelectionRoute>(path: '/earthquake-search')
class EarthquakeSearchSelectionRoute extends GoRouteData
    with $EarthquakeSearchSelectionRoute {
  const EarthquakeSearchSelectionRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const EarthquakeSearchSelectionPage();
}

@TypedGoRoute<EarthquakeSearchResultRoute>(
  path: '/earthquake-search/:type/:code',
)
class EarthquakeSearchResultRoute extends GoRouteData
    with $EarthquakeSearchResultRoute {
  const EarthquakeSearchResultRoute({
    required this.type,
    required this.code,
    this.name,
  });

  final String type;
  final String code;
  final String? name;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final searchType = EarthquakeSearchType.values.firstWhere(
      (e) => e.name == type,
      orElse: () => EarthquakeSearchType.region,
    );
    return EarthquakeSearchResultPage(
      type: searchType,
      code: code,
      name: name ?? code,
    );
  }
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

@TypedGoRoute<TelegramListByEventIdRoute>(
  path: '/telegram-list/:eventId',
)
class TelegramListByEventIdRoute extends GoRouteData
    with $TelegramListByEventIdRoute {
  const TelegramListByEventIdRoute({required this.eventId});

  final String eventId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TelegramListByEventIdPage(eventId: eventId);
  }
}

@TypedGoRoute<InformationHistoryRoute>(path: '/information-history')
class InformationHistoryRoute extends GoRouteData
    with $InformationHistoryRoute {
  const InformationHistoryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const InformationHistoryPage();
}

@TypedGoRoute<InformationHistoryDetailsRoute>(
  path: '/information-history-details',
)
class InformationHistoryDetailsRoute extends GoRouteData
    with $InformationHistoryDetailsRoute {
  const InformationHistoryDetailsRoute({required this.$extra});

  final InformationV3 $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      InformationHistoryDetailsPage(data: $extra);
}

@TypedGoRoute<HomeRoute>(
  path: '/',
  routes: [
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
        TypedGoRoute<EarthquakeReplayRoute>(path: 'earthquake-replay'),
        TypedGoRoute<DebugDeviceApiRoute>(path: 'device-api'),
        TypedGoRoute<NiedRoute>(
          path: 'nied',
          routes: [
            TypedGoRoute<AquaRoute>(
              path: 'aqua',
              routes: [
                TypedGoRoute<AquaCatalogRoute>(path: 'catalog'),
              ],
            ),
            TypedGoRoute<FnetRoute>(
              path: 'fnet',
              routes: [
                TypedGoRoute<FnetCatalogRoute>(path: 'catalog'),
              ],
            ),
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
      const SettingsScreen();
}

class DisplayRoute extends GoRouteData with $DisplayRoute {
  const DisplayRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DisplaySettingsScreen();
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

class WebsocketEndpointSelectorRoute extends GoRouteData
    with $WebsocketEndpointSelectorRoute {
  const WebsocketEndpointSelectorRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const WebSocketApiEndpointSelectorPage();
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
      TermOfServiceScreen(onResult: $extra, showAcceptButton: showAcceptButton);
}

class ColorSchemeConfigRoute extends GoRouteData with $ColorSchemeConfigRoute {
  const ColorSchemeConfigRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ColorSchemeConfigPage();
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
      PrivacyPolicyScreen(onResult: $extra, showAcceptButton: showAcceptButton);
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

class DebugJmaMapRoute extends GoRouteData with $DebugJmaMapRoute {
  const DebugJmaMapRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugJmaMapPage();
  }
}

class DebugDeviceApiRoute extends GoRouteData with $DebugDeviceApiRoute {
  const DebugDeviceApiRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DebugDeviceApiPage();
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

class EarthquakeReplayRoute extends GoRouteData with $EarthquakeReplayRoute {
  const EarthquakeReplayRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const EarthquakeReplayPage();
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

class KyoshinMonitorAboutRoute extends GoRouteData
    with $KyoshinMonitorAboutRoute {
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
