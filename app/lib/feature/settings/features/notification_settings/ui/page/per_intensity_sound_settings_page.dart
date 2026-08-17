import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/settings/component/settings_section_header.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_kind.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/override_edit_page.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/ui/page/slot_detail_page.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PerIntensitySoundSettingsPage extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final slotsAsync = ref.watch(notificationSlotsProvider);
    final slots = [...?slotsAsync.value]
      ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));

    return Scaffold(
      appBar: AppBar(title: const Text('震度別の音設定')),
      body: ListView(
        padding: const EdgeInsets.only(top: 16, bottom: 24),
        children: [
          if (slotsAsync.isLoading && slots.isEmpty)
            const Padding(
              padding: EdgeInsets.all(24),
              child: Center(child: CircularProgressIndicator.adaptive()),
            )
          else ...[
            const SettingsSectionHeader(text: '緊急地震速報(予報)'),
            _SlotOverrideCard(slots: slots, overrideType: NotificationKind.eew),
            const SettingsSectionHeader(text: '地震情報'),
            _SlotOverrideCard(
              slots: slots,
              overrideType: NotificationKind.earthquake,
            ),
          ],
        ],
      ),
    );
  }
}

class _SlotOverrideCard extends StatelessWidget {
  const new({
    required this.slots,
    required this.overrideType,
  });

  final List<NotificationSlot> slots;
  final NotificationKind overrideType;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;
    final shape = designSystem.shape;

    return Card.outlined(
      margin: EdgeInsets.fromLTRB(
        spacing.lg,
        spacing.sm,
        spacing.lg,
        spacing.md,
      ),
      color: colorTheme.surfaceContainerHigh,
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(shape.card),
        side: BorderSide(color: colorTheme.outlineVariant),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < slots.length; i++) ...[
            if (i > 0) const Divider(height: 1),
            _SlotOverrideTile(slot: slots[i], overrideType: overrideType),
          ],
        ],
      ),
    );
  }
}

class _SlotOverrideTile extends StatelessWidget {
  const new({
    required this.slot,
    required this.overrideType,
  });

  final NotificationSlot slot;
  final NotificationKind overrideType;

  @override
  Widget build(BuildContext context) {
    final (icon, name) = switch (slot.slotType) {
      NotificationSlotType.currentLocation => ('📍', '現在地'),
      NotificationSlotType.nationwide => ('🌐', '全国'),
      NotificationSlotType.region => (
        '📍',
        slot.cityName != null
            ? '${slot.regionName ?? slot.slotType.label} ${slot.cityName}'
            : slot.regionName ?? slot.slotType.label,
      ),
    };

    final overrides = switch (overrideType) {
      NotificationKind.eew => slot.eewOverrides ?? [],
      NotificationKind.earthquake => slot.earthquakeOverrides ?? [],
    };

    final subtitle =
        overrides.isEmpty ? '設定なし' : '${overrides.length}件のオーバーライド';

    return ListTile(
      leading: Text(icon, style: const TextStyle(fontSize: 20)),
      title: Text(name),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: () async => Navigator.of(context).push<void>(
        MaterialPageRoute<void>(
          builder: (_) => OverrideEditPage(
            slotId: slot.id,
            slotType: slot.slotType,
            overrideType: overrideType,
            currentOverrides: overrides,
          ),
        ),
      ),
    );
  }
}
