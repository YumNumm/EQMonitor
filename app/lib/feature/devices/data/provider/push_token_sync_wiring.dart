import 'dart:async';
import 'dart:ui';

import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/devices/data/model/notification_token.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/devices/data/notifier/push_token_sync_notifier.dart';
import 'package:eqmonitor/feature/devices/data/provider/notification_token_stream.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'push_token_sync_wiring.g.dart';

@Riverpod(keepAlive: true)
Future<void> pushTokenSyncStartup(Ref ref) async {
  // 起動時の provision が打ち切られた後も、resume のたびに未登録なら
  // やり直す (再起動やバナー操作を待たずに通知を受け取れるようにする)。
  ref.listen(appLifecycleProvider, (_, next) {
    if (next != AppLifecycleState.resumed) {
      return;
    }
    if (ref.read(DeviceProvisioningNotifier.provisionMutation)
        is MutationPending) {
      return;
    }
    final status = ref.read(deviceProvisioningProvider).value;
    if (status != DeviceProvisioningStatus.required) {
      return;
    }
    unawaited(
      DeviceProvisioningNotifier.provisionMutation
          .run(
            ref,
            (tsx) async =>
                tsx.get(deviceProvisioningProvider.notifier).provision(),
          )
          .catchError((Object error, StackTrace stackTrace) {
            talker.error(
              '[Provisioning] retry on resume failed',
              error,
              stackTrace,
            );
          }),
    );
  });

  await ref.watch(pushTokenSyncWiringProvider.future);
  final provisionStatus = await ref.read(deviceProvisioningProvider.future);
  if (provisionStatus == DeviceProvisioningStatus.required) {
    await DeviceProvisioningNotifier.provisionMutation.run(
      ref,
      (tsx) async => tsx.get(deviceProvisioningProvider.notifier).provision(),
    );
  }
}

@Riverpod(keepAlive: true)
Future<void> pushTokenSyncWiring(Ref ref) async {
  final provisionStatus = await ref.watch(deviceProvisioningProvider.future);
  if (provisionStatus != DeviceProvisioningStatus.notRequired) {
    return;
  }

  await ref.read(pushTokenSyncProvider.future);
  ref.listen(appLifecycleProvider, (_, next) {
    if (next == AppLifecycleState.resumed) {
      final token = ref.read(notificationTokenStreamProvider).value;
      if (token != null) {
        ref.read(pushTokenSyncProvider.notifier).accept(token);
      }
    }
  });
  ref.listen<AsyncValue<NotificationToken>>(notificationTokenStreamProvider, (
    _,
    next,
  ) {
    final token = next.value;
    if (token != null) {
      // Notifier は rebuild のたびに作り直されるため、毎回現在のものを取得する。
      // 取得を 1 度きりにすると、破棄済みの旧インスタンスへ渡してしまう。
      ref.read(pushTokenSyncProvider.notifier).accept(token);
    }
  }, fireImmediately: true);
}
