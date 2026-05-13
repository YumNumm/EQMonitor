import 'package:collection/collection.dart';
import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/current_location_intensity_display.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/current_location_intensity_provider.dart';
import 'package:eqmonitor/feature/location/data/location.dart';
import 'package:eqmonitor/feature/location/data/nearest_jma_feature.dart';
import 'package:eqmonitor/feature/parameter/data/notifier/parameter_set_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lat_lng/lat_lng.dart';

class EarthquakeHistoryListTile extends HookConsumerWidget {
  const EarthquakeHistoryListTile({
    required this.item,
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
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final hypocenter = item.hypocenter;
    final intensity = item.intensity;
    final maxIntensity = intensity?.maxIntensity;

    final hypoName = hypocenter?.name;
    final hypoDetailName = hypocenter?.detailedName;

    const maxIntensityPrefectures = <String>[];
    final title = switch ((
      hypoName,
      hypoDetailName,
      maxIntensity,
      maxIntensityPrefectures,
    )) {
      (final String hypoName, final String hypoDetailName, _, _) =>
        '$hypoName($hypoDetailName)',
      (final String hypoName, _, _, _) => hypoName,
      (
        _,
        _,
        final JmaIntensity maxInt,
        final List<String> regionNames,
      )
          when regionNames.length >= 2 =>
        '最大震度${maxInt.label}を${regionNames.first}などで観測',
      (
        _,
        _,
        final JmaIntensity maxInt,
        final List<String> regionNames,
      )
          when regionNames.isNotEmpty =>
        '最大震度${maxInt.label}を${regionNames.first}で観測',
      (_, _, final JmaIntensity maxInt, _) => '最大震度${maxInt.label}を観測',
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
          _ => '',
        } +
        switch (depth) {
          EarthquakeDepthOver700km() => '深さ 700km以上',
          EarthquakeDepthShallow() => '深さ ごく浅い',
          EarthquakeDepthUnknown() => '',
          EarthquakeDepthValue(:final value) => '深さ ${value}km',
          null => '',
        };

    final intensityColorState = ref.watch(intensityColorProvider);
    final intensityColor = maxIntensity != null
        ? intensityColorState.fromJmaIntensity(maxIntensity).background
        : null;
    final maxLpgmIntensity = intensity?.maxLpgmIntensity;

    final magnitude = hypocenter?.magnitude;
    final trailingText = switch (magnitude) {
      EarthquakeMagnitudeValue(:final value) => 'M$value',
      EarthquakeMagnitudeUnknown() => 'M不明',
      EarthquakeMagnitudeOverM8() => 'M8超',
      null => '',
    };

    // 現在地情報（スコープが現在地の場合のみ取得）
    final position = showCurrentLocationIntensity
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

    final cityCode = city?.property?.code;
    final cityParam = showCurrentLocationIntensity && cityCode != null
        ? ref.watch(
            parameterSetProvider.select(
              (v) => v.value?.earthquake.prefectures
                  .expand(
                    (p) => p.regions.expand(
                      (r) => r.cities.map((c) => (prefecture: p, city: c)),
                    ),
                  )
                  .firstWhereOrNull((e) => e.city.code == cityCode),
            ),
          )
        : null;

    final regionCode = region?.property?.code;
    final regionParam = showCurrentLocationIntensity && regionCode != null
        ? ref.watch(
            parameterSetProvider.select(
              (v) => v.value?.earthquake.prefectures
                  .expand((p) => p.regions.map((r) => (prefecture: p, region: r)))
                  .firstWhereOrNull((e) => e.region.code == regionCode),
            ),
          )
        : null;

    final currentLocationIntensityAsync = showCurrentLocationIntensity
        ? ref.watch(
            currentLocationIntensityProvider(
              eventId: item.eventId,
              cityAreaCode: cityCode,
              regionAreaCode: regionCode,
            ),
          )
        : null;

    // 現在地の地名を解決
    String? currentLocationName;
    if (cityParam != null) {
      currentLocationName =
          '${cityParam.prefecture.name.ja}${cityParam.city.name.ja}';
    } else if (regionParam != null) {
      currentLocationName =
          '${regionParam.prefecture.name.ja}${regionParam.region.name.ja}';
    }

    // 現在地の震度チップテキストを解決
    String? currentLocationChipLabel;
    switch (currentLocationIntensityAsync?.value) {
      case CurrentLocationIntensityDisplayQuick(:final intensity):
        currentLocationChipLabel =
            '${currentLocationName != null ? "$currentLocationName " : ""}現在地で震度${intensity.label}を観測(速報)';
      case CurrentLocationIntensityDisplayResult(:final intensity):
        currentLocationChipLabel =
            '${currentLocationName != null ? "$currentLocationName " : ""}現在地で震度${intensity.label}を観測';
      case CurrentLocationIntensityDisplayNone():
      case null:
        if (currentLocationName != null) {
          currentLocationChipLabel = currentLocationName;
        }
    }

    // 現在地チップを構築
    Widget? currentLocationChip;
    if (showCurrentLocationIntensity && currentLocationChipLabel != null) {
      currentLocationChip = Chip(
        label: Text(currentLocationChipLabel),
        padding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      );
    }

    final chips = <Widget>[
      if (maxLpgmIntensity != null && maxLpgmIntensity != JmaLpgmIntensity.zero)
        Chip(
          label: Text('最大長周期地震動階級 ${maxLpgmIntensity.label}'),
          padding: EdgeInsets.zero,
        ),
      ?currentLocationChip,
    ];

    return ListTile(
      visualDensity: visualDensity,
      tileColor: showBackgroundColor
          ? intensityColor?.withValues(alpha: 0.4)
          : null,
      onTap: onTap,
      title: Text(
        title,
        style: theme.textTheme.titleSmall!.copyWith(
          fontWeight: FontWeight.bold,
          color: titleTextColor,
        ),
      ),
      subtitle: Wrap(
        spacing: 4,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            subTitle,
            style: TextStyle(
              fontFamily: FontFamily.googleSansCode,
              fontFamilyFallback: const [FontFamily.notoSansJP],
              letterSpacing: -0.2,
              color: descriptionTextColor,
            ),
          ),
          ...chips,
        ],
      ),
      leading: maxIntensity != null
          ? JmaIntensityIcon(
              intensity: maxIntensity,
              type: .filled,
              size: intensityIconSize,
            )
          : null,
      trailing: Text(
        trailingText,
        style: theme.textTheme.labelLarge!.copyWith(
          fontWeight: FontWeight.bold,
          color: magnitudeTextColor,
          fontFamily: FontFamily.googleSansCode,
          letterSpacing: -0.5,
        ),
      ),
      dense: dense,
      contentPadding: contentPadding,
    );
  }
}
