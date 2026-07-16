import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/devices/data/notifier/push_token_sync_notifier.dart';
import 'package:eqmonitor/feature/devices/data/provider/notification_token_stream.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'push_token_sync_wiring.g.dart';

@Riverpod(keepAlive: true)
Future<void> pushTokenSyncWiring(Ref ref) async {
  final provisionStatus = await ref.watch(deviceProvisioningProvider.future);
  if (provisionStatus != DeviceProvisioningStatus.notRequired) {
    return;
  }

  // ノーティファイアの build() 完了を待つ
  await ref.read(pushTokenSyncProvider.future);
  final notifier = ref.read(pushTokenSyncProvider.notifier);

  ref.onDispose(notifier.disposeWorkers);

  ref.listen(notificationTokenStreamProvider, (_, next) {
    final token = next.value;
    if (token == null) {
      return;
    }
    notifier.accept(token);
  });
}
