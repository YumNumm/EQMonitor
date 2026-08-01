import 'package:eqmonitor/feature/parameter/data/model/common/parameter_common.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_metadata.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:lat_lng/lat_lng.dart';

final class EarthquakeParameterJsonDecoder {
  const EarthquakeParameterJsonDecoder();

  EarthquakeParameter decode(Map<String, dynamic> json) => EarthquakeParameter(
    metadata: ParameterMetadata.fromJson(
      json['metadata'] as Map<String, dynamic>,
    ),
    prefectures: (json['prefectures'] as List)
        .cast<Map<String, dynamic>>()
        .map(decodePrefecture)
        .toList(),
  );

  EarthquakeParameterPrefectureItem decodePrefecture(
    Map<String, dynamic> json,
  ) => EarthquakeParameterPrefectureItem(
    code: json['code'] as String,
    name: LocalizedName.fromJson(json['name'] as Map<String, dynamic>),
    regions: (json['regions'] as List)
        .cast<Map<String, dynamic>>()
        .map(decodeRegion)
        .toList(),
  );

  EarthquakeParameterRegionItem decodeRegion(Map<String, dynamic> json) =>
      EarthquakeParameterRegionItem(
        code: json['code'] as String,
        name: LocalizedName.fromJson(json['name'] as Map<String, dynamic>),
        kana: json['kana'] as String?,
        cities: (json['cities'] as List)
            .cast<Map<String, dynamic>>()
            .map(decodeCity)
            .toList(),
      );

  EarthquakeParameterCityItem decodeCity(Map<String, dynamic> json) =>
      EarthquakeParameterCityItem(
        code: json['code'] as String,
        name: LocalizedName.fromJson(json['name'] as Map<String, dynamic>),
        kana: json['kana'] as String?,
        stations: (json['stations'] as List)
            .cast<Map<String, dynamic>>()
            .map(decodeStation)
            .toList(),
      );

  EarthquakeParameterStationItem decodeStation(Map<String, dynamic> json) {
    final location = json['location'] as Map<String, dynamic>;
    final status = switch (json['status']) {
      'OPERATING' => EarthquakeStationStatus.operating,
      'CHANGED' => EarthquakeStationStatus.changed,
      'NEW' => EarthquakeStationStatus.valueNew,
      'ABOLISHED' => EarthquakeStationStatus.abolished,
      'UNKNOWN' => EarthquakeStationStatus.unknown,
      final value => throw FormatException('Unknown station status: $value'),
    };
    return EarthquakeParameterStationItem(
      code: json['code'] as String,
      noCode: json['no_code'] as String,
      name: LocalizedName.fromJson(json['name'] as Map<String, dynamic>),
      kana: json['kana'] as String?,
      status: status,
      sourceStatus: json['source_status'] as String,
      owner: json['owner'] as String,
      location: LatLng(
        (location['latitude'] as num).toDouble(),
        (location['longitude'] as num).toDouble(),
      ),
      arv400: (json['arv_400'] as num?)?.toDouble(),
    );
  }
}
