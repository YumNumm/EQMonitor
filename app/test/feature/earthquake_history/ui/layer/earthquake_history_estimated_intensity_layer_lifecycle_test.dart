import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_details_estimated_intensity_layer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maplibre/maplibre.dart';

import '../../../../core/util/map/fake_style_controller.dart';

void main() {
  const style = EarthquakeHistoryEstimatedIntensityStyle();

  test('推計震度のフル URL に pmtiles scheme を一度だけ付与する', () async {
    final controller = EstimatedIntensityStyleController();

    await style.replace(
      styleController: controller,
      tileUrl: 'https://example.com/estimated.pmtiles',
      isDisposed: () => false,
    );

    final source = controller.addedSources.single as VectorSource;
    expect(source.url, 'pmtiles://https://example.com/estimated.pmtiles');
  });

  test('固定 ID の推計震度リソースを再適用前に除去する', () async {
    final controller = EstimatedIntensityStyleController();

    await style.replace(
      styleController: controller,
      tileUrl: 'https://example.com/first.pmtiles',
      isDisposed: () => false,
    );
    await style.replace(
      styleController: controller,
      tileUrl: 'https://example.com/second.pmtiles',
      isDisposed: () => false,
    );

    expect(controller.activeSourceIds, {
      EarthquakeHistoryEstimatedIntensityStyle.sourceId,
    });
    expect(controller.activeLayerIds, {
      EarthquakeHistoryEstimatedIntensityStyle.fillLayerId,
      EarthquakeHistoryEstimatedIntensityStyle.lineLayerId,
    });
  });

  test('推計震度リソースを layer から source の順で除去する', () async {
    final controller = EstimatedIntensityStyleController();
    await style.replace(
      styleController: controller,
      tileUrl: 'https://example.com/estimated.pmtiles',
      isDisposed: () => false,
    );
    controller.operations.clear();

    await style.remove(styleController: controller);

    expect(controller.operations, [
      'remove-layer:${EarthquakeHistoryEstimatedIntensityStyle.lineLayerId}',
      'remove-layer:${EarthquakeHistoryEstimatedIntensityStyle.fillLayerId}',
      'remove-source:${EarthquakeHistoryEstimatedIntensityStyle.sourceId}',
    ]);
  });
}

class EstimatedIntensityStyleController extends FakeStyleController {
  EstimatedIntensityStyleController() : super(throwOnDuplicateLayerIds: true);

  final activeSourceIds = <String>{};
  final operations = <String>[];

  @override
  Future<void> addSource(Source source) async {
    if (!activeSourceIds.add(source.id)) {
      throw Exception('A Source with the id "${source.id}" already exists');
    }
    operations.add('add-source:${source.id}');
    await super.addSource(source);
  }

  @override
  Future<void> addLayer(
    StyleLayer layer, {
    String? belowLayerId,
    String? aboveLayerId,
    int? atIndex,
  }) async {
    operations.add('add-layer:${layer.id}');
    await super.addLayer(
      layer,
      belowLayerId: belowLayerId,
      aboveLayerId: aboveLayerId,
      atIndex: atIndex,
    );
  }

  @override
  Future<void> removeLayer(String id) async {
    operations.add('remove-layer:$id');
    await super.removeLayer(id);
  }

  @override
  Future<void> removeSource(String id) async {
    operations.add('remove-source:$id');
    activeSourceIds.remove(id);
    await super.removeSource(id);
  }
}
