import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

/// An expandable section with an accessible header and an unconstrained body.
class ExpandableSection extends HookWidget {
  const new({
    required this.title,
    required this.children,
    this.subtitle,
    this.leading,
    this.trailing,
    this.initiallyExpanded = false,
    this.onExpansionChanged,
    this.tilePadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.childrenPadding = EdgeInsets.zero,
    this.index = 0,
    this.totalCount = 1,
    super.key,
  });

  final Widget title;
  final List<Widget> children;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final bool initiallyExpanded;
  final ValueChanged<bool>? onExpansionChanged;
  final EdgeInsetsGeometry tilePadding;
  final EdgeInsetsGeometry childrenPadding;
  final int index;
  final int totalCount;

  @override
  Widget build(BuildContext context) {
    final expanded = useState(initiallyExpanded);
    final toggle = () {
      expanded.value = !expanded.value;
      onExpansionChanged?.call(expanded.value);
    };
    final textTheme = Theme.of(context).textTheme;

    return M3EExpandableSegmentedItem(
      index: index,
      totalCount: totalCount,
      isExpanded: expanded.value,
      onToggle: toggle,
      padding: tilePadding,
      childPadding: EdgeInsets.zero,
      showTrailingIcon: trailing == null,
      header: MergeSemantics(
        child: Semantics(
          button: true,
          expanded: expanded.value,
          onTap: toggle,
          child: Row(
            children: [
              if (leading case final leading?) ...[
                leading,
                const SizedBox(width: 16),
              ],
              Expanded(
                child: Column(
                  mainAxisSize: .min,
                  crossAxisAlignment: .start,
                  children: [
                    DefaultTextStyle.merge(
                      style: textTheme.titleMedium,
                      child: title,
                    ),
                    if (subtitle case final subtitle?)
                      DefaultTextStyle.merge(
                        style: textTheme.bodyMedium,
                        child: subtitle,
                      ),
                  ],
                ),
              ),
              if (trailing case final trailing?) ...[
                const SizedBox(width: 16),
                trailing,
              ],
            ],
          ),
        ),
      ),
      children: [
        Padding(
          padding: childrenPadding,
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .stretch,
            children: children,
          ),
        ),
      ],
    );
  }
}
