import 'dart:async';

import 'package:eqmonitor/feature/devices/data/model/notification_token.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/devices/data/notifier/push_token_sync_notifier.dart';
import 'package:eqmonitor/feature/devices/data/provider/notification_token_stream.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'push_token_sync_wiring.g.dart';

@Riverpod(keepAlive: true)
Future<void> pushTokenSyncStartup(Ref ref) async {
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
  final notifier = ref.read(pushTokenSyncProvider.notifier);
  ref.listen<AsyncValue<NotificationToken>>(notificationTokenStreamProvider, (
    _,
    next,
  ) {
    final token = next.value;
    if (token != null) {
      notifier.accept(token);
    }
  }, fireImmediately: true);
}
