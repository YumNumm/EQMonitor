import 'package:collection/collection.dart';
import 'package:eqapi_schema/eqapi_schema.dart';
import 'package:eqmonitor/common/component/intenisty/jma_forecast_intensity_icon.dart';
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
        print(constraints);

        return SizedBox(
          width: constraints.maxWidth,
          child: Column(
            children: state
                .mapIndexed(
                  (index, element) => EewWidget(item: element, index: index),
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
  final int? index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    assert(item.latestEew != null && item.latestEewTelegram != null);
    final eew = item.latestEew!;
    final telegram = item.latestEewTelegram!;
    final intensityColorScheme = ref.watch(intensityColorProvider);
    final theme = Theme.of(context);
    if (eew is TelegramVxse45Cancel) {
      return Card(
        margin: const EdgeInsets.all(4),
        elevation: 1,
        shadowColor: Colors.transparent,
        // 角丸にして Border
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
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
          eew.forecastMaxInt?.to == JmaForecastIntensityOver.over
              ? eew.forecastMaxInt?.from
              : eew.forecastMaxInt?.to.toJmaForecastIntensity;

      // 「緊急地震速報 警報 [SPACE] #5(最終)」
      final isWarning = (telegram.headline ?? '').contains('強い揺れ');
      final header = Padding(
        padding: const EdgeInsets.all(2),
        child: Row(
          children: [
            FittedBox(
              child: Text(
                '緊急地震速報 ${isWarning ? "警報" : "予報"}',
                style: theme.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            Text(
              '#${telegram.serialNo}'
              '${eew.isLastInfo ? "(最終)" : ""}',
              style: theme.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                fontFamily: FontFamily.jetBrainsMono,
                fontFamilyFallback: [FontFamily.notoSansJP],
              ),
            ),
          ],
        ),
      );
      final (backgroundColor, foregroundColor) =
          intensityColorScheme.fromJmaForecastIntensity(maxIntensity!);
      final maxIntensityWidget = Column(
        children: [
          JmaForecastIntensityWidget(
            size: 60,
            intensity: maxIntensity,
          ),
          const Text('最大震度')
        ],
      );
      // 「[MaxInt, 震源地, 規模」
      final hypoWidget = Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.ideographic,
        children: [
          Text(
            '震源地',
            style: theme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.textTheme.bodyMedium!.color!.withOpacity(0.6),
            ),
          ),
          const SizedBox(width: 4),
          Text(
            eew.hypocenter?.name ?? '不明',
            style: theme.textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      );

      // 地震発生時刻
      final timeWidget = Text(
        '${DateFormat('yyyy/MM/dd HH:mm:ss').format(eew.originTime ?? eew.arrivalTime)}'
        ' '
        '${eew.originTime == null ? "検知" : "発生"}',
      );
      final body = Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 8,
        children: [
          maxIntensityWidget,
          hypoWidget,
          const Text(
            'Mx.x / 深さ xxx km',
          ),
          timeWidget,
        ],
      );
      final card = Card(
        margin: const EdgeInsets.all(4),
        elevation: 0,
        shadowColor: Colors.transparent,
        // 角丸にして Border
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
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
              const SizedBox(height: 2),
              Row(
                children: [
                  body,
                ],
              ),
            ],
          ),
        ),
      );
      if (index != null) {
        return LayoutBuilder(
          builder: (context, constraints) {
            print(constraints);
            return SizedBox(
              width: constraints.maxWidth,
              child: Stack(
                children: [
                  card,
                  const Center(
                    child: FittedBox(
                      child: Text(
                        '1',
                        style: TextStyle(
                          fontSize: 200,
                          fontWeight: FontWeight.w900,
                          fontFamily: FontFamily.jetBrainsMono,
                          color: Colors.white24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }
      return LayoutBuilder(
        builder: (context, constraints) {
          print(constraints);
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
