import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider/init/talker.dart';
import '../utils/talker_log/go_router_talker_observer.dart';
import 'view/setting/debug/log_view.dart';
import 'view/setting/update_history_view/update_history_view.dart';
import 'view/views.dart';

part 'route.g.dart';

@TypedGoRoute<MainRoute>(
  path: '/',
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<IntroductionRoute>(path: 'introduction'),
    TypedGoRoute<EarthquakeHistoryItemRoute>(
      path: 'earthquakeHistoryItem/:eventId',
    ),
    TypedGoRoute<FullScreenRoute>(path: 'fullScreen'),
    TypedGoRoute<SettingRoute>(
      path: 'settings',
      routes: [
        TypedGoRoute<NotificationSettingRoute>(path: 'notification'),
        TypedGoRoute<DesignSettingRoute>(
          path: 'design',
          routes: [
            TypedGoRoute<ThemeSettingRoute>(path: 'theme'),
            TypedGoRoute<IntensityColorSettingRoute>(path: 'intensity'),
          ],
        ),
        TypedGoRoute<AboutAppRoute>(
          path: 'appinfo',
          routes: [
            TypedGoRoute<TermOfServiceRoute>(
              path: 'termOfService/:showAcceptButton',
            ),
            TypedGoRoute<UpdateHistoryRoute>(path: 'updateHistory'),
          ],
        ),
        TypedGoRoute<DebugMenuRoute>(
          path: 'debug',
          routes: [
            TypedGoRoute<DeveloperDebugRoute>(path: 'info'),
            TypedGoRoute<EewTestRoute>(path: 'eewTest'),
            TypedGoRoute<LogRoute>(path: 'log'),
          ],
        ),
      ],
    ),
  ],
)
@immutable
class MainRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return const MainView();
  }
}

class IntroductionRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const IntroductionView();
}

class EarthquakeHistoryItemRoute extends GoRouteData {
  EarthquakeHistoryItemRoute({
    required this.eventId,
  });
  final int eventId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      EarthquakeHistoryDetailPage(eventId);
}

class FullScreenRoute extends GoRouteData {
  FullScreenRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersive,
      overlays: [],
    );
    return KmoniMap(showAppBar: false);
  }
}

class SettingRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingsPage();
}

class NotificationSettingRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const NotificationSettingPage();
}

class DesignSettingRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DesignSettingsPage();
}

class ThemeSettingRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ThemeChoicePage();
}

class IntensityColorSettingRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const IntensityColorSettingsPage();
}

class AboutAppRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AboutAppPage();
}

class TermOfServiceRoute extends GoRouteData {
  TermOfServiceRoute({
    required this.showAcceptButton,
  });
  final bool showAcceptButton;
  @override
  Widget build(BuildContext context, GoRouterState state) => TermOfServicePage(
        showAcceptButton: showAcceptButton,
      );
}

class UpdateHistoryRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const UpdateHistoryView();
}

class DebugMenuRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DebugMenuPage();
}

class DeveloperDebugRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DeveloperDebugPage();
}

class EewTestRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const EewTestPage();
}

class LogRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) => const LogView();
}

final routerProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    routes: $appRoutes,
    initialLocation: ref.watch(initialRouteProvider),
    errorBuilder: (context, state) => ErrorScreen(state.error!),
    observers: [
      if (kDebugMode) GoRouterTalkerObserver(ref.watch(talkerProvider))
    ],
  ),
);

final initialRouteProvider = Provider<String>((ref) {
  return '/';
});
