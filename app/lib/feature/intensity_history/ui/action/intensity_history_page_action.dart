import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'intensity_history_page_action.g.dart';

@Riverpod(keepAlive: true)
IntensityHistoryPageAction intensityHistoryPageAction(Ref ref) =>
    const IntensityHistoryPageAction();

class IntensityHistoryPageAction {
  const new();

  Future<void> retryMapConfiguration(WidgetRef ref) async {
    try {
      ref.invalidate(mapConfigurationProvider, asReload: true);
      await ref.read(mapConfigurationProvider.future);
    } on Object {
      // provider のエラー状態を画面に反映するため、Future の例外は伝播させない。
    }
  }
}
