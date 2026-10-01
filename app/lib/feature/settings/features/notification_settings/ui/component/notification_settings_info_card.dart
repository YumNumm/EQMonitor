import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:material_ui/material_ui.dart';

class NotificationSettingsInfoCard extends StatelessWidget {
  const new({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    return Card.outlined(
      margin: EdgeInsets.fromLTRB(
        designSystem.spacing.lg,
        designSystem.spacing.sm,
        designSystem.spacing.lg,
        designSystem.spacing.md,
      ),
      color: designSystem.colorTheme.surfaceContainerHigh,
      shape: RoundedSuperellipseBorder(
        borderRadius: .circular(designSystem.shape.card),
        side: BorderSide(color: designSystem.colorTheme.outlineVariant),
      ),
      child: Padding(
        padding: EdgeInsets.all(designSystem.spacing.lg),
        child: Text(text),
      ),
    );
  }
}
