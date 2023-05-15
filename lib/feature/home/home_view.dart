import 'package:eqmonitor/common/router/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EQMonitor'),
      ),
      body: Center(
        child: TextButton.icon(
          onPressed: () =>
              context.push(const EarthquakeHistoryRoute().location),
          icon: const Icon(
            Icons.arrow_forward_ios,
          ),
          label: const Text('EarthquakeHistory'),
        ),
      ),
    );
  }
}
