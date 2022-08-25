import 'package:eqmonitor/provider/earthquake/eew_controller.dart';
import 'package:eqmonitor/provider/kmoni_controller.dart';
import 'package:eqmonitor/provider/setting/developer_mode.dart';
import 'package:eqmonitor/widget/updater.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'main/earthquake_history.dart';
import 'main/intensity_estimate.dart';
import 'main/kmoni_map.dart';
import 'main/settings.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = useState(0);

    return Stack(
      children: [
        OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('EQMonitor'),
                  actions: [
                    if (kDebugMode ||
                        ref.watch(isDeveloperModeAllowedProvider) == true)
                      IconButton(
                        icon: const Icon(Icons.settings),
                        onPressed: () {
                          ref.read(kmoniProvider.notifier).startTestCase();
                          ref.read(eewHistoryProvider.notifier).startTestcase();
                        },
                      ),
                  ],
                  leading: (ref.watch(isDeveloperModeAllowedProvider) == true)
                      ? const Icon(Icons.lock_open)
                      : null,
                ),
                bottomNavigationBar: NavigationBar(
                  selectedIndex: selectedIndex.value,
                  onDestinationSelected: (i) {
                    HapticFeedback.selectionClick();

                    selectedIndex.value = i;
                  },
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.home),
                      label: '強震モニタ',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.history),
                      label: '地震履歴',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.calculate),
                      label: '震度計算',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.settings),
                      label: '設定',
                    ),
                  ],
                ),
                body: selectedIndex.value == 0
                    ? const KmoniMap()
                    : selectedIndex.value == 1
                        ? EarthquakeHistoryPage()
                        : selectedIndex.value == 2
                            ? IntensityEstimatePage()
                            : const SettingsPage(),
              );
            } else {
              return Scaffold(
                body: SafeArea(
                  child: Row(
                    children: [
                      NavigationRail(
                        labelType: NavigationRailLabelType.all,
                        destinations: const [
                          NavigationRailDestination(
                            icon: Icon(Icons.home),
                            label: Text('強震モニタ'),
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.history),
                            label: Text('地震履歴'),
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.calculate),
                            label: Text('震度計算'),
                          ),
                          NavigationRailDestination(
                            icon: Icon(Icons.settings),
                            label: Text('設定'),
                          ),
                        ],
                        selectedIndex: selectedIndex.value,
                        onDestinationSelected: (i) => selectedIndex.value = i,
                      ),
                      Expanded(
                        child: selectedIndex.value == 0
                            ? const KmoniMap()
                            : selectedIndex.value == 1
                                ? EarthquakeHistoryPage()
                                : selectedIndex.value == 2
                                    ? IntensityEstimatePage()
                                    : const SettingsPage(),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
        // 破壊的なアップデートがある場合のダイアログ
        const UpdaterWidget(),
      ],
    );
  }
}
