import 'package:collection/collection.dart';
import 'package:eqmonitor/core/component/sheet/basic_modal_sheet.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/home/ui/component/eew/eew_card.dart';
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
    final state = ref.watch(eewAliveTelegramProvider) ?? [];

    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: state.reversed
                  .mapIndexed(
                    (index, element) => EewCard(
                      eew: element,
                      index: (state.length > 1) ? '${index + 1}' : null,
                    ),
                  )
                  .toList(),
            ),
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
