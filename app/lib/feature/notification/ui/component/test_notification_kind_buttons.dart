import 'package:eqmonitor/feature/notification/data/model/test_notification_delivery.dart';
import 'package:flutter/material.dart';

class TestNotificationKindButtons extends StatelessWidget {
  const TestNotificationKindButtons({
    required this.pendingKind,
    required this.onPressed,
    super.key,
  });

  final TestNotificationKind? pendingKind;
  final Future<void> Function(TestNotificationKind) onPressed;

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 8,
    runSpacing: 8,
    children: [TestNotificationKind.normal, TestNotificationKind.critical].map((
      kind,
    ) {
      final isPending = pendingKind == kind;
      return FilledButton.tonal(
        onPressed: pendingKind != null && !isPending
            ? null
            : () async => onPressed(kind),
        child: isPending
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator.adaptive(strokeWidth: 2),
              )
            : Text(kind.displayLabel),
      );
    }).toList(),
  );
}
