import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';

/// 地震一覧のソートチップの選択状態。
///
/// 同じ項目を再タップすると昇順/降順を入れ替え、別項目を選ぶと
/// その項目の初期順（深さは昇順、それ以外は降順）にする。
class EarthquakeSortSelection {
  const new({
    required this.sortBy,
    required this.sortOrder,
  });

  final EarthquakeSortBy sortBy;
  final SortOrder sortOrder;

  EarthquakeSortSelection selecting(EarthquakeSortBy value) {
    if (sortBy == value) {
      return EarthquakeSortSelection(
        sortBy: sortBy,
        sortOrder: switch (sortOrder) {
          .asc => .desc,
          .desc => .asc,
        },
      );
    }
    return EarthquakeSortSelection(
      sortBy: value,
      sortOrder: switch (value) {
        .depth => .asc,
        _ => .desc,
      },
    );
  }
}
