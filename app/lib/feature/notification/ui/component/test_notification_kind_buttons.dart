import 'package:eqmonitor/core/component/progress/accessible_progress_indicator.dart';
import 'package:eqmonitor/feature/notification/data/model/test_notification_delivery.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

class TestNotificationKindButtons extends StatelessWidget {
  const new({
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
      return M3EFilledButton.tonal(
        onPressed: pendingKind == null ? () async => onPressed(kind) : null,
        child: isPending
            ? const SizedBox(
                width: 18,
                height: 18,
                child: AccessibleCircularProgressIndicator(strokeWidth: 2),
              )
            : Text(kind.displayLabel),
      );
    }).toList(),
  );
}
