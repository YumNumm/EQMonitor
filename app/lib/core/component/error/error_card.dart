import 'package:eqmonitor/core/component/error/error_message_builder.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/util/fullscreen_loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ErrorCard extends ConsumerWidget {
  const ErrorCard({
    required this.error,
    super.key,
    this.onDioExceptionStatusOverride,
    this.color,
    this.suffixMessage,
    this.title,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.onReload,
  });

  final Object error;
  final Color? color;
  final String? title;
  final String? suffixMessage;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  /// DioExceptionで、StatusCodeがある時に　エラーメッセージを上書きする
  final String? Function(int statusCode)? onDioExceptionStatusOverride;

  /// 再読み込み
  final Future<void> Function()? onReload;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final message = ref.read(errorMessageBuilderProvider).build(
      error: error,
      onDioExceptionStatusOverride: onDioExceptionStatusOverride,
    );
    final colorScheme = theme.colorScheme;

    return Center(
      child: Card(
        margin: margin,
        color: color ?? theme.colorScheme.errorContainer,
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error, size: 36, color: colorScheme.error),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      title ?? 'ERROR!',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onErrorContainer,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onErrorContainer,
                  fontFamily: FontFamily.googleSansCode,
                ),
              ),
              if (suffixMessage != null) ...[
                const SizedBox(height: 8),
                Text(
                  suffixMessage!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onErrorContainer,
                    fontFamily: FontFamily.googleSansCode,
                  ),
                ),
              ],
              if (onReload != null) ...[
                const SizedBox(height: 8),
                FilledButton.tonalIcon(
                  onPressed: () =>
                      FullScreenCircularProgressIndicator.showUntil(
                        context,
                        onReload!,
                      ),
                  icon: const Icon(Icons.refresh),
                  label: const Text('再読み込み'),
                  style: FilledButton.styleFrom(
                    backgroundColor: colorScheme.error,
                    foregroundColor: colorScheme.onError,
                    iconColor: colorScheme.onError,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
