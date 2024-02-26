import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/feature/earthquake_history_old/model/state/earthquake_history_item.dart';
import 'package:eqmonitor/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class EewDetailedHistoryScreen extends HookConsumerWidget {
  const EewDetailedHistoryScreen({
    required this.data,
    super.key,
  });
  final EarthquakeHistoryItem data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final eews = data.eewList.reversed.toList();
    if (eews.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text(
            '当該IDの地震情報に対する緊急地震速報が見つかりませんでした。',
          ),
        ),
      );
    }

    // TableItem
    final tableItemGenerator = <({
      String title,
      String Function(TelegramV3 eew, Vxse45 body) value,
      double width,
    })>[
      (
        title: 'ID',
        value: (eew, body) => eew.serialNo.toString(),
        width: 50,
      ),
      (
        title: '震源地名',
        value: (eew, body) => (body is TelegramVxse45Body)
            ? body.hypocenter?.name ?? '不明'
            : 'キャンセル報',
        width: 100,
      ),
      (
        title: '規模',
        value: (eew, body) => (body is TelegramVxse45Body)
            ? ((body.isPlum || body.isLevelEew)
                ? ''
                : 'M${body.magnitude ?? "不明"}')
            : '---',
        width: 50,
      ),
      (
        title: '深さ',
        value: (eew, body) => (body is TelegramVxse45Body)
            ? ((body.isPlum || body.isLevelEew)
                ? ''
                : '${body.depth ?? "不明"}km')
            : '---',
        width: 50,
      ),
      (
        title: '予想最大震度',
        value: (eew, body) {
          if (body is TelegramVxse45Body) {
            final maxInt = body.forecastMaxInt?.toDisplayMaxInt();
            if (maxInt == null) {
              return '不明';
            }
            return '${maxInt.maxInt.type}${maxInt.isOver ? "程度以上" : ""}'
                .replaceAll('-', '弱')
                .replaceAll('+', '強');
          }
          return '---';
        },
        width: 50,
      ),
      (
        title: '予想最大長周期階級',
        value: (eew, body) {
          if (body is TelegramVxse45Body) {
            final maxLgInt = body.forecastMaxLgInt?.toDisplayMaxLgInt();
            if (maxLgInt == null) {
              return '不明';
            }
            return '${maxLgInt.maxLgInt.type}${maxLgInt.isOver ? "程度以上" : ""}';
          }
          return '---';
        },
        width: 80,
      ),
      (
        title: '発表時刻',
        value: (eew, body) => DateFormat('HH:mm:ss').format(
              eew.pressTime.toLocal(),
            ),
        width: 100,
      ),
      (
        title: '検知から',
        value: (eew, body) => (body is TelegramVxse45Body)
            ? '+${eew.pressTime.difference(body.arrivalTime).inSeconds}秒'
            : '---',
        width: 50,
      ),
      (
        title: '発生時刻',
        value: (eew, body) => (body is TelegramVxse45Body)
            ? DateFormat('HH:mm:ss').format(
                body.arrivalTime.toLocal(),
              )
            : '---',
        width: 100,
      ),
      (
        title: '震源精度',
        value: (eew, body) {
          if (body is TelegramVxse45Body) {
            final code = body.accuracy.epicenters.join();
            if (body.isIpfOnePoint) {
              return 'IPF1点($code)';
            }
            if (body.isPlum) {
              return 'PLUM法($code)';
            }
            if (body.isLevelEew) {
              return 'レベル報($code)';
            }
            return code;
          }
          return '---';
        },
        width: 50,
      ),
    ];

    final headerDecoration = TableSpanDecoration(
      border: TableSpanBorder(
        trailing: BorderSide(
          color: colorScheme.onSurface.withOpacity(0.3),
        ),
      ),
    );
    final intensityColorScheme = ref.watch(intensityColorProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('緊急地震速報の履歴'),
      ),
      body: Card(
        clipBehavior: Clip.antiAlias,
        child: TableView.builder(
          pinnedColumnCount: 1,
          pinnedRowCount: 1,
          columnBuilder: (index) => switch (index) {
            0 => TableSpan(
                extent: FixedTableSpanExtent(tableItemGenerator[index].width),
                backgroundDecoration: TableSpanDecoration(
                  color: colorScheme.secondaryContainer.withOpacity(0.25),
                ),
                foregroundDecoration: headerDecoration,
              ),
            5 => TableSpan(
                extent: FixedTableSpanExtent(tableItemGenerator[index].width),
                foregroundDecoration: headerDecoration,
              ),
            _ => TableSpan(
                extent: FixedTableSpanExtent(tableItemGenerator[index].width),
              ),
          },
          rowBuilder: (index) {
            if (index == 0) {
              return TableSpan(
                extent: const FixedTableSpanExtent(50),
                foregroundDecoration: headerDecoration,
                backgroundDecoration: TableSpanDecoration(
                  color: colorScheme.secondaryContainer.withOpacity(0.25),
                ),
              );
            }
            final eew = eews[index - 1].body as Vxse45;
            final maxInt = (eew is TelegramVxse45Body)
                ? eew.forecastMaxInt?.toDisplayMaxInt()
                : null;
            final color = maxInt != null
                ? intensityColorScheme.fromJmaForecastIntensity(maxInt.maxInt)
                : null;

            return TableSpan(
              extent: const FixedTableSpanExtent(50),
              backgroundDecoration: TableSpanDecoration(
                color: ((eew is TelegramVxse45Body)
                        ? color?.background
                        : Colors.redAccent)
                    ?.withOpacity(0.2),
              ),
            );
          },
          rowCount: eews.length + 1, // header分
          columnCount: tableItemGenerator.length,
          cellBuilder: (context, vicinity) {
            final builder = tableItemGenerator[vicinity.column];
            // check if it is a header cell
            if (vicinity.yIndex == 0) {
              return Center(
                child: Text(
                  builder.title,
                  style: theme.textTheme.titleMedium!.copyWith(
                    fontFamily: FontFamily.jetBrainsMono,
                    fontFamilyFallback: [FontFamily.notoSansJP],
                  ),
                ),
              );
            }
            final eew = eews[vicinity.yIndex - 1];
            return Center(
              child: Text(
                builder.value(eew, eew.body as Vxse45),
                style: (vicinity.xIndex == 0
                        ? theme.textTheme.titleMedium
                        : theme.textTheme.bodyMedium)!
                    .copyWith(
                  fontFamily: FontFamily.jetBrainsMono,
                  fontFamilyFallback: [FontFamily.notoSansJP],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
