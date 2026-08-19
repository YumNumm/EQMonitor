import 'package:eqmonitor/feature/start/data/model/forced_update_info_model.dart';
import 'package:eqmonitor/feature/start/data/notifier/start_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'forced_update_info_provider.g.dart';

/// UI 層がドメイン型のみを参照できるよう、
/// Start API レスポンスから強制アップデート判定情報のみを抽出したドメインモデルを返す。
@riverpod
AsyncValue<ForcedUpdateInfoModel> forcedUpdateInfo(Ref ref) {
  final state = ref.watch(startProvider);
  return state.whenData((response) => response.toForcedUpdateInfoModel());
}
