import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:flutter/material.dart';

class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.description,
    this.action,
    this.actionLabel,
  });

  final String message;
  final IconData icon;
  final String? description;
  final VoidCallback? action;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(designSystem.spacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: designSystem.textColor.secondary),
            SizedBox(height: designSystem.spacing.sm),
            Text(
              message,
              style: designSystem.typography.titleSmall,
              textAlign: TextAlign.center,
            ),
            if (description != null) ...[
              SizedBox(height: designSystem.spacing.xs),
              Text(
                description!,
                style: designSystem.typography.bodySmall.copyWith(
                  color: designSystem.textColor.secondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (action != null && actionLabel != null) ...[
              SizedBox(height: designSystem.spacing.md),
              TextButton(onPressed: action, child: Text(actionLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}
