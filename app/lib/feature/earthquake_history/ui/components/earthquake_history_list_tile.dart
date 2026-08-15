import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_type_icon.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/magnitude_text.dart';
import 'package:extensions/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

class EarthquakeHistoryListTile extends StatelessWidget {
  const new({
    required this.item,
    required this.searchParameter,
    this.onTap,
    this.showBackgroundColor = true,
    this.intensityIconSize = 40.0,
    this.titleTextColor,
    this.descriptionTextColor,
    this.magnitudeTextColor,
    this.visualDensity,
    this.dense = false,
    this.contentPadding,
    this.showCurrentLocationIntensity = false,
    super.key,
  });

  final EarthquakePartial item;
  final EarthquakeHistoryParameter searchParameter;

  final void Function()? onTap;
  final bool showBackgroundColor;
  final double intensityIconSize;
  final Color? titleTextColor;
  final Color? descriptionTextColor;
  final Color? magnitudeTextColor;
  final VisualDensity? visualDensity;
  final bool dense;
  final EdgeInsets? contentPadding;
  final bool showCurrentLocationIntensity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final intensityColors = context.designSystem.colorTheme.intensity;

    final earthquake = item.earthquake;
    final hypocenter = earthquake.hypocenter;
    final intensity = earthquake.intensity;
    final maxIntensity = intensity?.maxIntensity;

    final hypoName = hypocenter?.name;
    final hypoDetailName = hypocenter?.detailedName;

    final title = switch ((hypoName, hypoDetailName, maxIntensity)) {
      (final String hypoName, final String hypoDetailName, _) =>
        '$hypoName($hypoDetailName)'.replaceAll('、', ' '),
      (final String hypoName, _, _) => hypoName,
      (_, _, final JmaIntensity maxInt) => '最大震度${maxInt.label}を観測',
      _ => '',
    };

    final dateFormatter = DateFormat('yyyy/MM/dd HH:mm');
    final depth = hypocenter?.depth;
    final subTitle =
        switch ((earthquake.originTime, earthquake.arrivalTime)) {
          (final DateTime originTime, _) =>
            '${dateFormatter.format(originTime.toLocal())}頃発生 ',
          (_, final DateTime arrivalTime) =>
            '${dateFormatter.format(arrivalTime.toLocal())}頃検知 ',
          _ => '震源要素 調査中',
        } +
        switch (depth) {
          EarthquakeDepthOver700km() => '深さ 700km以上',
          EarthquakeDepthShallow() => '深さ ごく浅い',
          EarthquakeDepthUnknown() => '',
          EarthquakeDepthValue(:final value) => '深さ ${value}km',
          null => '',
        };

    final maxIntensityColor = maxIntensity != null
        ? intensityColors.fromJmaIntensity(maxIntensity).background
        : null;

    final tileBaseColor =
        earthquake.earthquakeType.baseColor ?? maxIntensityColor;

    final magnitude = hypocenter?.magnitude;

    return ListTile(
      visualDensity: visualDensity,
      tileColor: showBackgroundColor
          ? tileBaseColor?.withValues(alpha: 0.4)
          : null,
      onTap: onTap,
      title: Text(
        title.toHalfWidth,
        style: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: titleTextColor,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: subTitle,
                  style: TextStyle(
                    fontFamily: FontFamily.googleSansCode,
                    fontFamilyFallback: const [FontFamily.notoSansJP],
                    letterSpacing: -0.2,
                    color: descriptionTextColor,
                  ),
                ),
              ],
            ),
          ),
          if (item is! EarthquakePartialNormal)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Consumer(
                builder: (context, ref, _) {
                  return _AreaIntensityChip(
                    intensity: switch (item) {
                      EarthquakePartialPrefecture(:final prefectureIntensity) =>
                        prefectureIntensity,
                      EarthquakePartialRegion(:final regionIntensity) =>
                        regionIntensity,
                      EarthquakePartialCity(:final cityIntensity) =>
                        cityIntensity,
                      EarthquakePartialStation(:final stationIntensity) =>
                        stationIntensity,
                      EarthquakePartialNormal() => throw StateError(
                        'EarthquakePartialNormal is not supported',
                      ),
                    },
                    intensityColors: intensityColors,
                  );
                },
              ),
            ),
        ],
      ),
      leading: switch (earthquake.earthquakeType) {
        EarthquakeType.distant || EarthquakeType.volcano => EarthquakeTypeIcon(
          type: earthquake.earthquakeType,
          size: intensityIconSize,
        ),
        EarthquakeType.normal when maxIntensity != null => JmaIntensityIcon(
          intensity: maxIntensity,
          type: .filled,
          size: intensityIconSize,
        ),
        EarthquakeType.normal => null,
      },
      trailing: MagnitudeText(magnitude: magnitude, color: magnitudeTextColor),
      dense: dense,
      contentPadding: contentPadding,
    );
  }
}

/// 検索対象地域の震度情報を表示する小さなチップ。
/// 「(地域名) 震度N」を、その震度の色で塗りつぶして表示する。
class _AreaIntensityChip extends StatelessWidget {
  const new({required this.intensity, required this.intensityColors});

  final JmaIntensity intensity;
  final IntensityColors intensityColors;

  @override
  Widget build(BuildContext context) {
    final entry = intensityColors.fromJmaIntensity(intensity);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: entry.background,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '震度${intensity.label}',
        style: TextStyle(
          color: entry.resolvedForeground,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
