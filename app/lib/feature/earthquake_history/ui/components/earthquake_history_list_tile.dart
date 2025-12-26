import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_icon_type.dart';
import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
    final hypoName = hypocenter?.value.name;
    final hypoDetailName = hypocenter?.detailed?.name;

    // 最大震度観測地域
    final maxIntensityPrefectures = intensity?.prefectures
        .where((p) => p.maxIntensity == maxIntensity)
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
        '最大震度${maxInt.value}を${regionNames.first}などで観測',
      (
        _,
        _,
        final IntensityValue maxInt,
        final List<String> regionNames,
      ) when regionNames.isNotEmpty =>
        '最大震度${maxInt.value}を${regionNames.first}で観測',
      (_, _, final IntensityValue maxInt, _) => '最大震度${maxInt.value}を観測',
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
        _formatDepth(hypocenter?.depth);

    final intensityColorState = ref.watch(intensityColorProvider);
    final intensityColor = maxIntensity != null
        ? intensityColorState.fromIntensityValue(maxIntensity).background
        : null;
    final maxLpgmIntensity = intensity?.maxLpgmIntensity;

    final trailingText = _formatMagnitude(hypocenter?.magnitude);

    final chips = <Widget>[
      if (maxLpgmIntensity != null && maxLpgmIntensity != LpgmIntensityValue.zero)
        Chip(
          label: Text('最大長周期地震動階級 ${maxLpgmIntensity.value}'),
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
              fontFamily: FontFamily.notoSansMono,
              fontFamilyFallback: const [FontFamily.notoSansJP],
              letterSpacing: -0.2,
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
          fontFamily: FontFamily.notoSansMono,
          letterSpacing: -0.5,
        ),
      ),
      dense: dense,
      contentPadding: contentPadding,
    );
  }

  String _formatDepth(Depth? depth) {
    if (depth == null) {
      return '';
    }
    return switch (depth) {
      DepthShallow() => '深さ ごく浅い',
      DepthNormal(:final value) => '深さ ${value}km',
      DepthOver700() => '深さ 700km以上',
      DepthUnknown() => '',
    };
  }

  String _formatMagnitude(Magnitude? magnitude) {
    if (magnitude == null) {
      return '';
    }
    return switch (magnitude) {
      MagnitudeNormal(:final value) => 'M${value.toStringAsFixed(1)}',
      MagnitudeUnknown() => 'M不明',
      MagnitudeOverM8() => 'M8超',
    };
  }
}
