import 'package:eqmonitor/core/component/progress/accessible_progress_indicator.dart';
import 'package:collection/collection.dart';
import 'package:eqmonitor/core/component/selector/controlled_dropdown.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:eqmonitor/feature/parameter/data/notifier/parameter_set_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

/// 都道府県選択ドロップダウン
class PrefectureSelector extends ConsumerWidget {
  const new({
    required this.selectedCode,
    required this.onChanged,
    this.hintText = '都道府県を選択',
    super.key,
  });

  final String? selectedCode;
  final ValueChanged<JmaCodeTableItem?> onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parameterSet = ref.watch(parameterSetProvider).value;
    if (parameterSet == null) {
      return const Center(
        child: AccessibleCircularProgressIndicator(),
      );
    }
    final prefectures = parameterSet
        .jmaCodeTable
        .codeTables
        .areaInformationPrefectureEarthquake;

    return ControlledDropdown(
      items: prefectures
          .map(
            (prefecture) => M3EDropdownItem(
              value: prefecture,
              label: prefecture.name.ja,
              selected: prefecture.code == selectedCode,
            ),
          )
          .toList(),
      singleSelect: true,
      allowEmptySelection: true,
      fieldStyle: M3EDropdownFieldStyle(hintText: hintText),
      onSelectionChanged: (selection) {
        final first = selection.firstOrNull;
        if (first == null) {
          onChanged(null);
        } else {
          onChanged(first.value);
        }
      },
      chipStyle: .new(
        backgroundColor: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
    );
  }
}
