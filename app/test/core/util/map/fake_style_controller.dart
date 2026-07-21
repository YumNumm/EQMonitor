import 'dart:typed_data';

import 'package:maplibre/maplibre.dart';

class FakeStyleController implements StyleController {
  FakeStyleController({
    this.failingLayerIds = const {},
    this.failingSourceIds = const {},
    this.failingImageIds = const {},
  });

  final Set<String> failingLayerIds;
  final Set<String> failingSourceIds;
  final Set<String> failingImageIds;

  final addedSources = <Source>[];
  final addedLayers = <StyleLayer>[];
  final addedImageIds = <String>[];
  final updatedGeoJsonSources = <({String id, String data})>[];
  final removedLayerIds = <String>[];
  final removedSourceIds = <String>[];
  final removedImageIds = <String>[];

  @override
  Future<void> addSource(Source source) async => addedSources.add(source);

  @override
  Future<void> addLayer(
    StyleLayer layer, {
    String? belowLayerId,
    String? aboveLayerId,
    int? atIndex,
  }) async => addedLayers.add(layer);

  @override
  Future<void> addImage(String id, Uint8List bytes) async {
    addedImageIds.add(id);
  }

  @override
  Future<void> updateGeoJsonSource({
    required String id,
    required String data,
  }) async {
    updatedGeoJsonSources.add((id: id, data: data));
  }

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
  Future<void> removeImage(String id) async {
    removedImageIds.add(id);
    if (failingImageIds.contains(id)) {
      throw Exception('removeImage failed: $id');
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
