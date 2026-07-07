import 'package:eqmonitor/core/provider/cached_notifier.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/startup/startup_profiler_provider.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:eqmonitor/feature/parameter/data/repository/parameter_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'parameter_set_notifier.g.dart';

@Riverpod(keepAlive: true)
class ParameterSetNotifier extends _$ParameterSetNotifier
    with CachedNotifier<ParameterSet> {
  @override
  Future<ParameterSet> build() async {
    // 大きな JSON (≈10 MB) の転送コストで compute 化が逆効果になりうるため、
    // まず実データで所要時間を確認する。
    final sw = Stopwatch()..start();
    final repository = await ref.watch(parameterRepositoryProvider.future);
    try {
      final result = await cachedBuild();
      ref
          .read(startupProfilerProvider)
          .measure('parameter_load', sw.elapsedMicroseconds);
      return result;
    } on Exception catch (e, st) {
      talker.warning(
        '[Parameter] API/キャッシュからの読み込みに失敗したため、同梱パラメータを使用します。',
        e,
        st,
      );
      final result = await repository.loadAsset();
      ref
          .read(startupProfilerProvider)
          .measure('parameter_load', sw.elapsedMicroseconds);
      return result;
    }
  }

  @override
  Future<ParameterSet> fetch(api.ApiClient client) async {
    final repository = await ref.read(parameterRepositoryProvider.future);
    return repository.fetch(client);
  }

  /// バックグラウンドでマニフェストを確認し、更新があればパラメーターを再取得して state を更新する。
  ///
  /// 戻り値: パラメーターが更新された場合は true。
  Future<bool> refresh() async {
    ref.invalidateSelf();
    await future;
    talker.info('[Parameter] パラメーターを再読み込みしました。');
    return true;
  }
}
