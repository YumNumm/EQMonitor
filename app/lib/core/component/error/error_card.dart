import 'package:eqmonitor/core/component/error/error_message_builder.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
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
    final designSystem = context.designSystem;
    final message = ref
        .read(errorMessageBuilderProvider)
        .build(
          error: error,
          onDioExceptionStatusOverride: onDioExceptionStatusOverride,
        );

    return Center(
      child: Card(
        margin: margin,
        color: color ?? designSystem.colorTheme.errorContainer,
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error, size: 36, color: designSystem.colorTheme.error),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      title ?? 'ERROR!',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: designSystem.colorTheme.onErrorContainer,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: designSystem.colorTheme.onErrorContainer,
                  fontFamily: FontFamily.googleSansCode,
                ),
              ),
              if (suffixMessage case final msg?) ...[
                const SizedBox(height: 8),
                Text(
                  msg,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: designSystem.colorTheme.onErrorContainer,
                    fontFamily: FontFamily.googleSansCode,
                  ),
                ),
              ],
              if (onReload case final reload?) ...[
                const SizedBox(height: 8),
                FilledButton.tonalIcon(
                  onPressed: () =>
                      FullScreenCircularProgressIndicator.showUntil(
                        context,
                        reload,
                      ),
                  icon: const Icon(Icons.refresh),
                  label: const Text('再読み込み'),
                  style: FilledButton.styleFrom(
                    backgroundColor: designSystem.colorTheme.error,
                    foregroundColor: designSystem.colorTheme.onError,
                    iconColor: designSystem.colorTheme.onError,
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
