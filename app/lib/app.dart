import 'package:dynamic_color/dynamic_color.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/core/theme/build_theme.dart';
import 'package:eqmonitor/core/theme/custom_colors.dart';
import 'package:eqmonitor/core/theme/theme_provider.dart';
import 'package:eqmonitor/feature/debug/launcher/debug_launcher.dart';
import 'package:eqmonitor/feature/start/ui/component/forced_update_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class App extends HookConsumerWidget {
  const App({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);
    final routerConfig = ref.watch(goRouterProvider);

    final app = DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        const brandBlue = Color(0xFF1E88E5);

        var lightCustomColors = const CustomColors(danger: Color(0xFFE53935));
        var darkCustomColors = const CustomColors(danger: Color(0xFFEF9A9A));

        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;

        if (lightDynamic != null && darkDynamic != null) {
          lightColorScheme = lightDynamic.harmonized();
          lightColorScheme = lightColorScheme.copyWith(secondary: brandBlue);
          lightCustomColors = lightCustomColors.harmonized(lightColorScheme);

          darkColorScheme = darkDynamic.harmonized();
          darkColorScheme = darkColorScheme.copyWith(secondary: brandBlue);
          darkCustomColors = darkCustomColors.harmonized(darkColorScheme);
        } else {
          lightColorScheme = ColorScheme.fromSeed(seedColor: brandBlue);
          darkColorScheme = ColorScheme.fromSeed(
            seedColor: brandBlue,
            brightness: Brightness.dark,
          );
        }
        return MaterialApp.router(
          title: 'EQMonitor',
          themeMode: theme.value,
          routerConfig: routerConfig,
          builder: (context, child) =>
              DebugLauncher(child: child ?? const SizedBox.shrink()),
          theme: buildTheme(
            colorScheme: lightColorScheme,
            customColors: lightCustomColors,
          ),
          darkTheme: buildTheme(
            colorScheme: darkColorScheme,
            customColors: darkCustomColors,
          ),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ja', 'JP'),
          ],
        );
      },
    );
    final buildConfig = ref.watch(buildConfigProvider);
    Widget result = ForcedUpdateWrapper(
      child: app,
    );

    final packageInfo = ref.watch(packageInfoProvider);
    final versionBanner = Banner(
      message: 'v${packageInfo.version}+${packageInfo.buildNumber}',
      location: BannerLocation.bottomEnd,
      color: const Color(0xFFF4C75E),
      textStyle: const TextStyle(
        color: Color(0xFF0F141A),
        fontSize: 8,
        fontWeight: FontWeight.w600,
      ),
      child: result,
    );

    if (buildConfig.isBetaTesting) {
      result = Directionality(
        textDirection: TextDirection.ltr,
        child: Banner(
          message: 'Beta',
          location: BannerLocation.topEnd,
          color: const Color(0xFFF4C75E),
          textStyle: const TextStyle(
            color: Color(0xFF0F141A),
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
          child: versionBanner,
        ),
      );
    }

    if (kDebugMode && !buildConfig.isBetaTesting) {
      final packageInfo = ref.watch(packageInfoProvider);
      result = Directionality(
        textDirection: TextDirection.ltr,
        child: Banner(
          message: 'v${packageInfo.version}-${packageInfo.buildNumber}',
          location: BannerLocation.bottomStart,
          child: versionBanner,
        ),
      );
    }

    return result;
  }
}
