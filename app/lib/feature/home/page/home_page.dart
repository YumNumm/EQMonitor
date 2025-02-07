import 'package:eqmonitor/feature/home/component/map/home_map_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Stack(
        children: [
          HomeMapView(),
          // _Sheet(),
        ],
      ),
    );
  }
}
