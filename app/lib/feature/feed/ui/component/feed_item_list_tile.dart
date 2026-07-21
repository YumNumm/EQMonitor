import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/feature/feed/data/model/feed_items.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Color? feedUrgencyColor(FeedItem item) {
  if (item.priority == .critical) {
    return Color(0xFFD32F2F);
  }
  if (item.isHighUrgency) {
    return Color(0xFFF57C00);
  }
  return null;
}

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
      'yyyy/MM/dd HH:mm頃発表',
    ).format(item.publishedAt.toLocal());

    final isEarthquakeNotice = item.feedType == .earthquakeNotice;
    final preferredTitle = isEarthquakeNotice ? item.summary : item.title;
    final title = (preferredTitle ?? '').replaceAll('◆', '');
    final summary = isEarthquakeNotice
        ? item.title?.replaceAll('◆', '')
        : item.summary;

    return ListTile(
      onTap: onTap,
      tileColor: urgencyColor?.withValues(alpha: 0.4),
      title: Text(
        title,
        style: theme.textTheme.titleSmall!.copyWith(
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
        overflow: .ellipsis,
      ),
      subtitle: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          if (summary != null && summary.isNotEmpty)
            Text(
              summary.toHalfWidth,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorTheme.onSurfaceVariant,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          Text(
            dateStr,
            style: theme.textTheme.labelSmall?.copyWith(
              fontFamily: FontFamily.googleSansCode,
              fontFamilyFallback: const [FontFamily.notoSansJP],
              letterSpacing: -0.2,
              color: colorTheme.onSurfaceVariant,
            ),
          ),
          // Row(
          //   children: [
          //     FeedTypeBadge(data: item.data),
          //     const SizedBox(width: 8),
          //     Text(
          //       dateStr,
          //       style: theme.textTheme.labelSmall?.copyWith(
          //         fontFamily: FontFamily.googleSansCode,
          //         fontFamilyFallback: const [FontFamily.notoSansJP],
          //         letterSpacing: -0.2,
          //         color: colorTheme.onSurfaceVariant,
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: colorTheme.onSurfaceVariant,
      ),
    );
  }
}
