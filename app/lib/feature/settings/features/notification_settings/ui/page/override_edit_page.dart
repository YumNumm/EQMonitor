import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/experimental/mutation.dart';

enum OverrideType { eew, earthquake }

const _presetSounds = [
  'default',
  'eew_warning',
  'eew_forecast',
  'earthquake',
];

const List<JmaIntensity> _overrideIntensities = [
  JmaIntensity.zero,
  JmaIntensity.one,
  JmaIntensity.two,
  JmaIntensity.three,
  JmaIntensity.four,
  JmaIntensity.fiveLower,
  JmaIntensity.fiveUpper,
  JmaIntensity.sixLower,
  JmaIntensity.sixUpper,
  JmaIntensity.seven,
];

const _maxOverrides = 12;

class OverrideEditPage extends HookConsumerWidget {
  const OverrideEditPage({
    required this.slotId,
    required this.slotType,
    required this.overrideType,
    required this.currentOverrides,
    super.key,
  });

  final String slotId;
  final NotificationSlotType slotType;
  final OverrideType overrideType;
  final List<NotificationOverride> currentOverrides;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final slot = ref
        .watch(notificationSlotsProvider)
        .value
        ?.where((s) => s.id == slotId)
        .firstOrNull;

    final overrides = switch (overrideType) {
      OverrideType.eew => slot?.eewOverrides,
      OverrideType.earthquake => slot?.earthquakeOverrides,
    } ??
        currentOverrides;

    final sorted = List<NotificationOverride>.of(overrides)
      ..sort(
        (a, b) =>
            a.minJmaIntensity.orderIndex - b.minJmaIntensity.orderIndex,
      );

    final title = switch (overrideType) {
      OverrideType.eew => 'EEW 震度別設定',
      OverrideType.earthquake => '地震情報 震度別設定',
    };

    void listenError(Mutation<void> mutation, String message) {
      ref.listen(mutation, (_, next) {
        if (next is MutationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$message: ${next.error}'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      });
    }

    listenError(
      NotificationSlotsNotifier.putCurrentLocationMutation,
      '設定の保存に失敗しました',
    );
    listenError(
      NotificationSlotsNotifier.putNationwideMutation,
      '設定の保存に失敗しました',
    );
    listenError(
      NotificationSlotsNotifier.updateRegionMutation,
      '設定の保存に失敗しました',
    );

    final usedIntensities = sorted.map((o) => o.minJmaIntensity).toSet();
    final canAdd = sorted.length < _maxOverrides;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      floatingActionButton: canAdd
          ? FloatingActionButton(
              onPressed: () => _showAddDialog(
                context,
                ref,
                slot,
                sorted,
                usedIntensities,
              ),
              child: const Icon(Icons.add),
            )
          : null,
      body: sorted.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.tune,
                    size: 48,
                    color: Theme.of(context).disabledColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '震度別設定がありません',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).disabledColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '右下の＋ボタンから追加できます',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).disabledColor,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 80),
              itemCount: sorted.length,
              itemBuilder: (context, index) {
                final entry = sorted[index];
                return _OverrideTile(
                  entry: entry,
                  onTap: () => _showEditDialog(
                    context,
                    ref,
                    slot,
                    sorted,
                    index,
                  ),
                  onDismissed: () => _deleteOverride(
                    ref,
                    slot,
                    sorted,
                    index,
                  ),
                );
              },
            ),
    );
  }

  Future<void> _showAddDialog(
    BuildContext context,
    WidgetRef ref,
    NotificationSlot? slot,
    List<NotificationOverride> sorted,
    Set<JmaIntensity> usedIntensities,
  ) async {
    final availableIntensities = _overrideIntensities
        .where((i) => !usedIntensities.contains(i))
        .toList();

    if (availableIntensities.isEmpty) {
      return;
    }

    final result = await showDialog<NotificationOverride>(
      context: context,
      builder: (context) => _OverrideFormDialog(
        availableIntensities: availableIntensities,
        initialIntensity: availableIntensities.first,
      ),
    );

    if (result == null || slot == null) {
      return;
    }

    final updated = [...sorted, result]..sort(
      (a, b) =>
          a.minJmaIntensity.orderIndex - b.minJmaIntensity.orderIndex,
    );

    await _saveOverrides(ref, slot, updated);
  }

  Future<void> _showEditDialog(
    BuildContext context,
    WidgetRef ref,
    NotificationSlot? slot,
    List<NotificationOverride> sorted,
    int index,
  ) async {
    final current = sorted[index];

    final result = await showDialog<NotificationOverride>(
      context: context,
      builder: (context) => _OverrideFormDialog(
        availableIntensities: [current.minJmaIntensity],
        initialIntensity: current.minJmaIntensity,
        initialSound: current.sound,
        initialInterruptionLevel: current.interruptionLevel,
        isEditing: true,
      ),
    );

    if (result == null || slot == null) {
      return;
    }

    final updated = [...sorted];
    updated[index] = result;

    await _saveOverrides(ref, slot, updated);
  }

  Future<void> _deleteOverride(
    WidgetRef ref,
    NotificationSlot? slot,
    List<NotificationOverride> sorted,
    int index,
  ) async {
    if (slot == null) {
      return;
    }

    final updated = [...sorted]..removeAt(index);
    await _saveOverrides(ref, slot, updated);
  }

  Future<void> _saveOverrides(
    WidgetRef ref,
    NotificationSlot slot,
    List<NotificationOverride> overrides,
  ) async {
    final eewOverrides = overrideType == OverrideType.eew
        ? overrides
        : slot.eewOverrides;
    final earthquakeOverrides = overrideType == OverrideType.earthquake
        ? overrides
        : slot.earthquakeOverrides;

    try {
      switch (slotType) {
        case NotificationSlotType.currentLocation:
          await NotificationSlotsNotifier.putCurrentLocationMutation.run(
            ref,
            (tsx) async {
              await tsx
                  .get(notificationSlotsProvider.notifier)
                  .putCurrentLocation(
                    eewOverrides: eewOverrides,
                    earthquakeOverrides: earthquakeOverrides,
                  );
            },
          );
        case NotificationSlotType.nationwide:
          await NotificationSlotsNotifier.putNationwideMutation.run(
            ref,
            (tsx) async {
              await tsx
                  .get(notificationSlotsProvider.notifier)
                  .putNationwide(
                    eewOverrides: eewOverrides,
                    earthquakeOverrides: earthquakeOverrides,
                  );
            },
          );
        case NotificationSlotType.region:
          await NotificationSlotsNotifier.updateRegionMutation.run(
            ref,
            (tsx) async {
              await tsx
                  .get(notificationSlotsProvider.notifier)
                  .updateRegion(
                    slotId: slotId,
                    eewOverrides: eewOverrides,
                    earthquakeOverrides: earthquakeOverrides,
                  );
            },
          );
      }
    } on Object {
      return;
    }
  }
}

