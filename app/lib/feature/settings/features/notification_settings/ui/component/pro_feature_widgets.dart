import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:material_ui/material_ui.dart';

class ProBadge extends StatelessWidget {
  const new({super.key});

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

class LockedSettingTile extends StatelessWidget {
  const new({
    required this.title,
    required this.subtitle,
    required this.locked,
    this.onTap,
    super.key,
  });

  final String title;
  final String subtitle;
  final bool locked;
  final VoidCallback? onTap;

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
