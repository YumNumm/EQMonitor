import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/chip/custom_chip.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/component/intenisty/jma_forecast_intensity_icon.dart';
import 'package:eqmonitor/core/component/intenisty/jma_forecast_lg_intensity_icon.dart';
import 'package:eqmonitor/core/extension/intensity_value_ext.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/theme/build_theme.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class EewWidgets extends ConsumerWidget {
  const EewWidgets({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(eewAliveTelegramProvider) ?? [];

    return Column(
      children: state.reversed
          .mapIndexed(
            (index, element) => EewWidget(
              eew: element,
              index: (state.length > 1) ? '${index + 1}' : null,
            ),
          )
          .toList(),
    );
  }
}

class EewWidget extends ConsumerWidget {
  const EewWidget({required this.eew, required this.index, super.key});

  final EewItemWithRelations eew;
  final String? index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorTheme = theme.colorScheme;
    final intensityColorScheme = ref.watch(intensityColorProvider);

    if (eew.isCanceled) {
      return BorderedContainer(
        elevation: 1,
        margin: const EdgeInsets.symmetric(horizontal: 12) +
            const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(eew.headline ?? '先ほどの緊急地震速報は取り消されました'),
          ),
        ),
      );
    }

    final forecastIntensity = eew.forecastIntensity;
    final maxIntensityValue = forecastIntensity?.maxIntensity?.value;
    final maxIntensity = maxIntensityValue?.toJmaForecastIntensity ?? JmaForecastIntensity.unknown;
    final intensityScheme = intensityColorScheme.fromJmaForecastIntensity(maxIntensity);
    final (_, backgroundColor) = (
      intensityScheme.foreground,
      intensityScheme.background,
    );

    final isWarning = eew.isWarning ?? eew.headline?.contains('強い揺れ') ?? false;
    final header = Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        const Row(),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 4,
          children: [
            Text(
              '緊急地震速報 ${isWarning ? "警報" : "予報"}',
              style: textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            if (eew.isPlum)
              const CustomChip(
                borderWidth: 1,
                backgroundColor: Colors.transparent,
                child: Text(
                  'PLUM法',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: FontFamily.notoSansMono,
                  ),
                ),
              ),
          ],
        ),
        Text(
          '#${eew.serialNo}'
          '${eew.isLastInfo ? "(最終)" : ""}',
          style: textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: textTheme.titleMedium!.color!.withValues(alpha: 0.8),
            fontFamily: FontFamily.notoSansMono,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );

    final maxIntensityWidget = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          '最大震度',
          style: TextStyle(
            fontFamily: FontFamily.notoSansJP,
            letterSpacing: -0.5,
          ),
        ),
        JmaForecastIntensityWidget(size: 60, intensity: maxIntensity),
      ],
    );

    final hypocenter = eew.hypocenter;
    final hypoWidget = Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.ideographic,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          eew.isPlum ? '検知観測点' : '震源地',
          style: textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: textTheme.bodyMedium!.color!.withValues(alpha: 0.8),
          ),
        ),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            hypocenter?.value.name ?? '不明',
            style: textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );

    final happenedTime = eew.originTime ?? eew.arrivalTime;
    if (happenedTime == null) {
      return const SizedBox.shrink();
    }
    final timeWidget = Text(
      '${DateFormat('yyyy/MM/dd HH:mm:ss').format(happenedTime.toLocal())}'
      ' '
      '${(eew.originTime == null || eew.isPlum) ? "検知" : "発生"}',
      style: textTheme.bodyMedium!.copyWith(
        fontFamily: FontFamily.notoSansMono,
        fontFamilyFallback: const [FontFamily.notoSansJP],
        letterSpacing: -0.5,
      ),
    );

    final magnitude = hypocenter?.magnitude;
    final magnitudeWidget = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          'M',
          style: textTheme.titleMedium!.copyWith(
            color: textTheme.titleMedium!.color!.withValues(alpha: 0.8),
          ),
        ),
        if (magnitude != null) ...[
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: magnitude.toString().split('.').first,
                  style: textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: FontFamily.notoSansMono,
                  ),
                ),
                TextSpan(
                  text: '.',
                  style: textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: FontFamily.notoSansJP,
                  ),
                ),
                TextSpan(
                  text: magnitude.toString().split('.').last,
                  style: textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: FontFamily.notoSansMono,
                  ),
                ),
              ],
            ),
          ),
        ] else
          Text(
            '不明',
            style: textTheme.displaySmall!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );

    final depth = hypocenter?.depth;
    final depthWidget = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          '深さ',
          style: textTheme.titleMedium!.copyWith(
            color: textTheme.titleMedium!.color!.withValues(alpha: 0.8),
          ),
        ),
        if (depth != null) ...[
          Text(
            depth.toString(),
            style: textTheme.displaySmall!.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: FontFamily.notoSansMono,
            ),
          ),
          Text(
            'km',
            style: textTheme.titleMedium!.copyWith(
              color: textTheme.titleMedium!.color!.withValues(alpha: 0.8),
              fontFamily: FontFamily.notoSansMono,
            ),
          ),
        ] else
          Text(
            '不明',
            style: textTheme.displaySmall!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );

    final body = Wrap(
      spacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.center,
      children: [
        const Row(),
        hypoWidget,
        if (eew.isPlum)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'PLUM法による仮定震源要素',
              style: textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
          )
        else
          Wrap(
            children: [
              magnitudeWidget,
              const SizedBox(width: 4),
              depthWidget,
            ],
          ),
        timeWidget,
      ],
    );

    final headline = eew.headline?.toString().toHalfWidth;
    final warningMessageWidget = (headline != null)
        ? [
            Text(
              headline.split('で地震 ').getOrNull(1) ?? headline,
              style: textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(color: colorTheme.onSurface.withValues(alpha: 0.6)),
          ]
        : null;

    final maxLpgmIntensityValue = forecastIntensity?.maxLpgmIntensity?.value;
    final maxLpgmIntensity = maxLpgmIntensityValue?.toJmaForecastLgIntensity;
    final card = Card(
      elevation: 1,
      color: backgroundColor.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Color.lerp(
            backgroundColor,
            colorTheme.outline.withValues(alpha: 0.6),
            0.7,
          )!,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header,
            if (warningMessageWidget != null) ...warningMessageWidget,
            const SizedBox(height: 2),
            Row(
              children: [
                maxIntensityWidget,
                const SizedBox(width: 4),
                Expanded(child: body),
              ],
            ),
            if (maxLpgmIntensity != null &&
                maxLpgmIntensity != JmaForecastLgIntensity.zero) ...[
              Row(
                children: [
                  Column(
                    children: [
                      const Text('最大LPGM'),
                      JmaForecastLgIntensityWidget(intensity: maxLpgmIntensity),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '予想最大長周期地震動階級 ${maxLpgmIntensity.type}',
                          style: textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text('高層階では特に周期の長い揺れに注意してください'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        if (index != null)
          Center(
            child: FittedBox(
              child: Text(
                index.toString(),
                style: TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.bold,
                  fontFamily: monoFont,
                  color: textTheme.bodyMedium!.color!.withValues(alpha: 0.3),
                ),
              ),
            ),
          ),
        card,
        if (eew.status != TelegramStatus.normal)
          Center(
            child: FittedBox(
              child: Text(
                eew.status.name,
                style: TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.bold,
                  color: textTheme.bodyMedium!.color!.withValues(alpha: 0.2),
                  fontFamily: FontFamily.notoSansMono,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
