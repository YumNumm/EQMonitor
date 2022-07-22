import 'package:eqmonitor/page/main/earthquake_history.dart';
import 'package:eqmonitor/page/main/kmoni_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        ],
      ),
      body:
          selectedIndex.value == 0 ? const KmoniMap() : EarthquakeHistoryPage(),
    );
  }
}
