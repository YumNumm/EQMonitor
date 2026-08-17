import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_catalog.dart';
import 'package:material_ui/material_ui.dart';

class ShindoDbEventNotes extends StatelessWidget {
  const ShindoDbEventNotes({required this.catalog, super.key});

  final EarthquakeCatalog catalog;

  @override
  Widget build(BuildContext context) {
    final damage = catalog.damageScaleLabel;
    final tsunami = catalog.tsunamiScaleLabel;

    if (damage == null && tsunami == null) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final noteStyle = theme.textTheme.bodySmall?.copyWith(
      color: context.designSystem.colorTheme.onSurfaceVariant,
      fontFamily: FontFamily.notoSansJP,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (damage != null)
            Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  size: 16,
                  color: context.designSystem.colorTheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Flexible(child: Text('被害規模 $damage', style: noteStyle)),
              ],
            ),
          if (tsunami != null)
            Row(
              children: [
                Icon(
                  Icons.waves_rounded,
                  size: 16,
                  color: context.designSystem.colorTheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Flexible(child: Text('津波規模 $tsunami', style: noteStyle)),
              ],
            ),
        ],
      ),
    );
  }
}
