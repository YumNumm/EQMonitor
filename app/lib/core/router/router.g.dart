// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $earthquakeHistoryRoute,
  $earthquakeSearchResultRoute,
  $earthquakeHistoryDetailsRoute,
  $telegramListByEventIdRoute,
  $homeRoute,
  $talkerRoute,
  $settingsRoute,
];

RouteBase get $earthquakeHistoryRoute => GoRouteData.$route(
  path: '/earthquake-history',
  factory: $EarthquakeHistoryRoute._fromState,
);

mixin $EarthquakeHistoryRoute on GoRouteData {
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

RouteBase get $earthquakeSearchResultRoute => GoRouteData.$route(
  path: '/earthquake-search/:type/:code',
  factory: $EarthquakeSearchResultRoute._fromState,
);

mixin $EarthquakeSearchResultRoute on GoRouteData {
  static EarthquakeSearchResultRoute _fromState(GoRouterState state) =>
      EarthquakeSearchResultRoute(
        type: state.pathParameters['type']!,
        code: state.pathParameters['code']!,
        name: state.uri.queryParameters['name'],
      );

  EarthquakeSearchResultRoute get _self => this as EarthquakeSearchResultRoute;

  @override
  String get location => GoRouteData.$location(
    '/earthquake-search/${Uri.encodeComponent(_self.type)}/${Uri.encodeComponent(_self.code)}',
    queryParams: {if (_self.name != null) 'name': _self.name},
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

RouteBase get $telegramListByEventIdRoute => GoRouteData.$route(
  path: '/telegram-list/:eventId',
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
  factory: $HomeRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'eew-details-by-event-id/:eventId',
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

RouteBase get $talkerRoute =>
    GoRouteData.$route(path: '/talker', factory: $TalkerRoute._fromState);

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
  factory: $SettingsRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'display',
      factory: $DisplayRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: 'color-schema',
          factory: $ColorSchemeConfigRoute._fromState,
        ),
      ],
    ),
    GoRouteData.$route(
      path: 'kyoshin-monitor-about',
      factory: $KyoshinMonitorAboutRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: 'observation-network',
          factory: $KyoshinMonitorAboutObservationNetworkRoute._fromState,
        ),
      ],
    ),
    GoRouteData.$route(
      path: 'term-of-service',
      factory: $TermOfServiceRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'privacy-policy',
      factory: $PrivacyPolicyRoute._fromState,
    ),
    GoRouteData.$route(path: 'license', factory: $LicenseRoute._fromState),
    GoRouteData.$route(
      path: 'earthquake-history',
      factory: $EarthquakeHistoryConfigRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'about-this-app',
      factory: $AboutThisAppRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'debug',
      factory: $DebugRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: 'api-endpoint-selector',
          factory: $HttpApiEndpointSelectorRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'kyoshin-monitor',
          factory: $DebugKyoshinMonitorRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'eew-card',
          factory: $DebugEewCardRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'jma-map',
          factory: $DebugJmaMapRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'playground',
          factory: $PlaygroundRoute._fromState,
        ),
        GoRouteData.$route(path: 'sse', factory: $DebugSseRoute._fromState),
        GoRouteData.$route(
          path: 'notification-delivery-log',
          factory: $DebugNotificationDeliveryLogRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'device-admin',
          factory: $DebugDeviceAdminRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'device-settings',
          factory: $DebugDeviceSettingsRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'earthquake-replay',
          factory: $EarthquakeReplayRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'nied',
          factory: $NiedRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: 'aqua',
              factory: $AquaRoute._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'catalog',
                  factory: $AquaCatalogRoute._fromState,
                ),
              ],
            ),
            GoRouteData.$route(
              path: 'fnet',
              factory: $FnetRoute._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'catalog',
                  factory: $FnetCatalogRoute._fromState,
                ),
              ],
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

mixin $ColorSchemeConfigRoute on GoRouteData {
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

mixin $TermOfServiceRoute on GoRouteData {
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

mixin $PrivacyPolicyRoute on GoRouteData {
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

mixin $DebugSseRoute on GoRouteData {
  static DebugSseRoute _fromState(GoRouterState state) => const DebugSseRoute();

  @override
  String get location => GoRouteData.$location('/settings/debug/sse');

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

mixin $EarthquakeReplayRoute on GoRouteData {
  static EarthquakeReplayRoute _fromState(GoRouterState state) =>
      const EarthquakeReplayRoute();

  @override
  String get location =>
      GoRouteData.$location('/settings/debug/earthquake-replay');

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

String _$goRouterHash() => r'8a62453a9e9e24d88c219ecf204af1cc7658b177';
