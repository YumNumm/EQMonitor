import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StatusFilterChip extends StatelessWidget {
  const StatusFilterChip({
    this.statuses,
    this.onChanged,
    super.key,
  });

  final void Function(List<TelegramStatus>?)? onChanged;
  final List<TelegramStatus>? statuses;

  static const List<TelegramStatus> initialStatuses = [TelegramStatus.normal];

  @override
  Widget build(BuildContext context) {
    final isDefault =
        statuses == null ||
        (statuses!.length == 1 && statuses!.first == TelegramStatus.normal);

    return RawChip(
      onSelected: (_) async {
        final result = await showModalBottomSheet<List<TelegramStatus>?>(
          clipBehavior: Clip.antiAlias,
          context: context,
          builder: (context) => _StatusFilterModal(currentStatuses: statuses),
        );
        if (result != null) {
          onChanged?.call(result);
        }
      },
      label: isDefault
          ? const Text('ステータス')
          : Text(
              _statusesToString(statuses!),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
      onDeleted: isDefault ? null : () => onChanged?.call(initialStatuses),
      selected: !isDefault,
      selectedColor: Theme.of(context).colorScheme.secondaryContainer,
    );
  }
}

String _statusesToString(List<TelegramStatus> statuses) {
  if (statuses.length == TelegramStatus.values.length) {
    return '全て';
  }
  return statuses.map(_statusToJapanese).join(', ');
}

String _statusToJapanese(TelegramStatus status) {
  return switch (status) {
    TelegramStatus.normal => '通常',
    TelegramStatus.training => '訓練',
    TelegramStatus.test => '試験',
  };
}

String _statusDescription(TelegramStatus status) {
  return switch (status) {
    TelegramStatus.normal => '通常発表された地震情報',
    TelegramStatus.training => '訓練用の地震情報',
    TelegramStatus.test => '試験用の地震情報',
  };
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
    final sheetBar = Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: 36,
      height: 4,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: theme.colorScheme.onSurface,
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.black12, blurRadius: 12),
        ],
      ),
    );

    return SafeArea(
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
              title: Text(_statusToJapanese(status)),
              subtitle: Text(_statusDescription(status)),
              value: selectedStatuses.value.contains(status),
              onChanged: (checked) {
                final newSet = Set<TelegramStatus>.from(selectedStatuses.value);
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
                onPressed: () => Navigator.of(context).pop(
                  selectedStatuses.value.toList(),
                ),
                child: const Text('完了'),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
