import 'package:collection/collection.dart';
import 'package:eqmonitor/feature/parameter/data/notifier/parameter_set_notifier.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 都道府県選択結果
typedef PrefectureSelection = ({String code, String name});

/// 都道府県選択ドロップダウン
class PrefectureSelector extends ConsumerWidget {
  const PrefectureSelector({
    required this.selectedCode,
    required this.onChanged,
    this.hintText = '都道府県を選択',
    super.key,
  });

  final String? selectedCode;
  final ValueChanged<PrefectureSelection?> onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parameterSet = ref.watch(parameterSetProvider).value;
    if (parameterSet == null) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }
    final prefectures = parameterSet
        .jmaCodeTable
        .codeTables
        .areaInformationPrefectureEarthquake;

    return DropdownMenu<String>(
      expandedInsets: EdgeInsets.zero,
      initialSelection: selectedCode,
      hintText: hintText,
      onSelected: (code) {
        if (code != null && code.isNotEmpty) {
          final prefecture = prefectures.firstWhereOrNull(
            (p) => p.code == code,
          );
          if (prefecture == null) {
            return;
          }
          onChanged((code: code, name: prefecture.name.ja));
        } else {
          onChanged(null);
        }
      },
      dropdownMenuEntries: [
        const DropdownMenuEntry<String>(
          value: '',
          label: '選択してください',
        ),
        ...prefectures.map(
          (e) => DropdownMenuEntry(value: e.code, label: e.name.ja),
        ),
      ],
    );
  }
}
