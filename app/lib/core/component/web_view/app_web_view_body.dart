import 'package:eqmonitor/core/component/progress/accessible_progress_indicator.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

enum AppWebViewLoadStatus { loading, loaded, error }

class AppWebViewBody extends StatelessWidget {
  const new({
    required this.webView,
    required this.status,
    required this.onRetry,
    super.key,
  });

  final Widget webView;
  final AppWebViewLoadStatus status;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final overlay = switch (status) {
      AppWebViewLoadStatus.loaded => const SizedBox.shrink(),
      AppWebViewLoadStatus.loading => ColoredBox(
        color: designSystem.colorTheme.surface,
        child: Center(
          child: AccessibleCircularProgressIndicator(
            color: designSystem.colorTheme.primary,
          ),
        ),
      ),
      AppWebViewLoadStatus.error => ColoredBox(
        color: designSystem.colorTheme.surface,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(designSystem.spacing.xl),
            child: Column(
              mainAxisSize: .min,
              spacing: designSystem.spacing.md,
              children: [
                Text(
                  'ページを読み込めませんでした',
                  style: designSystem.typography.titleMedium,
                ),
                Text(
                  '通信状況を確認して、もう一度お試しください。',
                  style: designSystem.typography.bodyMedium,
                  textAlign: .center,
                ),
                M3EFilledButton.tonal(
                  onPressed: onRetry,
                  child: const Text('再読み込み'),
                ),
              ],
            ),
          ),
        ),
      ),
    };

    return Stack(fit: .expand, children: [webView, overlay]);
  }
}
