import 'package:eqmonitor/feature/parameter/data/model/common/parameter_api_converter.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

extension EarthquakeStationsParameterApiConverter
    on api.ParameterDataResponseUnionEarthquakeStationsParameter {
  EarthquakeParameter toEarthquakeParameter({
    required EarthquakeStationArv400Index arv400Index,
  }) => EarthquakeParameter(
    metadata: metadata.toParameterMetadata(),
    prefectures: prefectures
        .map(
          (prefecture) => prefecture.toEarthquakeParameterPrefectureItem(
            arv400Index: arv400Index,
          ),
        )
        .toList(),
  );
}

extension EarthquakeStationPrefectureApiConverter
    on api.EarthquakeStationPrefecture {
  EarthquakeParameterPrefectureItem toEarthquakeParameterPrefectureItem({
    required EarthquakeStationArv400Index arv400Index,
  }) => EarthquakeParameterPrefectureItem(
    code: code,
    name: name.toLocalizedName(),
    regions: regions
        .map(
          (region) => region.toEarthquakeParameterRegionItem(
            arv400Index: arv400Index,
          ),
        )
        .toList(),
  );
}

extension EarthquakeStationRegionApiConverter on api.EarthquakeStationRegion {
  EarthquakeParameterRegionItem toEarthquakeParameterRegionItem({
    required EarthquakeStationArv400Index arv400Index,
  }) => EarthquakeParameterRegionItem(
    code: code,
    name: name.toLocalizedName(),
    kana: kana,
    cities: cities
        .map(
          (city) => city.toEarthquakeParameterCityItem(
            arv400Index: arv400Index,
          ),
        )
        .toList(),
  );
}

extension EarthquakeStationCityApiConverter on api.EarthquakeStationCity {
  EarthquakeParameterCityItem toEarthquakeParameterCityItem({
    required EarthquakeStationArv400Index arv400Index,
  }) => EarthquakeParameterCityItem(
    code: code,
    name: name.toLocalizedName(),
    kana: kana,
    stations: stations
        .map(
          (station) => station.toEarthquakeParameterStationItem(
            arv400: arv400Index[station.code],
          ),
        )
        .toList(),
  );
}

extension EarthquakeStationApiConverter on api.EarthquakeStation {
  EarthquakeParameterStationItem toEarthquakeParameterStationItem({
    required double? arv400,
  }) => EarthquakeParameterStationItem(
    code: code,
    noCode: noCode,
    name: name.toLocalizedName(),
    kana: kana,
    status: status.toEarthquakeStationStatus,
    sourceStatus: sourceStatus,
    owner: owner,
    location: location.toLatLng(),
    arv400: arv400,
  );
}

extension EarthquakeStationStatusApiConverter on api.EarthquakeStationStatus {
  EarthquakeStationStatus get toEarthquakeStationStatus => switch (this) {
    api.EarthquakeStationStatus.operating => EarthquakeStationStatus.operating,
    api.EarthquakeStationStatus.changed => EarthquakeStationStatus.changed,
    api.EarthquakeStationStatus.valueNew => EarthquakeStationStatus.valueNew,
    api.EarthquakeStationStatus.abolished =>
      EarthquakeStationStatus.abolished,
    api.EarthquakeStationStatus.unknown => EarthquakeStationStatus.unknown,
  };
}

final class EarthquakeStationArv400Index {
  const new _(this._values);

  factory fromJson(Map<String, dynamic> json) =>
      EarthquakeStationArv400Index.fromSubtree(json);

  factory fromSubtree(Map<String, dynamic> json) {
    final values = <String, double>{};
    _Arv400Collector.collect(json: json, values: values);
    return EarthquakeStationArv400Index._(values);
  }

  final Map<String, double> _values;

  double? operator [](String stationCode) => _values[stationCode];
}

final class _Arv400Collector {
  const new _();

  static void collect({
    required Map<String, dynamic> json,
    required Map<String, double> values,
  }) {
    final stations = json['stations'];
    if (stations is List<Object?>) {
      for (final station in stations) {
        if (station is! Map<String, dynamic>) {
          continue;
        }
        final code = station['code'];
        final arv400 = station['arv_400'];
        if (code is String && arv400 is num) {
          values[code] = arv400.toDouble();
        }
      }
    }

    final cities = json['cities'];
    if (cities is List<Object?>) {
      for (final city in cities) {
        if (city is Map<String, dynamic>) {
          collect(json: city, values: values);
        }
      }
    }

    final regions = json['regions'];
    if (regions is List<Object?>) {
      for (final region in regions) {
        if (region is Map<String, dynamic>) {
          collect(json: region, values: values);
        }
      }
    }

    final prefectures = json['prefectures'];
    if (prefectures is List<Object?>) {
      for (final prefecture in prefectures) {
        if (prefecture is Map<String, dynamic>) {
          collect(json: prefecture, values: values);
        }
      }
    }
  }
}
