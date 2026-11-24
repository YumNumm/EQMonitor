import 'package:collection/collection.dart';
import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/telegram_list/data/model/earthquake_body_diff.dart';
import 'package:material_ui/material_ui.dart';

/// 震度地域リスト（震度階級ごとにグループ化、差分注釈付き）
class const IntensityRegionList({
  required final List<IntensityRegionDiffEntry> entries,

  /// 市区町村コード先頭2桁で都道府県ごとにグループ化するか。
  final bool groupByPrefecture = false,

  /// 市区町村コード先頭2桁 → 都道府県名 のマップ（VXSE53用）
  final Map<String, String>? prefectureMap,
  super.key,
}) extends StatelessWidget {
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
      crossAxisAlignment: .start,
      children: [
        for (final intensity in sortedKeys)
          if (grouped[intensity] case final entries?)
            _IntensityRow(
              intensity: intensity,
              entries: entries,
              groupByPrefecture: groupByPrefecture,
              prefectureMap: prefectureMap,
            ),
      ],
    );
  }
}

class const _IntensityRow({
  required final JmaIntensity intensity,
  required final List<IntensityRegionDiffEntry> entries,
  required final bool groupByPrefecture,
  final Map<String, String>? prefectureMap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: .start,
        children: [
          JmaIntensityIcon(intensity: intensity, type: .filled, size: 28),
          const SizedBox(width: 8),
          Expanded(
            child: groupByPrefecture
                ? _PrefectureRegionList(
                    entries: entries,
                    prefectureMap: prefectureMap,
                  )
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
}

class const _PrefectureRegionList({
  required final List<IntensityRegionDiffEntry> entries,
  required final Map<String, String>? prefectureMap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final byPrefecture = <String, List<IntensityRegionDiffEntry>>{};
    for (final entry in entries) {
      final prefCode = entry.code.length >= 2 ? entry.code.substring(0, 2) : '';
      (byPrefecture[prefCode] ??= []).add(entry);
    }

    final sortedPrefCodes = byPrefecture.keys.toList()..sort();

    return Column(
      crossAxisAlignment: .start,
      children: [
        for (final prefCode in sortedPrefCodes)
          if (byPrefecture[prefCode] case final entries?)
            _PrefectureRegionRow(
              prefectureName: prefectureMap?[prefCode] ?? prefCode,
              entries: entries,
            ),
      ],
    );
  }
}

class const _PrefectureRegionRow({
  required final String prefectureName,
  required final List<IntensityRegionDiffEntry> entries,
}) extends StatelessWidget {
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
            fontWeight: .bold,
          ),
        ),
        for (final entry in entries) _RegionChip(entry: entry),
      ],
    );
  }
}

class const _RegionChip({required final IntensityRegionDiffEntry entry})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final baseStyle =
        theme.textTheme.bodySmall ?? const TextStyle(fontSize: 12);
    final boldStyle = baseStyle.copyWith(fontWeight: .bold);

    return switch (entry.diffType) {
      IntensityDiffType.same => Text(entry.name, style: baseStyle),
      IntensityDiffType.added => Text.rich(
        TextSpan(
          children: [
            TextSpan(text: entry.name, style: boldStyle),
            TextSpan(
              text: '（追加）',
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
              text: '（震度${entry.previousIntensity?.label ?? ""}↑）',
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
              text: '（震度${entry.previousIntensity?.label ?? ""}↓）',
              style: boldStyle.copyWith(color: Colors.orange.shade800),
            ),
          ],
        ),
      ),
    };
  }
}
