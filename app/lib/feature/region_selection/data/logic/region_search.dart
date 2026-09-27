import 'package:eqmonitor/feature/region_selection/data/model/region_option.dart';
import 'package:unorm_dart/unorm_dart.dart' as unorm;

final class const RegionSearch() {
  String normalize(String value) => String.fromCharCodes(
    unorm
        .nfkc(value)
        .toLowerCase()
        .replaceAll(RegExp(r'\s+'), '')
        .runes
        .map(
          (code) => code >= 0x30a1 && code <= 0x30f6 ? code - 0x60 : code,
        ),
  );

  List<RegionOption> filter({
    required List<RegionOption> items,
    required String query,
    RegionKind? kind,
    RegionOption? parent,
  }) {
    final term = normalize(query);
    return items.where((item) {
      if (kind != null && item.kind != kind) {
        return false;
      }
      if (parent != null &&
          !(parent.kind == .prefecture && item.prefectureCode == parent.code) &&
          (item.parentKind != parent.kind || item.parentCode != parent.code)) {
        return false;
      }
      return term.isEmpty ||
          [
            item.name,
            item.kana,
            item.englishName,
            item.parentName,
          ].whereType<String>().any((value) => normalize(value).contains(term));
    }).toList();
  }
}
