import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:flutter/material.dart';

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

  static String _scopeLabel(HomeEarthquakeHistoryScope scope) => switch (scope) {
    .nationwide => '全国',
    .currentLocation => '現在地',
    .custom => '指定地域',
  };

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final color = designSystem.color;
    final shape = designSystem.shape;
    final spacing = designSystem.spacing;
    final typography = designSystem.typography;

    return Padding(
      padding: EdgeInsets.all(spacing.xs),
      child: Row(
        spacing: spacing.sm,
        children: [
          Text(
            _scopeLabel(scope),
            style: typography.bodyLarge,
          ),
          MenuAnchor(
            style: MenuStyle(
              padding: WidgetStateProperty.all(EdgeInsets.zero),
              backgroundColor: WidgetStatePropertyAll(color.surfaceRaised),
              shape: WidgetStateProperty.all(
                RoundedSuperellipseBorder(
                  borderRadius: BorderRadius.circular(shape.md),
                  side: BorderSide(color: color.outlineSoft),
                ),
              ),
            ),
            menuChildren: [
              for (final s in HomeEarthquakeHistoryScope.values)
                MenuItemButton(
                  onPressed: () => onScopeChanged(s),
                  child: Text(
                    _scopeLabel(s),
                    style: typography.bodyLarge,
                  ),
                ),
            ],
            builder: (context, controller, child) => IconButton(
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
          ),
          if (locationName != null)
            Expanded(
              child: Text(
                locationName!,
                style: typography.bodyMedium.copyWith(
                  color: designSystem.textColor.secondary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }
}
