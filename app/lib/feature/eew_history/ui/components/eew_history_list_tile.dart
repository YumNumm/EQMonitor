import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:extensions/extensions.dart';
import 'package:material_ui/material_ui.dart';
import 'package:intl/intl.dart';

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
    final hypocenter = item.hypocenter;
    final maxIntensity = item.forecastIntensity?.maxIntensity;
    final isWarning = item.isWarning ?? false;

    final title = hypocenter?.name ?? '震源不明';
    final dateFormatter = DateFormat('yyyy/MM/dd HH:mm');
    final time = item.originTime ?? item.reportTime;
    final depth = hypocenter?.depth;
    final magnitude = hypocenter?.magnitude;
    final subtitleParts = [
      '${dateFormatter.format(time.toLocal())}発生',
      if (depth != null) '深さ ${depth}km',
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
      leading: maxIntensity != null
          ? JmaIntensityIcon(intensity: maxIntensity, type: .filled, size: 40)
          : null,
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
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
          Flexible(
            child: Text(
              title.toHalfWidth,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
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
