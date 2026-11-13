import 'package:eqmonitor/feature/region_selection/data/model/region_option.dart';

/// 同名の地域を区別できる表示文字列を組み立てる。
final class const RegionOptionLabel() {
  /// 一覧の補足行。種別に続けて所属する都道府県・親地域を示す。
  String subtitle(RegionOption option) {
    final parentName = option.parentName;
    final prefectureName = option.prefectureName;
    return [
      option.kind.label,
      if (prefectureName != null &&
          !(parentName?.contains(prefectureName) ?? false))
        prefectureName,
      ?parentName,
    ].join('・');
  }

  /// 選択中の地域を 1 行で示す。
  String selected(RegionOption option) {
    final parentName = option.parentName;
    return parentName == null ? option.name : '${option.name}（$parentName）';
  }
}
