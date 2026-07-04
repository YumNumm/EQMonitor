import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/magnitude_text.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EewHistoryListTile extends StatelessWidget {
  const EewHistoryListTile({
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
    final subTitle =
        '${dateFormatter.format(time.toLocal())}発生 '
        '${depth != null ? '深さ ${depth}km' : ''}';

    final intensityColors = context.designSystem.colorTheme.intensity;
    final maxIntensityColor = maxIntensity != null
        ? intensityColors.fromJmaIntensity(maxIntensity).background
        : null;

    final magnitude = hypocenter?.magnitude != null
        ? EarthquakeMagnitude.value(value: hypocenter!.magnitude!)
        : null;

    return ListTile(
      visualDensity: visualDensity,
      tileColor: maxIntensityColor?.withValues(alpha: 0.4),
      onTap: onTap,
      leading: maxIntensity != null
          ? JmaIntensityIcon(
              intensity: maxIntensity,
              type: .filled,
              size: 40,
            )
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
              style: theme.textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      subtitle: Text(
        subTitle,
        style: const TextStyle(
          fontFamily: FontFamily.googleSansCode,
          fontFamilyFallback: [FontFamily.notoSansJP],
          letterSpacing: -0.2,
        ),
      ),
      trailing: MagnitudeText(magnitude: magnitude),
    );
  }
}
