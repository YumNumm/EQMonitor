import 'dart:convert';

import 'package:eqapi_schema/model/lat_lng.dart';
import 'package:eqmonitor/common/component/map/map.dart';
import 'package:eqmonitor/common/component/map/view_model/map_viewmodel.dart';
import 'package:eqmonitor/common/component/sheet/basic_modal_sheet.dart';
import 'package:eqmonitor/common/component/sheet/sheet_floating_action_buttons.dart';
import 'package:eqmonitor/common/feature/map/provider/map_data_provider.dart';
import 'package:eqmonitor/common/hook/use_sheet_controller.dart';
import 'package:eqmonitor/common/provider/log/talker.dart';
import 'package:eqmonitor/feature/home/component/kmoni/kmoni_settings_dialog.dart';
import 'package:eqmonitor/feature/home/component/map/kmoni_map_widget.dart';
import 'package:eqmonitor/feature/home/component/sheet/earthquake_history_widget.dart';
import 'package:eqmonitor/feature/home/component/sheet/status_widget.dart';
import 'package:eqmonitor/gen/fonts.gen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../features/eew/eew_provider.dart';
import '../features/kmoni/viewmodel/kmoni_view_model.dart';
import '../features/telegram_ws/provider/eew_telegram_provider.dart';
import '../features/telegram_ws/provider/telegram_provider.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapKey = useMemoized(() => GlobalKey(debugLabel: 'HomeView'));
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
    // デバッグ用
    // EEW WSが来た時にダイアログを表示
    if (kDebugMode) {
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
    // * 地図データが読み込まれるまでローディングを表示
    if (state.projectedData == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }
    return TalkerWrapper(
      talker: ref.watch(talkerProvider),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                'EQMonitor',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                'Beta',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontFamily: FontFamily.jetBrainsMono,
                    ),
              ),
            ],
          ),
          forceMaterialTransparency: true,
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
    final globalPointAndZoomLevelController = useAnimationController();
    // * mapViewModelへWidgetの各情報を登録しながら 初期化
    useEffect(
      () {
        WidgetsBinding.instance.endOfFrame.then((_) {
          // Widgetのサイズを登録
          final renderBox =
              mapKey.currentContext!.findRenderObject()! as RenderBox;
          ref.read(mapViewModelProvider(mapKey).notifier)
            ..registerRenderBox(
              renderBox,
            )
            ..registerAnimationControllers(
              moveController: moveController,
              scaleController: scaleController,
              globalPointAndZoomLevelController:
                  globalPointAndZoomLevelController,
            )
            ..fitBounds([
              const LatLng(45.8, 145.1),
              const LatLng(30, 128.8),
            ])
            ..applyBounds();
        });
        return null;
      },
      [mapKey],
    );
    final sheetController = useSheetController();
    return Stack(
      children: [
        // background
        Container(
          color: Color.lerp(
            Theme.of(context).colorScheme.background,
            Colors.blueAccent,
            brightness == Brightness.light ? 0.3 : 0.15,
          ),
        ),
        ClipRRect(
          key: mapKey,
          child: Stack(
            children: [
              BaseMapWidget(mapKey: mapKey),
              KmoniMapWidget(mapKey: mapKey),
              MapTouchHandlerWidget(mapKey: mapKey),
            ],
          ),
        ),
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (kDebugMode)
                ElevatedButton.icon(
                  onPressed: () {
                    ref.read(telegramWsProvider.notifier).requestSample();
                  },
                  label: const Text('request Sample Telegram'),
                  icon: const Icon(Icons.send),
                ),
              const SizedBox(height: 8),
              // PoCを変更
              ElevatedButton.icon(
                onPressed: () {
                  ref.read(mapViewModelProvider(mapKey).notifier)
                    ..setBounds([
                      const LatLng(35, 135),
                      const LatLng(36, 137),
                    ])
                    ..animatedApplyBounds();
                },
                icon: const Icon(Icons.settings),
                label: const Text('表示領域を変更'),
              ),
              // 表示領域をリセット
              ElevatedButton.icon(
                onPressed: () {
                  ref.read(mapViewModelProvider(mapKey).notifier)
                    ..reset()
                    ..animatedApplyBounds();
                },
                icon: const Icon(Icons.home),
                label: const Text('表示領域をリセット'),
              ),
            ],
          ),
        ),
        SheetFloatingActionButtons(
          controller: sheetController,
          fab: [
            FloatingActionButton.small(
              onPressed: () {
                ref
                    .read(mapViewModelProvider(mapKey).notifier)
                    .animatedApplyBounds();
              },
              backgroundColor: Colors.blueGrey,
              child: const Icon(Icons.home),
            ),
          ],
        ),
        // Sheet
        BasicModalSheet(
          controller: sheetController,
          children: [
            const SheetStatusWidget(),
            const SizedBox(height: 4),
            const EarthquakeHistorySheetWidget(),
            Text(
              ref.watch(eewTelegramProviderProvider).toString(),
            ),
            ListTile(
              title: const Text('強震モニタ設定'),
              onTap: () {
                showDialog<void>(
                  context: context,
                  builder: (context) => const KmoniSettingsDialogWidget(),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
