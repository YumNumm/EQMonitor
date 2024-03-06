import 'package:dynamic_color/dynamic_color.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/core/theme/custom_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class App extends HookConsumerWidget {
  const App({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final app = DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        // Fictitious brand color.
        const brandBlue = Color(0xFF1E88E5);

        var lightCustomColors = const CustomColors(danger: Color(0xFFE53935));
        var darkCustomColors = const CustomColors(danger: Color(0xFFEF9A9A));

        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;

        if (lightDynamic != null && darkDynamic != null) {
          // On Android S+ devices, use the provided dynamic color scheme.
          // (Recommended) Harmonize the dynamic color scheme' built-in semantic
          // colors.
          lightColorScheme = lightDynamic.harmonized();
          // (Optional) Customize the scheme as desired. For example, one might
          // want to use a brand color to override the dynamic
          // [ColorScheme.secondary].
          lightColorScheme = lightColorScheme.copyWith(secondary: brandBlue);
          // (Optional) If applicable, harmonize custom colors.
          lightCustomColors = lightCustomColors.harmonized(lightColorScheme);

          // Repeat for the dark color scheme.
          darkColorScheme = darkDynamic.harmonized();
          darkColorScheme = darkColorScheme.copyWith(secondary: brandBlue);
          darkCustomColors = darkCustomColors.harmonized(darkColorScheme);
        } else {
          // Otherwise, use fallback schemes.
          lightColorScheme = ColorScheme.fromSeed(
            seedColor: brandBlue,
          );
          darkColorScheme = ColorScheme.fromSeed(
            seedColor: brandBlue,
            brightness: Brightness.dark,
          );
        }
        return MaterialApp.router(
          title: 'EQMonitor',
          routerConfig: ref.watch(goRouterProvider),
          theme: ThemeData(
            colorScheme: lightColorScheme,
            extensions: [lightCustomColors],
            useMaterial3: true,
            textTheme: GoogleFonts.notoSansJpTextTheme(),
          ),
          darkTheme: ThemeData(
            colorScheme: darkColorScheme,
            extensions: [darkCustomColors],
            useMaterial3: true,
            textTheme: GoogleFonts.notoSansJpTextTheme(),
          ),
        );
      },
    );
    if (kDebugMode) {
      final packageInfo = ref.watch(packageInfoProvider);
      return Directionality(
        textDirection: TextDirection.ltr,
        child: Banner(
          message: 'v${packageInfo.version}-${packageInfo.buildNumber}',
          location: BannerLocation.bottomStart,
          color: Colors.red.shade900,
          child: app,
        ),
      );
    }
    return app;
  }
}
