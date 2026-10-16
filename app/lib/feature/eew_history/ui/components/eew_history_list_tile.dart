import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/core/util/date_time_format.dart';
import 'package:eqmonitor/core/util/jma_depth_formatter.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:extensions/extensions.dart';
import 'package:material_ui/material_ui.dart';

class EewHistoryListTile extends StatelessWidget {
  const new({
    required this.item,
    this.onTap,
    this.visualDensity,
    super.key,
  });

  final EewTelegramItem item;
  final VoidCallback? onTap;
  final VisualDensity? visualDensity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCanceled = item.isCanceled;
    final hypocenter = isCanceled ? null : item.hypocenter;
    final maxIntensity = isCanceled
        ? null
        : item.forecastIntensity?.maxIntensity;
    final isWarning = !isCanceled && (item.isWarning ?? false);

    final title = isCanceled ? '緊急地震速報は取り消されました' : hypocenter?.name ?? '震源不明';
    final time = item.originTime ?? item.reportTime;
    final depth = hypocenter?.depth;
    final magnitude = hypocenter?.magnitude;
    final subtitleParts = [
      if (isCanceled)
        '${item.reportTime.formatWithTz(DateTimeFormat.yearMonthDayHourMinute)}取消発表'
      else
        '${time.formatWithTz(DateTimeFormat.yearMonthDayHourMinute)}発生',
      if (depth != null) '深さ ${const JmaDepthFormatter().format(depth: depth)}',
      if (magnitude != null) 'M${magnitude.toStringAsFixed(1)}',
    ];
    final reportLabel = '#${item.serialNo}${item.isLastInfo ? ' (最終)' : ''}';

    final intensityColors = context.designSystem.colorTheme.intensity;
    final maxIntensityColor = maxIntensity != null
        ? intensityColors.fromJmaIntensity(maxIntensity).background
        : null;

    return ListTile(
      visualDensity: visualDensity,
      tileColor: maxIntensityColor?.withValues(alpha: 0.4),
      onTap: onTap,
      leading: isCanceled
          ? Icon(
              Icons.cancel_outlined,
              size: 40,
              color: context.designSystem.colorTheme.onSurfaceVariant,
            )
          : JmaIntensityIcon(
              intensity: maxIntensity ?? JmaIntensity.unknown,
              type: .filled,
              size: 40,
            ),
      title: Row(
        spacing: 4,
        children: [
          if (isWarning)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(179, 26, 26, 1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                '警報',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: .bold,
                  fontSize: 11,
                ),
              ),
            ),
          Flexible(
            child: Text(
              title.toHalfWidth,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: .bold,
              ),
            ),
          ),
        ],
      ),
      subtitle: Text(
        subtitleParts.join(' '),
        style: const TextStyle(
          fontFamily: FontFamily.googleSansCode,
          fontFamilyFallback: [FontFamily.notoSansJP],
          letterSpacing: -0.2,
        ),
      ),
      trailing: Text(
        reportLabel,
        style: theme.textTheme.labelLarge?.copyWith(
          fontFamily: FontFamily.googleSansCode,
          fontFamilyFallback: const [FontFamily.notoSansJP],
        ),
      ),
    );
  }
}
