import 'dart:typed_data';

import 'package:eqmonitor_map/src/foundation/render/map_packed_mesh_layout.dart';

final class MapPackedMesh {
  const new _({
    required this.payloadVersion,
    required this.layout,
    required this.vertexBytes,
    required this.vertexCount,
    required this.indexBytes,
    required this.indexCount,
  });

  final int payloadVersion;
  final MapPackedMeshLayout layout;
  final Uint8List vertexBytes;
  final int vertexCount;
  final Uint8List? indexBytes;
  final int? indexCount;
}

MapPackedMesh createMapPackedMesh({
  required int payloadVersion,
  required MapPackedMeshLayout layout,
  required Uint8List vertexBytes,
  required int vertexCount,
  required Uint8List? indexBytes,
  required int? indexCount,
}) {
  if (payloadVersion <= 0) {
    throw ArgumentError.value(
      payloadVersion,
      'payloadVersion',
      'must be positive',
    );
  }
  if (vertexCount < 0 ||
      vertexBytes.length % layout.vertexStride != 0 ||
      vertexBytes.length ~/ layout.vertexStride != vertexCount) {
    throw ArgumentError.value(vertexCount, 'vertexCount', 'does not fit bytes');
  }

  final indexFormat = layout.indexFormat;
  final hasAllIndexFields =
      indexFormat != null && indexBytes != null && indexCount != null;
  final hasNoIndexFields =
      indexFormat == null && indexBytes == null && indexCount == null;
  if (!hasAllIndexFields && !hasNoIndexFields) {
    throw ArgumentError(
      'indexFormat, indexBytes, and indexCount must all be present or absent',
    );
  }
  if (indexFormat != null && indexBytes != null && indexCount != null) {
    if (indexCount < 0 ||
        indexBytes.length % indexFormat.byteLength != 0 ||
        indexBytes.length ~/ indexFormat.byteLength != indexCount) {
      throw ArgumentError.value(
        indexCount,
        'indexCount',
        'does not fit bytes',
      );
    }
  }

  return MapPackedMesh._(
    payloadVersion: payloadVersion,
    layout: layout,
    vertexBytes: Uint8List.fromList(vertexBytes).asUnmodifiableView(),
    vertexCount: vertexCount,
    indexBytes: indexBytes == null
        ? null
        : Uint8List.fromList(indexBytes).asUnmodifiableView(),
    indexCount: indexCount,
  );
}
