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
      $eewDetailedHistoryRoute,
      $colorSchemeConfigRoute,
      $homeRoute,
      $talkerRoute,
      $kmoniRoute,
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
}

RouteBase get $earthquakeHistoryDetailsRoute => GoRouteData.$route(
      path: '/earthquake-history/:eventId',
      factory: $EarthquakeHistoryDetailsRouteExtension._fromState,
    );

extension $EarthquakeHistoryDetailsRouteExtension
    on EarthquakeHistoryDetailsRoute {
  static EarthquakeHistoryDetailsRoute _fromState(GoRouterState state) =>
      EarthquakeHistoryDetailsRoute(
        int.parse(state.pathParameters['eventId']!),
      );

  String get location => GoRouteData.$location(
        '/earthquake-history/${Uri.encodeComponent(eventId.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

RouteBase get $eewDetailedHistoryRoute => GoRouteData.$route(
      path: '/eew-detailed-history/:eventId',
      factory: $EewDetailedHistoryRouteExtension._fromState,
    );

extension $EewDetailedHistoryRouteExtension on EewDetailedHistoryRoute {
  static EewDetailedHistoryRoute _fromState(GoRouterState state) =>
      EewDetailedHistoryRoute(
        int.parse(state.pathParameters['eventId']!),
      );

  String get location => GoRouteData.$location(
        '/eew-detailed-history/${Uri.encodeComponent(eventId.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

RouteBase get $colorSchemeConfigRoute => GoRouteData.$route(
      path: '/config',
      factory: $ColorSchemeConfigRouteExtension._fromState,
    );

extension $ColorSchemeConfigRouteExtension on ColorSchemeConfigRoute {
  static ColorSchemeConfigRoute _fromState(GoRouterState state) =>
      const ColorSchemeConfigRoute();

  String get location => GoRouteData.$location(
        '/config',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);
}

RouteBase get $homeRoute => GoRouteData.$route(
      path: '/',
      factory: $HomeRouteExtension._fromState,
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
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$goRouterHash() => r'2b45ac372cb663512b42a9cc1b8e8f3600165263';

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
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
