import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:flutter/material.dart';

class SettingsSectionHeader extends StatelessWidget {
  const SettingsSectionHeader({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 16),
      child: Text(
        text,
        style: textTheme.titleSmall?.copyWith(
          color: context.designSystem.colorTheme.secondary,
        ),
      ),
    );
  }
}
