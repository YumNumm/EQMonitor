import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:material_ui/material_ui.dart';

class EarthquakeTypeFilterChip extends StatelessWidget {
  const EarthquakeTypeFilterChip({
    this.earthquakeType,
    this.onChanged,
    super.key,
  });

  final EarthquakeType? earthquakeType;
  final void Function(EarthquakeType?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final earthquakeType = this.earthquakeType;
    final isDefault = earthquakeType == null;

    return RawChip(
      onSelected: (_) async {
        final result = await showModalBottomSheet<({EarthquakeType? value})?>(
          clipBehavior: Clip.antiAlias,
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
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
      onDeleted: isDefault ? null : () => onChanged?.call(null),
      selected: !isDefault,
      selectedColor: context.designSystem.colorTheme.secondaryContainer,
    );
  }
}

class _EarthquakeTypeFilterModal extends StatelessWidget {
  const _EarthquakeTypeFilterModal({this.currentType});

  final EarthquakeType? currentType;

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
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: sheetBar),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                '地震種別',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
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
                onTap: () => Navigator.of(context).pop((value: type)),
              ),
            ),
            ListTile(
              title: const Text('すべて'),
              subtitle: const Text('種別で絞り込まない'),
              trailing: currentType == null
                  ? Icon(Icons.check, color: designSystem.colorTheme.primary)
                  : null,
              onTap: () =>
                  Navigator.of(context).pop((value: null as EarthquakeType?)),
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
