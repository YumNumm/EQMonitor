import 'package:collection/collection.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/feature/telegram_list/data/model/earthquake_body_diff.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 震度地域リスト（震度階級ごとにグループ化、差分注釈付き）
class IntensityRegionList extends ConsumerWidget {
  const IntensityRegionList({
    required this.entries,
    this.prefectureMap,
    super.key,
  });

  final List<IntensityRegionDiffEntry> entries;

  /// 市区町村コード先頭2桁 → 都道府県名 のマップ（VXSE53用）
  final Map<String, String>? prefectureMap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (entries.isEmpty) {
      return const SizedBox.shrink();
    }

    final intensityColor = ref.watch(intensityColorProvider);

    // 震度階級ごとにグループ化
    final grouped = groupBy<IntensityRegionDiffEntry, JmaIntensity>(
      entries,
      (e) => e.intensity,
    );

    // 震度降順でソート
    final sortedKeys = grouped.keys.toList()
      ..sort((a, b) => b.orderIndex.compareTo(a.orderIndex));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final intensity in sortedKeys)
          if (grouped[intensity] case final entries?)
            _IntensityRow(
              intensity: intensity,
              entries: entries,
              intensityColor: intensityColor,
              prefectureMap: prefectureMap,
            ),
      ],
    );
  }
}

class _IntensityRow extends StatelessWidget {
  const _IntensityRow({
    required this.intensity,
    required this.entries,
    required this.intensityColor,
    this.prefectureMap,
  });

  final JmaIntensity intensity;
  final List<IntensityRegionDiffEntry> entries;
  final IntensityColorModel intensityColor;
  final Map<String, String>? prefectureMap;

  @override
  Widget build(BuildContext context) {
    final color = intensityColor.fromJmaIntensity(intensity);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 震度バッジ
          Container(
            width: 36,
            height: 22,
            decoration: BoxDecoration(
              color: color.background,
              borderRadius: BorderRadius.circular(4),
            ),
            alignment: Alignment.center,
            child: Text(
              '${intensity.mainText}${intensity.suffix}',
              style: TextStyle(
                color: color.foreground,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                height: 1,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // 地域名リスト
          Expanded(
            child: prefectureMap != null
                ? _buildPrefectureGrouped(theme)
                : Wrap(
                    spacing: 4,
                    runSpacing: 2,
                    children: [
                      for (final entry in entries) _RegionChip(entry: entry),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  /// 都道府県でグループ化して表示
  Widget _buildPrefectureGrouped(ThemeData theme) {
    final byPrefecture = <String, List<IntensityRegionDiffEntry>>{};
    for (final entry in entries) {
      final prefCode = entry.code.length >= 2 ? entry.code.substring(0, 2) : '';
      (byPrefecture[prefCode] ??= []).add(entry);
    }

    // 都道府県コード順にソート
    final sortedPrefCodes = byPrefecture.keys.toList()..sort();

    return Wrap(
      spacing: 4,
      runSpacing: 2,
      children: [
        for (final prefCode in sortedPrefCodes) ...[
          Text(
            prefectureMap![prefCode] ?? prefCode,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          for (final entry in byPrefecture[prefCode]!)
            _RegionChip(entry: entry),
        ],
      ],
    );
  }
}

class _RegionChip extends StatelessWidget {
  const _RegionChip({required this.entry});

  final IntensityRegionDiffEntry entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final baseStyle =
        theme.textTheme.bodySmall ?? const TextStyle(fontSize: 12);
    final boldStyle = baseStyle.copyWith(fontWeight: FontWeight.bold);

    return switch (entry.diffType) {
      IntensityDiffType.same => Text(entry.name, style: baseStyle),
      IntensityDiffType.added => Text.rich(
        TextSpan(
          children: [
            TextSpan(text: entry.name, style: boldStyle),
            TextSpan(
              text: '(追加)',
              style: boldStyle.copyWith(color: Colors.blue.shade700),
            ),
          ],
        ),
      ),
      IntensityDiffType.upgraded => Text.rich(
        TextSpan(
          children: [
            TextSpan(text: entry.name, style: boldStyle),
            TextSpan(
              text: '(震度${entry.previousIntensity?.label ?? ""}↑)',
              style: boldStyle.copyWith(color: Colors.orange.shade800),
            ),
          ],
        ),
      ),
      IntensityDiffType.downgraded => Text.rich(
        TextSpan(
          children: [
            TextSpan(text: entry.name, style: boldStyle),
            TextSpan(
              text: '(震度${entry.previousIntensity?.label ?? ""}↓)',
              style: boldStyle.copyWith(color: Colors.orange.shade800),
            ),
          ],
        ),
      ),
    };
  }
}
