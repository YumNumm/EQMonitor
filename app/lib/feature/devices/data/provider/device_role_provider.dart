import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/devices/data/model/device_role.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_role_provider.g.dart';

/// このデバイスに紐づくユーザーのロール。
///
/// デバイス未登録時・取得失敗時・ロール未提供時は null を返す。
/// 権限判定に使うため、取得できない場合に権限ありへフォールバックしない。
@Riverpod(keepAlive: true)
Future<DeviceRole?> deviceRole(Ref ref) async {
  final provisioning = await ref.watch(deviceProvisioningProvider.future);
  if (provisioning != DeviceProvisioningStatus.notRequired) {
    return null;
  }

  final repository = await ref.watch(deviceRepositoryProvider.future);
  switch (await repository.getDeviceRole()) {
    case Success(:final value):
      return value;
    case Failure(:final exception, :final stackTrace):
      talker.warning(
        '[DeviceRole] failed to fetch role',
        exception,
        stackTrace,
      );
      return null;
  }
}
