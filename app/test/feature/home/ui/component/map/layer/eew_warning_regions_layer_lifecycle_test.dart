import 'dart:async';

import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_warning_regions_layer.dart';
import 'package:eqmonitor/feature/map/ui/map_operation_queue_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';
// ignore: implementation_imports
import 'package:maplibre_platform_interface/src/widget/inherited_model.dart';

import '../../../../../../core/util/map/fake_style_controller.dart';

void main() {
  testWidgets('初期化中の更新とdispose後の再初期化を登録順に処理する', (tester) async {
    final firstAddGate = Completer<void>();
    final styleController = WarningRegionStyleController(
      firstAddGate: firstAddGate,
    );
    final events = ValueNotifier<List<EewTelegramItem>>([
      warningEew(prefectureCode: '9020', regionCode: '202'),
    ]);
    final isVisible = ValueNotifier(true);

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: MapOperationQueueScope(
            child: MapLibreInheritedModel(
              mapController: WarningRegionMapController(
                styleController: styleController,
              ),
              mapCamera: null,
              child: ValueListenableBuilder<bool>(
                valueListenable: isVisible,
                builder: (context, visible, child) =>
                    ValueListenableBuilder<List<EewTelegramItem>>(
                      valueListenable: events,
                      builder: (context, value, child) => visible
                          ? EewWarningRegionsLayer(eews: value)
                          : const SizedBox.shrink(),
                    ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    expect(styleController.operations, ['add-start']);

    events.value = [warningEew(prefectureCode: '9030', regionCode: '211')];
    await tester.pump();
    isVisible.value = false;
    await tester.pump();
    events.value = [warningEew(prefectureCode: '9040', regionCode: '212')];
    isVisible.value = true;
    await tester.pump();

    firstAddGate.complete();
    await tester.pumpAndSettle();

    expect(styleController.operations, [
      'add-start',
      'add-done',
      'filter:9030',
      'remove',
      'add-start',
      'add-done',
      'filter:9040',
    ]);
    expect(styleController.activeLayerIds, {'eew-warning-regions-fill'});
    expect(styleController.updatedCodes.last, ['9040']);

    final layer = styleController.addedLayers.last as StyleLayerWithSource;
    expect(layer.sourceLayerId, 'areaForecastLocalEew');
    expect(layer.filter, [
      'in',
      ['get', 'code'],
      [
        'literal',
        ['9040'],
      ],
    ]);
  });
}

class WarningRegionStyleController extends FakeStyleController {
  WarningRegionStyleController({required this.firstAddGate})
    : super(throwOnDuplicateLayerIds: true);

  final Completer<void> firstAddGate;
  final operations = <String>[];
  final updatedCodes = <List<String>>[];
  var addCount = 0;

  @override
  Future<void> addLayer(
    StyleLayer layer, {
    String? belowLayerId,
    String? aboveLayerId,
    int? atIndex,
  }) async {
    addCount++;
    operations.add('add-start');
    if (addCount == 1) {
      await firstAddGate.future;
    }
    await super.addLayer(
      layer,
      belowLayerId: belowLayerId,
      aboveLayerId: aboveLayerId,
      atIndex: atIndex,
    );
    operations.add('add-done');
  }

  @override
  Future<void> updateFilter({
    required String id,
    required List<Object>? filter,
  }) async {
    final codes = switch (filter) {
      ['in', ['get', 'code'], ['literal', final List<String> values]] => values,
      _ => const <String>[],
    };
    updatedCodes.add(codes);
    operations.add('filter:${codes.join(',')}');
  }

  @override
  Future<void> removeLayer(String id) async {
    operations.add('remove');
    await super.removeLayer(id);
  }
}

class WarningRegionMapController implements MapController {
  WarningRegionMapController({required this.styleController});

  final StyleController styleController;

  @override
  StyleController get style => styleController;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

EewTelegramItem warningEew({
  required String prefectureCode,
  required String regionCode,
}) => EewTelegramItem(
  eventId: prefectureCode,
  status: TelegramStatus.normal,
  infoType: TelegramInfoType.publication,
  serialNo: 1,
  isCanceled: false,
  isLastInfo: false,
  reportTime: DateTime.utc(2026, 8, 17),
  isPlum: false,
  isWarning: true,
  warning: EewWarningInfo(
    regions: [
      EewWarningZoneInfo(code: regionCode, name: '予報区', hadWarning: false),
    ],
    zones: const [],
    prefectures: [
      EewWarningZoneInfo(
        code: prefectureCode,
        name: '府県予報区',
        hadWarning: false,
      ),
    ],
  ),
);
