import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:material_ui/material_ui.dart';

/// ホームシートに並ぶカードの共通外枠。
///
/// 角丸・枠線・背景色をカード間で揃えるために利用する。
/// 内側の余白は [HomeSheetCardHeader] / [HomeSheetCardFooter] と
/// 各コンテンツ側で `spacing.lg` を基準に揃える。
class HomeSheetCard extends StatelessWidget {
  const new({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;

    return Card.outlined(
      margin: EdgeInsets.zero,
      color: colorTheme.surfaceContainerHigh,
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(designSystem.shape.card),
        side: BorderSide(color: colorTheme.outlineVariant),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}

class HomeSheetCardHeader extends StatelessWidget {
  const new({required this.title, this.action, super.key});

  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;
    final typography = designSystem.typography;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        spacing.lg,
        spacing.md,
        action == null ? spacing.lg : spacing.sm,
        spacing.xs,
      ),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        spacing: spacing.sm,
        children: [
          Flexible(
            child: Text(
              title,
              style: typography.titleSmall.copyWith(fontWeight: .bold),
              overflow: .ellipsis,
            ),
          ),
          if (action case final action?) Flexible(child: action),
        ],
      ),
    );
  }
}
