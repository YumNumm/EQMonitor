import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'main/earthquake_history.dart';
import 'main/intensity_estimate.dart';
import 'main/kmoni_map.dart';
import 'main/settings.dart';

class MainView extends HookConsumerWidget {
  const MainView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = useState(0);
    return Banner(
      message: 'DEVELOP',
      location: BannerLocation.bottomStart,
      child: Scaffold(
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
        body: (() {
          switch (selectedIndex.value) {
            case 0:
              return const KmoniMap();
            case 1:
              return EarthquakeHistoryPage();
            case 2:
              return IntensityEstimatePage();
            case 3:
              return const SettingsPage();
          }
        })(),
      ),
    );
  }
}
