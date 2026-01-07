import 'package:eqmonitor/core/provider/user_id.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'setup_completed.g.dart';

/// 初期設定が完了しているかどうかを判定するProvider
/// userIdが存在する場合は初期設定完了とみなす
@Riverpod(keepAlive: true)
class SetupCompleted extends _$SetupCompleted {
  @override
  Future<bool> build() async {
    final userId = await ref.watch(userIdProvider.future);
    return userId != null;
  }

  /// 初期設定を完了としてマークする
  void markCompleted() {
    state = const AsyncData(true);
  }
}
