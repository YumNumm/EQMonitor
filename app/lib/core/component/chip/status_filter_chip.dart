import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StatusFilterChip extends StatelessWidget {
  const StatusFilterChip({required this.statuses, this.onChanged, super.key});

  final void Function(List<TelegramStatus>?)? onChanged;
  final List<TelegramStatus>? statuses;

  static const List<TelegramStatus> initialStatuses = [TelegramStatus.normal];

  @override
  Widget build(BuildContext context) {
    final currentStatuses = statuses;
    final isDefault =
        currentStatuses == null ||
        (currentStatuses.length == 1 &&
            currentStatuses.first == TelegramStatus.normal);

    return RawChip(
      onSelected: (_) async {
        final result = await showModalBottomSheet<List<TelegramStatus>?>(
          clipBehavior: Clip.antiAlias,
          context: context,
          builder: (context) =>
              _StatusFilterModal(currentStatuses: currentStatuses),
        );
        if (result != null) {
          onChanged?.call(result);
        }
      },
      label: isDefault
          ? const Text('ステータス')
          : Text(
              currentStatuses.length == TelegramStatus.values.length
                  ? '全て'
                  : currentStatuses.map((s) => s.label).join(', '),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
      onDeleted: isDefault ? null : () => onChanged?.call(initialStatuses),
      selected: !isDefault,
      selectedColor: context.designSystem.colorTheme.secondaryContainer,
    );
  }
}

class _StatusFilterModal extends HookWidget {
  const _StatusFilterModal({this.currentStatuses});

  final List<TelegramStatus>? currentStatuses;

  @override
  Widget build(BuildContext context) {
    final selectedStatuses = useState<Set<TelegramStatus>>(
      currentStatuses?.toSet() ?? {TelegramStatus.normal},
    );

    final theme = Theme.of(context);
    final designSystem = context.designSystem;
    final sheetBar = Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: 36,
      height: 4,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: designSystem.colorTheme.onSurface,
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.black12, blurRadius: 12),
        ],
      ),
    );

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: sheetBar),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                'ステータス',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            ...TelegramStatus.values.map(
              (status) => CheckboxListTile(
                title: Text(status.label),
                subtitle: Text(status.description),
                value: selectedStatuses.value.contains(status),
                enabled:
                    !(selectedStatuses.value.contains(status) &&
                        selectedStatuses.value.length == 1),
                onChanged: (checked) {
                  final newSet = Set<TelegramStatus>.from(
                    selectedStatuses.value,
                  );
                  if (checked ?? false) {
                    newSet.add(status);
                  } else {
                    // 最低1つは選択されている必要がある
                    if (newSet.length > 1) {
                      newSet.remove(status);
                    }
                  }
                  selectedStatuses.value = newSet;
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('キャンセル'),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.of(context)
                          .pop(selectedStatuses.value.toList()),
                  child: const Text('完了'),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

extension on TelegramStatus {
  String get label => switch (this) {
    TelegramStatus.normal => '通常',
    TelegramStatus.training => '訓練',
    TelegramStatus.test => '試験',
  };

  String get description => switch (this) {
    TelegramStatus.normal => '通常発表された地震情報',
    TelegramStatus.training => '訓練用の地震情報',
    TelegramStatus.test => '試験用の地震情報',
  };
}
