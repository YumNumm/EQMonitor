import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:material_ui/material_ui.dart';

class const ProBadge({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorTheme = context.designSystem.colorTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorTheme.primaryContainer,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Text(
          'Pro',
          style: TextStyle(color: colorTheme.onPrimaryContainer),
        ),
      ),
    );
  }
}

class const LockedSettingTile({
  required final String title,
  required final String subtitle,
  required final bool locked,
  final VoidCallback? onTap,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: locked ? const ProBadge() : const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
