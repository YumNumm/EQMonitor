import 'dart:async';

import 'package:eqmonitor/core/component/map/model/map_config.dart';
import 'package:eqmonitor/core/component/sheet/basic_modal_sheet.dart';
import 'package:eqmonitor/core/component/sheet/sheet_floating_action_buttons.dart';
import 'package:eqmonitor/core/hook/use_sheet_controller.dart';
import 'package:eqmonitor/core/provider/config/notification/fcm_topic_manager.dart';
import 'package:eqmonitor/core/provider/config/permission/permission_status_provider.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/home/component/eew/eew_widget.dart';
import 'package:eqmonitor/feature/home/component/sheet/earthquake_history_widget.dart';
import 'package:eqmonitor/feature/home/component/sheet/status_widget.dart';
import 'package:eqmonitor/feature/home/component/sheet/update_widget.dart';
import 'package:eqmonitor/feature/home/features/kmoni/viewmodel/kmoni_view_model.dart';
import 'package:eqmonitor/feature/home/features/kmoni/widget/kmoni_maintenance_widget.dart';
import 'package:eqmonitor/feature/home/features/map/map_widget.dart';
import 'package:eqmonitor/feature/home/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheet/sheet.dart';
import 'package:talker_flutter/talker_flutter.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(homeViewModelProvider);
    final mapKey = vm.mapKey;

    useEffect(
      () {
        WidgetsBinding.instance.endOfFrame.then((_) {
          unawaited(
            (
              ref.read(kmoniViewModelProvider.notifier).initialize(),
              ref.read(permissionProvider.notifier).initialize()
            ).wait,
          );
          ref.read(fcmTopicManagerProvider.notifier).setup().ignore();
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
          title: Text(
            'EQMonitor',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
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
    final sheetController = useSheetController();
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final backgroundColor =
        (isDark ? MapColorScheme.dark() : MapColorScheme.light())
            .backgroundColor;

    final child = Stack(
      children: [
        // background color
        Container(
          color: backgroundColor,
        ),
        const MainMapWidget(),
        RepaintBoundary(
          child: Stack(
            children: [
              SheetFloatingActionButtons(
                controller: sheetController,
                fab: [
                  FloatingActionButton.small(
                    heroTag: 'home',
                    onPressed: () {},
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
    return child;
  }
}

class _Sheet extends StatelessWidget {
  const _Sheet({
    required this.sheetController,
  });

  final SheetController sheetController;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: BasicModalSheet(
        controller: sheetController,
        children: [
          const EewWidgets(),
          const SheetStatusWidget(),
          const KmoniMaintenanceWidget(),
          const UpdateWidget(),
          const EarthquakeHistorySheetWidget(),
          ListTile(
            title: const Text('設定'),
            leading: const Icon(Icons.settings),
            onTap: () => context.push(const SettingsRoute().location),
          ),
        ],
      ),
    );
  }
}
