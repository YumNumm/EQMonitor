import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TelegramTypeFilterChip extends StatelessWidget {
  const TelegramTypeFilterChip({
    this.telegramTypes,
    this.onChanged,
    super.key,
  });

  final List<EarthquakeTelegramType>? telegramTypes;
  final ValueChanged<List<EarthquakeTelegramType>?>? onChanged;

  @override
  Widget build(BuildContext context) {
    final isActive = telegramTypes != null && telegramTypes!.isNotEmpty;

    return RawChip(
      onSelected: (_) async {
        final result =
            await showModalBottomSheet<List<EarthquakeTelegramType>?>(
              clipBehavior: Clip.antiAlias,
              context: context,
              builder: (context) =>
                  _TelegramTypeFilterModal(current: telegramTypes),
            );
        if (result != null) {
          onChanged?.call(
            result.length == EarthquakeTelegramType.values.length
                ? null
                : result,
          );
        }
      },
      label: isActive
          ? Text(
              _buildLabel(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          : const Text('電文種別'),
      onDeleted: isActive ? () => onChanged?.call(null) : null,
      selected: isActive,
      selectedColor: context.designSystem.colorTheme.secondaryContainer,
    );
  }

  String _buildLabel() {
    final types = telegramTypes;
    if (types == null || types.isEmpty) {
      return '電文種別';
    }
    if (types.length == 1) {
      return types.first.label;
    }
    return '${types.length}種別';
  }
}

class _TelegramTypeFilterModal extends HookWidget {
  const _TelegramTypeFilterModal({this.current});

  final List<EarthquakeTelegramType>? current;

  @override
  Widget build(BuildContext context) {
    final selected = useState<Set<EarthquakeTelegramType>>(
      current?.toSet() ?? EarthquakeTelegramType.values.toSet(),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: sheetBar),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              '電文種別',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          ...EarthquakeTelegramType.values.map(
            (type) => CheckboxListTile(
              title: Text(type.label),
              subtitle: Text(type.description),
              value: selected.value.contains(type),
              onChanged: (checked) {
                final newSet = Set<EarthquakeTelegramType>.from(selected.value);
                if (checked ?? false) {
                  newSet.add(type);
                } else {
                  if (newSet.length > 1) {
                    newSet.remove(type);
                  }
                }
                selected.value = newSet;
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
                  selected.value.toList()..sort(
                    (a, b) => a.index.compareTo(b.index),
                  ),
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

extension on EarthquakeTelegramType {
  String get label => switch (this) {
    EarthquakeTelegramType.vxse51 => '震度速報',
    EarthquakeTelegramType.vxse52 => '震源に関する情報',
    EarthquakeTelegramType.vxse53 => '震源・震度に関する情報',
    EarthquakeTelegramType.vxse61 => '地震の活動状況等に関する情報',
    EarthquakeTelegramType.vxse62 => '顕著な地震の震源要素更新のお知らせ',
    EarthquakeTelegramType.vxse45Forecast => '緊急地震速報（予報）',
    EarthquakeTelegramType.vxse45Warning => '緊急地震速報（警報）',
  };

  String get description => switch (this) {
    EarthquakeTelegramType.vxse51 => 'VXSE51',
    EarthquakeTelegramType.vxse52 => 'VXSE52',
    EarthquakeTelegramType.vxse53 => 'VXSE53',
    EarthquakeTelegramType.vxse61 => 'VXSE61',
    EarthquakeTelegramType.vxse62 => 'VXSE62',
    EarthquakeTelegramType.vxse45Forecast => 'VXSE45',
    EarthquakeTelegramType.vxse45Warning => 'VXSE45',
  };
}
