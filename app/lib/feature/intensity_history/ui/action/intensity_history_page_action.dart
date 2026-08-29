import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final intensityHistoryPageActionProvider = Provider(
  (_) => const IntensityHistoryPageAction(),
);

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
