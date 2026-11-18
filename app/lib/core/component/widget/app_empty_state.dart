import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

class const AppEmptyState({
  required final String message,
  super.key,
  final IconData icon = Icons.inbox_outlined,
  final String? description,
  final VoidCallback? action,
  final String? actionLabel,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final action = this.action;
    final actionLabel = this.actionLabel;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(designSystem.spacing.lg),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Icon(
              icon,
              size: 48,
              color: designSystem.colorTheme.onSurfaceVariant,
            ),
            SizedBox(height: designSystem.spacing.sm),
            Text(
              message,
              style: designSystem.typography.titleSmall,
              textAlign: .center,
            ),
            if (description case final description?) ...[
              SizedBox(height: designSystem.spacing.xs),
              Text(
                description,
                style: designSystem.typography.bodySmall.copyWith(
                  color: designSystem.colorTheme.onSurfaceVariant,
                ),
                textAlign: .center,
              ),
            ],
            if (action != null && actionLabel != null) ...[
              SizedBox(height: designSystem.spacing.md),
              M3ETextButton(onPressed: action, child: Text(actionLabel)),
            ],
          ],
        ),
      ),
    );
  }
}
