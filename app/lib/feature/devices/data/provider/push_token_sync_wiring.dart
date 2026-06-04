import 'dart:async';

import 'package:eqmonitor/feature/devices/data/model/push_token_sync_snapshot.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/devices/data/notifier/push_token_sync_notifier.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'push_token_sync_wiring.g.dart';

@Riverpod(keepAlive: true)
Future<void> pushTokenSyncWiring(Ref ref) async {
  final provisionStatus = await ref.watch(deviceProvisioningProvider.future);
  if (provisionStatus != DeviceProvisioningStatus.notRequired) {
    return;
  }

  ref.listen<AsyncValue<PushTokenSyncSnapshot>>(
    pushTokenSyncProvider,
    (_, next) {
      final snapshot = next.value;
      if (snapshot == null || !snapshot.hasPending) {
        return;
      }
      final mutation = PushTokenSyncNotifier.syncMutation;
      if (ref.read(mutation) is MutationPending) {
        return;
      }
      unawaited(
        mutation.run(
          ref,
          (tsx) async => tsx.get(pushTokenSyncProvider.notifier).sync(),
        ),
      );
    },
  );
}
