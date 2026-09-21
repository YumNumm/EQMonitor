import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/region_selection/data/model/region_option.dart';
import 'package:eqmonitor/feature/region_selection/data/model/region_selection_request.dart';
import 'package:eqmonitor/feature/region_selection/data/provider/region_catalog_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class EpicenterFilterChip extends ConsumerWidget {
  const new({
    required this.codes,
    required this.onChanged,
    super.key,
  });

  final List<int>? codes;
  final ValueChanged<List<int>?> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalog = (codes?.isNotEmpty ?? false)
        ? ref.watch(regionCatalogProvider()).value ?? const <RegionOption>[]
        : const <RegionOption>[];
    final selected = [
      for (final code in codes ?? const <int>[])
        catalog
                .where(
                  (item) =>
                      item.kind == .epicenter &&
                      int.tryParse(item.code) == code,
                )
                .firstOrNull ??
            RegionOption(
              kind: .epicenter,
              code: code.toString().padLeft(3, '0'),
              name: '震央地名 $code',
            ),
    ];
    return RawChip(
      selected: selected.isNotEmpty,
      label: Text(switch (selected.length) {
        0 => '震央地名',
        1 => selected.first.name,
        _ => '震央地名（${selected.length}）',
      }),
      onSelected: (_) async {
        final result = await RegionSelectionRoute(
          $extra: RegionSelectionRequest(
            title: '震央地名で絞り込み',
            kinds: const [.epicenter],
            mode: .multiple,
            initialSelection: selected,
            allowEmpty: true,
          ),
        ).push<List<RegionOption>>(context);
        if (result != null) {
          onChanged(
            result.isEmpty
                ? null
                : result.map((item) => int.parse(item.code)).toSet().toList(),
          );
        }
      },
      onDeleted: selected.isEmpty ? null : () => onChanged(null),
    );
  }
}
