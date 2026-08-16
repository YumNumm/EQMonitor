import 'package:collection/collection.dart';
import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/telegram_list/data/model/earthquake_body_diff.dart';
import 'package:flutter/material.dart';

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
    this.prefectureMap,
  });

  final JmaIntensity intensity;
  final List<IntensityRegionDiffEntry> entries;
  final Map<String, String>? prefectureMap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          JmaIntensityIcon(intensity: intensity, type: .filled, size: 28),
          const SizedBox(width: 8),
          Expanded(
            child: switch (prefectureMap) {
              final prefectureMap? => _PrefectureRegionList(
                entries: entries,
                prefectureMap: prefectureMap,
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
}

class _PrefectureRegionList extends StatelessWidget {
  const _PrefectureRegionList({
    required this.entries,
    required this.prefectureMap,
  });

  final List<IntensityRegionDiffEntry> entries;
  final Map<String, String> prefectureMap;

  @override
  Widget build(BuildContext context) {
    final byPrefecture = <String, List<IntensityRegionDiffEntry>>{};
    for (final entry in entries) {
      final prefCode = entry.code.length >= 2 ? entry.code.substring(0, 2) : '';
      (byPrefecture[prefCode] ??= []).add(entry);
    }

    final sortedPrefCodes = byPrefecture.keys.toList()..sort();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final prefCode in sortedPrefCodes)
          if (byPrefecture[prefCode] case final entries?)
            _PrefectureRegionRow(
              prefectureName: prefectureMap[prefCode] ?? prefCode,
              entries: entries,
            ),
      ],
    );
  }
}

class _PrefectureRegionRow extends StatelessWidget {
  const _PrefectureRegionRow({
    required this.prefectureName,
    required this.entries,
  });

  final String prefectureName;
  final List<IntensityRegionDiffEntry> entries;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Wrap(
      spacing: 4,
      runSpacing: 2,
      children: [
        Text(
          prefectureName,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        for (final entry in entries) _RegionChip(entry: entry),
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
