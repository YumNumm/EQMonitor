import 'package:collection/collection.dart';
import 'package:eqapi_schema/eqapi_schema.dart';
import 'package:eqapi_schema/extension/telegram_v3.dart';
import 'package:eqmonitor/common/component/chip/custom_chip.dart';
import 'package:eqmonitor/common/component/intenisty/jma_forecast_intensity_icon.dart';
import 'package:eqmonitor/common/extension/safe_list_access.dart';
import 'package:eqmonitor/common/extension/string.dart';
import 'package:eqmonitor/common/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/common/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/feature/earthquake_history/model/state/earthquake_history_item.dart';
import 'package:eqmonitor/feature/home/features/eew/eew_provider.dart';
import 'package:eqmonitor/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class EewWidgets extends ConsumerWidget {
  const EewWidgets({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(eewTelegramProvider);
    if (state.isEmpty) {
      return const SizedBox.shrink();
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          child: Column(
            children: state
                .mapIndexed(
                  (index, element) => EewWidget(
                    item: element,
                    index: (state.length > 1) ? '${index + 1}' : null,
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}

class EewWidget extends ConsumerWidget {
  const EewWidget({
    required this.item,
    required this.index,
    super.key,
  });

  final EarthquakeHistoryItem item;
  final String? index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    assert(item.latestEew != null && item.latestEewTelegram != null);
    final eew = item.latestEew!;
    final telegram = item.latestEewTelegram!;
    final intensityColorScheme = ref.watch(intensityColorProvider);
    if (eew is TelegramVxse45Cancel) {
      return Card(
        margin: const EdgeInsets.all(4),
        elevation: 1,
        shadowColor: Colors.transparent,
        // 角丸にして Border
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: theme.dividerColor.withOpacity(0.6),
            width: 0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          child: Row(
            children: [
              Text(eew.text),
            ],
          ),
        ),
      );
    }
    if (eew is TelegramVxse45Body) {
      final maxIntensity =
          (eew.forecastMaxInt?.to == JmaForecastIntensityOver.over
                  ? eew.forecastMaxInt?.from
                  : eew.forecastMaxInt?.to.toJmaForecastIntensity) ??
              JmaForecastIntensity.unknown;
      final intensityScheme =
          intensityColorScheme.fromJmaForecastIntensity(maxIntensity);
      final (foregroundColor, backgroundColor) =
          (intensityScheme.foreground, intensityScheme.background);
      // 「緊急地震速報 警報 [SPACE] #5(最終)」
      final isWarning = (telegram.headline ?? '').contains('強い揺れ');
      final header = Padding(
        padding: const EdgeInsets.all(2),
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Row(),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 4,
              children: [
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    '緊急地震速報 ${isWarning ? "警報" : "予報"}',
                    style: textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                if (eew.isLevelEew)
                  const CustomChip(
                    child: Text(
                      'レベル法',
                      style: TextStyle(
                        fontFamily: FontFamily.jetBrainsMono,
                        fontFamilyFallback: [FontFamily.notoSansJP],
                      ),
                    ),
                  ),
                if (eew.isIpfOnePoint)
                  const CustomChip(
                    child: Text(
                      '1点観測点による検出',
                      style: TextStyle(
                        fontFamily: FontFamily.jetBrainsMono,
                        fontFamilyFallback: [FontFamily.notoSansJP],
                      ),
                    ),
                  ),
                if (eew.isPlum)
                  const CustomChip(
                    child: Text(
                      'PLUM法',
                      style: TextStyle(
                        fontFamily: FontFamily.jetBrainsMono,
                        fontFamilyFallback: [FontFamily.notoSansJP],
                      ),
                    ),
                  ),
              ],
            ),
            Text(
              '#${telegram.serialNo}'
              '${eew.isLastInfo ? "(最終)" : ""}',
              style: textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w900,
                fontFamily: FontFamily.jetBrainsMono,
                fontFamilyFallback: [FontFamily.notoSansJP],
                color: textTheme.titleMedium!.color!.withOpacity(0.8),
              ),
            ),
          ],
        ),
      );
      final maxIntensityWidget = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('最大震度'),
          JmaForecastIntensityWidget(
            size: 60,
            intensity: maxIntensity,
          ),
        ],
      );
      // 「[MaxInt, 震源地, 規模」
      final hypoWidget = Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.ideographic,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            (eew.isPlum || eew.isLevelEew) ? '検知観測点' : '震源地',
            style: textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: textTheme.bodyMedium!.color!.withOpacity(0.7),
            ),
          ),
          const SizedBox(width: 4),
          Text(
            eew.hypocenter?.name ?? '不明',
            style: textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      );

      // 地震発生時刻
      final timeWidget = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '${DateFormat('yyyy/MM/dd HH:mm:ss').format(
              (eew.originTime ?? eew.arrivalTime).toLocal(),
            )}'
            ' '
            '${eew.originTime == null ? "検知" : "発生"}',
            style: textTheme.bodyMedium!.copyWith(
              fontFamily: FontFamily.jetBrainsMono,
              fontFamilyFallback: [FontFamily.notoSansJP],
            ),
          ),
        ],
      );

      // 「M 8.0 / 深さ100km」
      final magnitudeWidget = Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            'M',
            style: textTheme.titleMedium!.copyWith(
              color: textTheme.titleMedium!.color!.withOpacity(0.7),
            ),
          ),
          Text(
            (eew.magnitude ?? '不明').toString(),
            style: textTheme.displaySmall!.copyWith(
              fontWeight: FontWeight.w900,
              fontFamily: FontFamily.notoSansJP,
              fontFamilyFallback: [FontFamily.notoSansJP],
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
              color: textTheme.titleMedium!.color!.withOpacity(0.7),
            ),
          ),
          if (eew.depth != null) ...[
            Text(
              eew.depth.toString(),
              style: textTheme.displaySmall!.copyWith(
                fontWeight: FontWeight.w900,
                fontFamily: FontFamily.notoSansJP,
                fontFamilyFallback: [FontFamily.notoSansJP],
              ),
            ),
            Text(
              'km',
              style: textTheme.titleMedium!.copyWith(
                color: textTheme.titleMedium!.color!.withOpacity(0.7),
              ),
            ),
          ] else
            Text(
              '不明',
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
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        children: [
          const Row(),
          hypoWidget,
          if (eew.isPlum) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'PLUM法による仮定震源要素',
                style: textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w900,
                  fontFamily: FontFamily.notoSansJP,
                  fontFamilyFallback: [FontFamily.notoSansJP],
                ),
              ),
            ),
          ] else
            AnimatedOpacity(
              opacity: (eew.isIpfOnePoint || eew.isLevelEew) ? 0.6 : 1,
              duration: const Duration(milliseconds: 400),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  magnitudeWidget,
                  const SizedBox(width: 4),
                  depthWidget,
                ],
              ),
            ),
          timeWidget,
        ],
      );
      final headline = telegram.headline?.toString().toHalfWidth();
      final warningMessageWidget = (headline != null)
          ? [
              Text(
                headline.split('で地震 ').getOrNull(1) ?? headline,
                style: textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
            ]
          : null;
      final card = Card(
        margin: const EdgeInsets.all(4),
        elevation: 0,
        shadowColor: Colors.transparent,
        // 角丸にして Border
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: foregroundColor,
            width: 0,
          ),
        ),
        color: backgroundColor.withOpacity(0.3),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          child: Column(
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
            ],
          ),
        ),
      );
      if (index != null) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: constraints.maxWidth,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: FittedBox(
                      child: Text(
                        (index).toString(),
                        style: TextStyle(
                          fontSize: 100,
                          fontWeight: FontWeight.w900,
                          fontFamily: FontFamily.jetBrainsMono,
                          fontFamilyFallback: const [FontFamily.notoSansJP],
                          color: textTheme.bodyMedium!.color!.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                  card,
                ],
              ),
            );
          },
        );
      }
      return LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            width: constraints.maxWidth,
            child: card,
          );
        },
      );
    }
    throw Exception('不明なタイプの緊急地震速報を受信しました ${eew.runtimeType}');
  }
}