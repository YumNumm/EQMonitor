// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

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
      $homeRoute,
      $talkerRoute,
      $kmoniRoute,
      $settingsRoute,
    ];

RouteBase get $setupRoute => GoRouteData.$route(
      path: '/setup',
      factory: $SetupRouteExtension._fromState,
    );

extension $SetupRouteExtension on SetupRoute {
  static SetupRoute _fromState(GoRouterState state) => const SetupRoute();

  String get location => GoRouteData.$location(
        '/setup',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $earthquakeHistoryRoute => GoRouteData.$route(
      path: '/earthquake-history',
      factory: $EarthquakeHistoryRouteExtension._fromState,
    );

extension $EarthquakeHistoryRouteExtension on EarthquakeHistoryRoute {
  static EarthquakeHistoryRoute _fromState(GoRouterState state) =>
      const EarthquakeHistoryRoute();

  String get location => GoRouteData.$location(
        '/earthquake-history',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $earthquakeHistoryDetailsRoute => GoRouteData.$route(
      path: '/earthquake-history-details/:eventId',
      factory: $EarthquakeHistoryDetailsRouteExtension._fromState,
    );

extension $EarthquakeHistoryDetailsRouteExtension
    on EarthquakeHistoryDetailsRoute {
  static EarthquakeHistoryDetailsRoute _fromState(GoRouterState state) =>
      EarthquakeHistoryDetailsRoute(
        eventId: int.parse(state.pathParameters['eventId']!),
      );

  String get location => GoRouteData.$location(
        '/earthquake-history-details/${Uri.encodeComponent(eventId.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $informationHistoryRoute => GoRouteData.$route(
      path: '/information-history',
      factory: $InformationHistoryRouteExtension._fromState,
    );

extension $InformationHistoryRouteExtension on InformationHistoryRoute {
  static InformationHistoryRoute _fromState(GoRouterState state) =>
      const InformationHistoryRoute();

  String get location => GoRouteData.$location(
        '/information-history',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $informationHistoryDetailsRoute => GoRouteData.$route(
      path: '/information-history-details',
      factory: $InformationHistoryDetailsRouteExtension._fromState,
    );

extension $InformationHistoryDetailsRouteExtension
    on InformationHistoryDetailsRoute {
  static InformationHistoryDetailsRoute _fromState(GoRouterState state) =>
      InformationHistoryDetailsRoute(
        $extra: state.extra as InformationV3,
      );

  String get location => GoRouteData.$location(
        '/information-history-details',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

RouteBase get $homeRoute => GoRouteData.$route(
      path: '/',
      factory: $HomeRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'earthquake-history-early',
          factory: $EarthquakeHistoryEarlyRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'details/:id',
              factory: $EarthquakeHistoryEarlyDetailsRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $EarthquakeHistoryEarlyRouteExtension on EarthquakeHistoryEarlyRoute {
  static EarthquakeHistoryEarlyRoute _fromState(GoRouterState state) =>
      const EarthquakeHistoryEarlyRoute();

  String get location => GoRouteData.$location(
        '/earthquake-history-early',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $EarthquakeHistoryEarlyDetailsRouteExtension
    on EarthquakeHistoryEarlyDetailsRoute {
  static EarthquakeHistoryEarlyDetailsRoute _fromState(GoRouterState state) =>
      EarthquakeHistoryEarlyDetailsRoute(
        id: state.pathParameters['id']!,
      );

  String get location => GoRouteData.$location(
        '/earthquake-history-early/details/${Uri.encodeComponent(id)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $talkerRoute => GoRouteData.$route(
      path: '/talker',
      factory: $TalkerRouteExtension._fromState,
    );

extension $TalkerRouteExtension on TalkerRoute {
  static TalkerRoute _fromState(GoRouterState state) => const TalkerRoute();

  String get location => GoRouteData.$location(
        '/talker',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $kmoniRoute => GoRouteData.$route(
      path: '/kmoni_config',
      factory: $KmoniRouteExtension._fromState,
    );

extension $KmoniRouteExtension on KmoniRoute {
  static KmoniRoute _fromState(GoRouterState state) => const KmoniRoute();

  String get location => GoRouteData.$location(
        '/kmoni_config',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $settingsRoute => GoRouteData.$route(
      path: '/settings',
      factory: $SettingsRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'notification',
          factory: $NotificationRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'earthquake',
              factory: $NotificationEarthquakeRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'eew',
              factory: $NotificationEewRouteExtension._fromState,
            ),
          ],
        ),
        GoRouteData.$route(
          path: 'display',
          factory: $DisplayRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'color-schema',
              factory: $ColorSchemeConfigRouteExtension._fromState,
            ),
          ],
        ),
        GoRouteData.$route(
          path: 'term-of-service',
          factory: $TermOfServiceRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'privacy-policy',
          factory: $PrivacyPolicyRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'license',
          factory: $LicenseRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'earthquake-history',
          factory: $EarthquakeHistoryConfigRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'about-this-app',
          factory: $AboutThisAppRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'donation',
          factory: $DonationRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'executed',
              factory: $DonationExecutedRouteExtension._fromState,
            ),
          ],
        ),
        GoRouteData.$route(
          path: 'debugger',
          factory: $DebuggerRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'api-endpoint-selector',
              factory: $HttpApiEndpointSelectorRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'websocket-api-endpoint-selector',
              factory: $WebsocketEndpointSelectorRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'earthquake-parameter-list',
              factory: $EarthquakeParameterListRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $SettingsRouteExtension on SettingsRoute {
  static SettingsRoute _fromState(GoRouterState state) => const SettingsRoute();

  String get location => GoRouteData.$location(
        '/settings',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $NotificationRouteExtension on NotificationRoute {
  static NotificationRoute _fromState(GoRouterState state) =>
      const NotificationRoute();

  String get location => GoRouteData.$location(
        '/settings/notification',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $NotificationEarthquakeRouteExtension on NotificationEarthquakeRoute {
  static NotificationEarthquakeRoute _fromState(GoRouterState state) =>
      const NotificationEarthquakeRoute();

  String get location => GoRouteData.$location(
        '/settings/notification/earthquake',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $NotificationEewRouteExtension on NotificationEewRoute {
  static NotificationEewRoute _fromState(GoRouterState state) =>
      const NotificationEewRoute();

  String get location => GoRouteData.$location(
        '/settings/notification/eew',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DisplayRouteExtension on DisplayRoute {
  static DisplayRoute _fromState(GoRouterState state) => const DisplayRoute();

  String get location => GoRouteData.$location(
        '/settings/display',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ColorSchemeConfigRouteExtension on ColorSchemeConfigRoute {
  static ColorSchemeConfigRoute _fromState(GoRouterState state) =>
      const ColorSchemeConfigRoute();

  String get location => GoRouteData.$location(
        '/settings/display/color-schema',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $TermOfServiceRouteExtension on TermOfServiceRoute {
  static TermOfServiceRoute _fromState(GoRouterState state) =>
      TermOfServiceRoute(
        showAcceptButton: _$convertMapValue('show-accept-button',
                state.uri.queryParameters, _$boolConverter) ??
            false,
        $extra: state.extra as void Function({bool isAccepted})?,
      );

  String get location => GoRouteData.$location(
        '/settings/term-of-service',
        queryParams: {
          if (showAcceptButton != false)
            'show-accept-button': showAcceptButton.toString(),
        },
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $PrivacyPolicyRouteExtension on PrivacyPolicyRoute {
  static PrivacyPolicyRoute _fromState(GoRouterState state) =>
      PrivacyPolicyRoute(
        showAcceptButton: _$convertMapValue('show-accept-button',
                state.uri.queryParameters, _$boolConverter) ??
            false,
        $extra: state.extra as void Function({bool isAccepted})?,
      );

  String get location => GoRouteData.$location(
        '/settings/privacy-policy',
        queryParams: {
          if (showAcceptButton != false)
            'show-accept-button': showAcceptButton.toString(),
        },
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $LicenseRouteExtension on LicenseRoute {
  static LicenseRoute _fromState(GoRouterState state) => const LicenseRoute();

  String get location => GoRouteData.$location(
        '/settings/license',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $EarthquakeHistoryConfigRouteExtension
    on EarthquakeHistoryConfigRoute {
  static EarthquakeHistoryConfigRoute _fromState(GoRouterState state) =>
      const EarthquakeHistoryConfigRoute();

  String get location => GoRouteData.$location(
        '/settings/earthquake-history',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AboutThisAppRouteExtension on AboutThisAppRoute {
  static AboutThisAppRoute _fromState(GoRouterState state) =>
      const AboutThisAppRoute();

  String get location => GoRouteData.$location(
        '/settings/about-this-app',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DonationRouteExtension on DonationRoute {
  static DonationRoute _fromState(GoRouterState state) => const DonationRoute();

  String get location => GoRouteData.$location(
        '/settings/donation',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DonationExecutedRouteExtension on DonationExecutedRoute {
  static DonationExecutedRoute _fromState(GoRouterState state) =>
      DonationExecutedRoute(
        $extra: state.extra as (StoreProduct, CustomerInfo),
      );

  String get location => GoRouteData.$location(
        '/settings/donation/executed',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $DebuggerRouteExtension on DebuggerRoute {
  static DebuggerRoute _fromState(GoRouterState state) => const DebuggerRoute();

  String get location => GoRouteData.$location(
        '/settings/debugger',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $HttpApiEndpointSelectorRouteExtension
    on HttpApiEndpointSelectorRoute {
  static HttpApiEndpointSelectorRoute _fromState(GoRouterState state) =>
      const HttpApiEndpointSelectorRoute();

  String get location => GoRouteData.$location(
        '/settings/debugger/api-endpoint-selector',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $WebsocketEndpointSelectorRouteExtension
    on WebsocketEndpointSelectorRoute {
  static WebsocketEndpointSelectorRoute _fromState(GoRouterState state) =>
      const WebsocketEndpointSelectorRoute();

  String get location => GoRouteData.$location(
        '/settings/debugger/websocket-api-endpoint-selector',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $EarthquakeParameterListRouteExtension
    on EarthquakeParameterListRoute {
  static EarthquakeParameterListRoute _fromState(GoRouterState state) =>
      const EarthquakeParameterListRoute();

  String get location => GoRouteData.$location(
        '/settings/debugger/earthquake-parameter-list',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

T? _$convertMapValue<T>(
  String key,
  Map<String, String> map,
  T Function(String) converter,
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

String _$goRouterHash() => r'a7cd95377d5ff1f764cfb89abde896f1176007ce';

/// See also [goRouter].
@ProviderFor(goRouter)
final goRouterProvider = Provider<GoRouter>.internal(
  goRouter,
  name: r'goRouterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$goRouterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GoRouterRef = ProviderRef<GoRouter>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
