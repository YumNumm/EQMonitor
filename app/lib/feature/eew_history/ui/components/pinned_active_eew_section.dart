import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/eew/data/eew.dart';
import 'package:eqmonitor/feature/home/ui/component/eew/eew_card.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PinnedActiveEewSection extends ConsumerWidget {
  const PinnedActiveEewSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eews = ref.watch(eewProvider).value ?? const [];
    if (eews.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }
    final spacing = context.designSystem.spacing;
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(spacing.sm),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spacing.sm,
          children: [
            for (final eew in eews) EewCard(eew: eew, index: null),
          ],
        ),
      ),
    );
  }
}
