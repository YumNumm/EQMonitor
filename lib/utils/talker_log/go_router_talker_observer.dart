import 'package:eqmonitor/utils/talker_log/log_types.dart';
import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

class GoRouterTalkerObserver extends NavigatorObserver {
  GoRouterTalkerObserver(this.talker);

  final Talker talker;
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    talker.logTyped(
      GoRouterLog(
        '[PUSH] ${previousRoute?.settings.name} -> ${route.settings.name}',
      ),
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    talker.logTyped(
      GoRouterLog(
        '[POP] ${previousRoute?.settings.name} -> ${route.settings.name}',
      ),
    );
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    talker.logTyped(
      GoRouterLog(
        '[REMOVE] ${previousRoute?.settings.name} -> ${route.settings.name}',
      ),
    );
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    talker.logTyped(
      GoRouterLog(
        '[REPLACE] $oldRoute -> $newRoute',
      ),
    );
  }

  @override
  void didStartUserGesture(
      Route<dynamic> route, Route<dynamic>? previousRoute) {
    talker.logTyped(
      GoRouterLog(
        '[USER GESTURE] ${previousRoute?.settings.name} -> ${route.settings.name}',
      ),
    );
  }

  @override
  void didStopUserGesture() {
    talker.logTyped(
      GoRouterLog(
        '[STOP USER GESTURE]',
      ),
    );
  }
}
