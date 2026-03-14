import 'package:eqmonitor/core/component/sheet/basic_modal_sheet.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/home/ui/component/eew/eew_widget.dart';
import 'package:eqmonitor/feature/home/ui/component/map/home_map_view.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/home_earthquake_history_sheet.dart';
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
          BasicModalSheet(
            child: _SheetBody(),
          ),
        ],
      ),
    );
  }
}

class _SheetBody extends ConsumerWidget {
  const _SheetBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const EewWidgets(),
            const HomeEarthquakeHistorySheet(),
            ListTile(
              title: const Text('設定'),
              leading: const Icon(Icons.settings),
              onTap: () async => const SettingsRoute().push<void>(context),
            ),
            ListTile(
              title: const Text('デバッグページ'),
              leading: const Icon(Icons.bug_report),
              onTap: () async => const DebugRoute().push<void>(context),
            ),
          ],
        ),
      ),
    );
  }
}
