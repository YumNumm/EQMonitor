import 'package:eqmonitor/core/component/progress/accessible_progress_indicator.dart';
import 'package:eqmonitor/feature/notification/data/model/test_notification_delivery.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

class const TestNotificationKindButtons({
  required final TestNotificationKind? pendingKind,
  required final List<TestNotificationKind> kinds,
  required final Future<void> Function(TestNotificationKind) onPressed,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 8,
    runSpacing: 8,
    children: kinds.map((kind) {
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
