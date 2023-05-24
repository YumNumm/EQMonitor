import 'package:eqmonitor/common/router/router.dart';
import 'package:eqmonitor/common/theme/dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: MaterialApp.router(
        title: 'EQMonitor',
        theme: lightTheme,
        darkTheme: darkTheme,
        routerConfig: ref.watch(goRouterProvider),
      ),
    );
  }
}
