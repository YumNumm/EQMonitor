import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:material_ui/material_ui.dart';

/// ホームシートに並ぶカードの共通外枠。
///
/// 角丸・枠線・背景色をカード間で揃えるために利用する。
/// 内側の余白は [HomeSheetCardHeader] / [HomeSheetCardFooter] と
/// 各コンテンツ側で `spacing.lg` を基準に揃える。
class HomeSheetCard extends StatelessWidget {
  const HomeSheetCard({required this.children, super.key});

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

/// [HomeSheetCard] のタイトル行。
///
/// [action] にはカード単位の操作（表示範囲の切り替えなど）を渡す。
class HomeSheetCardHeader extends StatelessWidget {
  const HomeSheetCardHeader({required this.title, this.action, super.key});

  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;
    final typography = designSystem.typography;

    return Padding(
      // action はタップ領域ぶんの内側余白を持つため、右側の余白を詰めて
      // カード内容の右端と視覚的に揃える
      padding: EdgeInsets.fromLTRB(
        spacing.lg,
        spacing.md,
        action == null ? spacing.lg : spacing.sm,
        spacing.sm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: spacing.sm,
        children: [
          Flexible(
            child: Text(
              title,
              style: typography.titleSmall.copyWith(
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (action case final action?) Flexible(child: action),
        ],
      ),
    );
  }
}

/// [HomeSheetCard] 下部の「さらに表示」行。
///
/// [onPressed] が null の場合はボタンを無効化して表示する。
class HomeSheetCardFooter extends StatelessWidget {
  const HomeSheetCardFooter({
    required this.onPressed,
    this.label = 'さらに表示',
    super.key,
  });

  final VoidCallback? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    final spacing = context.designSystem.spacing;

    return Padding(
      // TextButton 自身の内側余白ぶん右を詰め、文字の右端をカード内容に揃える
      padding: EdgeInsets.fromLTRB(spacing.lg, 0, spacing.xs, spacing.sm),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(onPressed: onPressed, child: Text(label)),
      ),
    );
  }
}
