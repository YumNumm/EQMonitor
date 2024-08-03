import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqapi_types/model/v1/earthquake_early.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_icon_type.dart';
import 'package:eqmonitor/core/component/intenisty/jma_forecast_intensity_icon.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class EarthquakeHistoryEarlyListTile extends HookConsumerWidget {
  const EarthquakeHistoryEarlyListTile({
    required this.item,
    this.onTap,
    this.showBackgroundColor = true,
    super.key,
  });

  final EarthquakeEarly item;
  final void Function()? onTap;
  final bool showBackgroundColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final hypoName = item.name;

    final maxIntensity = item.maxIntensity;
    final title = switch ((
      hypoName,
      maxIntensity,
    )) {
      (
        final String hypoName,
        final JmaForecastIntensity _,
      ) =>
        hypoName,
      (
        final String hypoName,
        _,
      ) =>
        hypoName,
    };
    final originTime = item.originTime.toLocal();
    final subTitle = switch (item.originTimePrecision) {
          OriginTimePrecision.millisecond ||
          OriginTimePrecision.second =>
            DateFormat('yyyy/MM/dd HH:mm:ss ').format(originTime),
          OriginTimePrecision.minute =>
            DateFormat('yyyy/MM/dd HH:mm ').format(originTime),
          OriginTimePrecision.hour =>
            DateFormat('yyyy/MM/dd HH ').format(originTime),
          OriginTimePrecision.day =>
            DateFormat('yyyy/MM/dd ').format(originTime),
          OriginTimePrecision.month =>
            DateFormat('yyyy/MM ').format(originTime),
        } +
        switch (item.depth) {
          (final int depth) when depth == 0 => '深さ ごく浅い',
          (final int depth) when depth == 700 => '深さ 700km以上',
          (final int depth) => '深さ ${depth}km',
          _ => '',
        };
    final intensityColorState = ref.watch(intensityColorProvider);
    final intensityColor = maxIntensity != null
        ? intensityColorState.fromJmaForecastIntensity(maxIntensity).background
        : null;
    // 5 -> 5.0, 5.123 -> 5.1
    final magnitude = item.magnitude?.toStringAsFixed(1);
    final trailingText = switch (null) {
      _ when magnitude != null => 'M$magnitude',
      _ => '',
    };
    return ListTile(
      tileColor: showBackgroundColor ? intensityColor?.withOpacity(0.4) : null,
      onTap: onTap,
      title: Text(
        title,
        style: theme.textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Wrap(
        spacing: 4,
        children: [
          Text(
            subTitle,
            style: TextStyle(
              fontFamily: GoogleFonts.notoSansJp().fontFamily,
            ),
          ),
        ],
      ),
      leading: maxIntensity != null
          ? JmaForecastIntensityIcon(
              intensity: maxIntensity,
              type: IntensityIconType.filled,
              showSuffix: !item.maxIntensityIsEarly,
            )
          : null,
      trailing: Text(
        trailingText,
        style: theme.textTheme.labelLarge!.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
