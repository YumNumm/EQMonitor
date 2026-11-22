import 'dart:typed_data';

import 'package:maplibre/maplibre.dart';
import 'package:maplibre_platform_interface/maplibre_platform_interface.dart'
    show StyleBackend;

class FakeStyleBackend({
  final Set<String> failingLayerIds = const {},
  final Set<String> failingSourceIds = const {},
}) implements StyleBackend {
  final addedSources = <Source>[];
  final addedLayers = <({Map<String, Object?> json, String? belowLayerId})>[];
  final updatedGeoJsonSources = <({String id, GeoJsonData data})>[];
  final updatedFilters = <({String layerId, Object? filter})>[];
  final updatedLayerProperties =
      <({String layerId, String name, Object? value, bool layout})>[];
  final removedLayerIds = <String>[];
  final removedSourceIds = <String>[];

  @override
  Future<void> addSource(Source source) async => addedSources.add(source);

  @override
  Future<void> addLayer(
    Map<String, Object?> json, {
    String? belowLayerId,
  }) async => addedLayers.add((json: json, belowLayerId: belowLayerId));

  @override
  Future<void> setGeoJsonData(String id, GeoJsonData data) async =>
      updatedGeoJsonSources.add((id: id, data: data));

  @override
  void setFilter(String layerId, Object? filter) =>
      updatedFilters.add((layerId: layerId, filter: filter));

  @override
  void setLayerProperty(
    String layerId,
    String name,
    Object? value, {
    required bool layout,
  }) => updatedLayerProperties.add((
    layerId: layerId,
    name: name,
    value: value,
    layout: layout,
  ));

  @override
  Future<void> removeLayer(String id) async {
    removedLayerIds.add(id);
    if (failingLayerIds.contains(id)) {
      throw Exception('removeLayer failed: $id');
    }
  }

  @override
  Future<void> removeSource(String id) async {
    removedSourceIds.add(id);
    if (failingSourceIds.contains(id)) {
      throw Exception('removeSource failed: $id');
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// [layers] と [sources] は本物の collection で、呼び出しは [backend] に記録される。
class FakeStyleController({
  Set<String> failingLayerIds = const {},
  Set<String> failingSourceIds = const {},
  final Set<String> failingImageIds = const {},
}) implements StyleController {
  final FakeStyleBackend backend = FakeStyleBackend(
    failingLayerIds: failingLayerIds,
    failingSourceIds: failingSourceIds,
  );
  final addedImageIds = <String>[];
  final removedImageIds = <String>[];

  @override
  late final StyleSources sources = StyleSources(backend, layers: () => layers);

  @override
  late final StyleLayers layers = StyleLayers(backend, sources: sources);

  List<String> get activeLayerIds => [for (final layer in layers) layer.id];

  @override
  Future<void> addImage(
    String id,
    Uint8List bytes, {
    double pixelRatio = 1,
    StyleImageOptions options = const StyleImageOptions(),
  }) async {
    addedImageIds.add(id);
  }

  @override
  Future<void> removeImage(String id) async {
    removedImageIds.add(id);
    if (failingImageIds.contains(id)) {
      throw Exception('removeImage failed: $id');
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
