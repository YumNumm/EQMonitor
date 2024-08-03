import 'dart:io';

import 'package:eqapi_client/eqapi_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EarthquakeHistoryEarlySortChip extends StatelessWidget {
  const EarthquakeHistoryEarlySortChip({
    super.key,
    this.onChanged,
    required this.type,
    required this.ascending,
  });

  final void Function(
    EarthquakeEarlySortType type,
    // ignore: avoid_positional_boolean_parameters
    bool ascending,
  )? onChanged;

  final EarthquakeEarlySortType type;
  final bool ascending;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RawChip(
      label: Row(
        children: [
          Icon(
            ascending ? Icons.arrow_upward : Icons.arrow_downward,
            size: 18,
            color: theme.colorScheme.onSurface,
          ),
          const SizedBox(width: 4),
          Text(type.label),
        ],
      ),
      selected: true,
      selectedColor: theme.colorScheme.secondaryContainer,
      showCheckmark: false,
      onPressed: () async {
        final result =
            await showModalBottomSheet<(EarthquakeEarlySortType, bool)?>(
          clipBehavior: Clip.antiAlias,
          context: context,
          builder: (context) => _SortModal(
            currentSortType: type,
            currentAscending: ascending,
          ),
        );
        if (result != null) {
          onChanged?.call(result.$1, result.$2);
        }
      },
    );
  }
}

extension _EarthquakeEarlySortTypeEx on EarthquakeEarlySortType {
  String get label => switch (this) {
        EarthquakeEarlySortType.depth => '深さ',
        EarthquakeEarlySortType.magnitude => 'マグニチュード',
        EarthquakeEarlySortType.origin_time => '発生時刻',
        EarthquakeEarlySortType.max_intensity => '最大観測震度',
      };
}

class _SortModal extends HookConsumerWidget {
  const _SortModal({
    required this.currentSortType,
    required this.currentAscending,
  });

  final EarthquakeEarlySortType currentSortType;
  final bool currentAscending;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final type = useState(currentSortType);
    final ascending = useState(currentAscending);

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
              '地震履歴の並び替え',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: _SegmentedControl(
              type: type.value,
              onChanged: (v) => type.value = v,
            ),
          ),
          SwitchListTile.adaptive(
            title: const Text('昇順・降順'),
            subtitle: Text(
              switch ((type.value, ascending.value)) {
                (EarthquakeEarlySortType.depth, false) => '震源の深い順',
                (EarthquakeEarlySortType.depth, true) => '震源の浅い順',
                (EarthquakeEarlySortType.magnitude, false) => 'マグニチュードの大きい順',
                (EarthquakeEarlySortType.magnitude, true) => 'マグニチュードの小さい順',
                (EarthquakeEarlySortType.origin_time, false) => '地震発生時刻の新しい順',
                (EarthquakeEarlySortType.origin_time, true) => '地震発生時刻の古い順',
                (EarthquakeEarlySortType.max_intensity, false) => '最大観測震度の大きい順',
                (EarthquakeEarlySortType.max_intensity, true) => '最大観測震度の小さい順',
              },
            ),
            value: ascending.value,
            onChanged: (v) => ascending.value = v,
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
                  (type.value, ascending.value),
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

class _SegmentedControl extends StatelessWidget {
  const _SegmentedControl({
    required this.type,
    this.onChanged,
  });

  final EarthquakeEarlySortType type;
  final void Function(EarthquakeEarlySortType)? onChanged;

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb && (Platform.isIOS || Platform.isMacOS)) {
      return CupertinoSlidingSegmentedControl<EarthquakeEarlySortType>(
        children: {
          for (final e in EarthquakeEarlySortType.values)
            e: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: FittedBox(
                child: Text(e.label),
              ),
            ),
        },
        groupValue: type,
        onValueChanged: (v) {
          if (v != null) {
            onChanged?.call(v);
          }
        },
      );
    }
    return SegmentedButton(
      selected: {type},
      onSelectionChanged: (v) => onChanged?.call(v.first),
      segments: [
        for (final e in EarthquakeEarlySortType.values)
          ButtonSegment(
            value: e,
            label: Text(e.label),
          ),
      ],
    );
  }
}
