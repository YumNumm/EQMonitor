import 'package:eqmonitor/feature/parameter/data/model/common/parameter_common.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_metadata.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:lat_lng/lat_lng.dart';

extension ParameterMetadataApiConverter on api.ParameterMetadata {
  ParameterMetadata toParameterMetadata() => ParameterMetadata(
    type: type.toAppParameterType,
    schemaVersion: schemaVersion,
    sourceVersion: sourceVersion,
    sourceUpdatedAt: sourceUpdatedAt,
    sourceUrls: sourceUrls,
    sha256: sha256,
  );
}

extension ParameterTypeApiToAppConverter on api.ParameterType {
  ParameterType get toAppParameterType => switch (this) {
    .jmaCodeTable => .jmaCodeTable,
    .kyoshinObservationPoints => .kyoshinObservationPoints,
    .earthquakeStations => .earthquakeStations,
    .tsunamiStations => .tsunamiStations,
    .shindoDbStations => .shindoDbStations,
  };
}

extension LocalizedNameApiConverter on api.LocalizedName {
  LocalizedName toLocalizedName() => LocalizedName(
    ja: ja,
    en: en,
    zhHans: zhHans,
    zhHant: zhHant,
    ko: ko,
    es: es,
    pt: pt,
    id: id,
    vi: vi,
    tl: tl,
    th: th,
    ne: ne,
    km: km,
    my: my,
    mn: mn,
  );
}

extension ParameterLocationApiConverter on api.ParameterLocation {
  LatLng toLatLng() => LatLng(
    latitude.toDouble(),
    longitude.toDouble(),
  );
}
