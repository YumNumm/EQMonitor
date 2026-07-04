import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter/material.dart';

class DatasourceFilterChip extends StatelessWidget {
  const DatasourceFilterChip({
    this.datasource,
    this.onChanged,
    super.key,
  });

  final EarthquakeDatasource? datasource;
  final ValueChanged<EarthquakeDatasource?>? onChanged;

  @override
  Widget build(BuildContext context) {
    final isActive = datasource != null;

    return RawChip(
      onSelected: (_) async {
        final result = await showModalBottomSheet<EarthquakeDatasource?>(
          clipBehavior: Clip.antiAlias,
          context: context,
          builder: (context) => _DatasourceFilterModal(current: datasource),
        );
        if (result != null || context.mounted) {
          onChanged?.call(result);
        }
      },
      label: isActive
          ? Text(
              datasource!.label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          : const Text('データソース'),
      onDeleted: isActive ? () => onChanged?.call(null) : null,
      selected: isActive,
      selectedColor: context.designSystem.colorTheme.secondaryContainer,
    );
  }
}

class _DatasourceFilterModal extends StatelessWidget {
  const _DatasourceFilterModal({this.current});

  final EarthquakeDatasource? current;

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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: sheetBar),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              'データソース',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          for (final ds in EarthquakeDatasource.values)
            ListTile(
              title: Text(ds.label),
              subtitle: Text(ds.description),
              trailing: current == ds
                  ? Icon(Icons.check, color: designSystem.colorTheme.primary)
                  : null,
              onTap: () => Navigator.of(context).pop(ds),
            ),
          ListTile(
            title: const Text('すべて'),
            subtitle: const Text('データソースで絞り込まない'),
            trailing: current == null
                ? Icon(Icons.check, color: designSystem.colorTheme.primary)
                : null,
            onTap: () => Navigator.of(context).pop(),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

extension on EarthquakeDatasource {
  String get label => switch (this) {
    EarthquakeDatasource.jmaIntensityDatabase => '震度データベース',
    EarthquakeDatasource.jmaDisasterInformationXml => '防災情報XML',
  };

  String get description => switch (this) {
    EarthquakeDatasource.jmaIntensityDatabase => 'JMA 震度データベースの地震情報',
    EarthquakeDatasource.jmaDisasterInformationXml => 'JMA 防災情報XMLの地震情報',
  };
}
