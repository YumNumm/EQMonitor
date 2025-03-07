import 'package:eqapi_types/eqapi_types.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EewTable extends StatelessWidget {
  const EewTable({required this.eews, super.key});

  final List<EewV1> eews;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox.expand(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          primary: true,
          child: DataTable(
            horizontalMargin: 0,
            columnSpacing: 10,
            border: TableBorder.symmetric(
              borderRadius: BorderRadius.circular(8),
              outside: BorderSide(color: colorScheme.surface),
            ),
            columns:
                _EewTableColumn.values
                    .map(
                      (e) => DataColumn(
                        label: Row(
                          children: [
                            Text(e.name),
                            if (e.tooltip != null) ...[
                              const SizedBox(width: 4),
                              Tooltip(
                                message: e.tooltip,
                                triggerMode: TooltipTriggerMode.tap,
                                child: const Icon(Icons.info_outline),
                              ),
                            ],
                          ],
                        ),
                        numeric: e.isNumeric,
                        headingRowAlignment: MainAxisAlignment.center,
                      ),
                    )
                    .toList(),
            rows:
                eews
                    .map(
                      (eew) => DataRow(
                        color: WidgetStateProperty.all(
                          eew.isWarning ?? false
                              ? colorScheme.errorContainer.withValues(
                                alpha: 0.7,
                              )
                              : colorScheme.surfaceContainer,
                        ),
                        cells:
                            _EewTableColumn.values
                                .map((c) => DataCell(Text(c.value(eew).value)))
                                .toList(),
                      ),
                    )
                    .toList(),
          ),
        ),
      ),
    );
  }
}

enum _EewTableColumn {
  serialNo(name: 'No.', isNumeric: true),
  type(name: '種別', isNumeric: false),
  originTime(name: '発表時刻', isNumeric: true),
  elapsedTime(
    name: '経過時間',
    isNumeric: true,
    tooltip: '気象庁が地震を検知してから、緊急地震速報が発表されるまでの時間',
  ),
  epicenterName(name: '震源地名', isNumeric: false),
  epicenterLatitude(name: '緯度', isNumeric: true),
  epicenterLongitude(name: '経度', isNumeric: true),
  epicenterDepth(name: '深さ', isNumeric: true),
  magnitude(name: 'M', isNumeric: true),
  maxIntensity(name: '予想最大震度', isNumeric: true),
  maxLongPeriodIntensity(name: '予想最大長周期\n地震動階級', isNumeric: true),
  accuracy(name: '精度', isNumeric: false);

  const _EewTableColumn({
    required this.name,
    required this.isNumeric,
    this.tooltip,
  });

  final String name;
  final bool isNumeric;
  final String? tooltip;
}

extension _EewTableColumnEx on _EewTableColumn {
  _EewTableColumnValue value(EewV1 eew) => switch (this) {
    _EewTableColumn.serialNo => _EewTableColumnValue(
      value: eew.serialNo?.toString() ?? '',
      isNumeric: true,
    ),
    _EewTableColumn.originTime => _EewTableColumnValue(
      value:
          eew.originTime != null
              ? DateFormat(
                'yyyy/MM/dd HH:mm:ss',
              ).format(eew.originTime!.toLocal())
              : '',
      isNumeric: false,
    ),
    _EewTableColumn.elapsedTime => _EewTableColumnValue(
      value:
          eew.arrivalTime != null
              ? '+${eew.reportTime.difference(eew.arrivalTime!).inSeconds}秒'
              : '',
      isNumeric: false,
    ),
    _EewTableColumn.epicenterName => _EewTableColumnValue(
      value: eew.hypoName ?? '',
      isNumeric: false,
    ),
    _EewTableColumn.epicenterLatitude => _EewTableColumnValue(
      value: eew.latitude?.toString() ?? '',
      isNumeric: true,
    ),
    _EewTableColumn.epicenterLongitude => _EewTableColumnValue(
      value: eew.longitude?.toString() ?? '',
      isNumeric: true,
    ),
    _EewTableColumn.magnitude => _EewTableColumnValue(
      value: eew.magnitude != null ? 'M${eew.magnitude}' : '',
      isNumeric: true,
    ),
    _EewTableColumn.maxIntensity => _EewTableColumnValue(
      value:
          eew.forecastMaxIntensity != null
              ? '震度 ${eew.forecastMaxIntensity!.type.replaceAll('-', '弱').replaceAll('+', '強')}'
                  '${eew.forecastMaxIntensityIsOver ?? false ? '以上' : ''}'
              : '',
      isNumeric: false,
    ),
    _EewTableColumn.epicenterDepth => _EewTableColumnValue(
      value: eew.depth != null ? '${eew.depth}km' : '',
      isNumeric: true,
    ),
    _EewTableColumn.maxLongPeriodIntensity => _EewTableColumnValue(
      value:
          eew.forecastMaxLpgmIntensity?.type != null
              ? '長周期地震動階級 ${eew.forecastMaxLpgmIntensity!.type}'
              : '',
      isNumeric: false,
    ),
    _EewTableColumn.accuracy when eew.accuracy != null => _EewTableColumnValue(
      value: () {
        final accuracy = eew.accuracy!;
        return '${accuracy.depth}';
      }(),
      isNumeric: true,
    ),
    _EewTableColumn.accuracy => const _EewTableColumnValue(
      value: '',
      isNumeric: false,
    ),
    _EewTableColumn.type => _EewTableColumnValue(
      value: (eew.isWarning ?? false) ? '緊急地震速報 (警報)' : '緊急地震速報 (予報)',
      isNumeric: false,
    ),
  };
}

class _EewTableColumnValue {
  const _EewTableColumnValue({required this.value, required this.isNumeric});

  final String value;
  final bool isNumeric;
}
