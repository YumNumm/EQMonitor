import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:flutter/material.dart';

String scopeShortLabel(HomeEarthquakeHistoryScope scope) => switch (scope) {
  .nationwide => '全国',
  .currentLocation => '現在地',
  .custom => '指定地域',
};

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
    final designSystem = context.designSystem;
    final color = designSystem.color;
    final shape = designSystem.shape;
    final spacing = designSystem.spacing;
    final typography = designSystem.typography;

    return Padding(
      padding: EdgeInsets.all(spacing.xs),
      child: Row(
        children: [
          DropdownMenuFormField(
            inputDecorationTheme: InputDecorationTheme(
              contentPadding: const EdgeInsets.all(4),
              constraints: const BoxConstraints.expand(
                height: 40,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(shape.xl),
                borderSide: BorderSide(color: color.outlineSoft),
              ),
              isDense: true,
            ),
            initialSelection: scope,
            dropdownMenuEntries: [
              for (final s in HomeEarthquakeHistoryScope.values)
                DropdownMenuEntry(value: s, label: scopeShortLabel(s)),
            ],
            onSelected: (value) {
              if (value != null) {
                onScopeChanged(value);
              }
            },
            menuStyle: MenuStyle(
              padding: WidgetStateProperty.all(EdgeInsets.zero),
              backgroundColor: WidgetStatePropertyAll(color.surfaceRaised),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(shape.md),
                  side: BorderSide(color: color.outlineSoft),
                ),
              ),
            ),
            decorationBuilder: (context, controller) => InputDecoration(
              filled: true,
              fillColor: color.surfaceRaised,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(shape.md),
                borderSide: BorderSide(color: color.outlineSoft),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(shape.md),
                borderSide: BorderSide(color: color.outlineSoft),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(shape.md),
                borderSide: BorderSide(color: color.outlineStrong),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: spacing.md,
                vertical: spacing.sm,
              ),
              visualDensity: VisualDensity.compact,
              hintStyle: typography.bodyMedium.copyWith(
                color: designSystem.textColor.tertiary,
              ),
            ),
            textStyle: typography.bodyLarge,
          ),
          if (locationName != null) ...[
            SizedBox(width: spacing.sm),
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
        ],
      ),
    );
  }
}
