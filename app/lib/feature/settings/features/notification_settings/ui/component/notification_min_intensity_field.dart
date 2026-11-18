import 'package:eqmonitor/core/component/selector/controlled_dropdown.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_kind.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_min_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/notification_slot_repository.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

/// スロットの最小震度をドロップダウンで表示する。
class const NotificationMinIntensityField({
  required final NotificationSlotType slotType,
  required final NotificationKind kind,
  required final JmaIntensity? value,
  required final bool enabled,
  required final ValueChanged<JmaIntensity> onChanged,
  final double width = 160,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final options = notificationMinIntensityPolicy.optionsOf(
      slotType: slotType,
      kind: kind,
    );
    final fallback = switch ((slotType, kind)) {
      (.currentLocation, .eew) => currentLocationEewMinIntensity,
      (.currentLocation, .earthquake) => currentLocationEarthquakeMinIntensity,
      _ => defaultNotificationSlotMinIntensity,
    };
    // 下限導入前に保存された値・選択肢外の値は下限へ引き上げて表示する
    final resolved = notificationMinIntensityPolicy.clamp(
      slotType: slotType,
      kind: kind,
      minIntensity: JmaIntensity.selectableValues.contains(value)
          ? value
          : fallback,
    );

    return SizedBox(
      width: width,
      child: ControlledDropdown<JmaIntensity>(
        enabled: enabled,
        items: [
          for (final intensity in options)
            M3EDropdownItem(
              value: intensity,
              label: intensity.minIntensityLabel,
              selected: intensity == resolved,
            ),
        ],
        onSelectionChanged: (selectedItems) {
          if (selectedItems.isEmpty) return;
          final next = selectedItems.first.value;
          onChanged(next);
        },
      ),
    );
  }
}
