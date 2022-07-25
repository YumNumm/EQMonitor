import 'package:eqmonitor/page/main/earthquake_history.dart';
import 'package:eqmonitor/page/main/kmoni_map.dart';
import 'package:eqmonitor/state/all_state.dart';
import 'package:flutter/material.dart';
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
    ref.read(kmoniMapController.notifier).onInit();
    ref.read(earthquakeHistoryNotifier.notifier).onInit();

    // FCM登録
    ref.read(firebaseCloudMessagingNotifier.notifier).onInit();
    ref.read(kmoniNotifier.notifier).onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('EQMonitor'),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex.value,
        onDestinationSelected: (i) => selectedIndex.value = i,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: '強震モニタ'),
          NavigationDestination(icon: Icon(Icons.history), label: '地震履歴'),
          NavigationDestination(icon: Icon(Icons.settings), label: '設定'),
        ],
      ),
      body: selectedIndex.value == 0
          ? const KmoniMap()
          : selectedIndex.value == 1
              ? EarthquakeHistoryPage()
              : const SettingsPage(),
    );
  }
}
