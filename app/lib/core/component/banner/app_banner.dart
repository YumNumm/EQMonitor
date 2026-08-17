import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:material_ui/material_ui.dart';

/// ホームシートなどに積み上げて表示する通知バナーの共通レイアウト。
///
/// 角丸・内側余白・タイポグラフィをバナー間で統一する。
///
/// バナー同士の間隔（下余白）もこの Widget が持つ。表示条件を満たさない
/// バナーが `SizedBox.shrink()` を返したときに、親側の `Column` の
/// `spacing` だと余白だけが残ってしまうため。
class AppBanner extends StatelessWidget {
  const new({
    required this.icon,
    required this.title,
    required this.backgroundColor,
    required this.foregroundColor,
    this.description,
    this.onTap,
    this.trailing,
    this.onDismiss,
    super.key,
  });

  final IconData icon;
  final String title;
  final String? description;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback? onTap;

  /// タイトル右側に置く操作（再試行ボタン・進捗表示など）。
  final Widget? trailing;

  /// 指定した場合は右端に閉じるボタンを表示する。
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;
    final typography = designSystem.typography;
    final description = this.description;
    final isDismissible = onDismiss != null;

    return Padding(
      padding: EdgeInsets.only(bottom: spacing.md),
      child: Material(
        color: backgroundColor,
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(designSystem.shape.card),
          side: BorderSide(color: designSystem.colorTheme.outlineVariant),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            // 閉じるボタンは自身のタップ領域を持つため、右側と上下の余白を詰める
            padding: EdgeInsets.fromLTRB(
              spacing.lg,
              isDismissible ? spacing.sm : spacing.md,
              isDismissible ? spacing.sm : spacing.lg,
              isDismissible ? spacing.sm : spacing.md,
            ),
            child: Row(
              spacing: spacing.md,
              children: [
                Icon(icon, color: foregroundColor, size: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: typography.bodyMedium.copyWith(
                          color: foregroundColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (description != null && description.isNotEmpty)
                        Text(
                          description,
                          style: typography.bodySmall.copyWith(
                            color: foregroundColor,
                          ),
                        ),
                    ],
                  ),
                ),
                if (trailing case final trailing?) trailing,
                if (onDismiss case final onDismiss?)
                  IconButton(
                    onPressed: onDismiss,
                    icon: Icon(
                      Icons.close_rounded,
                      color: foregroundColor,
                      size: 20,
                    ),
                    visualDensity: VisualDensity.compact,
                    tooltip: '閉じる',
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
