import 'dart:math';

import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/sheet/basic_modal_sheet.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/eew/data/eew_telegram.dart';
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
        onPressed: () async => Navigator.of(context).push<void>(
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
              final random = Random();
              final eew = EewItemWithRelations(
                eventId: DateTime.now().toString().replaceAll(
                  RegExp('[^0-9]'),
                  '',
                ),
                type: TelegramType.vxse45,
                status: TelegramStatus.normal,
                infoType: TelegramInfoType.publication,
                serialNo: random.nextInt(100) + 1,
                headline: 'XX沖で地震 XX地方では強い揺れに警戒',
                isCanceled: false,
                isLastInfo: random.nextBool(),
                isWarning: random.nextBool(),
                isPlum: random.nextBool(),
                originTime: DateTime.now(),
                arrivalTime: DateTime.now(),
                hypocenter: EewHypocenter(
                  value: const CodeName(code: '000', name: 'テスト震源地'),
                  coordinates: Coordinate.latLng(
                    latitude: 30 + random.nextDouble() * 10,
                    longitude: 130 + random.nextDouble() * 10,
                  ),
                  magnitude: 5 + random.nextDouble() * 3,
                  depth: 10 + random.nextInt(100),
                ),
                forecastIntensity: EewIntensity(
                  maxIntensity: EewIntensityValue(
                    value: IntensityValue
                        .values[random.nextInt(IntensityValue.values.length)],
                    isOver: random.nextBool(),
                  ),
                  maxLpgmIntensity: EewIntensityLpgmValue(
                    value:
                        LpgmIntensityValue.values[random.nextInt(
                          LpgmIntensityValue.values.length,
                        )],
                    isOver: random.nextBool(),
                  ),
                  regions: [],
                ),
                accuracy: EewAccuracy(
                  epicenters: [random.nextInt(4)],
                  depth: random.nextInt(4),
                  magnitudeCalculation: random.nextInt(4),
                  numberOfMagnitudeCalculation: random.nextInt(10),
                ),
                editorialOffice: '気象庁',
                reportTime: DateTime.now(),
              );
              ref.read(eewProvider.notifier).upsert(eew);
            },
          ),
        ],
      ),
    );
  }
}
