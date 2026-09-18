import 'package:eqmonitor/core/component/layout/history_selection.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/eew/data/eew.dart';
import 'package:eqmonitor/feature/home/ui/component/eew/eew_card.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PinnedActiveEewSection extends ConsumerWidget {
  const new({this.selectedEventId, this.onSelect, super.key});

  final String? selectedEventId;
  final ValueChanged<String>? onSelect;

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
            for (final eew in eews)
              HistorySelection(
                selected: selectedEventId == eew.eventId,
                child: InkWell(
                  onTap: onSelect == null
                      ? null
                      : () => onSelect?.call(eew.eventId),
                  child: EewCard(eew: eew, index: null),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
