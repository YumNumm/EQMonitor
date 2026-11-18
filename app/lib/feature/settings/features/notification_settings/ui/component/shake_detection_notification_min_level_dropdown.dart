import 'package:eqmonitor/core/component/selector/controlled_dropdown.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/component/shake_detection_weaker_level_dialog.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

class const ShakeDetectionNotificationMinLevelDropdown({
  required final ShakeDetectionLevel minLevel,
  required final bool enabled,
  required final ValueChanged<ShakeDetectionLevel> onChanged,
  super.key,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // 確認を取り消したときに、Dropdown が保持する選択を保存済みの値へ戻す。
    final resyncCount = useState(0);

    return ControlledDropdown<ShakeDetectionLevel>(
      enabled: enabled,
      // 二行の項目が 5 件あり、既定の高さでは最後の項目が隠れる。
      dropdownStyle: const M3EDropdownStyle(maxHeight: 420),
      items: [
        for (final level in ShakeDetectionLevel.values)
          M3EDropdownItem(
            value: level,
            label: level.notificationMinLevelDropdownLabel,
            selected: level == minLevel,
          ),
      ],
      onSelectionChanged: (selectedItems) async {
        final next = selectedItems.firstOrNull?.value;
        if (next == null || next == minLevel) {
          return;
        }
        if (next.isDeprecatedForNotification) {
          final confirmed = await const ShakeDetectionWeakerLevelDialogAction()
              .confirm(
                context,
              );
          if (!context.mounted) {
            return;
          }
          if (!confirmed) {
            resyncCount.value += 1;
            return;
          }
        }
        onChanged(next);
      },
    );
  }
}
