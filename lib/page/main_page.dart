import 'package:eqmonitor/provider/package_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider/setting/developer_mode.dart';
import '../widget/updater.dart';
import 'main/earthquake_history.dart';
import 'main/intensity_estimate.dart';
import 'main/kmoni_map.dart';
import 'main/settings.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = useState(0);
    return Banner(
      message: 'DEVELOP',
      location: BannerLocation.bottomStart,
      child: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return Scaffold(
              appBar: AppBar(
                title: FittedBox(
                  child: Row(
                    textBaseline: TextBaseline.alphabetic,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      const Text(
                        'EQMonitor',
                      ),
                      const SizedBox(width: 5),
                      ref.watch(packageInfoProvider).when<Widget>(
                            loading: () => const SizedBox.shrink(),
                            error: (error, stack) => const SizedBox.shrink(),
                            data: (data) => Text(
                              'V${data.version}',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                    ],
                  ),
                ),
                actions: [
                  if (kDebugMode ||
                      ref.watch(developerModeProvider).isDeveloper == true)
                    IconButton(
                      icon: const Icon(Icons.settings_ethernet),
                      onPressed: () => context.push('/settings/debug/eew_test'),
                    ),
                  const UpdaterButtonWidget(),
                ],
                leading: (ref.watch(developerModeProvider).isDeveloper)
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
    );
  }
}
