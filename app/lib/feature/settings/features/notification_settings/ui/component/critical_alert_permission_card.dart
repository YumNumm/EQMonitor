import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:flutter/material.dart';

class CriticalAlertPermissionCard extends StatelessWidget {
  const CriticalAlertPermissionCard({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;

    return Card.outlined(
      margin: EdgeInsets.fromLTRB(
        spacing.lg,
        spacing.sm,
        spacing.lg,
        spacing.md,
      ),
      child: Padding(
        padding: EdgeInsets.all(spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '現在地が緊急地震速報（警報）の対象になった場合に、'
              '消音モード中でも通知するには重大な通知の許可が必要です。',
            ),
            SizedBox(height: spacing.md),
            FilledButton(onPressed: onPressed, child: const Text('重大な通知を許可')),
          ],
        ),
      ),
    );
  }
}
