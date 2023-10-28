import 'package:eqmonitor/core/component/map/base_map.dart';
import 'package:eqmonitor/core/component/map/map_touch_handler_widget.dart';
import 'package:eqmonitor/core/component/map/model/map_config.dart';
import 'package:eqmonitor/core/component/map/view_model/map_viewmodel.dart';
import 'package:eqmonitor/core/component/sheet/basic_modal_sheet.dart';
import 'package:eqmonitor/core/component/sheet/sheet_floating_action_buttons.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/config/debug/debug_attempt.dart';
import 'package:eqmonitor/feature/home/component/eew/eew_widget.dart';
import 'package:eqmonitor/feature/home/component/map/eew_estimated_intensity_widget.dart';
import 'package:eqmonitor/feature/home/component/map/eew_hypocenter_widget.dart';
import 'package:eqmonitor/feature/home/component/map/eew_pswave_arrival_circle.dart';
import 'package:eqmonitor/feature/home/component/map/kmoni_map_widget.dart';
import 'package:eqmonitor/feature/home/component/sheet/debug_widget.dart';
import 'package:eqmonitor/feature/home/component/sheet/earthquake_history_widget.dart';
import 'package:eqmonitor/feature/home/component/sheet/status_widget.dart';
import 'package:eqmonitor/feature/home/features/debugger/debugger_provider.dart';
import 'package:eqmonitor/feature/home/features/kmoni/viewmodel/kmoni_view_model.dart';
import 'package:eqmonitor/feature/home/features/kmoni/viewmodel/kmoni_view_settings.dart';
import 'package:eqmonitor/feature/home/features/kmoni/widget/kmoni_maintenance_widget.dart';
import 'package:eqmonitor/feature/home/features/telegram_ws/provider/telegram_provider.dart';
import 'package:eqmonitor/feature/home/viewmodel/home_viewmodel.dart';
import 'package:eqmonitor/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheet/src/sheet.dart';
import 'package:talker_flutter/talker_flutter.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(homeViewModelProvider);
    final mapKey = vm.mapKey;
    final debugAttemptCount = useState(0);

    useEffect(
      () {
        WidgetsBinding.instance.endOfFrame.then((_) {
          ref.read(kmoniViewModelProvider.notifier).initialize();
        });
        return null;
      },
      [mapKey],
    );
    // * 地図データが読み込まれるまでローディングを表示

    return TalkerWrapper(
      talker: ref.watch(talkerProvider),
      child: Scaffold(
        appBar: AppBar(
          title: GestureDetector(
            onDoubleTap: () async {
              debugAttemptCount.value++;
              if (debugAttemptCount.value >= 5) {
                final result = await DebugAttempt.attempt(context);
                if (result) {
                  await ref
                      .read(debuggerProvider.notifier)
                      .setDebugger(value: true);
                }
              }
            },
            child: Row(
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
                const SizedBox(width: 4),
                Text(
                  'Beta',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontFamily: FontFamily.jetBrainsMono,
                      ),
                ),
              ],
            ),
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
    final vm = ref.watch(homeViewModelProvider);
    final moveController = useAnimationController();
    final scaleController = useAnimationController();
    final globalPointAndZoomLevelController = useAnimationController();
    // * mapViewModelへWidgetの各情報を登録しながら 初期化
    void init() {
      // Widgetのサイズを登録
      final renderBox = mapKey.currentContext!.findRenderObject()! as RenderBox;
      ref.read(mapViewModelProvider(mapKey).notifier)
        ..registerRenderBox(
          renderBox,
        )
        ..registerAnimationControllers(
          moveController: moveController,
          scaleController: scaleController,
          globalPointAndZoomLevelController: globalPointAndZoomLevelController,
        )
        ..resetMarkAsMoved()
        ..applyBounds();
    }

    useEffect(
      () {
        WidgetsBinding.instance.endOfFrame.then((_) => init());
        return null;
      },
      [],
    );
    final sheetController = vm.sheetController;
    final mediaQuery = MediaQuery.of(context);

    useEffect(
      () {
        ref.read(homeViewModelProvider).height = mediaQuery.size.height -
            (mediaQuery.padding.top + mediaQuery.padding.bottom) -
            kToolbarHeight;
        return null;
      },
      [context],
    );
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        (isDark ? MapColorScheme.dark() : MapColorScheme.light())
            .backgroundColor;

    final child = Stack(
      children: [
        // background color
        Container(
          color: backgroundColor,
        ),
        RepaintBoundary(
          child: ClipRRect(
            key: mapKey,
            child: Stack(
              children: [
                RepaintBoundary(child: BaseMapWidget.polygon(mapKey)),
                RepaintBoundary(
                  child: EewPsWaveArrivalCircleWidget.gradient(mapKey: mapKey),
                ),
                RepaintBoundary(
                  child: EewEstimatedIntensityWidget(mapKey: mapKey),
                ),
                RepaintBoundary(child: BaseMapWidget.polyline(mapKey)),
                if (ref.watch(
                  kmoniSettingsProvider.select((value) => value.useKmoni),
                ))
                  RepaintBoundary(child: KmoniMapWidget(mapKey: mapKey)),
                RepaintBoundary(
                  child: EewPsWaveArrivalCircleWidget.border(mapKey: mapKey),
                ),
                RepaintBoundary(child: EewHypocenterWidget(mapKey: mapKey)),
                MapTouchHandlerWidget(mapKey: mapKey),
              ],
            ),
          ),
        ),
        RepaintBoundary(
          child: Stack(
            children: [
              SheetFloatingActionButtons(
                controller: sheetController,
                fab: [
                  FloatingActionButton.small(
                    heroTag: 'request',
                    onPressed: () {
                      ref.read(telegramWsProvider.notifier).requestSample();
                    },
                    elevation: 4,
                    child: const Icon(Icons.send),
                  ),
                  FloatingActionButton.small(
                    heroTag: 'home',
                    onPressed: () {
                      final height = mediaQuery.size.height -
                          (mediaQuery.padding.top + mediaQuery.padding.bottom) -
                          kToolbarHeight;
                      ref.read(mapViewModelProvider(mapKey).notifier)
                        ..resetMarkAsMoved()
                        ..animatedApplyBounds(
                          padding: const EdgeInsets.all(8).add(
                            EdgeInsets.only(
                              bottom: switch (sheetController.animation.value) {
                                < 0.3 =>
                                  height * sheetController.animation.value,
                                _ => height * 0.3,
                              },
                            ),
                          ),
                        );
                    },
                    elevation: 4,
                    child: const Icon(Icons.home),
                  ),
                ],
              ),
              // Sheet
              _Sheet(sheetController: sheetController),
            ],
          ),
        ),
      ],
    );

    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (notification) {
        WidgetsBinding.instance.endOfFrame.then(
          (_) => ref.read(mapViewModelProvider(mapKey).notifier)
            ..resetMarkAsMoved()
            ..applyBounds(),
        );
        return false;
      },
      child: SizeChangedLayoutNotifier(
        child: child,
      ),
    );
  }
}

class _Sheet extends ConsumerWidget {
  const _Sheet({
    required this.sheetController,
  });

  final SheetController sheetController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDebugMode = ref.watch(debuggerProvider);

    return RepaintBoundary(
      child: BasicModalSheet(
        controller: sheetController,
        children: [
          const EewWidgets(),
          const SheetStatusWidget(),
          const KmoniMaintenanceWidget(),
          const EarthquakeHistorySheetWidget(),
          ListTile(
            title: const Text('強震モニタ設定'),
            leading: const Icon(Icons.settings),
            onTap: () => context.push(const KmoniRoute().location),
          ),
          ListTile(
            title: const Text('震度配色設定'),
            leading: const Icon(Icons.color_lens),
            onTap: () => context.push(const ColorSchemeConfigRoute().location),
          ),
          if (isDebugMode.isDebugger || isDebugMode.isDeveloper)
            const DebugWidget(),
        ],
      ),
    );
  }
}
