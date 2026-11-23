import 'package:eqmonitor/core/util/haptic.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_notice.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

class const ShakeDetectionNoticeDialog({
  /// 注意事項の前に表示する、有効にする機能の説明。
  final String description =
      '揺れ検知は、試験提供している機能です。'
      '有効にする前に、以下の内容をご確認ください。',
  super.key,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final isAgreed = useState(false);
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;
    final typography = designSystem.typography;
    final bodyStyle = typography.bodyMedium.copyWith(
      color: colorTheme.onSurfaceVariant,
    );

    return AlertDialog(
      scrollable: true,
      title: const Text('揺れ検知（Beta）を有効にしますか？'),
      content: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          Text(description, style: bodyStyle),
          for (final (index, notice) in ShakeDetectionNotice.all.indexed) ...[
            SizedBox(height: spacing.lg),
            Text(
              '${index + 1}. ${notice.title}',
              style: typography.titleSmall.copyWith(
                color: colorTheme.onSurface,
              ),
            ),
            SizedBox(height: spacing.xs),
            Text(notice.body, style: bodyStyle),
          ],
          SizedBox(height: spacing.lg),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            controlAffinity: .leading,
            title: const Text('上記の注意事項を確認し、同意します'),
            value: isAgreed.value,
            onChanged: (value) =>
                HapticUtil.selection(() => isAgreed.value = value ?? false),
          ),
        ],
      ),
      actions: [
        M3ETextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('キャンセル'),
        ),
        M3EFilledButton(
          onPressed: isAgreed.value
              ? () => HapticUtil.light(() => Navigator.of(context).pop(true))
              : null,
          child: const Text('同意して有効にする'),
        ),
      ],
    );
  }
}
