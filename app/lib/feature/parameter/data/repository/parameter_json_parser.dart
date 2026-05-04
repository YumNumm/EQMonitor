import 'dart:convert';

import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'parameter_json_parser.g.dart';

@riverpod
ParameterJsonParser parameterJsonParser(Ref ref) => const ParameterJsonParser();

final class ParameterJsonParser {
  const ParameterJsonParser();

  ParameterManifest parseManifest(String source) =>
      ParameterManifest.fromJson(decodeObject(source));

  ParameterSet parseSet({
    required String manifestJson,
    required Map<ParameterType, String> parameterJsonByType,
  }) {
    final manifest = parseManifest(manifestJson);
    final jmaCodeTable = parseJmaCodeTable(
      parameterJsonByType[ParameterType.jmaCodeTable] ??
          (throw const FormatException('Missing jma_code_table parameter')),
    );
    final kyoshinObservationPoints = parseKyoshinObservationPoints(
      parameterJsonByType[ParameterType.kyoshinObservationPoints] ??
          (throw const FormatException(
            'Missing kyoshin_observation_points parameter',
          )),
    );
    final earthquake = parseEarthquake(
      parameterJsonByType[ParameterType.earthquakeStations] ??
          (throw const FormatException('Missing earthquake_stations parameter')),
    );
    final tsunami = parseTsunami(
      parameterJsonByType[ParameterType.tsunamiStations] ??
          (throw const FormatException('Missing tsunami_stations parameter')),
    );
    return ParameterSet(
      manifest: manifest,
      jmaCodeTable: jmaCodeTable,
      kyoshinObservationPoints: kyoshinObservationPoints,
      earthquake: earthquake,
      tsunami: tsunami,
    );
  }

  JmaCodeTableParameter parseJmaCodeTable(String source) =>
      JmaCodeTableParameter.fromJson(decodeObject(source));

  KyoshinObservationPointsParameter parseKyoshinObservationPoints(
    String source,
  ) =>
      KyoshinObservationPointsParameter.fromJson(decodeObject(source));

  EarthquakeParameter parseEarthquake(String source) =>
      EarthquakeParameter.fromJson(decodeObject(source));

  TsunamiParameter parseTsunami(String source) =>
      TsunamiParameter.fromJson(decodeObject(source));

  void parseParameter({
    required ParameterType type,
    required String source,
  }) {
    switch (type) {
      case ParameterType.jmaCodeTable:
        parseJmaCodeTable(source);
      case ParameterType.kyoshinObservationPoints:
        parseKyoshinObservationPoints(source);
      case ParameterType.earthquakeStations:
        parseEarthquake(source);
      case ParameterType.tsunamiStations:
        parseTsunami(source);
    }
  }

  Map<String, dynamic> decodeObject(String source) {
    final Object? decoded = jsonDecode(source);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }
    throw const FormatException('Parameter JSON root must be an object');
  }

  String encodeObject(Map<String, dynamic> json) => jsonEncode(json);
}
