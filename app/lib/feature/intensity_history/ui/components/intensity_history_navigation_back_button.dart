import 'package:flutter/material.dart';

class IntensityHistoryNavigationBackButton extends StatelessWidget {
  const IntensityHistoryNavigationBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Navigator.canPop(context)) {
      return const SizedBox.shrink();
    }

    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: IconButton.filledTonal(
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(
              RoundedSuperellipseBorder(
                side: BorderSide(
                  color: colorScheme.primary.withValues(alpha: 0.2),
                ),
                borderRadius: BorderRadius.circular(128),
              ),
            ),
          ),
          tooltip: '戻る',
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          color: colorScheme.primary,
          padding: const EdgeInsets.all(12),
        ),
      ),
    );
  }
}
