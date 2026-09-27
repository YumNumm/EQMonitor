import 'package:eqmonitor/core/component/selector/dropdown_menu_chip.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:material_ui/material_ui.dart';

/// [HomeEarthquakeHistoryScope] の表示用ラベルとアイコン。
extension HomeEarthquakeHistoryScopeDisplay on HomeEarthquakeHistoryScope {
  String get label => switch (this) {
    .nationwide => '全国',
    .currentLocation => '現在地',
    .custom => '指定地域',
  };

  IconData get icon => switch (this) {
    .nationwide => Icons.public_rounded,
    .currentLocation => Icons.my_location_rounded,
    .custom => Icons.place_outlined,
  };
}

/// 地震履歴カードの表示範囲を切り替えるチップ。
///
/// タップでメニューを開き、全国 / 現在地 / 指定地域を選択する。
/// [onEditRegion] を渡した場合は、指定地域の選び直しもメニューから行える。
class HomeScopeSelector extends StatelessWidget {
  const new({
    required this.scope,
    required this.onScopeChanged,
    this.onEditRegion,
    this.locationName,
    super.key,
  });

  final HomeEarthquakeHistoryScope scope;
  final ValueChanged<HomeEarthquakeHistoryScope> onScopeChanged;
  final VoidCallback? onEditRegion;

  /// 解決済みの地域名。チップにはこれを優先して表示する。
  final String? locationName;

  @override
  Widget build(BuildContext context) {
    return DropdownMenuChip<HomeEarthquakeHistoryScope>(
      label: locationName ?? scope.label,
      icon: scope.icon,
      value: scope,
      entries: [
        for (final value in HomeEarthquakeHistoryScope.values)
          DropdownMenuChipEntry(
            value: value,
            label: value.label,
            icon: value.icon,
          ),
      ],
      onSelected: onScopeChanged,
      additionalMenuChildren: [
        if (onEditRegion case final onEditRegion?)
          MenuItemButton(
            leadingIcon: const Icon(Icons.edit_location_alt_outlined, size: 20),
            onPressed: onEditRegion,
            child: Text(
              '地域を再選択',
              style: context.designSystem.typography.bodyLarge,
            ),
          ),
      ],
    );
  }
}
