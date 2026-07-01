import 'package:flutter/material.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';

class IntensityHistoryNavigationBackButton extends StatelessWidget {
  const IntensityHistoryNavigationBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Navigator.canPop(context)) {
      return const SizedBox.shrink();
    }

    final colorTheme = context.designSystem.colorTheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: IconButton.filledTonal(
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(
              RoundedSuperellipseBorder(
                side: BorderSide(
                  color: colorTheme.primary.withValues(alpha: 0.2),
                ),
                borderRadius: BorderRadius.circular(128),
              ),
            ),
          ),
          tooltip: '戻る',
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          color: colorTheme.primary,
          padding: const EdgeInsets.all(12),
        ),
      ),
    );
  }
}
