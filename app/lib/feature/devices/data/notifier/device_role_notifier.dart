import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/device_id.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/devices/data/model/device_role.dart';
import 'package:eqmonitor/feature/devices/data/notifier/device_provisioning_notifier.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_repository.dart';
import 'package:eqmonitor/feature/devices/data/repository/device_role_cache_repository.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_role_notifier.g.dart';

/// このデバイスのロール。
///
/// 端末に保存した前回の取得結果を使い、毎起動では問い合わせない。
/// 保存値が Admin のときだけ、取り消しを反映するため起動時に取得し直す。
/// 未登録・未取得・取得失敗は null を返す。権限判定に使うため、
/// 取得できない場合に権限ありへフォールバックしない。
@Riverpod(keepAlive: true)
class DeviceRoleNotifier extends _$DeviceRoleNotifier {
  @override
  Future<DeviceRole?> build() async {
    final provisioning = await ref.watch(deviceProvisioningProvider.future);
    if (provisioning != DeviceProvisioningStatus.notRequired) {
      return null;
    }
    // 再登録で端末 ID が変わったら、前の端末のロールを引き継がない。
    try {
      await ref.watch(deviceIdProvider.future);
    } on Object {
      return null;
    }
    final stored = await ref.watch(deviceRoleCacheRepositoryProvider).read();
    if (stored != DeviceRole.admin) {
      return stored;
    }
    return fetch(repository: await ref.watch(deviceRepositoryProvider.future));
  }

  /// サーバーからロールを取得し、成功した値だけを端末に保存する。
  Future<DeviceRole?> fetch({required DeviceRepository repository}) async {
    switch (await repository.getDeviceRole()) {
      case Success(:final value):
        await ref.read(deviceRoleCacheRepositoryProvider).write(value);
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

  static final refreshMutation = Mutation<void>();

  /// 保存値に関係なくロールを取得し直す。失敗時は現在の状態を維持する。
  Future<void> refresh() async {
    final provisioning = await ref.read(deviceProvisioningProvider.future);
    if (provisioning != DeviceProvisioningStatus.notRequired) {
      return;
    }
    final role = await fetch(
      repository: await ref.read(deviceRepositoryProvider.future),
    );
    if (role != null && ref.mounted) {
      state = AsyncData(role);
    }
  }
}
