import 'package:cupertino_ui/cupertino_ui.dart'
    show GlobalCupertinoLocalizations;
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/core/theme/build_theme.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:eqmonitor/core/theme/theme_provider.dart';
import 'package:eqmonitor/feature/debug/launcher/debug_launcher.dart';
import 'package:eqmonitor/feature/eew/ui/components/eew_warning_overlay_host.dart';
import 'package:eqmonitor/feature/live_monitor/data/provider/live_monitor_wake_lock_controller.dart';
import 'package:eqmonitor/feature/start/ui/component/forced_update_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart'
    show GlobalWidgetsLocalizations;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class App extends HookConsumerWidget {
  const new({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(liveMonitorWakeLockControllerProvider);
    final theme = ref.watch(themeModeProvider);
    final routerConfig = ref.watch(goRouterProvider);
    final lightColorSet = ref.watch(
      colorSetForBrightnessProvider(Brightness.light),
    );
    final darkColorSet = ref.watch(
      colorSetForBrightnessProvider(Brightness.dark),
    );

    final app = MaterialApp.router(
      title: 'EQMonitor',
      themeMode: theme.value,
      routerConfig: routerConfig,
      builder: (context, child) => EewWarningOverlayHost(
        backButtonDispatcher: routerConfig.backButtonDispatcher,
        child: DebugLauncher(child: child ?? const SizedBox.shrink()),
      ),
      theme: AppThemeDataBuilder.build(
        colorSet: lightColorSet,
        brightness: Brightness.light,
      ),
      darkTheme: AppThemeDataBuilder.build(
        colorSet: darkColorSet,
        brightness: Brightness.dark,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ja', 'JP')],
    );
    final buildConfig = ref.watch(buildConfigProvider);
    Widget result = ForcedUpdateWrapper(child: app);

    if (!kDebugMode && buildConfig.isBetaTesting) {
      result = Directionality(
        textDirection: TextDirection.ltr,
        child: Banner(
          message: 'BETA',
          location: BannerLocation.topEnd,
          color: Colors.orange.shade400,
          textStyle: const TextStyle(
            color: Color(0xFF0F141A),
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
          child: result,
        ),
      );
    }

    if (kDebugMode || buildConfig.isBetaTesting) {
      final packageInfo = ref.watch(packageInfoProvider);
      result = Directionality(
        textDirection: TextDirection.ltr,
        child: Banner(
          message: 'v${packageInfo.version}-${packageInfo.buildNumber}',
          location: BannerLocation.bottomStart,
          child: result,
        ),
      );
    }

    return result;
  }
}
