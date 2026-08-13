import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/designsystem/extensions/typography_theme_extension.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:material_ui/material_ui.dart';
import 'package:intl/intl.dart';

class EewTable extends StatelessWidget {
  const EewTable({
    required this.eews,
    this.selectedIndex,
    this.onSelect,
    super.key,
  });

  final List<EewTelegramItem> eews;
  final int? selectedIndex;
  final void Function(int index)? onSelect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final designSystem = context.designSystem;

    return SizedBox.expand(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          primary: true,
          child: DataTable(
            horizontalMargin: 0,
            columnSpacing: 4,
            showCheckboxColumn: false,
            border: TableBorder.symmetric(
              borderRadius: BorderRadius.circular(8),
              outside: BorderSide(color: designSystem.colorTheme.surface),
            ),
            columns: _EewTableColumn.values
                .map(
                  (e) => DataColumn(
                    label: Row(
                      spacing: 2,
                      children: [
                        Text(e.name),
                        if (e.tooltip != null)
                          Tooltip(
                            message: e.tooltip,
                            triggerMode: TooltipTriggerMode.tap,
                            child: const Icon(Icons.info_outline),
                          ),
                      ],
                    ),
                    numeric: e.isNumeric,
                    headingRowAlignment: MainAxisAlignment.center,
                  ),
                )
                .toList(),
            rows: List.generate(eews.length, (index) {
              final eew = eews[index];
              final isSelected = selectedIndex == index;
              return DataRow(
                selected: isSelected,
                onSelectChanged: onSelect != null
                    ? (_) => onSelect!(index)
                    : null,
                color: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return designSystem.colorTheme.primaryContainer;
                  }
                  return eew.isWarning ?? false
                      ? designSystem.colorTheme.errorContainer.withValues(alpha: 0.7)
                      : designSystem.colorTheme.surfaceContainer;
                }),
                cells: _EewTableColumn.values
                    .map(
                      (c) => DataCell(
                        Text(
                          c.value(eew).value,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontFamily: codeFontFamily,
                            fontFamilyFallback: japaneseFontFamilyFallback,
                            letterSpacing: -0.5,
                            fontFeatures: [const FontFeature.tabularFigures()],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            }),
          ),
        ),
      ),
    );
  }
}

enum _EewTableColumn {
  serialNo(name: 'No.', isNumeric: true),
  type(name: '種別', isNumeric: false),
  reportTime(name: '発表時刻', isNumeric: true),
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
  _EewTableColumnValue value(EewTelegramItem eew) => switch (this) {
    .serialNo => _EewTableColumnValue(
      value: eew.serialNo.toString(),
      isNumeric: true,
    ),
    .reportTime => _EewTableColumnValue(
      value: DateFormat('yyyy/MM/dd HH:mm:ss').format(eew.reportTime.toLocal()),
      isNumeric: false,
    ),
    .elapsedTime => _EewTableColumnValue(
      value: eew.arrivalTime != null
          ? '+${eew.reportTime.difference(eew.arrivalTime!).inSeconds}秒'
          : '',
      isNumeric: false,
    ),
    .epicenterName => _EewTableColumnValue(
      value: eew.hypocenter?.name ?? '',
      isNumeric: false,
    ),
    .epicenterLatitude => _EewTableColumnValue(
      value: () {
        final hypo = eew.hypocenter;
        if (hypo != null && hypo.latitude != null) {
          return hypo.latitude!.toString();
        }
        return '';
      }(),
      isNumeric: true,
    ),
    .epicenterLongitude => _EewTableColumnValue(
      value: () {
        final hypo = eew.hypocenter;
        if (hypo != null && hypo.longitude != null) {
          return hypo.longitude!.toString();
        }
        return '';
      }(),
      isNumeric: true,
    ),
    .magnitude => _EewTableColumnValue(
      value: !eew.isPlum && eew.hypocenter?.magnitude != null
          ? 'M${eew.hypocenter!.magnitude}'
          : '',
      isNumeric: true,
    ),
    .epicenterDepth => _EewTableColumnValue(
      value: !eew.isPlum && eew.hypocenter?.depth != null
          ? '${eew.hypocenter!.depth}km'
          : '',
      isNumeric: true,
    ),
    .maxIntensity => _EewTableColumnValue(
      value: () {
        final intensity = eew.forecastIntensity;
        if (intensity == null) {
          return '';
        }
        final maxIntensity = intensity.maxIntensity;
        if (maxIntensity == null) {
          return '-';
        }
        final typeStr = maxIntensity.label;
        return '震度 $typeStr${intensity.maxIntensityIsOver ? '程度以上' : ''}';
      }(),
      isNumeric: false,
    ),
    .maxLongPeriodIntensity => _EewTableColumnValue(
      value: () {
        final lpgmIntensity = eew.forecastIntensity?.maxLpgmIntensity;
        if (lpgmIntensity == null) {
          return '';
        }
        return '長周期地震動階級 ${lpgmIntensity.label}';
      }(),
      isNumeric: false,
    ),
    .accuracy when eew.accuracy != null => _EewTableColumnValue(
      value: '${eew.accuracy!.depth}',
      isNumeric: true,
    ),
    .accuracy => const _EewTableColumnValue(
      value: '',
      isNumeric: false,
    ),
    .type => _EewTableColumnValue(
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
