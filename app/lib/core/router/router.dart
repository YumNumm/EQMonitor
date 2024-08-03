import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/app.dart';
import 'package:eqmonitor/core/provider/debugger/debugger_provider.dart';
import 'package:eqmonitor/core/provider/kmoni/page/kmoni_settings_page.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:eqmonitor/feature/debug/earthquake_parameter/ui/earthquake_parameter_list_screen.dart';
import 'package:eqmonitor/feature/donation/ui/donation_executed_screen.dart';
import 'package:eqmonitor/feature/donation/ui/donation_screen.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/earthquake_history_screen.dart';
import 'package:eqmonitor/feature/earthquake_history_details/screen/earthquake_history_details.dart';
import 'package:eqmonitor/feature/earthquake_history_early/ui/earthquake_history_early_details_screen.dart';
import 'package:eqmonitor/feature/earthquake_history_early/ui/earthquake_history_early_screen.dart';
import 'package:eqmonitor/feature/home/view/home_view.dart';
import 'package:eqmonitor/feature/information_history/page/information_history_page.dart';
import 'package:eqmonitor/feature/information_history_details/information_history_details_page.dart';
import 'package:eqmonitor/feature/settings/children/application_info/about_this_app.dart';
import 'package:eqmonitor/feature/settings/children/application_info/license_page.dart';
import 'package:eqmonitor/feature/settings/children/application_info/privacy_policy_screen.dart';
import 'package:eqmonitor/feature/settings/children/application_info/term_of_service_screen.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/api_endpoint_selector/http_api_endpoint_selector_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/api_endpoint_selector/websocket_api_endpoint_selector_page.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/debugger_page.dart';
import 'package:eqmonitor/feature/settings/children/config/earthquake_history/earthquake_history_config_page.dart';
import 'package:eqmonitor/feature/settings/features/display_settings/color_scheme/color_scheme_config_page.dart';
import 'package:eqmonitor/feature/settings/features/display_settings/ui/display_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/ui/notification_remote_settings_page.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/ui/pages/notification_remote_settings_earthquake_page.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/ui/pages/notification_remote_settings_eew_page.dart';
import 'package:eqmonitor/feature/settings/settings_screen.dart';
import 'package:eqmonitor/feature/setup/screen/setup_screen.dart';
import 'package:eqmonitor/feature/talker/talker_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide LicensePage;
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'router.g.dart';

final isInitializedStateProvider = StateProvider<bool>((ref) => false);

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) => GoRouter(
      routes: $appRoutes,
      navigatorKey: App.navigatorKey,
      initialLocation:
          (ref.read(sharedPreferencesProvider).getBool('isInitialized') ??
                  false)
              ? const HomeRoute().location
              : const SetupRoute().location,
      observers: [
        _NavigatorObserver(
          ref.watch(talkerProvider),
        ),
        FirebaseAnalyticsObserver(
          analytics: FirebaseAnalytics.instance,
        ),
      ],
      debugLogDiagnostics: true,
      redirect: (context, state) {
        final isDebugger = ref.read(debuggerProvider).isDebugger;
        if ((state.fullPath?.contains('debug') ?? false) && !isDebugger) {
          throw GoRouterRedirectException(
            'Debugger is not enabled in production mode.',
          );
        }
        return null;
      },
    );

class GoRouterRedirectException implements Exception {
  GoRouterRedirectException(this.message);

  final String message;
}

@TypedGoRoute<SetupRoute>(
  path: '/setup',
)
class SetupRoute extends GoRouteData {
  const SetupRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SetupScreen();
}

@TypedGoRoute<EarthquakeHistoryRoute>(path: '/earthquake-history')
class EarthquakeHistoryRoute extends GoRouteData {
  const EarthquakeHistoryRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const EarthquakeHistoryScreen();
}

@TypedGoRoute<EarthquakeHistoryDetailsRoute>(
  path: '/earthquake-history-details/:eventId',
)
class EarthquakeHistoryDetailsRoute extends GoRouteData {
  const EarthquakeHistoryDetailsRoute({
    required this.eventId,
  });

  final int eventId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EarthquakeHistoryDetailsPage(
      eventId: eventId,
    );
  }
}

@TypedGoRoute<InformationHistoryRoute>(path: '/information-history')
class InformationHistoryRoute extends GoRouteData {
  const InformationHistoryRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const InformationHistoryPage();
}

@TypedGoRoute<InformationHistoryDetailsRoute>(
  path: '/information-history-details',
)
class InformationHistoryDetailsRoute extends GoRouteData {
  const InformationHistoryDetailsRoute({
    required this.$extra,
  });
  final InformationV3 $extra;
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      InformationHistoryDetailsPage(
        data: $extra,
      );
}

@TypedGoRoute<HomeRoute>(
  path: '/',
  routes: [
    TypedGoRoute<EarthquakeHistoryEarlyRoute>(
      path: 'earthquake-history-early',
      routes: [
        TypedGoRoute<EarthquakeHistoryEarlyDetailsRoute>(
          path: 'details/:id',
        ),
      ],
    ),
  ],
)
class HomeRoute extends GoRouteData {
  const HomeRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeView();
}

