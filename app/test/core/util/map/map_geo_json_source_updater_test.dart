import 'dart:async';

import 'package:eqmonitor/core/util/map/map_geo_json_source_updater.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fake_style_controller.dart';

void main() {
  const emptyGeoJson = '{"type":"FeatureCollection","features":[]}';

  test('初期化完了後に GeoJSON を更新する', () async {
    final style = FakeStyleController();
    final initialization = Completer<void>();
    final updater = MapGeoJsonSourceUpdater();

    final update = updater.update(
      styleController: style,
      sourceId: 'source',
      geoJson: emptyGeoJson,
      initialization: initialization.future,
      isDisposed: () => false,
    );

    expect(style.updatedGeoJsonSources, isEmpty);
    initialization.complete();
    await update;

    expect(style.updatedGeoJsonSources, [(id: 'source', data: emptyGeoJson)]);
  });

  test('同一 GeoJSON を重複更新しない', () async {
    final style = FakeStyleController();
    final updater = MapGeoJsonSourceUpdater();

    for (var index = 0; index < 2; index++) {
      await updater.update(
        styleController: style,
        sourceId: 'source',
        geoJson: emptyGeoJson,
        initialization: Future<void>.value(),
        isDisposed: () => false,
      );
    }

    expect(style.updatedGeoJsonSources, hasLength(1));
  });

  test('初期化待機中に破棄された場合は更新しない', () async {
    final style = FakeStyleController();
    final initialization = Completer<void>();
    final updater = MapGeoJsonSourceUpdater();
    var disposed = false;

    final update = updater.update(
      styleController: style,
      sourceId: 'source',
      geoJson: emptyGeoJson,
      initialization: initialization.future,
      isDisposed: () => disposed,
    );
    disposed = true;
    initialization.complete();
    await update;

    expect(style.updatedGeoJsonSources, isEmpty);
  });

  test('reset 後は同一 GeoJSON でも再度更新する', () async {
    final style = FakeStyleController();
    final updater = MapGeoJsonSourceUpdater();

    await updater.update(
      styleController: style,
      sourceId: 'source',
      geoJson: emptyGeoJson,
      initialization: Future<void>.value(),
      isDisposed: () => false,
    );
    updater.reset();
    await updater.update(
      styleController: style,
      sourceId: 'source',
      geoJson: emptyGeoJson,
      initialization: Future<void>.value(),
      isDisposed: () => false,
    );

    expect(style.updatedGeoJsonSources, hasLength(2));
  });
}
