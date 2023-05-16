import 'package:eqmonitor/common/router/router.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DebugHomeView extends ConsumerWidget {
  const DebugHomeView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EQMonitor Debug Menu'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('地震履歴'),
              onTap: () => const EarthquakeHistoryRoute().push<void>(context),
              leading: const Icon(Icons.history),
            ),
            ListTile(
              title: const Text('ホーム画面に戻る'),
              onTap: () => const HomeRoute().push<void>(context),
              leading: const Icon(Icons.home),
            ),
          ],
        ),
      ),
    );
  }
}
