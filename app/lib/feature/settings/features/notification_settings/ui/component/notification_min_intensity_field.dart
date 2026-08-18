import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_kind.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_min_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/notification_slot_repository.dart';
import 'package:material_ui/material_ui.dart';

/// スロットの最小震度をドロップダウンで表示する。
class NotificationMinIntensityField extends StatelessWidget {
  const new({
    required this.slotType,
    required this.kind,
    required this.value,
    required this.enabled,
    required this.onChanged,
    this.width = 160,
    super.key,
  });

  final NotificationSlotType slotType;
  final NotificationKind kind;
  final JmaIntensity? value;
  final bool enabled;
  final ValueChanged<JmaIntensity> onChanged;
  final double width;

  @override
  Widget build(BuildContext context) {
    final options = notificationMinIntensityPolicy.optionsOf(
      slotType: slotType,
      kind: kind,
    );
    final fallback = switch ((slotType, kind)) {
      (NotificationSlotType.currentLocation, NotificationKind.eew) =>
        currentLocationEewMinIntensity,
      (NotificationSlotType.currentLocation, NotificationKind.earthquake) =>
        currentLocationEarthquakeMinIntensity,
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

    return DropdownMenu<JmaIntensity>(
      initialSelection: resolved,
      enabled: enabled,
      requestFocusOnTap: false,
      width: width,
      onSelected: (next) {
        if (next != null) {
          onChanged(next);
        }
      },
      dropdownMenuEntries: [
        for (final intensity in options)
          DropdownMenuEntry(
            value: intensity,
            label: intensity.minIntensityLabel,
          ),
      ],
    );
  }
}
