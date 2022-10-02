import 'package:eqmonitor/provider/earthquake/earthquake_controller.dart';
import 'package:eqmonitor/provider/init/shared_preferences.dart';
import 'package:eqmonitor/provider/setting/developer_mode.dart';
import 'package:eqmonitor/view/error.dart';
import 'package:eqmonitor/view/introduction_view.dart';
import 'package:eqmonitor/view/main/earthquake_history/earthquake_history_detail.dart';
import 'package:eqmonitor/view/main/settings.dart';
import 'package:eqmonitor/view/main_view.dart';
import 'package:eqmonitor/view/setting/about_app.dart';
import 'package:eqmonitor/view/setting/debug/debug_menu.dart';
import 'package:eqmonitor/view/setting/debug/eew_test.dart';
import 'package:eqmonitor/view/setting/debug_info.dart';
import 'package:eqmonitor/view/setting/design/intensity_color_choice.dart';
import 'package:eqmonitor/view/setting/design/theme.dart';
import 'package:eqmonitor/view/setting/design_settings.dart';
import 'package:eqmonitor/view/setting/notification_setting.dart';
import 'package:eqmonitor/view/setting/term_of_service.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final routerProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    routes: [
      GoRoute(
        path: '/introduction',
        builder: (context, state) => const IntroductionView(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const MainView(),
        routes: [
          GoRoute(
            path: 'earthquake_history_item/:eventId',
            builder: (context, state) {
              final eventID = int.tryParse(state.params['eventId']!);
              final telegrams =
                  ref.read(earthquakeHistoryFutureProvider).value![eventID]!;
              return EarthquakeHistoryDetailPage(telegrams: telegrams);
            },
          ),
        ],
      ),

      /// Settings
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsPage(),
        routes: [
          GoRoute(
            path: 'notification',
            builder: (context, state) => const NotificationSettingPage(),
          ),
          GoRoute(
            path: 'design',
            builder: (context, state) => const DesignSettingsPage(),
            routes: [
              GoRoute(
                path: 'theme',
                builder: (context, state) => const ThemeChoicePage(),
              ),
              GoRoute(
                path: 'intensity',
                builder: (context, state) => const IntensityColorSettingsPage(),
              ),
            ],
          ),
          GoRoute(
            path: 'appinfo',
            builder: (context, state) => const AboutAppPage(),
            routes: [
              GoRoute(
                path: 'termOfService/:doesShowAcceptButton',
                builder: (context, state) => TermOfServicePage(
                  showAcceptButton:
                      state.params['doesShowAcceptButton'] == 'true',
                ),
              ),
            ],
          ),
          GoRoute(
            path: 'debug',
            builder: (context, state) => const DebugMenuPage(),
            routes: [
              GoRoute(
                path: 'info',
                builder: (context, state) =>
                    (kDebugMode || ref.watch(developerModeProvider).isDeveloper)
                        ? const DeveloperDebugPage()
                        : ErrorScreen(Exception('デベロッパーモードが有効になっていません')),
              ),
              GoRoute(
                path: 'eew_test',
                builder: (context, state) => const EewTestPage(),
              )
            ],
          ),
        ],
      ),
    ],
    initialLocation:
        (ref.read(sharedPreferencesProvder).getBool('isInitializated') ?? false)
            ? '/'
            : '/introduction',
    errorBuilder: (context, state) => ErrorScreen(state.error!),
    urlPathStrategy: UrlPathStrategy.path,
    debugLogDiagnostics:
        kDebugMode || ref.watch(developerModeProvider).isDeveloper,
  ),
);
