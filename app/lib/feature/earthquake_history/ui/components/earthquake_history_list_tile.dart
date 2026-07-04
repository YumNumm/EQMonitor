import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_area_info.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/magnitude_text.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EarthquakeHistoryListTile extends StatelessWidget {
  const EarthquakeHistoryListTile({
    required this.item,
    this.areaInfo,
    this.areaName,
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

  /// 地域検索時にレスポンスに含まれる、検索対象地域の震度情報。
  /// `areaInfo`と`areaName`はどちらもnot-null もしくは null である必要がある
  final IntensityAreaInfo? areaInfo;
  final String? areaName;

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
    assert(
      areaInfo != null && areaName != null ||
          areaInfo == null && areaName == null,
      'areaInfoとareaNameはどちらもnot-null もしくは null である必要がある',
    );
    final theme = Theme.of(context);
    final intensityColors = context.designSystem.colorTheme.intensity;

    final hypocenter = item.hypocenter;
    final intensity = item.intensity;
    final maxIntensity = intensity?.maxIntensity;

    // 地震種別はサーバ(earthquake_type)から取得する。
    final earthquakeType = item.earthquakeType;

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
        switch ((item.originTime, item.arrivalTime)) {
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

    final tileBaseColor = switch (earthquakeType) {
      EarthquakeType.distant => _distantColor,
      EarthquakeType.volcano => _volcanoColor,
      EarthquakeType.normal => maxIntensityColor,
    };

    // 地域検索時に、検索対象地域の震度情報をレスポンスからそのまま表示する。
    final areaIntensity = areaInfo?.intensity;

    final magnitude = hypocenter?.magnitude;

    return ListTile(
      visualDensity: visualDensity,
      tileColor: showBackgroundColor
          ? tileBaseColor?.withValues(alpha: 0.4)
          : null,
      onTap: onTap,
      title: Text(
        title.toHalfWidth,
        style: theme.textTheme.titleSmall!.copyWith(
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
          if (areaName != null && areaIntensity != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: _AreaIntensityChip(
                areaName: areaName!,
                intensity: areaIntensity,
                intensityColors: intensityColors,
              ),
            ),
        ],
      ),
      leading: switch (earthquakeType) {
        EarthquakeType.distant => _ForeignEarthquakeIcon(
          size: intensityIconSize,
          color: _distantColor,
          icon: Icons.public,
        ),
        EarthquakeType.volcano => _ForeignEarthquakeIcon(
          size: intensityIconSize,
          color: _volcanoColor,
          icon: Icons.volcano,
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
  const _AreaIntensityChip({
    required this.areaName,
    required this.intensity,
    required this.intensityColors,
  });

  final String areaName;
  final JmaIntensity intensity;
  final IntensityColors intensityColors;

  @override
  Widget build(BuildContext context) {
    final entry = intensityColors.fromJmaIntensity(intensity);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: entry.background,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '$areaName 震度${intensity.label}',
        style: TextStyle(
          color: entry.resolvedForeground,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}

/// 遠地地震 (海外地震情報) のベースカラー(青)。
const _distantColor = Color(0xFF1976D2);

/// 火山噴火 (海外の大規模な噴火) のベースカラー(赤)。
const _volcanoColor = Color(0xFFD32F2F);

/// 海外地震情報・火山噴火用のアイコン。
/// 震度アイコン([JmaIntensityIcon]の`.filled`)と同じ角丸矩形の見た目に揃え、
/// ベースカラーの中にアイコンを白で表示する。
class _ForeignEarthquakeIcon extends StatelessWidget {
  const _ForeignEarthquakeIcon({
    required this.size,
    required this.color,
    required this.icon,
  });

  final double size;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(size / 5),
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
            size: size * 0.7,
          ),
        ),
      ),
    );
  }
}
