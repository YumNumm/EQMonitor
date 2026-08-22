// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $splashRoute,
  $onboardingRoute,
  $onboardingWebViewRoute,
  $betaTestingWarningRoute,
  $earthquakeHistoryRoute,
  $eewHistoryRoute,
  $seismicityRoute,
  $intensityHistoryRoute,
  $earthquakeHistoryDetailsRoute,
  $earthquakeActivityRoute,
  $liveMonitorRoute,
  $telegramListByEventIdRoute,
  $homeRoute,
  $talkerRoute,
  $settingsRoute,
  $feedRoute,
  $feedDetailsRoute,
  $feedItemDetailsRoute,
  $tsunamiDetailsRoute,
  $paywallRoute,
  $subscriptionSettingsRoute,
];

RouteBase get $splashRoute => GoRouteData.$route(
  path: '/splash',
  hasOverriddenOnExit: false,
  factory: $SplashRoute._fromState,
);

mixin $SplashRoute on GoRouteData {
  static SplashRoute _fromState(GoRouterState state) => const SplashRoute();

  @override
  String get location => GoRouteData.$location('/splash');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $onboardingRoute => GoRouteData.$route(
  path: '/onboarding',
  hasOverriddenOnExit: false,
  factory: $OnboardingRoute._fromState,
);

mixin $OnboardingRoute on GoRouteData {
  static OnboardingRoute _fromState(GoRouterState state) =>
      const OnboardingRoute();

  @override
  String get location => GoRouteData.$location('/onboarding');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $onboardingWebViewRoute => GoRouteData.$route(
  path: '/onboarding/web-view',
  hasOverriddenOnExit: false,
  factory: $OnboardingWebViewRoute._fromState,
);

mixin $OnboardingWebViewRoute on GoRouteData {
  static OnboardingWebViewRoute _fromState(GoRouterState state) =>
      OnboardingWebViewRoute(
        title: state.uri.queryParameters['title']!,
        url: state.uri.queryParameters['url']!,
      );

  OnboardingWebViewRoute get _self => this as OnboardingWebViewRoute;

  @override
  String get location => GoRouteData.$location(
    '/onboarding/web-view',
    queryParams: {'title': _self.title, 'url': _self.url},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $betaTestingWarningRoute => GoRouteData.$route(
  path: '/beta-warning',
  hasOverriddenOnExit: false,
  factory: $BetaTestingWarningRoute._fromState,
);

mixin $BetaTestingWarningRoute on GoRouteData {
  static BetaTestingWarningRoute _fromState(GoRouterState state) =>
      const BetaTestingWarningRoute();

  @override
  String get location => GoRouteData.$location('/beta-warning');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $earthquakeHistoryRoute => GoRouteData.$route(
  path: '/earthquake-history',
  hasOverriddenOnExit: false,
  factory: $EarthquakeHistoryRoute._fromState,
);

mixin $EarthquakeHistoryRoute on GoRouteData {
  static EarthquakeHistoryRoute _fromState(GoRouterState state) =>
      EarthquakeHistoryRoute(
        $extra: state.extra as EarthquakeHistoryParameter?,
      );

  EarthquakeHistoryRoute get _self => this as EarthquakeHistoryRoute;

  @override
  String get location => GoRouteData.$location('/earthquake-history');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $eewHistoryRoute => GoRouteData.$route(
  path: '/eew-history',
  hasOverriddenOnExit: false,
  factory: $EewHistoryRoute._fromState,
);

mixin $EewHistoryRoute on GoRouteData {
  static EewHistoryRoute _fromState(GoRouterState state) =>
      const EewHistoryRoute();

  @override
  String get location => GoRouteData.$location('/eew-history');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $seismicityRoute => GoRouteData.$route(
  path: '/seismicity',
  hasOverriddenOnExit: false,
  factory: $SeismicityRoute._fromState,
);

mixin $SeismicityRoute on GoRouteData {
  static SeismicityRoute _fromState(GoRouterState state) =>
      const SeismicityRoute();

  @override
  String get location => GoRouteData.$location('/seismicity');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $intensityHistoryRoute => GoRouteData.$route(
  path: '/intensity-history',
  hasOverriddenOnExit: false,
  factory: $IntensityHistoryRoute._fromState,
);

mixin $IntensityHistoryRoute on GoRouteData {
  static IntensityHistoryRoute _fromState(GoRouterState state) =>
      IntensityHistoryRoute(
        prefectureCode: state.uri.queryParameters['prefecture-code'],
        cityCode: state.uri.queryParameters['city-code'],
      );

  IntensityHistoryRoute get _self => this as IntensityHistoryRoute;

  @override
  String get location => GoRouteData.$location(
    '/intensity-history',
    queryParams: {
      if (_self.prefectureCode != null) 'prefecture-code': _self.prefectureCode,
      if (_self.cityCode != null) 'city-code': _self.cityCode,
    },
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $earthquakeHistoryDetailsRoute => GoRouteData.$route(
  path: '/earthquake-history-details/:eventId',
  hasOverriddenOnExit: false,
  factory: $EarthquakeHistoryDetailsRoute._fromState,
);

mixin $EarthquakeHistoryDetailsRoute on GoRouteData {
  static EarthquakeHistoryDetailsRoute _fromState(GoRouterState state) =>
      EarthquakeHistoryDetailsRoute(eventId: state.pathParameters['eventId']!);

  EarthquakeHistoryDetailsRoute get _self =>
      this as EarthquakeHistoryDetailsRoute;

  @override
  String get location => GoRouteData.$location(
    '/earthquake-history-details/${Uri.encodeComponent(_self.eventId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $earthquakeActivityRoute => GoRouteData.$route(
  path: '/earthquake-activity',
  hasOverriddenOnExit: false,
  factory: $EarthquakeActivityRoute._fromState,
);

mixin $EarthquakeActivityRoute on GoRouteData {
  static EarthquakeActivityRoute _fromState(GoRouterState state) =>
      EarthquakeActivityRoute($extra: state.extra as EarthquakeActivityQuery);

  EarthquakeActivityRoute get _self => this as EarthquakeActivityRoute;

  @override
  String get location => GoRouteData.$location('/earthquake-activity');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $liveMonitorRoute => GoRouteData.$route(
  path: '/live-monitor',
  hasOverriddenOnExit: false,
  factory: $LiveMonitorRoute._fromState,
);

mixin $LiveMonitorRoute on GoRouteData {
  static LiveMonitorRoute _fromState(GoRouterState state) =>
      const LiveMonitorRoute();

  @override
  String get location => GoRouteData.$location('/live-monitor');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $telegramListByEventIdRoute => GoRouteData.$route(
  path: '/telegram-list/:eventId',
  hasOverriddenOnExit: false,
  factory: $TelegramListByEventIdRoute._fromState,
);

mixin $TelegramListByEventIdRoute on GoRouteData {
  static TelegramListByEventIdRoute _fromState(GoRouterState state) =>
      TelegramListByEventIdRoute(eventId: state.pathParameters['eventId']!);

  TelegramListByEventIdRoute get _self => this as TelegramListByEventIdRoute;

  @override
  String get location => GoRouteData.$location(
    '/telegram-list/${Uri.encodeComponent(_self.eventId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $homeRoute => GoRouteData.$route(
  path: '/',
  hasOverriddenOnExit: false,
  factory: $HomeRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'map-layer',
      hasOverriddenOnExit: false,
      factory: $HomeMapLayerRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'eew-details-by-event-id/:eventId',
      hasOverriddenOnExit: false,
      factory: $EewDetailsByEventIdRoute._fromState,
    ),
  ],
);

mixin $HomeRoute on GoRouteData {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $HomeMapLayerRoute on GoRouteData {
  static HomeMapLayerRoute _fromState(GoRouterState state) =>
      const HomeMapLayerRoute();

  @override
  String get location => GoRouteData.$location('/map-layer');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $EewDetailsByEventIdRoute on GoRouteData {
  static EewDetailsByEventIdRoute _fromState(GoRouterState state) =>
      EewDetailsByEventIdRoute(eventId: state.pathParameters['eventId']!);

  EewDetailsByEventIdRoute get _self => this as EewDetailsByEventIdRoute;

  @override
  String get location => GoRouteData.$location(
    '/eew-details-by-event-id/${Uri.encodeComponent(_self.eventId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $talkerRoute => GoRouteData.$route(
  path: '/talker',
  hasOverriddenOnExit: false,
  factory: $TalkerRoute._fromState,
);

mixin $TalkerRoute on GoRouteData {
  static TalkerRoute _fromState(GoRouterState state) => const TalkerRoute();

  @override
  String get location => GoRouteData.$location('/talker');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $settingsRoute => GoRouteData.$route(
  path: '/settings',
  hasOverriddenOnExit: false,
  factory: $SettingsRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'display',
      hasOverriddenOnExit: false,
      factory: $DisplayRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: 'theme',
          hasOverriddenOnExit: false,
          factory: $ThemeSettingsRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: 'editor/:mode',
              hasOverriddenOnExit: false,
              factory: $ThemeEditorRoute._fromState,
            ),
          ],
        ),
      ],
    ),
    GoRouteData.$route(
      path: 'kyoshin-monitor-about',
      hasOverriddenOnExit: false,
      factory: $KyoshinMonitorAboutRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: 'observation-network',
          hasOverriddenOnExit: false,
          factory: $KyoshinMonitorAboutObservationNetworkRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'data-type',
          hasOverriddenOnExit: false,
          factory: $KyoshinMonitorDataTypeRoute._fromState,
        ),
      ],
    ),
    GoRouteData.$route(
      path: 'term-of-service',
      hasOverriddenOnExit: false,
      factory: $TermOfServiceRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'privacy-policy',
      hasOverriddenOnExit: false,
      factory: $PrivacyPolicyRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'license',
      hasOverriddenOnExit: false,
      factory: $LicenseRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'notification',
      hasOverriddenOnExit: false,
      factory: $NotificationSettingsRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: 'shake',
          hasOverriddenOnExit: false,
          factory: $ShakeDetectionSettingsRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'history',
          hasOverriddenOnExit: false,
          factory: $NotificationHistoryRoute._fromState,
        ),
      ],
    ),
    GoRouteData.$route(
      path: 'earthquake-history',
      hasOverriddenOnExit: false,
      factory: $EarthquakeHistoryConfigRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'home-widget',
      hasOverriddenOnExit: false,
      factory: $HomeWidgetSettingsRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'about-this-app',
      hasOverriddenOnExit: false,
      factory: $AboutThisAppRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'changelog',
      hasOverriddenOnExit: false,
      factory: $ChangelogRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'debug',
      hasOverriddenOnExit: false,
      factory: $DebugRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: 'api-endpoint-selector',
          hasOverriddenOnExit: false,
          factory: $HttpApiEndpointSelectorRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'kyoshin-monitor',
          hasOverriddenOnExit: false,
          factory: $DebugKyoshinMonitorRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'eew-card',
          hasOverriddenOnExit: false,
          factory: $DebugEewCardRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'earthquake-history-card',
          hasOverriddenOnExit: false,
          factory: $DebugEarthquakeHistoryCardRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'earthquake-history-list-tile',
          hasOverriddenOnExit: false,
          factory: $DebugEarthquakeHistoryListTileRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'shake-detection-card',
          hasOverriddenOnExit: false,
          factory: $DebugShakeDetectionCardRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'shake-detection-insert',
          hasOverriddenOnExit: false,
          factory: $DebugShakeDetectionInsertRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'jma-map',
          hasOverriddenOnExit: false,
          factory: $DebugJmaMapRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'eqmonitor-map',
          hasOverriddenOnExit: false,
          factory: $EqmonitorMapDebugRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'playground',
          hasOverriddenOnExit: false,
          factory: $PlaygroundRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'websocket',
          hasOverriddenOnExit: false,
          factory: $DebugWebSocketRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'notification-delivery-log',
          hasOverriddenOnExit: false,
          factory: $DebugNotificationDeliveryLogRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'device-admin',
          hasOverriddenOnExit: false,
          factory: $DebugDeviceAdminRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'device-settings',
          hasOverriddenOnExit: false,
          factory: $DebugDeviceSettingsRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'navigation',
          hasOverriddenOnExit: false,
          factory: $DebugNavigationRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'app-group',
          hasOverriddenOnExit: false,
          factory: $DebugAppGroupRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'asset-pack',
          hasOverriddenOnExit: false,
          factory: $AssetPackDebugRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'shared-preferences',
          hasOverriddenOnExit: false,
          factory: $DebugSharedPreferencesRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'secure-storage',
          hasOverriddenOnExit: false,
          factory: $DebugSecureStorageRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'http-cache',
          hasOverriddenOnExit: false,
          factory: $DebugHttpCacheRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'intensity-icon',
          hasOverriddenOnExit: false,
          factory: $DebugIntensityIconRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'telemetry',
          hasOverriddenOnExit: false,
          factory: $DebugTelemetryRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'tsunami-details',
          hasOverriddenOnExit: false,
          factory: $DebugTsunamiDetailsRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: 'timeline/:tsunamiId',
              hasOverriddenOnExit: false,
              factory: $DebugTsunamiTimelineRoute._fromState,
            ),
          ],
        ),
        GoRouteData.$route(
          path: 'nied',
          hasOverriddenOnExit: false,
          factory: $NiedRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: 'aqua',
              hasOverriddenOnExit: false,
              factory: $AquaRoute._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'catalog',
                  hasOverriddenOnExit: false,
                  factory: $AquaCatalogRoute._fromState,
                ),
              ],
            ),
            GoRouteData.$route(
              path: 'fnet',
              hasOverriddenOnExit: false,
              factory: $FnetRoute._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'catalog',
                  hasOverriddenOnExit: false,
                  factory: $FnetCatalogRoute._fromState,
                ),
              ],
            ),
            GoRouteData.$route(
              path: 'knet',
              hasOverriddenOnExit: false,
              factory: $KnetWaveformRoute._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'settings',
                  hasOverriddenOnExit: false,
                  factory: $KnetCredentialsSettingsRoute._fromState,
                ),
                GoRouteData.$route(
                  path: 'media',
                  hasOverriddenOnExit: false,
                  factory: $KnetMediaRoute._fromState,
                ),
                GoRouteData.$route(
                  path: 'records',
                  hasOverriddenOnExit: false,
                  factory: $KnetRecordListRoute._fromState,
                ),
                GoRouteData.$route(
                  path: 'waveform',
                  hasOverriddenOnExit: false,
                  factory: $KnetStationWaveformRoute._fromState,
                ),
              ],
            ),
            GoRouteData.$route(
              path: 'hinet-seismicity',
              hasOverriddenOnExit: false,
              factory: $HinetSeismicityRoute._fromState,
            ),
          ],
        ),
      ],
    ),
  ],
);

