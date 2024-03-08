import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/chip/custom_chip.dart';
import 'package:eqmonitor/core/component/intenisty/jma_forecast_intensity_icon.dart';
import 'package:eqmonitor/core/component/intenisty/jma_forecast_lg_intensity_icon.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history_old/model/state/earthquake_history_item.dart';
import 'package:eqmonitor/feature/home/features/eew/provider/eew_alive_telegram.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class EewWidgets extends ConsumerWidget {
  const EewWidgets({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(eewAliveTelegramProvider) ?? [];
    if (state.isEmpty) {
      return const SizedBox.shrink();
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: SizedBox(
            key: ValueKey(state.length),
            width: constraints.maxWidth,
            child: Column(
              children: state.reversed
                  .mapIndexed(
                    (index, element) => EewWidget(
                      item: element,
                      index: (state.length > 1) ? '${index + 1}' : null,
                    ),
                  )
                  .toList(),
            ),
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
          child: Text(eew.text),
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
      final header = Wrap(
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (eew.isLevelEew)
                const CustomChip(
                  borderWidth: 1,
                  backgroundColor: Colors.transparent,
                  child: Text(
                    'レベル法',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              if (eew.isIpfOnePoint)
                const CustomChip(
                  borderWidth: 1,
                  backgroundColor: Colors.transparent,
                  child: Text(
                    '1点観測点による検知',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              if (eew.isPlum)
                const CustomChip(
                  borderWidth: 1,
                  backgroundColor: Colors.transparent,
                  child: Text(
                    'PLUM法',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
            ],
          ),
          Text(
            '#${telegram.serialNo}'
            '${eew.isLastInfo ? "(最終)" : ""}',
            style: textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: textTheme.titleMedium!.color!.withOpacity(0.8),
            ),
          ),
        ],
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
              color: textTheme.bodyMedium!.color!.withOpacity(0.8),
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
      final timeWidget = Text(
        '${DateFormat('yyyy/MM/dd HH:mm:ss').format(
          (eew.originTime ?? eew.arrivalTime).toLocal(),
        )}'
        ' '
        '${eew.originTime == null ? "検知" : "発生"}',
        style: textTheme.bodyMedium,
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
              color: textTheme.titleMedium!.color!.withOpacity(0.8),
            ),
          ),
          Text(
            (eew.magnitude ?? '不明').toString(),
            style: textTheme.displaySmall!.copyWith(
              fontWeight: FontWeight.w900,
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
          if (eew.depth != null) ...[
            Text(
              eew.depth.toString(),
              style: textTheme.displaySmall!.copyWith(
                fontWeight: FontWeight.w900,
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
              '不明',
              style: textTheme.displaySmall!.copyWith(
                fontWeight: FontWeight.w900,
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
                ),
              ),
            ),
          ] else if (eew.isLevelEew) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'レベル法による仮定震源要素',
                style: textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ] else
            AnimatedOpacity(
              opacity: (eew.isIpfOnePoint || eew.isLevelEew) ? 0.7 : 1,
              duration: const Duration(milliseconds: 400),
              child: Wrap(
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
      final headline = telegram.headline?.toString().toHalfWidth;
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
      final maxLgInt = eew.forecastMaxLgInt?.toDisplayMaxLgInt();
      final card = InkWell(
        onLongPress: () =>
            EewHisotryDetailRoute($extra: item).push<void>(context),
        child: Card(
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
                if (maxLgInt != null &&
                    ![
                      JmaForecastLgIntensity.zero,
                      JmaForecastLgIntensity.unknown,
                    ].contains(maxLgInt.maxLgInt)) ...[
                  Row(
                    children: [
                      Column(
                        children: [
                          const Text('最大LPGM'),
                          JmaForecastLgIntensityWidget(
                            intensity: maxLgInt.maxLgInt,
                          ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '予想最大長周期地震動階級 ${maxLgInt.maxLgInt.type}',
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
        ),
      );
      return Stack(
        alignment: Alignment.center,
        children: [
          if (index != null) ...[
            Center(
              child: FittedBox(
                child: Text(
                  (index).toString(),
                  style: TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.w900,
                    color: textTheme.bodyMedium!.color!.withOpacity(0.3),
                  ),
                ),
              ),
            ),
            Center(
              child: FittedBox(
                child: Text(
                  (index).toString(),
                  style: TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.w900,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 0
                      ..color = textTheme.bodyMedium!.color!.withOpacity(0.3),
                  ),
                ),
              ),
            ),
          ],
          card,
          if (telegram.status != TelegramStatus.normal)
            Center(
              child: FittedBox(
                child: Text(
                  telegram.status.type,
                  style: TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.w900,
                    color: textTheme.bodyMedium!.color!.withOpacity(0.4),
                  ),
                ),
              ),
            ),
        ],
      );
    }
    return Text('不明なタイプの緊急地震速報を受信しました ${eew.runtimeType}');
  }
}
