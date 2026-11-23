import 'package:eqmonitor/core/util/haptic.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:material_ui/material_ui.dart';

/// 近傍地震・市区町村詳細などで共通の地震一覧ソートチップ。
class const EarthquakeSortChips({
  required final EarthquakeSortBy sortBy,
  required final SortOrder sortOrder,
  required final ValueChanged<EarthquakeSortBy> onChanged,
  final bool showRegionalIntensity = false,
  super.key,
}) extends StatelessWidget {
  static const options = [
    (EarthquakeSortBy.eventId, '発生時刻'),
    (EarthquakeSortBy.magnitude, 'M'),
    (EarthquakeSortBy.maxIntensity, '最大震度'),
    (EarthquakeSortBy.depth, '深さ'),
  ];

  @override
  Widget build(BuildContext context) {
    final availableOptions = [
      if (showRegionalIntensity) (EarthquakeSortBy.regionalIntensity, '観測震度'),
      ...options,
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 4,
        children: [
          for (final (value, label) in availableOptions)
            FilterChip(
              selected: sortBy == value,
              showCheckmark: false,
              label: Row(
                mainAxisSize: .min,
                children: [
                  Text(label),
                  if (sortBy == value) ...[
                    const SizedBox(width: 2),
                    Icon(switch (sortOrder) {
                      .asc => Icons.arrow_upward,
                      .desc => Icons.arrow_downward,
                    }, size: 14),
                  ],
                ],
              ),
              onSelected: (_) => HapticUtil.selection(() => onChanged(value)),
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: .shrinkWrap,
            ),
        ],
      ),
    );
  }
}
