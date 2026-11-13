import 'package:eqmonitor/feature/region_selection/data/model/region_option.dart';

final class const RegionOptionLabel() {
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
}
