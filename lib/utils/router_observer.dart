import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

/// A [NavigatorObserver] that logs all route changes.
class NavObserver extends NavigatorObserver {
  final log = Logger();

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      log.v('didPush: ${route.str}, previousRoute= ${previousRoute?.str}');

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      log.v('didPop: ${route.str}, previousRoute= ${previousRoute?.str}');

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      log.v('didRemove: ${route.str}, previousRoute= ${previousRoute?.str}');

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) =>
      log.v('didReplace: new= ${newRoute?.str}, old= ${oldRoute?.str}');

  @override
  void didStartUserGesture(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) =>
      log.v(
        'didStartUserGesture: ${route.str}, '
        'previousRoute= ${previousRoute?.str}',
      );

  @override
  void didStopUserGesture() => log.v('didStopUserGesture');
}

extension on Route<dynamic> {
  String get str => 'route(${settings.name}: ${settings.arguments})';
}
