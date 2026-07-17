import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:eqmonitor/feature/feed/ui/component/feed_item_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// critical のベースカラー(赤)。
const _criticalColor = Color(0xFFD32F2F);

/// high / isImportant のベースカラー(オレンジ)。
const _highColor = Color(0xFFF57C00);

/// 緊急度の高いお知らせの強調色。緊急度が高くない場合は null。
Color? feedUrgencyColor(FeedItem item) {
  if (item.priority == FeedPriority.critical) {
    return _criticalColor;
  }
  if (item.isHighUrgency) {
    return _highColor;
  }
  return null;
}

IconData _feedTypeIcon(FeedItemData data) => switch (data) {
  FeedItemDataEarthquakeNotice() => Icons.crisis_alert,
  FeedItemDataEarthquakeExplanation() => Icons.menu_book,
  FeedItemDataEarthquakeCounts() => Icons.format_list_numbered,
  FeedItemDataEarthquakeNankai() => Icons.waves,
  FeedItemDataAppUpdate() => Icons.system_update,
  FeedItemDataIncident() => Icons.warning_amber_rounded,
  FeedItemDataDeveloperMessage() => Icons.campaign,
};

/// お知らせ一覧の1行。EarthquakeHistoryListTile と同じ ListTile 構成に揃える。
class FeedItemListTile extends StatelessWidget {
  const FeedItemListTile({required this.item, this.onTap, super.key});

  final FeedItem item;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorTheme = context.designSystem.colorTheme;
    final urgencyColor = feedUrgencyColor(item);
    final dateStr = DateFormat(
      'yyyy/MM/dd HH:mm',
    ).format(item.publishedAt.toLocal());
    final title = (item.title ?? item.summary ?? '').replaceAll('◆', '');
    final summary = item.title != null
        ? item.summary?.replaceAll('◆', '')
        : null;

    return ListTile(
      onTap: onTap,
      tileColor: urgencyColor?.withValues(alpha: 0.4),
      leading: _FeedTypeIconBox(
        icon: _feedTypeIcon(item.data),
        color: urgencyColor ?? colorTheme.surfaceContainerHighest,
        iconColor: urgencyColor != null
            ? Colors.white
            : colorTheme.onSurfaceVariant,
      ),
      title: Text(
        title,
        style: theme.textTheme.titleSmall!.copyWith(
          fontWeight: FontWeight.bold,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (summary != null && summary.isNotEmpty)
            Text(
              summary,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorTheme.onSurfaceVariant,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          Row(
            children: [
              FeedTypeBadge(data: item.data),
              const SizedBox(width: 8),
              Text(
                dateStr,
                style: theme.textTheme.labelSmall?.copyWith(
                  fontFamily: FontFamily.googleSansCode,
                  fontFamilyFallback: const [FontFamily.notoSansJP],
                  letterSpacing: -0.2,
                  color: colorTheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: colorTheme.onSurfaceVariant,
      ),
    );
  }
}

/// 震度アイコンと同じ角丸矩形の中に種別アイコンを表示する。
class _FeedTypeIconBox extends StatelessWidget {
  const _FeedTypeIconBox({
    required this.icon,
    required this.color,
    required this.iconColor,
  });

  final IconData icon;
  final Color color;
  final Color iconColor;

  static const _size = 40.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _size,
      width: _size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(_size / 5),
        ),
        child: Center(
          child: Icon(icon, color: iconColor, size: _size * 0.6),
        ),
      ),
    );
  }
}
