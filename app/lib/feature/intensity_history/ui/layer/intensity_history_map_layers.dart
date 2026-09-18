import 'package:eqmonitor/core/extension/async_value.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/city_max_intensity_provider.dart';
import 'package:eqmonitor/feature/intensity_history/ui/layer/intensity_fill_layer.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 市区町村別最大震度の取得状態に応じて MapLibre レイヤーを構成する。
///
/// 初回取得前は空のレイヤー更新を行わない。再取得中や再取得失敗時は
/// [AsyncValue] の previous value を使い、表示済みの塗りを維持する。
class IntensityHistoryMapLayers extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(cityMaxIntensityProvider).valueOrPrevious?.items;
    if (items == null) {
      return const SizedBox.shrink();
    }
    return IntensityFillLayer(items: items);
  }
}
