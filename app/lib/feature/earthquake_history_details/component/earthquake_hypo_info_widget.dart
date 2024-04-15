import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_icon_type.dart';
import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/provider/jma_code_table_provider.dart';
import 'package:eqmonitor/core/util/event_id.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_v1_extended.dart';
import 'package:eqmonitor/gen/fonts.gen.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class EarthquakeHypoInfoWidget extends HookConsumerWidget {
  const EarthquakeHypoInfoWidget({
    super.key,
    required this.item,
  });

  final EarthquakeV1Extended item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final intensityColorScheme = ref.watch(intensityColorProvider);

    final maxIntensity = item.maxIntensity;
    final colorScheme = switch (maxIntensity) {
      final JmaIntensity intensity =>
        intensityColorScheme.fromJmaIntensity(intensity),
      _ => null,
    };
    final codeTable = ref.watch(jmaCodeTableProvider);

    final hypoName = useMemoized(
      () => codeTable.areaEpicenter.items.firstWhereOrNull(
        (e) => int.tryParse(e.code) == item.epicenterCode,
      ),
      [item.epicenterCode],
    );
    final hypoDetailName = useMemoized(
      () => codeTable.areaEpicenterDetail.items.firstWhereOrNull(
        (e) => int.tryParse(e.code) == item.epicenterDetailCode,
      ),
      [item.epicenterDetailCode],
    );

    final maxIntensityWidget = maxIntensity != null
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('最大震度', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              JmaIntensityIcon(
                type: IntensityIconType.filled,
                size: 60,
                intensity: maxIntensity,
              ),
            ],
          )
        : null;
    // 「MaxInt, 震源地, 規模」
    final hypoWidget = Row(
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
                  text: hypoName?.name ?? '不明',
                  style: textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (hypoDetailName != null) ...[
                  const TextSpan(text: ' '),
                  TextSpan(
                    text: '(${hypoDetailName.name})',
                    style: textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );

    final creationDateFromEventId = EventId(item.eventId).toCreationDate();

    // 地震発生時刻
    final timeText =
        switch ((item.originTime, item.arrivalTime, creationDateFromEventId)) {
      (final DateTime originTime, _, _) =>
        DateFormat('yyyy/MM/dd HH:mm頃').format(
          originTime.toLocal(),
        ),
      (_, final DateTime arrivalTime, _) =>
        DateFormat('yyyy/MM/dd HH:mm頃').format(
          arrivalTime.toLocal(),
        ),
      (_, _, final DateTime creationDateFromEventId) =>
        DateFormat('yyyy/MM/dd HH:mm頃').format(
          creationDateFromEventId,
        ),
      _ => null,
    };
    final timeWidget = timeText != null
        ? Center(
            child: Text(
              timeText,
            ),
          )
        : null;

    // 「M 8.0 / 深さ100km」
    final magnitudeWidget = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        if (item.magnitudeCondition == null)
          Text(
            'M',
            style: textTheme.titleMedium!.copyWith(
              color: textTheme.titleMedium!.color!.withOpacity(0.8),
            ),
          ),
        Flexible(
          child: Text(
            switch ((
              item.magnitudeCondition,
              item.magnitude,
            )) {
              (final String cond, _) => cond.toHalfWidth,
              (_, final double value) => value.toStringAsFixed(1),
              // vxse53がある場合
              _ when item.intensityCities != null => '不明',
              _ => '調査中',
            },
            style: (item.magnitudeCondition != null
                    ? textTheme.headlineLarge
                    : textTheme.displaySmall)!
                .copyWith(
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
        if (item.depth != null && item.depth != 0 && item.depth != 700) ...[
          Text(
            item.depth.toString(),
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
              700 => '700km以上',
              // vxse53がある場合
              _ when item.intensityCities != null => '不明',
              _ => '調査中',
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
        (item.magnitudeCondition?.toHalfWidth == 'M不明' ||
                item.magnitude == null) &&
            item.depth == null;
    final magnitudeDepthUnknownWidget = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          'M・深さ',
          style: textTheme.titleMedium!.copyWith(
            color: textTheme.titleMedium!.color!.withOpacity(0.8),
          ),
        ),
        Text(
          switch (item.depth) {
            _ when item.intensityCities != null => '不明',
            _ => '調査中',
          },
          style: textTheme.displaySmall!.copyWith(
            fontWeight: FontWeight.w900,
            fontFamily: FontFamily.jetBrainsMono,
            fontFamilyFallback: [FontFamily.notoSansJP],
          ),
        ),
      ],
    );

    // M・深さ・震源 ともに不明の場合
    final isEarthquakeNull =
        isMagnitudeAndDepthUnknown && item.epicenterCode == null;

    final earthquakeNullWidget = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          'M・深さ・震源地',
          style: textTheme.titleMedium!.copyWith(
            color: textTheme.titleMedium!.color!.withOpacity(0.8),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          item.intensityCities != null ? '不明' : '調査中',
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
        if (isEarthquakeNull)
          earthquakeNullWidget
        else if (isMagnitudeAndDepthUnknown) ...[
          magnitudeDepthUnknownWidget,
          hypoWidget,
        ] else ...[
          magnitudeWidget,
          depthWidget,
          hypoWidget,
        ],
        if (timeWidget != null) timeWidget,
      ],
    );

    final card = Card(
      margin: const EdgeInsets.all(4),
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
            const SizedBox(height: 2),
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
