import 'package:collection/collection.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/feature/telegram_list/data/model/earthquake_body_diff.dart';
import 'package:material_ui/material_ui.dart';

/// 震度地域リスト（震度階級ごとにグループ化、差分注釈付き）
class IntensityRegionList extends StatelessWidget {
  const IntensityRegionList({
    required this.entries,
    this.prefectureMap,
    super.key,
  });

  final List<IntensityRegionDiffEntry> entries;

  /// 市区町村コード先頭2桁 → 都道府県名 のマップ（VXSE53用）
  final Map<String, String>? prefectureMap;

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return const SizedBox.shrink();
    }

    final intensityColors = context.designSystem.colorTheme.intensity;

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
              intensityColors: intensityColors,
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
    required this.intensityColors,
    this.prefectureMap,
  });

  final JmaIntensity intensity;
  final List<IntensityRegionDiffEntry> entries;
  final IntensityColors intensityColors;
  final Map<String, String>? prefectureMap;

  @override
  Widget build(BuildContext context) {
    final colorEntry = intensityColors.fromJmaIntensity(intensity);
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
              color: colorEntry.background,
              borderRadius: BorderRadius.circular(4),
            ),
            alignment: Alignment.center,
            child: Text(
              '${intensity.mainText}${intensity.suffix}',
              style: TextStyle(
                color: colorEntry.resolvedForeground,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                height: 1,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // 地域名リスト
          Expanded(
            child: switch (prefectureMap) {
              final prefectureMap? => _buildPrefectureGrouped(
                theme,
                prefectureMap,
              ),
              null => Wrap(
                spacing: 4,
                runSpacing: 2,
                children: [
                  for (final entry in entries) _RegionChip(entry: entry),
                ],
              ),
            },
          ),
        ],
      ),
    );
  }

  /// 都道府県でグループ化して表示
  Widget _buildPrefectureGrouped(
    ThemeData theme,
    Map<String, String> prefectureMap,
  ) {
    final byPrefecture = <String, List<IntensityRegionDiffEntry>>{};
    for (final entry in entries) {
      final prefCode = entry.code.length >= 2 ? entry.code.substring(0, 2) : '';
      (byPrefecture[prefCode] ??= []).add(entry);
    }

    // 都道府県コード順にソート
    final sortedPrefEntries = byPrefecture.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    return Wrap(
      spacing: 4,
      runSpacing: 2,
      children: [
        for (final prefEntry in sortedPrefEntries) ...[
          Text(
            prefectureMap[prefEntry.key] ?? prefEntry.key,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          for (final entry in prefEntry.value) _RegionChip(entry: entry),
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
