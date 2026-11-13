import 'package:eqmonitor/feature/region_selection/data/model/region_option.dart';

final class const RegionOptionLabel() {
  String title(RegionOption option) {
    final prefectureName = option.prefectureName;
    return prefectureName == null ||
            option.kind == .prefecture ||
            option.name.startsWith(prefectureName)
        ? option.name
        : '$prefectureName${option.name}';
  }

  String subtitle(RegionOption option) => switch (option.kind) {
    .city || .station => option.parentName ?? option.kind.label,
    _ => option.kind.label,
  };
}
