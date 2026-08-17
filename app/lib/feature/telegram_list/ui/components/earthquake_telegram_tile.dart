import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/model/telegram/telegram_type.dart';
import 'package:eqmonitor/feature/telegram_list/data/model/earthquake_body_diff.dart';
import 'package:eqmonitor/feature/telegram_list/data/model/earthquake_telegram_body_model.dart';
import 'package:eqmonitor/feature/telegram_list/data/model/telegram_comments_model.dart';
import 'package:eqmonitor/feature/telegram_list/data/model/telegram_item.dart';
import 'package:eqmonitor/feature/telegram_list/data/repository/earthquake_body_diff_calculator.dart';
import 'package:eqmonitor/feature/telegram_list/ui/components/hypocenter_summary.dart';
import 'package:eqmonitor/feature/telegram_list/ui/components/intensity_region_list.dart';
import 'package:extensions/extensions.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

/// 電文タイプ別地震情報リッチタイル
///
/// VXSE51〜53, VXSE61, VXSE62 の電文タイプに応じて
/// 震源サマリや震度地域リストの表示を切り替える。
class EarthquakeTelegramTile extends ConsumerWidget {
  const EarthquakeTelegramTile({
    required this.telegram,
    required this.body,
    required this.sequenceNumber,
    this.previousBody,
    this.comments,
    super.key,
  });

  /// 電文メタ情報
  final TelegramItem telegram;

  /// 電文コメント
  final TelegramCommentsModel? comments;

  /// 地震情報本文（EARTHQUAKE 型）
  final EarthquakeTelegramBodyModel body;

  /// 報番号（1-based、1 = 初報）
  final int sequenceNumber;

  /// 前報の本文（差分表示用、初報の場合は null）
  final EarthquakeTelegramBodyModel? previousBody;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final designSystem = context.designSystem;
    final dateFormat = DateFormat('yyyy/MM/dd HH:mm:ss');
    final diffCalculator = ref.watch(earthquakeBodyDiffCalculatorProvider);

    final currentRegions = switch (telegram.type) {
      .vxse51 => body.intensityRegions,
      .vxse53 => body.intensityCities ?? body.intensityRegions,
      .vxse62 => body.intensityRegions,
      _ => null,
    };
    final previousRegions = switch (telegram.type) {
      .vxse51 => previousBody?.intensityRegions,
      .vxse53 =>
        previousBody?.intensityCities ?? previousBody?.intensityRegions,
      .vxse62 => previousBody?.intensityRegions,
      _ => null,
    };
    final intensityPrefectures = body.intensityPrefectures;
    final prefectureMap =
        intensityPrefectures == null || intensityPrefectures.isEmpty
        ? null
        : {
            for (final prefecture in intensityPrefectures)
              prefecture.code: prefecture.name,
          };

    final regionDiff = currentRegions == null
        ? null
        : diffCalculator.computeIntensityRegionDiff(
            current: currentRegions,
            previous: previousRegions,
          );

    final hypocenterDiff = diffCalculator.computeHypocenterDiff(
      current: body.quake,
      previous: previousBody?.quake,
    );

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: .start,
          spacing: 4,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    telegram.title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (sequenceNumber > 1) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: designSystem.colorTheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '#$sequenceNumber',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: designSystem.colorTheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            Text(telegram.headline?.toHalfWidth ?? ''),
            Text(
              '発表: ${dateFormat.format(telegram.pressAt.toLocal())}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: designSystem.colorTheme.onSurfaceVariant,
              ),
            ),
            _EarthquakeTelegramTileContent(
              telegramType: telegram.type,
              body: body,
              regionDiff: regionDiff,
              hypocenterDiff: hypocenterDiff,
              prefectureMap: prefectureMap,
            ),
            Text(
              {
                    'text': comments?.text,
                    'free': comments?.free,
                    'warning': comments?.warning,
                    'forecast': comments?.forecast,
                    'additional': comments?.additional,
                  }.entries
                  .where((entry) => entry.value != null)
                  .map((entry) => '${entry.key}: ${entry.value}')
                  .join('\n')
                  .toHalfWidth,
              style: theme.textTheme.bodySmall?.copyWith(
                color: designSystem.colorTheme.onSurfaceVariant,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EarthquakeTelegramTileContent extends StatelessWidget {
  const _EarthquakeTelegramTileContent({
    required this.telegramType,
    required this.body,
    required this.regionDiff,
    required this.hypocenterDiff,
    required this.prefectureMap,
  });

  final TelegramType telegramType;
  final EarthquakeTelegramBodyModel body;
  final List<IntensityRegionDiffEntry>? regionDiff;
  final HypocenterDiff? hypocenterDiff;
  final Map<String, String>? prefectureMap;

  @override
  Widget build(BuildContext context) {
    final quake = body.quake;

    return switch (telegramType) {
      .vxse51 => switch (regionDiff) {
        final entries? => IntensityRegionList(entries: entries),
        null => const SizedBox.shrink(),
      },
      .vxse52 =>
        quake != null
            ? HypocenterSummary(quake: quake, diff: hypocenterDiff)
            : const SizedBox.shrink(),
      .vxse53 => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (quake != null)
            HypocenterSummary(quake: quake, diff: hypocenterDiff),
          if (quake != null && regionDiff != null) const SizedBox(height: 8),
          if (regionDiff case final entries?)
            IntensityRegionList(
              entries: entries,
              groupByPrefecture: true,
              prefectureMap: prefectureMap,
            ),
        ],
      ),
      .vxse61 =>
        quake != null
            ? HypocenterSummary(quake: quake, diff: hypocenterDiff)
            : const SizedBox.shrink(),
      .vxse62 => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (quake != null)
            HypocenterSummary(quake: quake, diff: hypocenterDiff),
          if (quake != null && regionDiff != null) const SizedBox(height: 8),
          if (regionDiff case final entries?)
            IntensityRegionList(entries: entries),
        ],
      ),
      _ => const SizedBox.shrink(),
    };
  }
}
