import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'main/earthquake_history.dart';
import 'main/kmoni_map.dart';
import 'main/settings.dart';

class MainView extends HookConsumerWidget {
  const MainView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = useState(0);
    return OrientationBuilder(
      builder: (context, orientation) {
        final isWide = orientation == Orientation.landscape;
        final mainViewExpandedKey = GlobalKey();

        return Scaffold(
          bottomNavigationBar: isWide
              ? null
              : NavigationBar(
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
                      icon: Icon(Icons.settings),
                      label: '設定',
                    ),
                  ],
                ),
          body: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isWide) ...[
                SafeArea(
                  child: NavigationRail(
                    labelType: NavigationRailLabelType.selected,
                    onDestinationSelected: (i) {
                      HapticFeedback.selectionClick();
                      selectedIndex.value = i;
                    },
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
                        icon: Icon(Icons.settings),
                        label: Text('設定'),
                      ),
                    ],
                    selectedIndex: selectedIndex.value,
                  ),
                ),
                const VerticalDivider(thickness: 1, width: 1),
              ],
              Expanded(
                key: mainViewExpandedKey,
                child: (() {
                  switch (selectedIndex.value) {
                    case 0:
                      return KmoniMap();
                    case 1:
                      return EarthquakeHistoryPage();
                    // case 2:
                    //   return IntensityEstimatePage();
                    case 2:
                      return const SettingsPage();
                    default:
                      throw StateError(
                        'Invalid index: ${selectedIndex.value}',
                      );
                  }
                })(),
              ),
            ],
          ),
        );
      },
    );
  }
}
