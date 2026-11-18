import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/debug/data/model/debug_mode_notice.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

class const DebugModeWarningDialog({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;
    final typography = designSystem.typography;
    final colorScheme = Theme.of(context).colorScheme;
    final foreground = colorScheme.onErrorContainer;

    return Dialog.fullscreen(
      backgroundColor: colorScheme.errorContainer,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(spacing.xl),
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        size: 56,
                        color: colorScheme.error,
                      ),
                      SizedBox(height: spacing.lg),
                      Text(
                        'デバッグ機能を有効にしますか？',
                        style: typography.headlineSmall.copyWith(
                          color: foreground,
                          fontWeight: .bold,
                        ),
                      ),
                      SizedBox(height: spacing.md),
                      Text(
                        '有効にする前に、以下の内容をご確認ください。',
                        style: typography.bodyMedium.copyWith(
                          color: foreground,
                        ),
                      ),
                      for (final notice in DebugModeNotice.values) ...[
                        SizedBox(height: spacing.xl),
                        Text(
                          notice.title,
                          style: typography.titleMedium.copyWith(
                            color: foreground,
                            fontWeight: .bold,
                          ),
                        ),
                        SizedBox(height: spacing.xs),
                        Text(
                          notice.body,
                          style: typography.bodyMedium.copyWith(
                            color: foreground,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              SizedBox(height: spacing.lg),
              M3EFilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                decoration: M3EButtonDecoration.styleFrom(
                  backgroundColor: colorScheme.error,
                  foregroundColor: colorScheme.onError,
                ),
                child: const Text('同意して有効にする'),
              ),
              SizedBox(height: spacing.sm),
              M3ETextButton(
                onPressed: () => Navigator.of(context).pop(false),
                decoration: M3EButtonDecoration.styleFrom(
                  foregroundColor: foreground,
                ),
                child: const Text('キャンセル'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
