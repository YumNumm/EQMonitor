import 'package:eqmonitor/core/component/error/error_details_sheet.dart';
import 'package:eqmonitor/core/component/error/error_message_builder.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/util/fullscreen_loading_overlay.dart';
import 'package:eqmonitor/feature/settings/data/contact/contact_action.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ErrorCard extends ConsumerWidget {
  const ErrorCard({
    required this.error,
    super.key,
    this.title,
    this.suffixMessage,
    this.onReload,
    this.stackTrace,
    this.showDetails = true,
    this.showContact = true,
    this.onDioExceptionStatusOverride,
  });

  final Object error;
  final String? title;
  final String? suffixMessage;
  final Future<void> Function()? onReload;
  final StackTrace? stackTrace;
  final bool showDetails;
  final bool showContact;

  /// DioExceptionで、StatusCodeがある時にエラーメッセージを上書きする
  final String? Function(int statusCode)? onDioExceptionStatusOverride;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final designSystem = context.designSystem;
    final message = ref
        .read(errorMessageBuilderProvider)
        .build(
          error: error,
          onDioExceptionStatusOverride: onDioExceptionStatusOverride,
        );

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: designSystem.colorTheme.surfaceContainerHighest,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: designSystem.colorTheme.error,
            ),
            const SizedBox(height: 8),
            Text(
              title ?? 'エラーが発生しました',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(message, style: theme.textTheme.bodyMedium),
            if (suffixMessage case final suffix?) ...[
              const SizedBox(height: 4),
              Text(suffix, style: theme.textTheme.bodyMedium),
            ],
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                if (onReload case final reload?)
                  FilledButton.tonalIcon(
                    onPressed: () =>
                        FullScreenCircularProgressIndicator.showUntil(
                          context,
                          reload,
                        ),
                    icon: const Icon(Icons.refresh_rounded, size: 18),
                    label: const Text('再試行'),
                  ),
                if (showDetails)
                  TextButton(
                    onPressed: () => ref
                        .read(errorDetailsSheetActionProvider)
                        .show(context, error: error, stackTrace: stackTrace),
                    child: const Text('詳細'),
                  ),
                if (showContact)
                  TextButton(
                    onPressed: () async {
                      final open = ref.read(openContactProvider);
                      await open(ref, context);
                    },
                    child: const Text('問い合わせ'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