mixin $SettingsRoute on GoRouteData {
  static SettingsRoute _fromState(GoRouterState state) => const SettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $DisplayRoute on GoRouteData {
  static DisplayRoute _fromState(GoRouterState state) => const DisplayRoute();

  @override
  String get location => GoRouteData.$location('/settings/display');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ThemeSettingsRoute on GoRouteData {
  static ThemeSettingsRoute _fromState(GoRouterState state) =>
      const ThemeSettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings/display/theme');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ThemeEditorRoute on GoRouteData {
  static ThemeEditorRoute _fromState(GoRouterState state) =>
      ThemeEditorRoute(mode: state.pathParameters['mode']!);

  ThemeEditorRoute get _self => this as ThemeEditorRoute;

  @override
  String get location => GoRouteData.$location(
    '/settings/display/theme/editor/${Uri.encodeComponent(_self.mode)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $KyoshinMonitorAboutRoute on GoRouteData {
  static KyoshinMonitorAboutRoute _fromState(GoRouterState state) =>
      const KyoshinMonitorAboutRoute();

  @override
  String get location =>
      GoRouteData.$location('/settings/kyoshin-monitor-about');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $KyoshinMonitorAboutObservationNetworkRoute on GoRouteData {
  static KyoshinMonitorAboutObservationNetworkRoute _fromState(
    GoRouterState state,
  ) => const KyoshinMonitorAboutObservationNetworkRoute();

  @override
  String get location => GoRouteData.$location(
    '/settings/kyoshin-monitor-about/observation-network',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $KyoshinMonitorDataTypeRoute on GoRouteData {
  static KyoshinMonitorDataTypeRoute _fromState(GoRouterState state) =>
      const KyoshinMonitorDataTypeRoute();

  @override
  String get location =>
      GoRouteData.$location('/settings/kyoshin-monitor-about/data-type');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $TermOfServiceRoute on GoRouteData {
  static TermOfServiceRoute _fromState(GoRouterState state) =>
      const TermOfServiceRoute();

  @override
  String get location => GoRouteData.$location('/settings/term-of-service');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PrivacyPolicyRoute on GoRouteData {
  static PrivacyPolicyRoute _fromState(GoRouterState state) =>
      const PrivacyPolicyRoute();

  @override
  String get location => GoRouteData.$location('/settings/privacy-policy');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $LicenseRoute on GoRouteData {
  static LicenseRoute _fromState(GoRouterState state) => const LicenseRoute();

  @override
  String get location => GoRouteData.$location('/settings/license');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $NotificationSettingsRoute on GoRouteData {
  static NotificationSettingsRoute _fromState(GoRouterState state) =>
      const NotificationSettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings/notification');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ShakeDetectionSettingsRoute on GoRouteData {
  static ShakeDetectionSettingsRoute _fromState(GoRouterState state) =>
      const ShakeDetectionSettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings/notification/shake');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $NotificationHistoryRoute on GoRouteData {
  static NotificationHistoryRoute _fromState(GoRouterState state) =>
      const NotificationHistoryRoute();

  @override
  String get location =>
      GoRouteData.$location('/settings/notification/history');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $EarthquakeHistoryConfigRoute on GoRouteData {
  static EarthquakeHistoryConfigRoute _fromState(GoRouterState state) =>
      const EarthquakeHistoryConfigRoute();

  @override
  String get location => GoRouteData.$location('/settings/earthquake-history');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $HomeWidgetSettingsRoute on GoRouteData {
  static HomeWidgetSettingsRoute _fromState(GoRouterState state) =>
      const HomeWidgetSettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings/home-widget');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AboutThisAppRoute on GoRouteData {
  static AboutThisAppRoute _fromState(GoRouterState state) =>
      const AboutThisAppRoute();

  @override
  String get location => GoRouteData.$location('/settings/about-this-app');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ChangelogRoute on GoRouteData {
  static ChangelogRoute _fromState(GoRouterState state) =>
      const ChangelogRoute();

  @override
  String get location => GoRouteData.$location('/settings/changelog');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $DebugRoute on GoRouteData {
  static DebugRoute _fromState(GoRouterState state) => const DebugRoute();

  @override
  String get location => GoRouteData.$location('/settings/debug');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $HttpApiEndpointSelectorRoute on GoRouteData {
  static HttpApiEndpointSelectorRoute _fromState(GoRouterState state) =>
      const HttpApiEndpointSelectorRoute();

  @override
  String get location =>
      GoRouteData.$location('/settings/debug/api-endpoint-selector');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $DebugKyoshinMonitorRoute on GoRouteData {
  static DebugKyoshinMonitorRoute _fromState(GoRouterState state) =>
      const DebugKyoshinMonitorRoute();

  @override
  String get location =>
      GoRouteData.$location('/settings/debug/kyoshin-monitor');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $DebugEewCardRoute on GoRouteData {
  static DebugEewCardRoute _fromState(GoRouterState state) =>
      const DebugEewCardRoute();

  @override
  String get location => GoRouteData.$location('/settings/debug/eew-card');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $DebugEarthquakeHistoryCardRoute on GoRouteData {
  static DebugEarthquakeHistoryCardRoute _fromState(GoRouterState state) =>
      const DebugEarthquakeHistoryCardRoute();

  @override
  String get location =>
      GoRouteData.$location('/settings/debug/earthquake-history-card');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $DebugEarthquakeHistoryListTileRoute on GoRouteData {
  static DebugEarthquakeHistoryListTileRoute _fromState(GoRouterState state) =>
      const DebugEarthquakeHistoryListTileRoute();

  @override
  String get location =>
      GoRouteData.$location('/settings/debug/earthquake-history-list-tile');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $DebugShakeDetectionCardRoute on GoRouteData {
  static DebugShakeDetectionCardRoute _fromState(GoRouterState state) =>
      const DebugShakeDetectionCardRoute();

  @override
  String get location =>
      GoRouteData.$location('/settings/debug/shake-detection-card');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $DebugShakeDetectionInsertRoute on GoRouteData {
  static DebugShakeDetectionInsertRoute _fromState(GoRouterState state) =>
      const DebugShakeDetectionInsertRoute();

  @override
  String get location =>
      GoRouteData.$location('/settings/debug/shake-detection-insert');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $DebugJmaMapRoute on GoRouteData {
  static DebugJmaMapRoute _fromState(GoRouterState state) =>
      const DebugJmaMapRoute();

  @override
  String get location => GoRouteData.$location('/settings/debug/jma-map');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $EqmonitorMapDebugRoute on GoRouteData {
  static EqmonitorMapDebugRoute _fromState(GoRouterState state) =>
      const EqmonitorMapDebugRoute();

  @override
  String get location => GoRouteData.$location('/settings/debug/eqmonitor-map');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PlaygroundRoute on GoRouteData {
  static PlaygroundRoute _fromState(GoRouterState state) =>
      const PlaygroundRoute();

  @override
  String get location => GoRouteData.$location('/settings/debug/playground');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $DebugWebSocketRoute on GoRouteData {
  static DebugWebSocketRoute _fromState(GoRouterState state) =>
      const DebugWebSocketRoute();

  @override
  String get location => GoRouteData.$location('/settings/debug/websocket');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $DebugNotificationDeliveryLogRoute on GoRouteData {
  static DebugNotificationDeliveryLogRoute _fromState(GoRouterState state) =>
      const DebugNotificationDeliveryLogRoute();

  @override
  String get location =>
      GoRouteData.$location('/settings/debug/notification-delivery-log');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $DebugDeviceAdminRoute on GoRouteData {
  static DebugDeviceAdminRoute _fromState(GoRouterState state) =>
      const DebugDeviceAdminRoute();

  @override
  String get location => GoRouteData.$location('/settings/debug/device-admin');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $DebugDeviceSettingsRoute on GoRouteData {
  static DebugDeviceSettingsRoute _fromState(GoRouterState state) =>
      const DebugDeviceSettingsRoute();

  @override
  String get location =>
      GoRouteData.$location('/settings/debug/device-settings');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $DebugNavigationRoute on GoRouteData {
  static DebugNavigationRoute _fromState(GoRouterState state) =>
      const DebugNavigationRoute();

  @override
  String get location => GoRouteData.$location('/settings/debug/navigation');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $DebugAppGroupRoute on GoRouteData {
  static DebugAppGroupRoute _fromState(GoRouterState state) =>
      const DebugAppGroupRoute();

  @override
  String get location => GoRouteData.$location('/settings/debug/app-group');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AssetPackDebugRoute on GoRouteData {
  static AssetPackDebugRoute _fromState(GoRouterState state) =>
      const AssetPackDebugRoute();

  @override
  String get location => GoRouteData.$location('/settings/debug/asset-pack');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $DebugSharedPreferencesRoute on GoRouteData {
  static DebugSharedPreferencesRoute _fromState(GoRouterState state) =>
      const DebugSharedPreferencesRoute();

  @override
  String get location =>
      GoRouteData.$location('/settings/debug/shared-preferences');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $DebugSecureStorageRoute on GoRouteData {
  static DebugSecureStorageRoute _fromState(GoRouterState state) =>
      const DebugSecureStorageRoute();

  @override
  String get location =>
      GoRouteData.$location('/settings/debug/secure-storage');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $DebugHttpCacheRoute on GoRouteData {
  static DebugHttpCacheRoute _fromState(GoRouterState state) =>
      const DebugHttpCacheRoute();

  @override
  String get location => GoRouteData.$location('/settings/debug/http-cache');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $DebugIntensityIconRoute on GoRouteData {
  static DebugIntensityIconRoute _fromState(GoRouterState state) =>
      const DebugIntensityIconRoute();

  @override
  String get location =>
      GoRouteData.$location('/settings/debug/intensity-icon');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $DebugTelemetryRoute on GoRouteData {
  static DebugTelemetryRoute _fromState(GoRouterState state) =>
      const DebugTelemetryRoute();

  @override
  String get location => GoRouteData.$location('/settings/debug/telemetry');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $DebugTsunamiDetailsRoute on GoRouteData {
  static DebugTsunamiDetailsRoute _fromState(GoRouterState state) =>
      const DebugTsunamiDetailsRoute();

  @override
  String get location =>
      GoRouteData.$location('/settings/debug/tsunami-details');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $DebugTsunamiTimelineRoute on GoRouteData {
  static DebugTsunamiTimelineRoute _fromState(GoRouterState state) =>
      DebugTsunamiTimelineRoute(tsunamiId: state.pathParameters['tsunamiId']!);

  DebugTsunamiTimelineRoute get _self => this as DebugTsunamiTimelineRoute;

  @override
  String get location => GoRouteData.$location(
    '/settings/debug/tsunami-details/timeline/${Uri.encodeComponent(_self.tsunamiId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $NiedRoute on GoRouteData {
  static NiedRoute _fromState(GoRouterState state) => const NiedRoute();

  @override
  String get location => GoRouteData.$location('/settings/debug/nied');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AquaRoute on GoRouteData {
  static AquaRoute _fromState(GoRouterState state) => const AquaRoute();

  @override
  String get location => GoRouteData.$location('/settings/debug/nied/aqua');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AquaCatalogRoute on GoRouteData {
  static AquaCatalogRoute _fromState(GoRouterState state) =>
      const AquaCatalogRoute();

  @override
  String get location =>
      GoRouteData.$location('/settings/debug/nied/aqua/catalog');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $FnetRoute on GoRouteData {
  static FnetRoute _fromState(GoRouterState state) => const FnetRoute();

  @override
  String get location => GoRouteData.$location('/settings/debug/nied/fnet');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $FnetCatalogRoute on GoRouteData {
  static FnetCatalogRoute _fromState(GoRouterState state) =>
      const FnetCatalogRoute();

  @override
  String get location =>
      GoRouteData.$location('/settings/debug/nied/fnet/catalog');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $KnetWaveformRoute on GoRouteData {
  static KnetWaveformRoute _fromState(GoRouterState state) =>
      const KnetWaveformRoute();

  @override
  String get location => GoRouteData.$location('/settings/debug/nied/knet');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $KnetCredentialsSettingsRoute on GoRouteData {
  static KnetCredentialsSettingsRoute _fromState(GoRouterState state) =>
      const KnetCredentialsSettingsRoute();

  @override
  String get location =>
      GoRouteData.$location('/settings/debug/nied/knet/settings');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $KnetMediaRoute on GoRouteData {
  static KnetMediaRoute _fromState(GoRouterState state) =>
      KnetMediaRoute($extra: state.extra as DateTime);

  KnetMediaRoute get _self => this as KnetMediaRoute;

  @override
  String get location =>
      GoRouteData.$location('/settings/debug/nied/knet/media');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

mixin $KnetRecordListRoute on GoRouteData {
  static KnetRecordListRoute _fromState(GoRouterState state) =>
      KnetRecordListRoute($extra: state.extra as DateTime);

  KnetRecordListRoute get _self => this as KnetRecordListRoute;

  @override
  String get location =>
      GoRouteData.$location('/settings/debug/nied/knet/records');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

mixin $KnetStationWaveformRoute on GoRouteData {
  static KnetStationWaveformRoute _fromState(GoRouterState state) =>
      KnetStationWaveformRoute($extra: state.extra as KnetStationResult);

  KnetStationWaveformRoute get _self => this as KnetStationWaveformRoute;

  @override
  String get location =>
      GoRouteData.$location('/settings/debug/nied/knet/waveform');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

mixin $HinetSeismicityRoute on GoRouteData {
  static HinetSeismicityRoute _fromState(GoRouterState state) =>
      const HinetSeismicityRoute();

  @override
  String get location =>
      GoRouteData.$location('/settings/debug/nied/hinet-seismicity');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $feedRoute => GoRouteData.$route(
  path: '/feed',
  hasOverriddenOnExit: false,
  factory: $FeedRoute._fromState,
);

mixin $FeedRoute on GoRouteData {
  static FeedRoute _fromState(GoRouterState state) => const FeedRoute();

  @override
  String get location => GoRouteData.$location('/feed');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $feedDetailsRoute => GoRouteData.$route(
  path: '/feed/source/:telegramHash',
  hasOverriddenOnExit: false,
  factory: $FeedDetailsRoute._fromState,
);

mixin $FeedDetailsRoute on GoRouteData {
  static FeedDetailsRoute _fromState(GoRouterState state) =>
      FeedDetailsRoute(telegramHash: state.pathParameters['telegramHash']!);

  FeedDetailsRoute get _self => this as FeedDetailsRoute;

  @override
  String get location => GoRouteData.$location(
    '/feed/source/${Uri.encodeComponent(_self.telegramHash)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $feedItemDetailsRoute => GoRouteData.$route(
  path: '/feed/detail/:id',
  hasOverriddenOnExit: false,
  factory: $FeedItemDetailsRoute._fromState,
);

mixin $FeedItemDetailsRoute on GoRouteData {
  static FeedItemDetailsRoute _fromState(GoRouterState state) =>
      FeedItemDetailsRoute(
        id: state.pathParameters['id']!,
        $extra: state.extra as FeedItem?,
      );

  FeedItemDetailsRoute get _self => this as FeedItemDetailsRoute;

  @override
  String get location =>
      GoRouteData.$location('/feed/detail/${Uri.encodeComponent(_self.id)}');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $tsunamiDetailsRoute => GoRouteData.$route(
  path: '/tsunami/:tsunamiId',
  hasOverriddenOnExit: false,
  factory: $TsunamiDetailsRoute._fromState,
);

mixin $TsunamiDetailsRoute on GoRouteData {
  static TsunamiDetailsRoute _fromState(GoRouterState state) =>
      TsunamiDetailsRoute(tsunamiId: state.pathParameters['tsunamiId']!);

  TsunamiDetailsRoute get _self => this as TsunamiDetailsRoute;

  @override
  String get location =>
      GoRouteData.$location('/tsunami/${Uri.encodeComponent(_self.tsunamiId)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $paywallRoute => GoRouteData.$route(
  path: '/subscription/paywall',
  hasOverriddenOnExit: false,
  factory: $PaywallRoute._fromState,
);

mixin $PaywallRoute on GoRouteData {
  static PaywallRoute _fromState(GoRouterState state) => const PaywallRoute();

  @override
  String get location => GoRouteData.$location('/subscription/paywall');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $subscriptionSettingsRoute => GoRouteData.$route(
  path: '/subscription/settings',
  hasOverriddenOnExit: false,
  factory: $SubscriptionSettingsRoute._fromState,
);

mixin $SubscriptionSettingsRoute on GoRouteData {
  static SubscriptionSettingsRoute _fromState(GoRouterState state) =>
      const SubscriptionSettingsRoute();

  @override
  String get location => GoRouteData.$location('/subscription/settings');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(goRouter)
final goRouterProvider = GoRouterProvider._();

final class GoRouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  GoRouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goRouterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goRouterHash();

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    return goRouter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }
}

String _$goRouterHash() => r'09d918cfa4700a752c7f2fba1b7ed126c626e32b';
