import 'package:eqmonitor/feature/devices/data/model/device_role.dart';
import 'package:eqmonitor/feature/devices/data/provider/device_role_provider.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_eew_estimation_debug_notifier.dart';
import 'package:eqmonitor/feature/settings/features/debug/debug_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_eew_estimation_debug_provider.g.dart';

/// ホーム画面の推計震度・到達予想時刻の表示設定を変更できるかどうか。
///
/// Device API のロールが Admin であり、かつデバッグモードが有効な場合のみ true。
@riverpod
Future<bool> isHomeEewEstimationDebugAvailable(Ref ref) async {
  final isDebugEnabled = await ref.watch(debugProvider.future);
  if (!isDebugEnabled) {
    return false;
  }
  final role = await ref.watch(deviceRoleProvider.future);
  return role == DeviceRole.admin;
}

/// ホーム画面のEEWカードに推計震度・到達予想時刻を表示するかどうか。
///
/// 設定が有効でも、変更権限を失った場合は表示しない。
/// EEW 受信中にロール取得の API 呼び出しを発生させないため、
/// ローカルに保存された設定を先に確認する。
@riverpod
Future<bool> isHomeEewEstimationVisible(Ref ref) async {
  final isEnabled = await ref.watch(homeEewEstimationDebugProvider.future);
  if (!isEnabled) {
    return false;
  }
  return ref.watch(isHomeEewEstimationDebugAvailableProvider.future);
}
