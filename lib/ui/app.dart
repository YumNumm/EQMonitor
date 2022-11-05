import 'package:device_preview/device_preview.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider/theme_providers.dart';
import 'route.dart';
import 'theme/theme.dart';

class App extends ConsumerWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeProvider = ref.watch(themeProvider);
    final router = ref.watch(routerProvider);
    return DevicePreview(
      builder: (context) => DynamicColorBuilder(
        builder: (lightDynamic, darkDynamic) {
          return MaterialApp.router(
            title: 'EQMonitor',
            theme: lightTheme(
              themeModeProvider.useDynamicColor ? lightDynamic : null,
            ),
            darkTheme: darkTheme(
                themeModeProvider.useDynamicColor ? darkDynamic : null),
            themeMode: themeModeProvider.themeMode,
            locale: DevicePreview.locale(context),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ja', 'JP'),
            ],
            useInheritedMediaQuery: true,
            routerDelegate: router.routerDelegate,
            routeInformationParser: router.routeInformationParser,
            routeInformationProvider: router.routeInformationProvider,
          );
        },
      ),
    );
  }
}
