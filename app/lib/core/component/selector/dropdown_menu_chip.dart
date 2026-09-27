import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

/// A compact selection menu shared by sheet headers.
class DropdownMenuChip<T> extends StatelessWidget {
  const new({
    required this.label,
    required this.value,
    required this.entries,
    required this.onSelected,
    this.icon,
    this.additionalMenuChildren = const [],
    super.key,
  });

  final String label;
  final T value;
  final List<DropdownMenuChipEntry<T>> entries;
  final ValueChanged<T> onSelected;
  final IconData? icon;
  final List<Widget> additionalMenuChildren;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;

    return MenuAnchor(
      style: MenuStyle(
        padding: WidgetStateProperty.all(.zero),
        backgroundColor: WidgetStatePropertyAll(colorTheme.surfaceContainerLow),
        shape: WidgetStateProperty.all(
          RoundedSuperellipseBorder(
            borderRadius: BorderRadius.circular(designSystem.shape.md),
            side: BorderSide(color: colorTheme.outlineVariant),
          ),
        ),
      ),
      menuChildren: [
        for (final entry in entries)
          MenuItemButton(
            leadingIcon: entry.icon == null ? null : Icon(entry.icon, size: 20),
            trailingIcon: entry.value == value
                ? Icon(Icons.check_rounded, size: 20, color: colorTheme.primary)
                : null,
            onPressed: () => onSelected(entry.value),
            child: Text(entry.label, style: designSystem.typography.bodyLarge),
          ),
        if (additionalMenuChildren.isNotEmpty) ...[
          const Divider(height: 1),
          ...additionalMenuChildren,
        ],
      ],
      builder: (context, controller, child) => _DropdownChip(
        label: label,
        icon: icon,
        onTap: () async {
          if (controller.isOpen) {
            controller.close();
          } else {
            controller.open();
          }
          await HapticFeedback.lightImpact();
        },
      ),
    );
  }
}

class const DropdownMenuChipEntry<T>({
  required final T value,
  required final String label,
  final IconData? icon,
});

class _DropdownChip extends StatelessWidget {
  const new({required this.label, required this.onTap, this.icon});

  final String label;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;

    return Semantics(
      button: true,
      child: Material(
        color: colorTheme.surfaceContainerLow,
        shape: StadiumBorder(
          side: BorderSide(color: colorTheme.outlineVariant),
        ),
        clipBehavior: .antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: spacing.md,
              vertical: spacing.sm,
            ),
            child: Row(
              mainAxisSize: .min,
              spacing: spacing.xs,
              children: [
                if (icon != null)
                  Icon(icon, size: 16, color: colorTheme.onSurfaceVariant),
                Flexible(
                  child: Text(
                    label,
                    style: designSystem.typography.labelLarge,
                    maxLines: 1,
                    overflow: .ellipsis,
                  ),
                ),
                Icon(
                  Icons.expand_more_rounded,
                  size: 18,
                  color: colorTheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
