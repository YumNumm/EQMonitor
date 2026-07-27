import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/startup/startup_profiler_provider.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:eqmonitor/feature/parameter/data/repository/parameter_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'parameter_set_notifier.g.dart';

/// パラメータは Asset Pack が唯一のソースであるため、HTTP キャッシュ層
/// （`CachedNotifier`）は使わず、単純に [ParameterRepository.loadAsset] を
/// 呼び出すだけの Notifier とする。Pack 未取得/破損時は
/// `AssetPackNotReadyException` が [build] からそのまま `AsyncError` として
/// 伝播する（偽データへのフォールバックはしない）。
@Riverpod(keepAlive: true)
class ParameterSetNotifier extends _$ParameterSetNotifier {
  @override
  Future<ParameterSet> build() async {
    // 大きな JSON (≈10 MB) の転送コストで compute 化が逆効果になりうるため、
    // まず実データで所要時間を確認する。
    final sw = Stopwatch()..start();
    final repository = await ref.watch(parameterRepositoryProvider.future);
    final result = await repository.loadAsset();
    ref
        .read(startupProfilerProvider)
        .measure('parameter_load', sw.elapsedMicroseconds);
    return result;
  }

  /// Asset Pack を再読み込みし、パラメーターの state を更新する。
  ///
  /// 戻り値: マニフェストの `generated_at` が変化した場合は true。
  Future<bool> refresh() async {
    final previous = state.hasValue ? state.requireValue : null;
    ref.invalidateSelf();
    final next = await future;
    talker.info('[Parameter] パラメーターを再読み込みしました。');
    return previous == null ||
        previous.manifest.generatedAt != next.manifest.generatedAt;
  }
}