class _OverrideTile extends StatelessWidget {
  const _OverrideTile({
    required this.entry,
    required this.onTap,
    required this.onDismissed,
  });

  final NotificationOverride entry;
  final VoidCallback onTap;
  final VoidCallback onDismissed;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final color = designSystem.color;
    final spacing = designSystem.spacing;
    final shape = designSystem.shape;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: spacing.lg,
        vertical: spacing.xs,
      ),
      child: Dismissible(
        key: ValueKey(entry.minJmaIntensity),
        direction: DismissDirection.endToStart,
        onDismissed: (_) => onDismissed(),
        background: Card(
          color: Theme.of(context).colorScheme.error,
          shape: RoundedSuperellipseBorder(
            borderRadius: BorderRadius.circular(shape.card),
          ),
          child: const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 24),
              child: Icon(Icons.delete, color: Colors.white),
            ),
          ),
        ),
        child: Card.outlined(
          margin: EdgeInsets.zero,
          color: color.surfaceCard,
          clipBehavior: Clip.antiAlias,
          elevation: 0,
          shape: RoundedSuperellipseBorder(
            borderRadius: BorderRadius.circular(shape.card),
            side: BorderSide(color: color.outlineSoft),
          ),
          child: ListTile(
            onTap: onTap,
            leading: _IntensityBadge(intensity: entry.minJmaIntensity),
            title: Text('震度${entry.minJmaIntensity.label}以上'),
            subtitle: Text(
              '${_soundLabel(entry.sound)} / ${entry.interruptionLevel.label}',
            ),
            trailing: const Icon(Icons.chevron_right),
          ),
        ),
      ),
    );
  }
}

class _IntensityBadge extends StatelessWidget {
  const _IntensityBadge({required this.intensity});

  final JmaIntensity intensity;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        intensity.label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}

class _OverrideFormDialog extends StatefulWidget {
  const _OverrideFormDialog({
    required this.availableIntensities,
    required this.initialIntensity,
    this.initialSound = 'default',
    this.initialInterruptionLevel = InterruptionLevel.active,
    this.isEditing = false,
  });

  final List<JmaIntensity> availableIntensities;
  final JmaIntensity initialIntensity;
  final String initialSound;
  final InterruptionLevel initialInterruptionLevel;
  final bool isEditing;

  @override
  State<_OverrideFormDialog> createState() => _OverrideFormDialogState();
}

class _OverrideFormDialogState extends State<_OverrideFormDialog> {
  late JmaIntensity _selectedIntensity;
  late String _selectedSound;
  late InterruptionLevel _selectedInterruptionLevel;

  @override
  void initState() {
    super.initState();
    _selectedIntensity = widget.initialIntensity;
    _selectedSound = widget.initialSound;
    _selectedInterruptionLevel = widget.initialInterruptionLevel;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.isEditing ? '震度別設定を編集' : '震度別設定を追加'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '最小震度',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            DropdownButton<JmaIntensity>(
              value: _selectedIntensity,
              isExpanded: true,
              onChanged: widget.isEditing
                  ? null
                  : (next) {
                      if (next != null) {
                        setState(() => _selectedIntensity = next);
                      }
                    },
              items: [
                for (final intensity in widget.availableIntensities)
                  DropdownMenuItem(
                    value: intensity,
                    child: Text('震度${intensity.label}'),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '通知音',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            DropdownButton<String>(
              value: _selectedSound,
              isExpanded: true,
              onChanged: (next) {
                if (next != null) {
                  setState(() => _selectedSound = next);
                }
              },
              items: [
                for (final sound in _presetSounds)
                  DropdownMenuItem(
                    value: sound,
                    child: Text(_soundLabel(sound)),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '割り込みレベル',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            RadioGroup<InterruptionLevel>(
              groupValue: _selectedInterruptionLevel,
              onChanged: (next) {
                if (next != null) {
                  setState(() => _selectedInterruptionLevel = next);
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final level in InterruptionLevel.values)
                    RadioListTile<InterruptionLevel>(
                      title: Text(level.label),
                      value: level,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(
            NotificationOverride(
              minJmaIntensity: _selectedIntensity,
              sound: _selectedSound,
              interruptionLevel: _selectedInterruptionLevel,
            ),
          ),
          child: Text(widget.isEditing ? '保存' : '追加'),
        ),
      ],
    );
  }
}

String _soundLabel(String sound) => switch (sound) {
  'default' => 'デフォルト',
  'eew_warning' => 'EEW警報',
  'eew_forecast' => 'EEW予報',
  'earthquake' => '地震情報',
  _ => sound,
};
