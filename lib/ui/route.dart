import 'package:eqmonitor/ui/view/setting/update_history_view/update_history_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider/init/shared_preferences.dart';
import '../provider/setting/developer_mode.dart';
import 'view/main/earthquake_history.viewmodel.dart';
import 'view/views.dart';

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

              final data =
                  ref.read(earthquakeHistoryViewModel).value!.firstWhere(
                        (element) => element.id == eventID,
                      );
              return EarthquakeHistoryDetailPage(item: data);
            },
          ),
          GoRoute(
            path: 'full_screen',
            builder: (context, state) {
              SystemChrome.setEnabledSystemUIMode(
                SystemUiMode.manual,
                overlays: [],
              );
              return KmoniMap(showAppBar: false);
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
              GoRoute(
                path: 'updateHistory',
                builder: (context, state) => const UpdateHistotyView(),
              )
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
    debugLogDiagnostics:
        kDebugMode || ref.watch(developerModeProvider).isDeveloper,
  ),
);
