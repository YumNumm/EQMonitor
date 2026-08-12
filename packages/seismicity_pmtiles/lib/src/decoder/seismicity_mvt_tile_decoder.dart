import 'package:pmtiles_v3/pmtiles_v3.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoded_hypocenter.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_mvt_point_decoder.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_mvt_property_decoder.dart';
import 'package:vector_tile/raw/raw_vector_tile.dart';

final class SeismicityMvtTileDecoder {
  const SeismicityMvtTileDecoder();

  int decode({
    required int tileId,
    required int dataZoom,
    required List<int> tileBytes,
    required void Function(SeismicityDecodedHypocenter) onHypocenter,
  }) {
    final tile = VectorTile.fromBuffer(tileBytes);
    final layer = tile.layers.singleWhere(
      (candidate) => candidate.name == 'hypocenters',
    );
    final position = const PmTilesV3TileId().zxyForTileId(tileId: tileId);
    const pointDecoder = SeismicityMvtPointDecoder();
    const propertyDecoder = SeismicityMvtPropertyDecoder();

    for (final (featureIndex, feature) in layer.features.indexed) {
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
