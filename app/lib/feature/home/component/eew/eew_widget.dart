import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/chip/custom_chip.dart';
import 'package:eqmonitor/core/component/container/bordered_container.dart';
import 'package:eqmonitor/core/component/intenisty/jma_forecast_intensity_icon.dart';
import 'package:eqmonitor/core/component/intenisty/jma_forecast_lg_intensity_icon.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/provider/eew/eew_alive_telegram.dart';
import 'package:eqmonitor/core/provider/websocket/websocket_provider.dart';
import 'package:eqmonitor/gen/fonts.gen.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class EewWidgets extends ConsumerWidget {
  const EewWidgets({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(eewAliveTelegramProvider) ?? [];

    final body = LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: Column(
            children: state.reversed
                .mapIndexed(
                  (index, element) => EewWidget(
                    eew: element,
                    index: (state.length > 1) ? '${index + 1}' : null,
                  ),
                )
                .toList(),
          ),
        );
      },
    );

    return Column(
      children: [
        if (kDebugMode)
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              FilledButton.tonal(
                child: const Text('SAMPLE EEW Telegram'),
                onPressed: () {
                  ref.read(websocketProvider).send('sample/eew');
                },
              ),
              FilledButton.tonal(
                child: const Text('キャンセル報'),
                onPressed: () {
                  ref.read(websocketProvider).send('sample/eew-cancel');
                },
              ),
            ],
          ),
        body,
      ],
    );
  }
}

class EewWidget extends ConsumerWidget {
  const EewWidget({
    required this.eew,
    required this.index,
    super.key,
  });

  final EewV1 eew;
  final String? index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorTheme = theme.colorScheme;
    final intensityColorScheme = ref.watch(intensityColorProvider);
    if (eew.isCanceled) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Card(
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
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(eew.headline ?? '先ほどの緊急地震速報は取り消されました'),
            ),
          ),
        ),
      );
    }
    final maxIntensity =
        eew.forecastMaxIntensity ?? JmaForecastIntensity.unknown;
    final intensityScheme =
        intensityColorScheme.fromJmaForecastIntensity(maxIntensity);
    final (_, backgroundColor) =
        (intensityScheme.foreground, intensityScheme.background);
    // 「緊急地震速報 警報 [SPACE] #5(最終)」
    final isWarning = eew.headline?.contains('強い揺れ') ?? false;
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
            if (eew.isPlum ?? false)
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
          '#${eew.serialNo ?? 1}'
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
          (eew.isPlum ?? false || eew.isLevelEew) ? '検知観測点' : '震源地',
          style: textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: textTheme.bodyMedium!.color!.withOpacity(0.8),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          eew.hypoName ?? '不明',
          style: textTheme.headlineMedium!.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );

    // 地震発生時刻
    final happenedTime = eew.originTime ?? eew.arrivalTime;
    if (happenedTime == null) {
      return const SizedBox.shrink();
    }
    final timeWidget = Text(
      '${DateFormat('yyyy/MM/dd HH:mm:ss').format(
        happenedTime.toLocal(),
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
        if (eew.magnitude != null) ...[
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: eew.magnitude!.toString().split('.').first,
                  style: textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.w900,
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
                  text: eew.magnitude!.toString().split('.').last,
                  style: textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
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
        if (eew.isPlum ?? false) ...[
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
    final headline = eew.headline?.toString().toHalfWidth;
    final warningMessageWidget = (headline != null)
        ? [
            Text(
              headline.split('で地震 ').getOrNull(1) ?? headline,
              style: textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              color: colorTheme.onSurface.withOpacity(0.6),
            ),
          ]
        : null;
    final card = BorderedContainer(
      padding: EdgeInsets.zero,
      accentColor: backgroundColor.withOpacity(0.3),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
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
            if (eew.forecastMaxLpgmIntensity != null &&
                ![
                  JmaForecastLgIntensity.zero,
                  JmaForecastLgIntensity.unknown,
                ].contains(eew.forecastMaxLpgmIntensity)) ...[
              Row(
                children: [
                  Column(
                    children: [
                      const Text('最大LPGM'),
                      JmaForecastLgIntensityWidget(
                        intensity: eew.forecastMaxLpgmIntensity!,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '予想最大長周期地震動階級 ${eew.forecastMaxLpgmIntensity!.type}',
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
        if (eew.status != TelegramStatus.normal.type)
          Center(
            child: FittedBox(
              child: Text(
                eew.status,
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
}
