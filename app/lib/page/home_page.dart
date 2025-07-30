import 'dart:math';

import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/sheet/basic_modal_sheet.dart';
import 'package:eqmonitor/core/provider/jma_code_table_provider.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/eew/data/eew_telegram.dart';
import 'package:eqmonitor/feature/home/ui/component/eew/eew_widget.dart';
import 'package:eqmonitor/feature/home/ui/component/map/home_map_view.dart';
import 'package:eqmonitor/feature/home/ui/component/shake-detect/shake_detection_card.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/home_earthquake_history_sheet.dart';
import 'package:eqmonitor/feature/shake_detection/provider/shake_detection_provider.dart';
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
          BasicModalSheet(child: _SheetBody()),
          _DebugButton(),
        ],
      ),
    );
  }
}

class _DebugButton extends StatelessWidget {
  const _DebugButton();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: FloatingActionButton.small(
        onPressed:
            () async => Navigator.of(context).push<void>(
              ModalBottomSheetRoute(
                isScrollControlled: false,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) => const _DebugModal(),
              ),
            ),
        child: const Icon(Icons.bug_report),
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
            const _ShakeDetectionList(),
            const HomeEarthquakeHistorySheet(),
            ListTile(
              title: const Text('津波情報'),
              leading: const Icon(Icons.tsunami),
              onTap: () async => const TsunamiHistoryRoute().push<void>(context),
            ),
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

class _ShakeDetectionList extends ConsumerWidget {
  const _ShakeDetectionList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shakeDetectionEvents = ref.watch(shakeDetectionProvider);

    return switch (shakeDetectionEvents) {
      AsyncData(:final value) when value.isNotEmpty => Column(
        children:
            value.map((event) => ShakeDetectionCard(event: event)).toList(),
      ),
      _ => const SizedBox.shrink(),
    };
  }
}

class _DebugModal extends ConsumerWidget {
  const _DebugModal();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('DEBUG')),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('ADD EEW SAMPLE'),
            onTap: () async {
              final eew = EewV1(
                id: Random().nextInt(1000000000),
                eventId: Random().nextInt(1000000000),
                type: 'type',
                schemaType: 'schemaType',
                status: 'TEST',
                infoType: 'infoType',
                reportTime: DateTime.now(),
                isCanceled: false,
                isLastInfo: Random().nextBool(),
                isWarning: Random().nextBool(),
                isPlum: Random().nextBool(),
                accuracy: null,
                serialNo: Random().nextInt(100),
                latitude: 30 + Random().nextDouble() * 10,
                longitude: 130 + Random().nextDouble() * 10,
                arrivalTime: DateTime.now(),
                hypoName: 'テスト震源地',
                magnitude: (Random().nextDouble() * 100).toInt() / 10,
                depth: Random().nextInt(15) * 10,
                originTime: DateTime.now(),
                forecastMaxIntensity:
                    JmaForecastIntensity.values[Random().nextInt(
                      JmaForecastIntensity.values.length,
                    )],
                regions:
                    [
                      for (final region
                          in ref.read(jmaCodeTableProvider).areaEpicenter.items)
                        () {
                          if (Random().nextDouble() > 0.9) {
                            return EstimatedIntensityRegion(
                              code: region.code,
                              name: region.name,
                              arrivalTime: null,
                              isPlum: false,
                              isWarning: false,
                              forecastMaxInt: ForecastMaxInt(
                                from: JmaForecastIntensity.one,
                                to:
                                    JmaForecastIntensityOver
                                        .values[Random().nextInt(
                                      JmaForecastIntensityOver.values.length,
                                    )],
                              ),
                              forecastMaxLgInt: ForecastMaxLgInt(
                                from: JmaForecastLgIntensity.one,
                                to:
                                    JmaForecastLgIntensityOver
                                        .values[Random().nextInt(
                                      JmaForecastLgIntensityOver.values.length,
                                    )],
                              ),
                            );
                          }
                        }(),
                    ].nonNulls.toList(),
              );
              print(eew.regions);
              ref.read(eewProvider.notifier).upsert(eew);
            },
          ),
        ],
      ),
    );
  }
}
