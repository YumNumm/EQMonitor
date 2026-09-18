import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:material_ui/material_ui.dart';

/// 近傍地震・市区町村詳細などで共通の地震一覧ソートチップ。
class EarthquakeSortChips extends StatelessWidget {
  const new({
    required this.sortBy,
    required this.sortOrder,
    required this.onChanged,
    super.key,
  });

  final EarthquakeSortBy sortBy;
  final SortOrder sortOrder;
  final ValueChanged<EarthquakeSortBy> onChanged;

  static const options = [
    (EarthquakeSortBy.eventId, '発生時刻'),
    (EarthquakeSortBy.magnitude, 'M'),
    (EarthquakeSortBy.maxIntensity, '最大震度'),
    (EarthquakeSortBy.depth, '深さ'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 4,
        children: [
          for (final (value, label) in options)
            FilterChip(
              selected: sortBy == value,
              showCheckmark: false,
              label: Row(
                mainAxisSize: MainAxisSize.min,
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
              onSelected: (_) => onChanged(value),
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
        ],
      ),
    );
  }
}
