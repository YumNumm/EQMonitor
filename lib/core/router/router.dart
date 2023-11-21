import 'package:eqmonitor/app.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:eqmonitor/feature/settings/children/config/color_scheme/color_scheme_config_page.dart';
import 'package:eqmonitor/feature/earthquake_history/page/earthquake_history.dart';
import 'package:eqmonitor/feature/earthquake_history_details/screen/earthquake_history_details.dart';
import 'package:eqmonitor/feature/eew_detailed_history/eew_detailed_history_screen.dart';
import 'package:eqmonitor/feature/home/features/kmoni/page/kmoni_settings_page.dart';
import 'package:eqmonitor/feature/home/view/home_view.dart';
import 'package:eqmonitor/feature/settings/children/privacy_policy_screen.dart';
import 'package:eqmonitor/feature/settings/children/term_of_service_screen.dart';
import 'package:eqmonitor/feature/settings/settings_screen.dart';
import 'package:eqmonitor/feature/setup/screen/setup_screen.dart';
import 'package:eqmonitor/feature/talker/talker_page.dart';
import 'package:eqmonitor/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
    );

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
      const EarthquakeHistoryPage();
}

@TypedGoRoute<EarthquakeHistoryDetailsRoute>(
  path: '/earthquake-history/:eventId',
)
class EarthquakeHistoryDetailsRoute extends GoRouteData {
  const EarthquakeHistoryDetailsRoute(this.eventId);
  final int eventId;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EarthquakeHistoryDetailsPage(
      eventId: eventId,
    );
  }
}

@TypedGoRoute<EewDetailedHistoryRoute>(
  path: '/eew-detailed-history/:eventId',
)
class EewDetailedHistoryRoute extends GoRouteData {
  const EewDetailedHistoryRoute(this.eventId);
  final int eventId;
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      EewDetailedHistoryScreen(
        eventId: eventId,
      );
}

@TypedGoRoute<ColorSchemeConfigRoute>(path: '/config')
class ColorSchemeConfigRoute extends GoRouteData {
  const ColorSchemeConfigRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ColorSchemeConfigPage();
}

@TypedGoRoute<HomeRoute>(path: '/')
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
    TypedGoRoute<TermOfServiceRoute>(
      path: 'term-of-service',
    ),
    TypedGoRoute<PrivacyPolicyRoute>(
      path: 'privacy-policy',
    ),
    TypedGoRoute<LicenseRoute>(
      path: 'license',
    ),
  ],
)
class SettingsRoute extends GoRouteData {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingsScreen();
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
  Widget build(BuildContext context, GoRouterState state) => LicensePage(
        applicationName: 'EQMonitor',
        applicationLegalese:
            '${DateTime.now().year} © Ryotaro Onoue All Rights Reserved.',
        applicationIcon: Padding(
          padding: const EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Assets.images.icon.image(
              height: 80,
            ),
          ),
        ),
      );
}
