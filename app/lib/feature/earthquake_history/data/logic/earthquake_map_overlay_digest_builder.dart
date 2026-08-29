import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor_map/eqmonitor_map.dart';

enum EarthquakeMapOverlayHypocenterState {
  earthquakeAbsent,
  coordinateAbsent,
  unknown,
  latLng,
}

typedef EarthquakeOverlayHypocenterInput = ({
  EarthquakeMapOverlayHypocenterState state,
  double? longitude,
  double? latitude,
});

final class CanonicalOverlayRecord {
  new({
    required this.recordType,
    required this.stableId,
    required Map<String, String> fields,
  }) : fields = Map.unmodifiable(fields);

  final String recordType;
  final String stableId;
  final Map<String, String> fields;
}

final class EarthquakeMapOverlayDigestBuilder {
  const new();

  String buildDataDigest({
    required List<({String stableId, int intensityOrder})> regions,
    required List<({String stableId, int intensityOrder})> cities,
    required List<
      ({
        String stableId,
        double longitude,
        double latitude,
        int intensityOrder,
        bool isMaximum,
      })
    >
    stations,
    required EarthquakeMapOverlayHypocenterState hypocenterState,
    required double? hypocenterLongitude,
    required double? hypocenterLatitude,
  }) {
    final records = <CanonicalOverlayRecord>[
      for (final region in regions)
        CanonicalOverlayRecord(
          recordType: 'region',
          stableId: region.stableId,
          fields: {'intensityOrder': region.intensityOrder.toString()},
        ),
      for (final city in cities)
        CanonicalOverlayRecord(
          recordType: 'city',
          stableId: city.stableId,
          fields: {'intensityOrder': city.intensityOrder.toString()},
        ),
      for (final station in stations)
        CanonicalOverlayRecord(
          recordType: 'station',
          stableId: station.stableId,
          fields: {
            'intensityOrder': station.intensityOrder.toString(),
            'isMaximum': station.isMaximum.toString(),
            'latitude': canonicalDouble(station.latitude),
            'longitude': canonicalDouble(station.longitude),
          },
        ),
      CanonicalOverlayRecord(
        recordType: 'hypocenter',
        stableId: 'hypocenter',
        fields: {
          if (hypocenterLatitude != null)
            'latitude': canonicalDouble(hypocenterLatitude),
          if (hypocenterLongitude != null)
            'longitude': canonicalDouble(hypocenterLongitude),
          'state': hypocenterState.name,
        },
      ),
    ];
    return canonicalDigest(
      format: 'earthquake-overlay-data-v1',
      headerFields: const {},
      records: records,
    );
  }

  String buildRenderDigest({
    required int dataSequence,
    required String dataDigest,
    required double regionToCityZoom,
    required double stationMinZoom,
    required List<EarthquakeAreaStyle> regionStyles,
    required List<EarthquakeAreaStyle> cityStyles,
    required List<EarthquakeObservationPoint> stations,
    required MapSpriteAtlas spriteAtlas,
    required List<MapPointSpriteFeature> sprites,
  }) {
    final records = <CanonicalOverlayRecord>[
      CanonicalOverlayRecord(
        recordType: 'policy',
        stableId: 'overlay',
        fields: {
          'regionToCityZoom': canonicalDouble(regionToCityZoom),
          'stationMinZoom': canonicalDouble(stationMinZoom),
        },
      ),
      CanonicalOverlayRecord(
        recordType: 'spriteAtlas',
        stableId: spriteAtlas.identity.value,
        fields: {
          'height': spriteAtlas.height.toString(),
          'regionCount': spriteAtlas.regions.length.toString(),
          'width': spriteAtlas.width.toString(),
        },
      ),
      for (final style in regionStyles)
        areaStyleRecord(recordType: 'regionStyle', style: style),
      for (final style in cityStyles)
        areaStyleRecord(recordType: 'cityStyle', style: style),
      for (final station in stations)
        CanonicalOverlayRecord(
          recordType: 'stationStyle',
          stableId: station.id,
          fields: {
            'colorArgb': station.color.toARGB32().toString(),
            'latitude': canonicalDouble(station.latitude),
            'longitude': canonicalDouble(station.longitude),
            'radiusLogicalPixels': canonicalDouble(
              station.radiusLogicalPixels,
            ),
          },
        ),
      for (final sprite in sprites)
        CanonicalOverlayRecord(
          recordType: 'sprite',
          stableId: sprite.id,
          fields: {
            'latitude': canonicalDouble(sprite.latitude),
            'longitude': canonicalDouble(sprite.longitude),
            'opacityAtOrAboveValue': canonicalDouble(
              sprite.opacity.atOrAboveValue,
            ),
            'opacityBelowValue': canonicalDouble(sprite.opacity.belowValue),
            'opacityThresholdZoom': canonicalDouble(
              sprite.opacity.thresholdZoom,
            ),
            'priority': sprite.priority.toString(),
            'sizeEndValue': canonicalDouble(sprite.sizeScale.endValue),
            'sizeEndZoom': canonicalDouble(sprite.sizeScale.endZoom),
            'sizeStartValue': canonicalDouble(sprite.sizeScale.startValue),
            'sizeStartZoom': canonicalDouble(sprite.sizeScale.startZoom),
            'spriteRegionId': sprite.spriteRegionId,
          },
        ),
    ];
    return canonicalDigest(
      format: 'earthquake-overlay-render-v2',
      headerFields: {
        'dataDigest': dataDigest,
        'dataSequence': dataSequence.toString(),
      },
      records: records,
    );
  }

