import 'package:eqmonitor/common/theme/dark_theme.dart';
import 'package:eqmonitor/feature/setup/screen/setup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: MaterialApp(
        title: 'EQMonitor',
        home: const SetupScreen(),
        darkTheme: darkTheme,
        themeMode: ThemeMode.dark,
      ),
    );
  }
}
