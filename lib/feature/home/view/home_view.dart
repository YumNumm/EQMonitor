import 'dart:convert';

import 'package:eqapi_schema/model/lat_lng.dart';
import 'package:eqmonitor/common/component/map/map.dart';
import 'package:eqmonitor/common/component/map/view_model/map_viemwodel.dart';
import 'package:eqmonitor/common/feature/map/provider/map_data_provider.dart';
import 'package:eqmonitor/common/provider/log/talker.dart';
import 'package:eqmonitor/feature/home/component/kmoni/kmoni_settings_dialog.dart';
import 'package:eqmonitor/feature/home/component/map/kmoni_map_widget.dart';
import 'package:eqmonitor/feature/home/providers/kmoni/viewmodel/kmoni_view_model.dart';
import 'package:eqmonitor/feature/home/providers/telegram_ws/provider/eew_telegram_provider.dart';
import 'package:eqmonitor/feature/home/providers/telegram_ws/provider/telegram_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheet/sheet.dart';
import 'package:talker_flutter/talker_flutter.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapKey = useMemoized(() => GlobalKey(debugLabel: 'HomeView'));
    final modalController = useMemoized(SheetController.new);
    useAnimationController();
    final state = ref.watch(mapDataProvider);
    useEffect(
      () {
        WidgetsBinding.instance.endOfFrame.then((_) {
          ref.read(mapDataProvider.notifier).initialize();
          ref.read(kmoniViewModelProvider.notifier).initialize();
        });
        return null;
      },
      [],
    );
    ref.listen(eewWsTelegramProvider, (previous, next) {
      final data = next.value;
      if (data != null) {
        // show dialog
        showDialog<void>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('電文を受信しました'),
              content: SingleChildScrollView(
                child: Text(
                  const JsonEncoder.withIndent(' ').convert(data.toJson()),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });
    if (state.projectedData == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }

    useEffect(
      () {
        WidgetsBinding.instance.endOfFrame.then((_) {
          ref.read(mapDataProvider.notifier).initialize();
          ref.read(kmoniViewModelProvider.notifier).initialize();
        });
        return null;
      },
      [mapKey],
    );
    return TalkerWrapper(
      talker: ref.watch(talkerProvider),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('EQMonitor'),
          actions: [
            IconButton(
              onPressed: () {
                ref.read(mapViewModelProvider(mapKey).notifier).animatedBounds([
                  const LatLng(45.8, 145.1),
                  const LatLng(30, 128.8),
                ]);
              },
              icon: const Icon(Icons.zoom_out_map),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => showDialog<void>(
            context: context,
            builder: (context) => const KmoniSettingsDialogWidget(),
          ),
          label: const Text('Kmoni Settings'),
          icon: const Icon(Icons.settings),
        ),
        body: _HomeBodyWidget(mapKey: mapKey),
      ),
    );
  }
}

class _HomeBodyWidget extends HookConsumerWidget {
  const _HomeBodyWidget({
    required this.mapKey,
  });

  final GlobalKey<State<StatefulWidget>> mapKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final moveController = useAnimationController();
    final scaleController = useAnimationController();
    useEffect(
      () {
        WidgetsBinding.instance.endOfFrame.then((_) {
          ref.read(mapViewModelProvider(mapKey).notifier)
            ..registerWidgetSize(
              context.size!,
            )
            ..registerAnimationControllers(
              moveController: moveController,
              scaleController: scaleController,
            )
            ..fitBounds([
              const LatLng(45.8, 145.1),
              const LatLng(30, 128.8),
            ]);
        });
        return null;
      },
      [mapKey],
    );
    return Stack(
      children: [
        // background
        Container(
          color: Color.lerp(
            Theme.of(context).colorScheme.background,
            Colors.blue,
            brightness == Brightness.light ? 0.3 : 0.15,
          ),
        ),
        ClipRRect(
          child: Stack(
            children: [
              BaseMapWidget(mapKey: mapKey),
              KmoniMapWidget(mapKey: mapKey),
              MapTouchHandlerWidget(mapKey: mapKey),
            ],
          ),
        ),
        SafeArea(
          child: ElevatedButton.icon(
            onPressed: () {
              ref.read(telegramWsProvider.notifier).requestSample();
            },
            icon: const Icon(Icons.abc),
            label: const Text('abc'),
          ),
        ),
      ],
    );
  }
}
