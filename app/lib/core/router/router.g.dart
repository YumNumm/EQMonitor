// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $setupRoute,
  $earthquakeHistoryRoute,
  $earthquakeHistoryDetailsRoute,
  $informationHistoryRoute,
  $informationHistoryDetailsRoute,
  $tsunamiHistoryRoute,
  $tsunamiDetailsRoute,
  $homeRoute,
  $talkerRoute,
  $settingsRoute,
];

RouteBase get $setupRoute =>
    GoRouteData.$route(path: '/setup', factory: _$SetupRoute._fromState);

mixin _$SetupRoute on GoRouteData {
  static SetupRoute _fromState(GoRouterState state) => const SetupRoute();

  @override
  String get location => GoRouteData.$location('/setup');

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

  factory: _$EarthquakeHistoryRoute._fromState,
);

mixin _$EarthquakeHistoryRoute on GoRouteData {
  static EarthquakeHistoryRoute _fromState(GoRouterState state) =>
      const EarthquakeHistoryRoute();

  @override
  String get location => GoRouteData.$location('/earthquake-history');

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

  factory: _$EarthquakeHistoryDetailsRoute._fromState,
);

mixin _$EarthquakeHistoryDetailsRoute on GoRouteData {
  static EarthquakeHistoryDetailsRoute _fromState(GoRouterState state) =>
      EarthquakeHistoryDetailsRoute(
        eventId: int.parse(state.pathParameters['eventId']!)!,
      );

  EarthquakeHistoryDetailsRoute get _self =>
      this as EarthquakeHistoryDetailsRoute;

  @override
  String get location => GoRouteData.$location(
    '/earthquake-history-details/${Uri.encodeComponent(_self.eventId.toString())}',
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

RouteBase get $informationHistoryRoute => GoRouteData.$route(
  path: '/information-history',

  factory: _$InformationHistoryRoute._fromState,
);

mixin _$InformationHistoryRoute on GoRouteData {
  static InformationHistoryRoute _fromState(GoRouterState state) =>
      const InformationHistoryRoute();

  @override
  String get location => GoRouteData.$location('/information-history');

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

RouteBase get $informationHistoryDetailsRoute => GoRouteData.$route(
  path: '/information-history-details',

  factory: _$InformationHistoryDetailsRoute._fromState,
);

mixin _$InformationHistoryDetailsRoute on GoRouteData {
  static InformationHistoryDetailsRoute _fromState(GoRouterState state) =>
      InformationHistoryDetailsRoute($extra: state.extra as InformationV3);

  InformationHistoryDetailsRoute get _self =>
      this as InformationHistoryDetailsRoute;

  @override
  String get location => GoRouteData.$location('/information-history-details');

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

RouteBase get $tsunamiHistoryRoute => GoRouteData.$route(
  path: '/tsunami-history',

  factory: _$TsunamiHistoryRoute._fromState,
);

mixin _$TsunamiHistoryRoute on GoRouteData {
  static TsunamiHistoryRoute _fromState(GoRouterState state) =>
      const TsunamiHistoryRoute();

  @override
  String get location => GoRouteData.$location('/tsunami-history');

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

RouteBase get $tsunamiDetailsRoute => GoRouteData.$route(
  path: '/tsunami-details',

  factory: _$TsunamiDetailsRoute._fromState,
);

mixin _$TsunamiDetailsRoute on GoRouteData {
  static TsunamiDetailsRoute _fromState(GoRouterState state) =>
      TsunamiDetailsRoute($extra: state.extra as TsunamiEvent);

  TsunamiDetailsRoute get _self => this as TsunamiDetailsRoute;

  @override
  String get location => GoRouteData.$location('/tsunami-details');

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

RouteBase get $homeRoute => GoRouteData.$route(
  path: '/',

  factory: _$HomeRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'earthquake-history-early',

      factory: _$EarthquakeHistoryEarlyRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: 'details/:id',

          factory: _$EarthquakeHistoryEarlyDetailsRoute._fromState,
        ),
      ],
    ),
    GoRouteData.$route(
      path: 'eew-details-by-event-id/:eventId',

      factory: _$EewDetailsByEventIdRoute._fromState,
    ),
  ],
);

mixin _$HomeRoute on GoRouteData {
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

mixin _$EarthquakeHistoryEarlyRoute on GoRouteData {
  static EarthquakeHistoryEarlyRoute _fromState(GoRouterState state) =>
      const EarthquakeHistoryEarlyRoute();

  @override
  String get location => GoRouteData.$location('/earthquake-history-early');

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

mixin _$EarthquakeHistoryEarlyDetailsRoute on GoRouteData {
  static EarthquakeHistoryEarlyDetailsRoute _fromState(GoRouterState state) =>
      EarthquakeHistoryEarlyDetailsRoute(id: state.pathParameters['id']!);

  EarthquakeHistoryEarlyDetailsRoute get _self =>
      this as EarthquakeHistoryEarlyDetailsRoute;

  @override
  String get location => GoRouteData.$location(
    '/earthquake-history-early/details/${Uri.encodeComponent(_self.id)}',
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

mixin _$EewDetailsByEventIdRoute on GoRouteData {
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

RouteBase get $talkerRoute =>
    GoRouteData.$route(path: '/talker', factory: _$TalkerRoute._fromState);

mixin _$TalkerRoute on GoRouteData {
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

  factory: _$SettingsRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'notification',

      factory: _$NotificationRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: 'earthquake',

          factory: _$NotificationEarthquakeRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'eew',

          factory: _$NotificationEewRoute._fromState,
        ),
      ],
    ),
    GoRouteData.$route(
      path: 'display',

      factory: _$DisplayRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: 'color-schema',

          factory: _$ColorSchemeConfigRoute._fromState,
        ),
      ],
    ),
    GoRouteData.$route(
      path: 'kyoshin-monitor-about',

      factory: _$KyoshinMonitorAboutRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: 'observation-network',

          factory: _$KyoshinMonitorAboutObservationNetworkRoute._fromState,
        ),
      ],
    ),
    GoRouteData.$route(
      path: 'term-of-service',

      factory: _$TermOfServiceRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'privacy-policy',

      factory: _$PrivacyPolicyRoute._fromState,
    ),
    GoRouteData.$route(path: 'license', factory: _$LicenseRoute._fromState),
    GoRouteData.$route(
      path: 'earthquake-history',

      factory: _$EarthquakeHistoryConfigRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'about-this-app',

      factory: _$AboutThisAppRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'donation',

      factory: _$DonationRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: 'executed',

          factory: _$DonationExecutedRoute._fromState,
        ),
      ],
    ),
    GoRouteData.$route(
      path: 'debug',

      factory: _$DebugRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: 'api-endpoint-selector',

          factory: _$HttpApiEndpointSelectorRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'websocket-api-endpoint-selector',

          factory: _$WebsocketEndpointSelectorRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'kyoshin-monitor',

          factory: _$DebugKyoshinMonitorRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'jma-map',

          factory: _$DebugJmaMapRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'playground',

          factory: _$PlaygroundRoute._fromState,
        ),
      ],
    ),
  ],
);

