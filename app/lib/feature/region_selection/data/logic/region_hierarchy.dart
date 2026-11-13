import 'package:eqmonitor/feature/region_selection/data/model/region_option.dart';

/// 都道府県 → 細分化地域 → 市区町村 の階層で地域を辿るための絞り込み。
final class const RegionHierarchy() {
  /// カタログに含まれる地域が属する都道府県を、カタログの並び順で返す。
  ///
  /// 都道府県を選択肢に持たないカタログでも辿れるよう、各地域が持つ
  /// 都道府県コード・名称から組み立てる。
  List<RegionOption> prefectures(List<RegionOption> catalog) {
    final result = <String, RegionOption>{};
    for (final item in catalog) {
      if (item.kind == .prefecture) {
        result[item.code] = item;
      } else if ((item.prefectureCode, item.prefectureName) case (
        final code?,
        final name?,
      )) {
        result.putIfAbsent(
          code,
          () => RegionOption(kind: .prefecture, code: code, name: name),
        );
      }
    }
    return result.values.toList();
  }

  /// [option] が一覧に現れる階層（都道府県・細分化地域）を返す。
  ///
  /// 選択済みの地域がある状態で開いたとき、その地域が見える階層から始める。
  ({RegionOption? prefecture, RegionOption? region}) location({
    required List<RegionOption> catalog,
    required RegionOption? option,
  }) {
    if (option == null) {
      return (prefecture: null, region: null);
    }
    final prefectureCode = option.kind == .prefecture
        ? option.code
        : option.prefectureCode;
    final prefecture = prefectures(
      catalog,
    ).where((item) => item.code == prefectureCode).firstOrNull;
    if (prefecture == null || option.kind != .city) {
      return (prefecture: prefecture, region: null);
    }
    final region = catalog
        .where(
          (item) =>
              item.kind == .region &&
              option.parentKind == .region &&
              item.code == option.parentCode,
        )
        .firstOrNull;
    return (prefecture: prefecture, region: region);
  }

  List<RegionOption> regions({
    required List<RegionOption> catalog,
    required RegionOption prefecture,
  }) => catalog
      .where(
        (item) =>
            item.kind == .region && item.prefectureCode == prefecture.code,
      )
      .toList();

  List<RegionOption> cities({
    required List<RegionOption> catalog,
    required RegionOption region,
  }) => catalog
      .where(
        (item) =>
            item.kind == .city &&
            item.parentKind == .region &&
            item.parentCode == region.code,
      )
      .toList();
}