  EarthquakeOverlayHypocenterInput hypocenterInput(Earthquake earthquake) {
    final hypocenter = earthquake.hypocenter;
    if (hypocenter == null) {
      return (
        state: EarthquakeMapOverlayHypocenterState.earthquakeAbsent,
        longitude: null,
        latitude: null,
      );
    }
    return switch (hypocenter.coordinates) {
      null => (
        state: EarthquakeMapOverlayHypocenterState.coordinateAbsent,
        longitude: null,
        latitude: null,
      ),
      CoordinateUnknown() => (
        state: EarthquakeMapOverlayHypocenterState.unknown,
        longitude: null,
        latitude: null,
      ),
      CoordinateLatLng(:final longitude, :final latitude) => (
        state: EarthquakeMapOverlayHypocenterState.latLng,
        longitude: longitude,
        latitude: latitude,
      ),
    };
  }

  CanonicalOverlayRecord areaStyleRecord({
    required String recordType,
    required EarthquakeAreaStyle style,
  }) => CanonicalOverlayRecord(
    recordType: recordType,
    stableId: style.code,
    fields: {
      'colorArgb': style.color.toARGB32().toString(),
      'opacity': canonicalDouble(style.opacity),
    },
  );

  String canonicalDouble(double value) => value == 0 ? '0' : '$value';

  String canonicalDigest({
    required String format,
    required Map<String, String> headerFields,
    required List<CanonicalOverlayRecord> records,
  }) {
    final bytes = <int>[];
    appendField(bytes: bytes, tag: 'format', value: format);
    final headerEntries = headerFields.entries.toList()
      ..sort((first, second) => first.key.compareTo(second.key));
    for (final field in headerEntries) {
      appendField(bytes: bytes, tag: field.key, value: field.value);
    }
    final sortedRecords = records.toList()
      ..sort((first, second) {
        final typeOrder = first.recordType.compareTo(second.recordType);
        return typeOrder != 0
            ? typeOrder
            : first.stableId.compareTo(second.stableId);
      });
    appendField(
      bytes: bytes,
      tag: 'recordCount',
      value: sortedRecords.length.toString(),
    );
    for (final record in sortedRecords) {
      appendRecord(bytes: bytes, record: record);
    }
    return sha256.convert(bytes).toString();
  }

  void appendRecord({
    required List<int> bytes,
    required CanonicalOverlayRecord record,
  }) {
    appendField(
      bytes: bytes,
      tag: 'recordType',
      value: record.recordType,
    );
    appendField(bytes: bytes, tag: 'stableId', value: record.stableId);
    appendField(
      bytes: bytes,
      tag: 'fieldCount',
      value: record.fields.length.toString(),
    );
    final fields = record.fields.entries.toList()
      ..sort((first, second) => first.key.compareTo(second.key));
    for (final field in fields) {
      appendField(bytes: bytes, tag: field.key, value: field.value);
    }
  }

  void appendField({
    required List<int> bytes,
    required String tag,
    required String value,
  }) {
    final tagBytes = utf8.encode(tag);
    final valueBytes = utf8.encode(value);
    bytes
      ..addAll(ascii.encode('${tagBytes.length}:'))
      ..addAll(tagBytes)
      ..addAll(ascii.encode('${valueBytes.length}:'))
      ..addAll(valueBytes);
  }
}
