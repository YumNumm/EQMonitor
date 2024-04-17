import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/provider/jma_code_table_provider.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_v1_extended.dart';
import 'package:eqmonitor/feature/earthquake_history_details/component/earthquake_hypo_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'EarthquakeHypoInfoWidget',
  type: EarthquakeHypoInfoWidget,
)
Widget earthquakeHypoInfoWidget(BuildContext context) => const Column(
      children: [
        _Body(),
      ],
    );

class _Body extends ConsumerWidget {
  const _Body();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jmaParameter = ref.watch(jmaParameterProvider);
    final jmaParameterWidget = jmaParameter.whenOrNull(
      error: (error, stackTrace) => Text('Error: $error'),
    );
    if (jmaParameterWidget != null) {
      return jmaParameterWidget;
    }
    final earthquakeParameter = jmaParameter.requireValue.earthquake;

    final codeTable = ref.watch(jmaCodeTableProvider);
    final epicenters = codeTable.areaEpicenter.items;
    final detailedEpicenters = codeTable.areaEpicenterDetail.items;
    final v1 = EarthquakeV1(
      arrivalTime: context.knobs.dateTimeOrNull(
        label: 'arrival_time',
        start: DateTime(2000),
        end: DateTime(2100),
        initialValue: DateTime.now(),
        description: '検出時刻',
      ),
      originTime: context.knobs.dateTimeOrNull(
        label: 'origin_time',
        start: DateTime(2000),
        end: DateTime(2100),
        initialValue: DateTime.now(),
        description: '発生時刻',
      ),
      eventId: 2024010203042359,
      status: '通常',
      depth: context.knobs.int.input(
        label: 'depth',
        initialValue: 10,
        description: '震源の深さ\n(0 -> "ごく浅い", 700 -> "700km以上")',
      ),
      epicenterCode: context.knobs.listOrNull(
        options: epicenters.map((e) => int.parse(e.code)).toList(),
        label: 'epicenter_code',
        labelBuilder: (value) => value.toString(),
        description: '震央地名(コード表41: AreaEpicenter)より',
      ),
      epicenterDetailCode: context.knobs.listOrNull(
        options: detailedEpicenters.map((e) => int.parse(e.code)).toList(),
        label: 'epicenter_detail_code',
        description: '詳細震央地名(コード表43: AreaEpicenterDetail)より\n(遠地地震で利用)',
        labelBuilder: (value) => value.toString(),
      ),
      magnitude: context.knobs.doubleOrNull.slider(
        label: 'magnitude',
        initialValue: 5,
        max: 8,
        description: 'マグニチュード',
      ),
      magnitudeCondition: context.knobs.listOrNull(
        label: 'magnitude_condition',
        options: ['Ｍ不明', 'Ｍ８を超える巨大地震'],
        description: 'マグニチュードの数値が求まらない事項を記載',
      ),
      maxIntensity: context.knobs.listOrNull(
        options: JmaIntensity.values,
        label: 'max_intensity',
        initialOption: JmaIntensity.fiveLower,
        labelBuilder: (value) => '震度$value',
        description: '最大震度',
      ),
    );
    return EarthquakeHypoInfoWidget(
      item: EarthquakeV1Extended(
        earthquake: v1,
        maxIntensityRegionNames: [
          context.knobs.listOrNull(
            label: '最大震度観測地域',
            description: '一次細分化地域',
            options: earthquakeParameter.regions.map((e) => e.name).toList(),
            labelBuilder: (data) => data.toString(),
          ),
        ].whereNotNull().toList(),
      ),
    );
  }
}
