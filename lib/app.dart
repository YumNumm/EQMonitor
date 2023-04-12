import 'package:eqmonitor/common/theme/dark_theme.dart';
import 'package:eqmonitor/feature/setup/setup_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EQMonitor',
      home: const SetupScreen(),
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
    );
  }
}
