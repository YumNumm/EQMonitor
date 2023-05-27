import 'package:eqmonitor/common/fcm/silent_data_handle.dart';
import 'package:eqmonitor/common/router/router.dart';
import 'package:eqmonitor/common/theme/dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class App extends HookConsumerWidget {
  const App({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(
      () {
        WidgetsBinding.instance.endOfFrame
            .then((_) => NotificationController.displayNotificationRationale());
        return null;
      },
      [],
    );
    return MaterialApp.router(
      title: 'EQMonitor',
      theme: lightTheme,
      darkTheme: darkTheme,
      routerConfig: ref.watch(goRouterProvider),
    );
  }
}
