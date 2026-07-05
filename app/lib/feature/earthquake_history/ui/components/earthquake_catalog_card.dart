import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_catalog.dart';
import 'package:eqmonitor/feature/home/ui/component/sheet/sheet_header.dart';
import 'package:flutter/material.dart';

class EarthquakeCatalogCard extends StatelessWidget {
  const EarthquakeCatalogCard({required this.catalog, super.key});

  final EarthquakeCatalog? catalog;

  @override
  Widget build(BuildContext context) {
    final catalog = this.catalog;
    if (catalog == null || catalog.sections.isEmpty) {
      return const SizedBox.shrink();
    }

    return BorderedContainer(
      elevation: 1,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SheetHeader(title: '震度データベース詳細'),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: catalog.sections.length,
            itemBuilder: (context, index) {
              final section = catalog.sections[index];
              return _CatalogSectionTile(section: section);
            },
          ),
        ],
      ),
    );
  }
}

class _CatalogSectionTile extends StatelessWidget {
  const _CatalogSectionTile({required this.section});

  final EarthquakeCatalogSection section;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 8),
      childrenPadding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      title: Text(
        section.title,
        style: Theme.of(
          context,
        ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
      ),
      initiallyExpanded: section.title == '震度データベース概要',
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: section.rows.length,
          itemBuilder: (context, index) {
            final row = section.rows[index];
            return _CatalogRowView(row: row);
          },
        ),
      ],
    );
  }
}

class _CatalogRowView extends StatelessWidget {
  const _CatalogRowView({required this.row});

  final EarthquakeCatalogRow row;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 128,
            child: Text(
              row.label,
              style: textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SelectableText(
              row.value,
              style: textTheme.bodyMedium?.copyWith(
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