mixin _$SettingsRoute on GoRouteData {
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

mixin _$NotificationRoute on GoRouteData {
  static NotificationRoute _fromState(GoRouterState state) =>
      const NotificationRoute();

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

mixin _$NotificationEarthquakeRoute on GoRouteData {
  static NotificationEarthquakeRoute _fromState(GoRouterState state) =>
      const NotificationEarthquakeRoute();

  @override
  String get location =>
      GoRouteData.$location('/settings/notification/earthquake');

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

mixin _$NotificationEewRoute on GoRouteData {
  static NotificationEewRoute _fromState(GoRouterState state) =>
      const NotificationEewRoute();

  @override
  String get location => GoRouteData.$location('/settings/notification/eew');

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

mixin _$DisplayRoute on GoRouteData {
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

mixin _$ColorSchemeConfigRoute on GoRouteData {
  static ColorSchemeConfigRoute _fromState(GoRouterState state) =>
      const ColorSchemeConfigRoute();

  @override
  String get location =>
      GoRouteData.$location('/settings/display/color-schema');

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

mixin _$KyoshinMonitorAboutRoute on GoRouteData {
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

mixin _$KyoshinMonitorAboutObservationNetworkRoute on GoRouteData {
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

mixin _$TermOfServiceRoute on GoRouteData {
  static TermOfServiceRoute _fromState(GoRouterState state) =>
      TermOfServiceRoute(
        showAcceptButton:
            _$convertMapValue(
              'show-accept-button',
              state.uri.queryParameters,
              _$boolConverter,
            ) ??
            false,
        $extra: state.extra as void Function({bool isAccepted})?,
      );

  TermOfServiceRoute get _self => this as TermOfServiceRoute;

  @override
  String get location => GoRouteData.$location(
    '/settings/term-of-service',
    queryParams: {
      if (_self.showAcceptButton != false)
        'show-accept-button': _self.showAcceptButton.toString(),
    },
  );

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

mixin _$PrivacyPolicyRoute on GoRouteData {
  static PrivacyPolicyRoute _fromState(GoRouterState state) =>
      PrivacyPolicyRoute(
        showAcceptButton:
            _$convertMapValue(
              'show-accept-button',
              state.uri.queryParameters,
              _$boolConverter,
            ) ??
            false,
        $extra: state.extra as void Function({bool isAccepted})?,
      );

  PrivacyPolicyRoute get _self => this as PrivacyPolicyRoute;

  @override
  String get location => GoRouteData.$location(
    '/settings/privacy-policy',
    queryParams: {
      if (_self.showAcceptButton != false)
        'show-accept-button': _self.showAcceptButton.toString(),
    },
  );

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

mixin _$LicenseRoute on GoRouteData {
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

mixin _$EarthquakeHistoryConfigRoute on GoRouteData {
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

mixin _$AboutThisAppRoute on GoRouteData {
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

mixin _$DonationRoute on GoRouteData {
  static DonationRoute _fromState(GoRouterState state) => const DonationRoute();

  @override
  String get location => GoRouteData.$location('/settings/donation');

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

mixin _$DonationExecutedRoute on GoRouteData {
  static DonationExecutedRoute _fromState(GoRouterState state) =>
      DonationExecutedRoute(
        $extra: state.extra as (StoreProduct, CustomerInfo),
      );

  DonationExecutedRoute get _self => this as DonationExecutedRoute;

  @override
  String get location => GoRouteData.$location('/settings/donation/executed');

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

mixin _$DebugRoute on GoRouteData {
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

mixin _$HttpApiEndpointSelectorRoute on GoRouteData {
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

mixin _$WebsocketEndpointSelectorRoute on GoRouteData {
  static WebsocketEndpointSelectorRoute _fromState(GoRouterState state) =>
      const WebsocketEndpointSelectorRoute();

  @override
  String get location =>
      GoRouteData.$location('/settings/debug/websocket-api-endpoint-selector');

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

mixin _$DebugKyoshinMonitorRoute on GoRouteData {
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

mixin _$DebugJmaMapRoute on GoRouteData {
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

mixin _$PlaygroundRoute on GoRouteData {
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

T? _$convertMapValue<T>(
  String key,
  Map<String, String> map,
  T? Function(String) converter,
) {
  final value = map[key];
  return value == null ? null : converter(value);
}

bool _$boolConverter(String value) {
  switch (value) {
    case 'true':
      return true;
    case 'false':
      return false;
    default:
      throw UnsupportedError('Cannot convert "$value" into a bool.');
  }
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(goRouter)
const goRouterProvider = GoRouterProvider._();

final class GoRouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  const GoRouterProvider._()
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

String _$goRouterHash() => r'8a62453a9e9e24d88c219ecf204af1cc7658b177';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
