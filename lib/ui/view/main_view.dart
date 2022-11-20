import 'package:eqmonitor/provider/init/talker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'main/earthquake_history.dart';
import 'main/kmoni_map.dart';
import 'main/settings.dart';

class MainView extends HookConsumerWidget {
  const MainView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = useState(0);
    return Scaffold(
      bottomNavigationBar: RepaintBoundary(
        child: NavigationBar(
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
      ),
      body: TalkerWrapper(
        talker: ref.watch(talkerProvider),
        options: const TalkerWrapperOptions(
          enableErrorAlerts: true,
          errorTitle: 'エラーが発生しました',
          exceptionTitle: '例外が発生しました',
        ),
        child: Container(
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
            }
          })(),
        ),
      ),
    );
  }
}
