// ignore_for_file: avoid_eqmonitor_api_in_ui
import 'package:eqmonitor/core/component/decoration/warning_stripe_decoration.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/tsunami/ui/components/tsunami_warning_history_overlay.dart';
import 'package:eqmonitor/feature/tsunami/ui/utils/tsunami_warning_color.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TsunamiWarningStatusCard extends StatelessWidget {
  const TsunamiWarningStatusCard({required this.tsunami, super.key});

  final TsunamiState tsunami;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final color = designSystem.color;

    final maxKind = TsunamiWarningColor.resolveMaxKind(tsunami.forecastRegions);
    final isCanceled = tsunami.isCanceled;
    final isExpired = !tsunami.isActive && !tsunami.isCanceled;
    final showStripe =
        !isCanceled && !isExpired && maxKind != TsunamiWarningKind.forecast;

    final headerBg = isCanceled || isExpired
        ? color.surfaceRaised
        : TsunamiWarningColor.headerColor(maxKind);
    final headerFg = isCanceled || isExpired
        ? designSystem.textColor.primary
        : Colors.white;
    final headline = _resolveHeadline(tsunami.latestTelegrams);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: color.outlineSoft),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (showStripe)
              WarningStripeDecoration(
                colors: TsunamiWarningColor.stripeColors(maxKind),
              ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: headerBg,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      isCanceled
                          ? '解除済み'
                          : isExpired
                          ? '有効期限切れ'
                          : TsunamiWarningColor.displayName(maxKind),
                      style: TextStyle(
                        color: headerFg,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TsunamiWarningHistoryButton(tsunami: tsunami),
                ],
              ),
            ),
            if (headline != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                child: Text(
                  headline,
                  style: TextStyle(
                    fontSize: 14,
                    color: designSystem.textColor.primary,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
              child: Text(
                '最終更新: ${DateFormat('yyyy/MM/dd HH:mm').format(tsunami.updatedAt.toLocal())}',
                style: TextStyle(
                  fontSize: 12,
                  color: designSystem.textColor.secondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String? _resolveHeadline(List<LatestTelegram> telegrams) {
    for (final t in telegrams) {
      if (t.type == TelegramType.vtse41 && t.headline != null) {
        return t.headline;
      }
    }
    return null;
  }
}
