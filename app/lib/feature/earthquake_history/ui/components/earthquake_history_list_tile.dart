import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/current_location_intensity_display.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_area_info.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/current_location_intensity_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/magnitude_text.dart';
import 'package:eqmonitor/feature/location/data/location.dart';
import 'package:eqmonitor/feature/location/data/nearest_jma_feature.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lat_lng/lat_lng.dart';

class EarthquakeHistoryListTile extends ConsumerWidget {
  const EarthquakeHistoryListTile({
    required this.item,
    required this.intensityColor,
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
  final IntensityColorModel intensityColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    assert(
      areaInfo != null && areaName != null ||
          areaInfo == null && areaName == null,
      'areaInfoとareaNameはどちらもnot-null もしくは null である必要がある',
    );
    final theme = Theme.of(context);

    final hypocenter = item.hypocenter;
    final intensity = item.intensity;
    final maxIntensity = intensity?.maxIntensity;

    final hypoName = hypocenter?.name;
    final hypoDetailName = hypocenter?.detailedName;

    final title = switch ((hypoName, hypoDetailName, maxIntensity)) {
      (final String hypoName, final String hypoDetailName, _) =>
        '$hypoName($hypoDetailName)',
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
        ? intensityColor.fromJmaIntensity(maxIntensity).background
        : null;

    final magnitude = hypocenter?.magnitude;
    final areaChipLabel = switch ((areaName, areaInfo?.intensity)) {
      (final String name, final JmaIntensity intensity) =>
        '$name 震度${intensity.label}',
      _ => null,
    };
    final needsCurrentLocation =
        showCurrentLocationIntensity && areaInfo == null;
    final position = needsCurrentLocation
        ? ref.watch(locationStreamProvider).value
        : null;
    final latLng = position != null
        ? LatLng(position.latitude, position.longitude)
        : null;
    final city = latLng != null
        ? ref.watch(jmaMapAreaInformationCityInsideProvider(latLng)).value
        : null;
    final region = latLng != null
        ? ref.watch(jmaMapAreaForecastLocalEInsideProvider(latLng)).value
        : null;
    final currentLocationIntensity = needsCurrentLocation
        ? ref
              .watch(
                currentLocationIntensityProvider(
                  eventId: item.eventId,
                  cityAreaCode: city?.property?.code,
                  regionAreaCode: region?.property?.code,
                ),
              )
              .value
        : null;
    final currentLocationChipLabel =
        areaChipLabel ??
        switch (currentLocationIntensity) {
          CurrentLocationIntensityDisplayQuick(:final intensity) =>
            '現在地 震度${intensity.label} (速報)',
          CurrentLocationIntensityDisplayResult(:final intensity) =>
            '現在地 震度${intensity.label}',
          CurrentLocationIntensityDisplayNone() || null => null,
        };

    return ListTile(
      visualDensity: visualDensity,
      tileColor: showBackgroundColor
          ? maxIntensityColor?.withValues(alpha: 0.4)
          : null,
      onTap: onTap,
      title: Text(
        title,
        style: theme.textTheme.titleSmall!.copyWith(
          fontWeight: FontWeight.bold,
          color: titleTextColor,
        ),
      ),
      subtitle: Text.rich(
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
            if (currentLocationChipLabel != null)
              TextSpan(text: '\n$currentLocationChipLabel'),
          ],
        ),
      ),
      leading: maxIntensity != null
          ? JmaIntensityIcon(
              intensity: maxIntensity,
              type: .filled,
              size: intensityIconSize,
            )
          : null,
      trailing: MagnitudeText(magnitude: magnitude, color: magnitudeTextColor),
      dense: dense,
      contentPadding: contentPadding,
    );
  }
}