@TypedGoRoute<TalkerRoute>(path: '/talker')
class TalkerRoute extends GoRouteData {
  const TalkerRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const TalkerPage();
}

@TypedGoRoute<KmoniRoute>(path: '/kmoni_config')
class KmoniRoute extends GoRouteData {
  const KmoniRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const KmoniSettingsPage();
}

@TypedGoRoute<SettingsRoute>(
  path: '/settings',
  routes: [
    TypedGoRoute<NotificationRoute>(
      path: 'notification',
      routes: [
        TypedGoRoute<NotificationEarthquakeRoute>(
          path: 'earthquake',
        ),
        TypedGoRoute<NotificationEewRoute>(
          path: 'eew',
        ),
      ],
    ),
    TypedGoRoute<DisplayRoute>(
      path: 'display',
      routes: [
        TypedGoRoute<ColorSchemeConfigRoute>(
          path: 'color-schema',
        ),
      ],
    ),
    TypedGoRoute<TermOfServiceRoute>(
      path: 'term-of-service',
    ),
    TypedGoRoute<PrivacyPolicyRoute>(
      path: 'privacy-policy',
    ),
    TypedGoRoute<LicenseRoute>(
      path: 'license',
    ),
    TypedGoRoute<EarthquakeHistoryConfigRoute>(
      path: 'earthquake-history',
    ),
    TypedGoRoute<AboutThisAppRoute>(
      path: 'about-this-app',
    ),
    TypedGoRoute<DonationRoute>(
      path: 'donation',
      routes: [
        TypedGoRoute<DonationExecutedRoute>(
          path: 'executed',
        ),
      ],
    ),
    TypedGoRoute<DebuggerRoute>(
      path: 'debugger',
      routes: [
        TypedGoRoute<HttpApiEndpointSelectorRoute>(
          path: 'api-endpoint-selector',
        ),
        TypedGoRoute<WebsocketEndpointSelectorRoute>(
          path: 'websocket-api-endpoint-selector',
        ),
        TypedGoRoute<EarthquakeParameterListRoute>(
          path: 'earthquake-parameter-list',
        ),
      ],
    ),
  ],
)
class SettingsRoute extends GoRouteData {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingsScreen();
}

class NotificationRoute extends GoRouteData {
  const NotificationRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const NotificationRemoteSettingsPage();
}

class DisplayRoute extends GoRouteData {
  const DisplayRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DisplaySettingsScreen();
}

class NotificationEarthquakeRoute extends GoRouteData {
  const NotificationEarthquakeRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const NotificationRemoteSettingsEarthquakePage();
}

class NotificationEewRoute extends GoRouteData {
  const NotificationEewRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const NotificationRemoteSettingsEewPage();
}

class DebuggerRoute extends GoRouteData {
  const DebuggerRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DebuggerPage();
}

class HttpApiEndpointSelectorRoute extends GoRouteData {
  const HttpApiEndpointSelectorRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const HttpApiEndpointSelectorPage();
}

class WebsocketEndpointSelectorRoute extends GoRouteData {
  const WebsocketEndpointSelectorRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const WebSocketApiEndpointSelectorPage();
}

class EarthquakeHistoryConfigRoute extends GoRouteData {
  const EarthquakeHistoryConfigRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const EarthquakeHistoryConfigPage();
}

class TermOfServiceRoute extends GoRouteData {
  const TermOfServiceRoute({
    required this.$extra,
    this.showAcceptButton = false,
  });
  final void Function({bool isAccepted})? $extra;
  final bool showAcceptButton;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      TermOfServiceScreen(
        onResult: $extra,
        showAcceptButton: showAcceptButton,
      );
}

class ColorSchemeConfigRoute extends GoRouteData {
  const ColorSchemeConfigRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ColorSchemeConfigPage();
}

class PrivacyPolicyRoute extends GoRouteData {
  const PrivacyPolicyRoute({
    required this.$extra,
    this.showAcceptButton = false,
  });
  final void Function({bool isAccepted})? $extra;
  final bool showAcceptButton;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      PrivacyPolicyScreen(
        onResult: $extra,
        showAcceptButton: showAcceptButton,
      );
}

class LicenseRoute extends GoRouteData {
  const LicenseRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const LicensePage();
}

class AboutThisAppRoute extends GoRouteData {
  const AboutThisAppRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AboutThisAppScreen();
}

class EarthquakeParameterListRoute extends GoRouteData {
  const EarthquakeParameterListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const EarthquakeParameterListScreen();
}

class DonationRoute extends GoRouteData {
  const DonationRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      CustomTransitionPage(
        child: const DonationScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
}

class DonationExecutedRoute extends GoRouteData {
  const DonationExecutedRoute({
    required this.$extra,
  });
  final (
    StoreProduct,
    CustomerInfo,
  ) $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      DonationExecutedScreen(result: $extra);
}

class _NavigatorObserver extends NavigatorObserver {
  _NavigatorObserver(this.talker);

  final Talker talker;
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route is PageRoute) {
      final page = route.settings.name;
      talker.logTyped(GoRouterLog('push to $page'));
      if (kIsWeb) {
        return;
      }
      FirebaseAnalytics.instance.logScreenView(
        screenName: page,
      );
    }
  }
}
