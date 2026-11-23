import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/util/haptic.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:material_ui/material_ui.dart';
import 'package:m3e_core/m3e_core.dart';

class const EarthquakeTypeFilterChip({
  final EarthquakeType? earthquakeType,
  final void Function(EarthquakeType?)? onChanged,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final earthquakeType = this.earthquakeType;
    final isDefault = earthquakeType == null;

    return RawChip(
      onSelected: (_) async {
        final result =
            await showM3EModalBottomSheet<({EarthquakeType? value})?>(
              isScrollControlled: false,
              useSafeArea: false,
              style: const M3EBottomSheetStyle(padding: EdgeInsets.zero),
              clipBehavior: .antiAlias,
              context: context,
              builder: (context) =>
                  _EarthquakeTypeFilterModal(currentType: earthquakeType),
            );
        if (result != null && context.mounted) {
          onChanged?.call(result.value);
        }
      },
      label: earthquakeType == null
          ? const Text('種別')
          : Text(
              earthquakeType.displayLabel,
              style: const TextStyle(fontWeight: .bold),
            ),
      onDeleted: isDefault
          ? null
          : () => HapticUtil.light(() => onChanged?.call(null)),
      selected: !isDefault,
      selectedColor: context.designSystem.colorTheme.secondaryContainer,
    );
  }
}

class const _EarthquakeTypeFilterModal({final EarthquakeType? currentType})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            Center(child: sheetBar),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                '地震種別',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: .bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            ...EarthquakeType.values.map(
              (type) => ListTile(
                title: Text(type.displayLabel),
                trailing: currentType == type
                    ? Icon(Icons.check, color: designSystem.colorTheme.primary)
                    : null,
                onTap: () => HapticUtil.selection(
                  () => Navigator.of(context).pop((value: type)),
                ),
              ),
            ),
            ListTile(
              title: const Text('すべて'),
              subtitle: const Text('種別で絞り込まない'),
              trailing: currentType == null
                  ? Icon(Icons.check, color: designSystem.colorTheme.primary)
                  : null,
              onTap: () => HapticUtil.selection(
                () =>
                    Navigator.of(context).pop((value: null as EarthquakeType?)),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

extension on EarthquakeType {
  String get displayLabel => switch (this) {
    .normal => '通常',
    .distant => '遠地地震',
    .volcano => '火山噴火',
  };
}
