import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/feature/ads/data/flow/ads_opt_out_flow.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 広告 opt-out 前に Pro へ誘導する販促ボトムシート。
///
/// `AdsOptOutPromoSheet.show(context)` で表示する。
class AdsOptOutPromoSheet extends ConsumerWidget {
  const AdsOptOutPromoSheet({super.key});

  static Future<void> show(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AdsOptOutPromoSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorTheme = context.designSystem.colorTheme;
    final flow = ref.watch(adsOptOutFlowProvider);
    final isProFeaturesEnabled = ref
        .watch(buildConfigProvider)
        .isProFeaturesEnabled;

    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: colorTheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: colorTheme.outlineVariant,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            Text(
              'EQMonitor の運営を支援する',
              style: textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Text(
              'EQMonitor は、サーバー代と開発費を広告収入でまかなっています。 '
              'EQMonitor Pro なら広告非表示に加えて、通知地点の拡張などの特典も '
              'ご利用いただけます。\n'
              '広告なしのまま無料で続けることも可能です。',
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            if (isProFeaturesEnabled) ...[
              FilledButton(
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () async => flow.showPaywall(ref, context),
                child: const Text('EQMonitor Pro を見る'),
              ),
              const SizedBox(height: 8),
            ],
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () async => flow.continueWithoutAds(ref, context),
              child: const Text('広告なしで続ける（無料）'),
            ),
            const SizedBox(height: 4),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('キャンセル'),
            ),
          ],
        ),
      ),
    );
  }
}
