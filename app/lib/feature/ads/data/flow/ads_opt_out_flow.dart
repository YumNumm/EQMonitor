import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/ads/data/notifier/ads_opt_out_notifier.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ads_opt_out_flow.g.dart';

@riverpod
AdsOptOutFlow adsOptOutFlow(Ref ref) => AdsOptOutFlow();

/// 広告 opt-out / Paywall 導線をまとめた Flow。
class AdsOptOutFlow {
  /// 「EQMonitor Pro を見る」を選んだとき。
  /// ボトムシートを閉じてから Paywall へ遷移する。
  Future<void> showPaywall(WidgetRef ref, BuildContext context) async {
    Navigator.of(context).pop();
    if (!context.mounted) {
      return;
    }
    await const PaywallRoute().push<void>(context);
  }

  /// 「広告なしで続ける（無料）」を選んだとき。
  /// opt-out フラグを true にしてシートを閉じる。
  Future<void> continueWithoutAds(
    WidgetRef ref,
    BuildContext context,
  ) async {
    await AdsOptOutNotifier.saveMutation.run(
      ref,
      (tsx) async => tsx.get(adsOptOutProvider.notifier).setOptOut(value: true),
    );
    if (!context.mounted) {
      return;
    }
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('広告を非表示にしました')),
    );
  }
}
