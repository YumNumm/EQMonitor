import 'dart:async';

import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_warning_regions_layer.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:eqmonitor/feature/map/ui/map_operation_queue_scope.dart';
import 'package:material_ui/material_ui.dart';
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
    await styleController.sources.add(
      const VectorSource.url(id: 'eqmonitor_map', url: 'pmtiles://base'),
    );
    await styleController.layers.add(
      BackgroundStyleLayer(id: BaseLayer.regionOverlayAnchor.name),
    );
    styleController.operations.clear();
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
              cameraPosition: null,
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
    expect(styleController.activeLayerIds, [
      'eew-warning-regions-fill',
      BaseLayer.regionOverlayAnchor.name,
    ]);
    expect(styleController.updatedCodes.last, ['9040']);

    final added = styleController.gatedBackend.addedLayers.last;
    expect(added.belowLayerId, BaseLayer.regionOverlayAnchor.name);
    expect(added.json['source'], 'eqmonitor_map');
    expect(added.json['source-layer'], 'areaForecastLocalEew');
    expect(added.json['filter'], [
      'in',
      ['get', 'code'],
      [
        'literal',
        ['9040'],
      ],
    ]);
    expect(added.json['paint'], {
      'fill-color': '#ff0000',
      'fill-opacity': 0.25,
    });
  });
}

class WarningRegionStyleController({
  required final Completer<void> firstAddGate,
}) extends FakeStyleController {
  late final gatedBackend = WarningRegionStyleBackend(
    firstAddGate: firstAddGate,
    operations: operations,
    updatedCodes: updatedCodes,
  );

  final operations = <String>[];
  final updatedCodes = <List<String>>[];

  @override
  late final StyleSources sources = StyleSources(
    gatedBackend,
    layers: () => layers,
  );

  @override
  late final StyleLayers layers = StyleLayers(gatedBackend, sources: sources);
}

class WarningRegionStyleBackend({
  required final Completer<void> firstAddGate,
  required final List<String> operations,
  required final List<List<String>> updatedCodes,
}) extends FakeStyleBackend {
  var addCount = 0;

  @override
  Future<void> addLayer(
    Map<String, Object?> json, {
    String? belowLayerId,
  }) async {
    addCount++;
    operations.add('add-start');
    if (addCount == 2) {
      await firstAddGate.future;
    }
    await super.addLayer(json, belowLayerId: belowLayerId);
    operations.add('add-done');
  }

  @override
  void setFilter(String layerId, Object? filter) {
    final codes = switch (filter) {
      ['in', ['get', 'code'], ['literal', final List<String> values]] => values,
      _ => const <String>[],
    };
    updatedCodes.add(codes);
    operations.add('filter:${codes.join(',')}');
    super.setFilter(layerId, filter);
  }

  @override
  Future<void> removeLayer(String id) async {
    operations.add('remove');
    await super.removeLayer(id);
  }
}

class WarningRegionMapController({
  required final StyleController styleController,
}) implements MapController {
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
