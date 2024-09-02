import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqapi_types/model/v1/earthquake_early.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_icon_type.dart';
import 'package:eqmonitor/core/component/intenisty/jma_forecast_intensity_icon.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class EarthquakeEarlyHypoInfoWidget extends HookConsumerWidget {
  const EarthquakeEarlyHypoInfoWidget({
    super.key,
    required this.item,
  });

  final EarthquakeEarlyEvent item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final intensityColorScheme = ref.watch(intensityColorProvider);

    final maxIntensity = item.maxIntensity;
    final colorScheme = switch (maxIntensity) {
      final JmaForecastIntensity intensity =>
        intensityColorScheme.fromJmaForecastIntensity(intensity),
      _ => null,
    };

    final maxIntensityWidget = maxIntensity != null
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('最大震度', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              JmaForecastIntensityIcon(
                type: IntensityIconType.filled,
                size: 60,
                intensity: maxIntensity,
                showSuffix: !item.maxIntensityIsEarly,
              ),
            ],
          )
        : null;

    // 「MaxInt, 震源地, 規模」
    final hypoWidget = item.name == '詳細不明'
        ? null
        : Row(
            textBaseline: TextBaseline.ideographic,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Text(
                '震源地',
                style: textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: textTheme.bodyMedium!.color!.withOpacity(0.8),
                ),
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: item.name,
                        style: textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );

    // 地震発生時刻
    final originTime = item.originTime.toLocal();
    final timeText = switch (item.originTimePrecision) {
      OriginTimePrecision.millisecond ||
      OriginTimePrecision.second =>
        DateFormat('yyyy/MM/dd HH:mm:ss ').format(originTime),
      OriginTimePrecision.minute =>
        DateFormat('yyyy/MM/dd HH:mm ').format(originTime),
      OriginTimePrecision.hour =>
        DateFormat('yyyy/MM/dd HH ').format(originTime),
      OriginTimePrecision.day => DateFormat('yyyy/MM/dd ').format(originTime),
      OriginTimePrecision.month => DateFormat('yyyy/MM ').format(originTime),
    };
    final timeWidget = Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '発生時刻 ',
            style: textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: textTheme.bodyMedium!.color!.withOpacity(0.8),
            ),
          ),
          TextSpan(
            text: timeText,
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: textTheme.bodyMedium?.color,
            ),
          ),
        ],
      ),
    );

    // 「M 8.0 / 深さ100km」
    final magnitudeWidget = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          'M',
          style: textTheme.titleMedium?.copyWith(
            color: textTheme.titleMedium?.color?.withOpacity(0.8),
          ),
        ),
        Flexible(
          child: Text(
            switch (item.magnitude) {
              final double value => value.toStringAsFixed(1),
              // vxse53がある場合
              _ => '不明',
            },
            style: textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: FontFamily.notoSansJP,
            ),
          ),
        ),
      ],
    );
    final depthWidget = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          '深さ',
          style: textTheme.titleMedium!.copyWith(
            color: textTheme.titleMedium!.color!.withOpacity(0.8),
          ),
        ),
        if (item.depth != null && item.depth != 0) ...[
          Text(
            item.depth!.toInt().toString(),
            style: textTheme.displaySmall!.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: FontFamily.notoSansJP,
            ),
          ),
          Text(
            'km',
            style: textTheme.titleMedium!.copyWith(
              color: textTheme.titleMedium!.color!.withOpacity(0.8),
            ),
          ),
        ] else
          Text(
            switch (item.depth) {
              0 => 'ごく浅い',
              _ => '不明',
            },
            style: textTheme.displaySmall!.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: FontFamily.notoSansJP,
            ),
          ),
      ],
    );
    // M・深さ ともに不明の場合
    final isMagnitudeAndDepthUnknown =
        (item.magnitude == null) && item.depth == null;
    final magnitudeDepthUnknownWidget = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          'M・深さ',
          style: textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: textTheme.bodyMedium!.color!.withOpacity(0.8),
          ),
        ),
        Text(
          switch (item.depth) {
            _ => '不明',
          },
          style: textTheme.displaySmall!.copyWith(
            fontWeight: FontWeight.w900,
            fontFamily: FontFamily.jetBrainsMono,
            fontFamilyFallback: [FontFamily.notoSansJP],
          ),
        ),
      ],
    );

    final body = Wrap(
      spacing: 8,
      crossAxisAlignment: WrapCrossAlignment.end,
      alignment: WrapAlignment.center,
      children: [
        const Row(),
        if (isMagnitudeAndDepthUnknown) ...[
          magnitudeDepthUnknownWidget,
          if (hypoWidget != null) hypoWidget,
        ] else ...[
          magnitudeWidget,
          depthWidget,
          if (hypoWidget != null) hypoWidget,
        ],
        const Row(),
        timeWidget,
      ],
    );

    final card = Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
      ).add(
        const EdgeInsets.only(bottom: 4),
      ),
      elevation: 0,

      shadowColor: Colors.transparent,
      // 角丸にして Border
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme?.background ?? Colors.transparent,
          width: 0,
        ),
      ),
      color: (colorScheme?.background ?? Colors.transparent).withOpacity(0.3),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        child: Column(
          children: [
            Row(
              children: [
                if (maxIntensityWidget != null) maxIntensityWidget,
                const SizedBox(width: 4),
                Expanded(child: body),
              ],
            ),
          ],
        ),
      ),
    );
    return card;
  }
}
