import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/component/sheet/basic_modal_sheet.dart';
import 'package:eqmonitor/core/map/controller/kyoshin_monitor_layer_controller.dart';
import 'package:eqmonitor/core/map/controller/layer_controller.dart';
import 'package:eqmonitor/core/map/model/camera_position.dart';
import 'package:eqmonitor/core/map/widget/declarative_map.dart';
import 'package:eqmonitor/feature/earthquake_history_early/ui/earthquake_history_early_screen.dart';
import 'package:eqmonitor/feature/home/component/eew/eew_widget.dart';
import 'package:eqmonitor/feature/home/component/parameter/parameter_loader_widget.dart';
import 'package:eqmonitor/feature/home/component/shake-detect/shake_detection_card.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/data/service/notification_remote_settings_migrate_service.dart';
import 'package:eqmonitor/feature/shake_detection/provider/shake_detection_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // レイヤーの監視
    final layerState = ref.watch(mapLayerControllerProvider);
    // 強震モニタレイヤーの監視
    final kyoshinLayer = ref.watch(kyoshinMonitorLayerControllerProvider);

    return const Scaffold(
      body: Stack(
        children: [
          DeclarativeMap(
            initialCameraPosition: MapCameraPosition(
              target: LatLng(35.681236, 139.767125),
            ),
          ),
        ],
      ),
    );
  }
}

class _Sheet extends HookConsumerWidget {
  const _Sheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const BasicModalSheet(
      children: [
        // 緊急地震速報
        EewWidgets(),
        SizedBox(height: 8),
        // 強震モニタ
        ParameterLoaderWidget(),
        SizedBox(height: 8),
        // 履歴
        BorderedContainer(
          child: EarthquakeHistoryEarlyScreen(),
        ),
      ],
    );
  }
}

class _ShakeDetectionEvents extends ConsumerWidget {
  const _ShakeDetectionEvents();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(shakeDetectionProvider);
    return switch (state) {
      AsyncData(:final value) => Column(
          children: [
            for (final e in value)
              Padding(
                padding: const EdgeInsets.all(4),
                child: ShakeDetectionCard(
                  event: e,
                ),
              ),
          ],
        ),
      _ => const SizedBox.shrink(),
    };
  }
}

class _NotificationMigrationWidget extends ConsumerWidget {
  const _NotificationMigrationWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state =
        ref.watch(notificationRemoteSettingsInitialSetupNotifierProvider);
    return switch (state) {
      AsyncError(:final error) => BorderedContainer(
          elevation: 1,
          child: ListTile(
            title: const Text('通知設定の初期化に失敗しました。アプリケーションを再起動することで 再度初期化を試みます。'),
            subtitle: Text(error.runtimeType.toString()),
            leading: const Icon(Icons.error),
          ),
        ),
      AsyncData(:final value) => switch (value) {
          NotificationRemoteSettingsSetupState.initial ||
          NotificationRemoteSettingsSetupState.completed =>
            const SizedBox.shrink(),
          _ => BorderedContainer(
              elevation: 1,
              child: switch (value) {
                NotificationRemoteSettingsSetupState.waitingForFcmToken =>
                  const ListTile(
                    title: Text('通知配信用トークンの取得中...'),
                    leading: CircularProgressIndicator.adaptive(),
                  ),
                NotificationRemoteSettingsSetupState.registering =>
                  const ListTile(
                    title: Text('通知配信用トークンの登録中...'),
                    leading: CircularProgressIndicator.adaptive(),
                  ),
                NotificationRemoteSettingsSetupState.migrating =>
                  const ListTile(
                    title: Text('通知設定の初期化中...'),
                    leading: CircularProgressIndicator.adaptive(),
                  ),
                NotificationRemoteSettingsSetupState.unsubscribingOldTopics =>
                  const ListTile(
                    title: Text('旧通知設定の解除中'),
                    leading: CircularProgressIndicator.adaptive(),
                  ),
                NotificationRemoteSettingsSetupState.completing =>
                  const ListTile(
                    title: Text('通知設定のセットアップが完了しました'),
                    leading: Icon(Icons.check),
                  ),
                _ => const SizedBox.shrink(),
              },
            ),
        },
      _ => const ListTile(
          title: Text('通知設定の移行中'),
          leading: CircularProgressIndicator.adaptive(),
        ),
    };
  }
}
