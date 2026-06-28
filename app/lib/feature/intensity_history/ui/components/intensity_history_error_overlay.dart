import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/prefecture_highest_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IntensityHistoryErrorOverlay extends ConsumerWidget {
  const IntensityHistoryErrorOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefectureHighestAsync = ref.watch(prefectureHighestProvider);
    final error = prefectureHighestAsync.error;

    if (error == null) {
      return const SizedBox.shrink();
    }

    return Positioned.fill(
      child: ColoredBox(
        color: Colors.black.withValues(alpha: 0.35),
        child: SafeArea(
          child: Center(
            child: ErrorCard(
              error: error,
              suffixMessage: '地図表示は利用できますが、最大震度の塗り分けは更新されません。',
            ),
          ),
        ),
      ),
    );
  }
}
