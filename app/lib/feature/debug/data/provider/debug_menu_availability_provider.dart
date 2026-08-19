import 'package:eqmonitor/core/model/environment.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/feature/devices/data/model/device_role.dart';
import 'package:eqmonitor/feature/devices/data/provider/device_role_provider.dart';
import 'package:eqmonitor/feature/settings/features/debug/debug_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_menu_availability_provider.g.dart';

/// デバッグメニューを開いてよいかを判定する。
///
/// 判定順:
/// 1. デバッグビルドなら常に許可
/// 2. Device API のロールが [DeviceRole.admin] なら、ローカルのデバッグモード設定や
///    BETA 配布かどうかに関係なく許可する。一般配布ビルド
///    ([BuildConfig.isDeveloperUiEnabled] が false)では、デバッグモードを ON に
///    するトグル自体がデバッグメニュー内にしか無いため、これが管理者の唯一の経路。
/// 3. それ以外は [BuildConfig.isDeveloperUiEnabled] かつ
///    (BETA 配布 または デバッグモード ON)
///
/// [role] が null(未登録・取得失敗)のときに権限ありへフォールバックしない。
bool resolveDebugMenuAvailability({
  required bool isDebugBuild,
  required DeviceRole? role,
  required BuildConfig buildConfig,
  required bool isDebugEnabled,
}) {
  if (isDebugBuild) {
    return true;
  }
  if (role == DeviceRole.admin) {
    return true;
  }
  if (!buildConfig.isDeveloperUiEnabled) {
    return false;
  }
  return buildConfig.isBetaTesting || isDebugEnabled;
}

/// デバッグメニュー(`/settings/debug` 配下)を開いてよいか。
///
/// 判定ロジックは [resolveDebugMenuAvailability] を参照。
///
/// go_router の `redirect` から同期的に読むため、非同期依存は
/// [AsyncValue.value] を参照する。ロール取得前は null 扱いで権限なし側に倒れ、
/// 取得完了後に再評価される。
///
/// keepAlive にしているのは、`redirect` の単発の [Ref.read] で
/// 非同期依存が未解決のまま false と判定され、正当な遷移が弾かれるのを防ぐため。
@Riverpod(keepAlive: true)
bool isDebugMenuAvailable(Ref ref) => resolveDebugMenuAvailability(
  isDebugBuild: kDebugMode,
  role: ref.watch(deviceRoleProvider).value,
  buildConfig: ref.watch(buildConfigProvider),
  isDebugEnabled: ref.watch(debugProvider).value ?? false,
);
