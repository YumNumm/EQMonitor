import 'package:eqmonitor/page/main/earthquake_history.dart';
import 'package:eqmonitor/page/main/intensity_estimate.dart';
import 'package:eqmonitor/page/main/kmoni_map.dart';
import 'package:eqmonitor/state/all_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'main/settings.dart';

class MainPage extends StatefulHookConsumerWidget {
  const MainPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  @override
  void initState() {
    // ref.read(travelTimeController.notifier).onInit();
    // ref.read(kmoniMapController.notifier).onInit();
    // ref.read(earthquakeHistoryController.notifier).onInit();
    // ref.read(eewHistoryController.notifier).onInit();

    // FCM登録
    //ref.read(firebaseCloudMessagingNotifier.notifier).onInit();
    // ref.read(kmoniController.notifier).onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);

    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('EQMonitor'),
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
                        ? const IntensityEstimatePage()
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
                                ? const IntensityEstimatePage()
                                : const SettingsPage(),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
