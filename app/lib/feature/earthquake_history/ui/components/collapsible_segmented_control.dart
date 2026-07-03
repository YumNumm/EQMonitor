import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CollapsibleSegmentedControl<T> extends HookWidget {
  const CollapsibleSegmentedControl({
    required this.segments,
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final List<SegmentItem<T>> segments;
  final T selected;
  // ignore: unsafe_variance
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    final theme = Theme.of(context);
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;

    final selectedSegment = segments.firstWhere(
      (s) => s.value == selected,
      orElse: () => segments.first,
    );

    if (!isExpanded.value) {
      return Align(
        alignment: .centerRight,
        child: GestureDetector(
          onTap: () => isExpanded.value = true,
          child: Container(
            padding: const .symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: designSystem.colorTheme.secondaryContainer,
              borderRadius: .circular(8),
            ),
            child: Row(
              mainAxisSize: .min,
              spacing: spacing.xs,
              children: [
                Text(
                  selectedSegment.label,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: designSystem.colorTheme.onSecondaryContainer,
                    fontWeight: .bold,
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  size: 18,
                  color: designSystem.colorTheme.onSecondaryContainer,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return TapRegion(
      onTapOutside: (_) => isExpanded.value = false,
      child: Align(
        alignment: .centerRight,
        child: AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: .centerRight,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: designSystem.colorTheme.surfaceContainerHighest,
              borderRadius: .circular(8),
            ),
            child: Row(
              mainAxisSize: .min,
              children: [
                for (final segment in segments)
                  GestureDetector(
                    onTap: () {
                      onSelected(segment.value);
                      isExpanded.value = false;
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: .symmetric(
                        horizontal: spacing.xs,
                        vertical: spacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: segment.value == selected
                            ? designSystem.colorTheme.secondaryContainer
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        segment.label,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: segment.value == selected
                              ? designSystem.colorTheme.onSecondaryContainer
                              : designSystem.colorTheme.onSurfaceVariant,
                          fontWeight: segment.value == selected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SegmentItem<T> {
  const SegmentItem({required this.value, required this.label});
  final T value;
  final String label;
}
