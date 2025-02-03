import 'dart:async';

import 'package:eqmonitor/core/api/api_authentication_notifier.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/component/sheet/basic_modal_sheet.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/notification_token.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history_early/ui/earthquake_history_early_screen.dart';
import 'package:eqmonitor/feature/home/component/eew/eew_widget.dart';
import 'package:eqmonitor/feature/home/component/parameter/parameter_loader_widget.dart';
import 'package:eqmonitor/feature/home/component/shake-detect/shake_detection_card.dart';
import 'package:eqmonitor/feature/home/component/sheet/earthquake_history_widget.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/components/kyoshin_monitor_maintenance_card.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/data/service/fcm_token_change_detector.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/data/service/notification_remote_authentication_service.dart';
import 'package:eqmonitor/feature/settings/features/notification_remote_settings/data/service/notification_remote_settings_migrate_service.dart';
import 'package:eqmonitor/feature/shake_detection/provider/shake_detection_provider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(
      () {
        // TODO(YumNumm): Refactor this code!
        unawaited(
          WidgetsBinding.instance.endOfFrame.then(
            (_) async {
              await () async {
                try {
                  talker.log('Start Initialize');
                  final token =
                      await ref.read(notificationTokenProvider.future);
                  talker.log('Token: ${token.toJson()}');
                  final fcmToken = token.fcmToken;
                  if (fcmToken == null) {
                    throw Exception('fcmToken is null');
                  }
                  talker.log('updateToken...');
                  await ref
                      .read(notificationRemoteAuthenticateServiceProvider)
                      .updateToken(fcmToken: fcmToken);
                  talker.log('updateToken... Done');
                  await ref
                      .read(fcmTokenChangeDetectorProvider.notifier)
                      .save(fcmToken);
                  talker.log('fcmTokenChangeDetectorProvider... Done');
                  final authenticationService =
                      ref.read(apiAuthenticationNotifierProvider.notifier);
                  final (
                    id: id,
                    role: role,
                  ) = await authenticationService.extractPayload();
                  talker.log(
                    'Authentication: id=$id, role=$role',
                  );
                  await FirebaseCrashlytics.instance.setUserIdentifier(id);
                  await FirebaseAnalytics.instance.setUserId(
                    id: id,
                  );
                  // ignore: avoid_catches_without_on_clauses
                } catch (e) {
                  talker.log(
                    'Authentication Error: $e',
                  );
                  await FirebaseCrashlytics.instance.recordError(
                    e,
                    StackTrace.current,
                  );
                  rethrow;
                }
              }();
            },
          ),
        );
        return null;
      },
      [],
    );

    return Scaffold(
      body: Stack(
        children: [
          MapLibreMap(
            minMaxZoomPreference: const MinMaxZoomPreference(
              0,
              10,
            ),
            initialCameraPosition: const CameraPosition(
              target: LatLng(35.681236, 139.767125),
              zoom: 5,
            ),
            styleString: 'https://v2.map.eqmonitor.app/style-dark.json',
            onMapCreated: (controller) {},
            onStyleLoadedCallback: () async {},
            rotateGesturesEnabled: false,
            tiltGesturesEnabled: false,
            trackCameraPosition: true,
          ),
          const _Sheet(),
        ],
      ),
    );
  }
}

class _Sheet extends ConsumerWidget {
  const _Sheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      bottom: false,
      child: BasicModalSheet(
        children: [
          const EewWidgets(),
          const KyoshinMonitorMaintenanceCardnceCard(),
          const _ShakeDetectionEvents(),
          const EarthquakeHistorySheetWidget(),
          const ParameterLoaderWidget(),
          ListTile(
            title: const Text('震度データベース'),
            subtitle: const Text(
              '震度データベースを用いて、より過去の地震情報を検索できます',
            ),
            leading: const Icon(Icons.history),
            onTap: () async =>
                const EarthquakeHistoryEarlyRoute().push<void>(context),
          ),
          const _NotificationMigrationWidget(),
          ListTile(
            title: const Text('地震・津波に関するお知らせ'),
            leading: const Icon(Icons.info),
            onTap: () async =>
                const InformationHistoryRoute().push<void>(context),
          ),
          ListTile(
            title: const Text('設定'),
            leading: const Icon(Icons.settings),
            onTap: () async => const SettingsRoute().push<void>(context),
          ),
          if (kDebugMode)
            ListTile(
              title: const Text('Debug'),
              leading: const Icon(Icons.bug_report),
              onTap: () async => const DebuggerRoute().push<void>(context),
            ),
          const SizedBox(height: 200),
        ],
      ),
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
