import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_icon_type.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_value_icon.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final hypocenter = item.hypocenter;
    final intensity = item.intensity;
    final maxIntensity = intensity?.maxIntensity;

    // 震源名
    final hypoName = hypocenter?.code?.name;
    final hypoDetailName = hypocenter?.detailedCode?.name;

    // 最大震度観測地域
    final maxIntensityPrefectures = intensity?.prefectures
        ?.where((p) => p.maxIntensity == maxIntensity)
        .map((p) => p.value.name)
        .toList();

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
        final IntensityValue maxInt,
        final List<String> regionNames,
      ) when regionNames.length >= 2 =>
        '最大震度$maxIntを${regionNames.first}などで観測',
      (
        _,
        _,
        final IntensityValue maxInt,
        final List<String> regionNames,
      ) when regionNames.isNotEmpty =>
        '最大震度$maxIntを${regionNames.first}で観測',
      (_, _, final IntensityValue maxInt, _) => '最大震度$maxIntを観測',
      _ => '',
    };

    final dateFormatter = DateFormat('yyyy/MM/dd HH:mm');
    final subTitle =
        switch ((item.originTime, item.arrivalTime)) {
          (final DateTime originTime, _) =>
            '${dateFormatter.format(originTime.toLocal())}頃発生 ',
          (_, final DateTime arrivalTime) =>
            '${dateFormatter.format(arrivalTime.toLocal())}頃検知 ',
          _ => '',
        } +
        switch (hypocenter?.depth) {
          (final String depth) when depth == '0km' => '深さ ごく浅い',
          (final String depth) when depth == '700km以上' => '深さ 700km以上',
          (final String depth) => '深さ $depth',
          _ => '',
        };

    final intensityColorState = ref.watch(intensityColorProvider);
    final intensityColor = maxIntensity != null
        ? intensityColorState.fromIntensityValue(maxIntensity).background
        : null;
    final maxLpgmIntensity = intensity?.maxLpgmIntensity;

    final magnitude = hypocenter?.magnitude?.value.toStringAsFixed(1);
    final magnitudeCondition = hypocenter?.magnitude?.condition;
    final trailingText = switch (null) {
      _ when magnitudeCondition != null => magnitudeCondition,
      _ when magnitude != null => 'M$magnitude',
      _ => '',
    };

    final chips = <Widget>[
      if (maxLpgmIntensity != null && maxLpgmIntensity != LpgmIntensityValue.zero)
        Chip(
          label: Text('最大長周期地震動階級 $maxLpgmIntensity'),
          padding: EdgeInsets.zero,
        ),
    ];

    return ListTile(
      visualDensity: visualDensity,
      tileColor: showBackgroundColor
          ? intensityColor?.withValues(alpha: 0.4)
          : null,
      onTap: onTap,
      title: Text(
        title,
        style: theme.textTheme.titleMedium!.copyWith(
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
              fontFamily: GoogleFonts.notoSansJp().fontFamily,
              color: descriptionTextColor,
            ),
          ),
          ...chips,
        ],
      ),
      leading: maxIntensity != null
          ? IntensityValueIcon(
              intensity: maxIntensity,
              type: IntensityIconType.filled,
              size: intensityIconSize,
            )
          : null,
      trailing: Text(
        trailingText,
        style: theme.textTheme.labelLarge!.copyWith(
          fontWeight: FontWeight.bold,
          color: magnitudeTextColor,
        ),
      ),
      dense: dense,
      contentPadding: contentPadding,
    );
  }
}
