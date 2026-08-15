import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:material_ui/material_ui.dart';

class HomeScopeSelector extends StatelessWidget {
  const HomeScopeSelector({
    required this.scope,
    required this.onScopeChanged,
    this.locationName,
    super.key,
  });

  final HomeEarthquakeHistoryScope scope;
  final ValueChanged<HomeEarthquakeHistoryScope> onScopeChanged;
  final String? locationName;

  @override
  Widget build(BuildContext context) {
    String scopeLabel(HomeEarthquakeHistoryScope scope) => switch (scope) {
      .nationwide => '全国',
      .currentLocation => '現在地',
      .custom => '指定地域',
    };

    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final shape = designSystem.shape;
    final spacing = designSystem.spacing;
    final typography = designSystem.typography;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: spacing.lg),
      child: Row(
        spacing: spacing.sm,
        children: [
          MenuAnchor(
            style: MenuStyle(
              padding: WidgetStateProperty.all(.zero),
              backgroundColor: WidgetStatePropertyAll(
                colorTheme.surfaceContainerLow,
              ),
              shape: WidgetStateProperty.all(
                RoundedSuperellipseBorder(
                  borderRadius: BorderRadius.circular(shape.md),
                  side: BorderSide(color: colorTheme.outlineVariant),
                ),
              ),
            ),
            menuChildren: [
              for (final s in HomeEarthquakeHistoryScope.values)
                MenuItemButton(
                  onPressed: () => onScopeChanged(s),
                  child: Text(scopeLabel(s), style: typography.bodyLarge),
                ),
            ],
            builder: (context, controller, child) => Row(
              spacing: spacing.sm,
              children: [
                GestureDetector(
                  child: Text(scopeLabel(scope), style: typography.bodyLarge),
                  onTap: () {
                    if (controller.isOpen) {
                      controller.close();
                    } else {
                      controller.open();
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  iconSize: 20,
                  onPressed: () {
                    if (controller.isOpen) {
                      controller.close();
                    } else {
                      controller.open();
                    }
                  },
                ),
              ],
            ),
          ),
          if (locationName case final locationName?)
            Expanded(
              child: Text(
                locationName,
                style: typography.bodyMedium.copyWith(
                  color: designSystem.colorTheme.onSurfaceVariant,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }
}
