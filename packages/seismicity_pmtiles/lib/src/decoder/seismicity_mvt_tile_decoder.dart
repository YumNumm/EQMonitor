import 'package:pmtiles_v3/pmtiles_v3.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoded_hypocenter.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_mvt_point_decoder.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_mvt_property_decoder.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:vector_tile/raw/raw_vector_tile.dart';

final class SeismicityMvtTileDecoder {
  const SeismicityMvtTileDecoder();

  int decode({
    required int tileId,
    required int dataZoom,
    required List<int> tileBytes,
    required void Function(SeismicityDecodedHypocenter) onHypocenter,
  }) {
    final tile = _parseSeismicityVectorTile(tileId: tileId, bytes: tileBytes);
    final layer = _requireSeismicityMvtLayer(tileId: tileId, tile: tile);
    final position = const PmTilesV3TileId().zxyForTileId(tileId: tileId);
    if (position.z != dataZoom) {
      throw SeismicityPmTilesException.invalidVectorTile(
        tileId: tileId,
        reason: 'tile_zoom_mismatch',
      );
    }
    _validateSeismicityMvtLayer(tileId: tileId, layer: layer);
    const pointDecoder = SeismicityMvtPointDecoder();
    const propertyDecoder = SeismicityMvtPropertyDecoder();

    for (final (featureIndex, feature) in layer.features.indexed) {
      if (!feature.hasType() || feature.type != VectorTile_GeomType.POINT) {
        throw SeismicityPmTilesException.invalidHypocenterFeature(
          tileId: tileId,
          featureIndex: featureIndex,
          field: 'geometry',
          reason: 'not_point',
        );
      }
      final point = pointDecoder.decode(
        geometry: feature.geometry,
        z: position.z,
        x: position.x,
        y: position.y,
        extent: layer.extent,
        tileId: tileId,
        featureIndex: featureIndex,
      );
      final properties = propertyDecoder.decode(
        tags: feature.tags,
        keys: layer.keys,
        values: layer.values,
        tileId: tileId,
        featureIndex: featureIndex,
      );
      onHypocenter(
        SeismicityDecodedHypocenter(
          tileId: tileId,
          featureIndex: featureIndex,
          hypocenterId: properties.hypocenterId,
          point: point,
          originTimeUnixMilliseconds: properties.originTimeUnixMilliseconds,
          magnitude: properties.magnitude,
          depthKm: properties.depthKm,
          maxIntensityUtf8: properties.maxIntensityUtf8,
          determinationFlagUtf8: properties.determinationFlagUtf8,
          earthquakeEventIdUtf8: properties.earthquakeEventIdUtf8,
          geometryClamped: properties.geometryClamped,
        ),
      );
    }
    return layer.features.length;
  }
}

VectorTile _parseSeismicityVectorTile({
  required int tileId,
  required List<int> bytes,
}) {
  try {
    return VectorTile.fromBuffer(bytes);
    // Protobuf reports a negative embedded-message length as ArgumentError.
    // ignore: avoid_catching_errors
  } on ArgumentError {
    throw SeismicityPmTilesException.invalidVectorTile(
      tileId: tileId,
      reason: 'malformed_protobuf',
    );
  } on Exception {
    throw SeismicityPmTilesException.invalidVectorTile(
      tileId: tileId,
      reason: 'malformed_protobuf',
    );
  }
}

VectorTile_Layer _requireSeismicityMvtLayer({
  required int tileId,
  required VectorTile tile,
}) {
  if (tile.layers.isEmpty) {
    throw SeismicityPmTilesException.invalidVectorTile(
      tileId: tileId,
      reason: 'missing_hypocenters_layer',
    );
  }
  if (tile.layers.length != 1) {
    final count = tile.layers
        .where((layer) => layer.name == 'hypocenters')
        .length;
    throw SeismicityPmTilesException.invalidVectorTile(
      tileId: tileId,
      reason: count > 1 ? 'duplicate_hypocenters_layer' : 'unexpected_layer',
    );
  }
  final layer = tile.layers.single;
  if (layer.name != 'hypocenters') {
    throw SeismicityPmTilesException.invalidVectorTile(
      tileId: tileId,
      reason: 'unexpected_layer',
    );
  }
  return layer;
}

void _validateSeismicityMvtLayer({
  required int tileId,
  required VectorTile_Layer layer,
}) {
  final reason = switch ((layer.hasVersion(), layer.hasExtent())) {
    (false, _) => 'missing_layer_version',
    (_, false) => 'missing_layer_extent',
    (true, true) when layer.version != 2 => 'unsupported_layer_version',
    (true, true) when layer.extent <= 0 => 'invalid_layer_extent',
    _ => null,
  };
  if (reason != null) {
    throw SeismicityPmTilesException.invalidVectorTile(
      tileId: tileId,
      reason: reason,
    );
  }
}
