import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:eqmonitor/feature/parameter/data/provider/parameter_provider.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'parameter_set_notifier.g.dart';

@Riverpod(keepAlive: true)
class ParameterSetNotifier extends _$ParameterSetNotifier {
  static final refreshMutation = Mutation<bool>();

  @override
  Future<ParameterSet> build() async {
    final repository = await ref.watch(parameterRepositoryProvider.future);
    return repository.load();
  }

  /// バックグラウンドでマニフェストを確認し、更新があればパラメーターを再取得して state を更新する。
  ///
  /// 戻り値: パラメーターが更新された場合は true。
  Future<bool> refresh() async {
    final repository = await ref.read(parameterRepositoryProvider.future);
    final updated = await repository.refresh();
    if (updated) {
      talker.info('[Parameter] パラメーターを更新しました。再読み込みします。');
      ref.invalidateSelf();
      await future;
    }
    return updated;
  }
}
