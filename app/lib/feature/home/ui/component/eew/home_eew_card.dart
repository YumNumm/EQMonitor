import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/eew/ui/hook/eew_estimated_regions_stale_cache_hook.dart';
import 'package:eqmonitor/feature/home/data/provider/home_eew_estimation_debug_provider.dart';
import 'package:eqmonitor/feature/home/ui/component/eew/eew_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// ホーム画面に表示するEEWカード。
///
/// デバッグ設定が有効な場合のみ、JMAが現在地の予想震度を発表していないときの
/// フォールバックとして、距離減衰式による推計震度とS波到達予想時刻を表示する。
class HomeEewCard extends HookConsumerWidget {
  const new({required this.eew, required this.index, super.key});

  final EewTelegramItem eew;
  final String? index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEstimationVisible =
        ref.watch(isHomeEewEstimationVisibleProvider).value ?? false;
    final estimatedRegions = EewEstimatedRegionsStaleCacheHook.use(
      ref: ref,
      eew: eew,
      isEnabled: isEstimationVisible,
    );

    return EewCard(eew: eew, index: index, estimatedRegions: estimatedRegions);
  }
}
