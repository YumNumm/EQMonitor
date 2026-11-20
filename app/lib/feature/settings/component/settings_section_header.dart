import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:material_ui/material_ui.dart';

class const SettingsSectionHeader({
  required final String text,
  final Widget? trailing,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final trailing = this.trailing;
    final label = Text(
      text,
      style: textTheme.titleSmall?.copyWith(
        color: context.designSystem.colorTheme.secondary,
      ),
    );
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 16),
      child: trailing == null
          ? label
          : Row(
              mainAxisSize: .min,
              spacing: context.designSystem.spacing.sm,
              children: [label, trailing],
            ),
    );
  }
}
