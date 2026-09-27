import 'package:eqmonitor/feature/region_selection/data/model/region_option.dart';

final class const RegionMapMatcher() {
  List<RegionOption> administrative({
    required List<RegionOption> catalog,
    required RegionKind kind,
    required String code,
    RegionOption? parent,
  }) {
    final matchingCode = kind == .prefecture
        ? catalog
              .where((item) => item.kind == .city && item.code == code)
              .firstOrNull
              ?.prefectureCode
        : code;
    return catalog
        .where(
          (item) =>
              item.kind == kind &&
              item.code == matchingCode &&
              (parent == null ||
                  (parent.kind == .prefecture &&
                      item.prefectureCode == parent.code) ||
                  (item.parentKind == parent.kind &&
                      item.parentCode == parent.code)),
        )
        .toList();
  }

  List<RegionOption> epicenters({
    required List<RegionOption> catalog,
    required Iterable<num> ids,
  }) {
    final codes = ids
        .where((id) => id.isFinite && id == id.truncateToDouble())
        .map((id) => id.toInt())
        .toSet();
    return catalog
        .where(
          (item) =>
              item.kind == .epicenter &&
              codes.contains(int.tryParse(item.code)),
        )
        .toList();
  }
}
