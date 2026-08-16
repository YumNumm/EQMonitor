import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_kind.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_min_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/notification_slot_repository.dart';
import 'package:material_ui/material_ui.dart';

/// 現在地スロットは固定値のラベル、それ以外はドロップダウンで最小震度を表示する。
class NotificationMinIntensityField extends StatelessWidget {
  const NotificationMinIntensityField({
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
    final designSystem = context.designSystem;
    final fixed = slotType.fixedMinIntensity(kind);

    if (fixed != null) {
      return Text(
        fixed.minIntensityLabel,
        style: designSystem.typography.bodyLarge.copyWith(
          color: enabled
              ? designSystem.colorTheme.onSurface
              : designSystem.colorTheme.onSurfaceVariant,
        ),
      );
    }

    final resolved =
        value != null && JmaIntensity.selectableValues.contains(value)
        ? value
        : defaultNotificationSlotMinIntensity;

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
        for (final intensity in JmaIntensity.selectableValues)
          DropdownMenuEntry(
            value: intensity,
            label: intensity.minIntensityLabel,
          ),
      ],
    );
  }
}
