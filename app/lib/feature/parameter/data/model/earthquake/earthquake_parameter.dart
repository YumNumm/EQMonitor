import 'package:eqmonitor/feature/parameter/data/model/common/parameter_common.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_metadata.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lat_lng/lat_lng.dart';

part 'earthquake_parameter.freezed.dart';

@freezed
abstract class EarthquakeParameter with _$EarthquakeParameter {
  const factory({
    required ParameterMetadata metadata,
    required List<EarthquakeParameterPrefectureItem> prefectures,
  }) = _EarthquakeParameter;
}

@freezed
abstract class EarthquakeParameterPrefectureItem
    with _$EarthquakeParameterPrefectureItem {
  const factory({
    required String code,
    required LocalizedName name,
    required List<EarthquakeParameterRegionItem> regions,
  }) = _EarthquakeParameterPrefectureItem;
}

@freezed
abstract class EarthquakeParameterRegionItem
    with _$EarthquakeParameterRegionItem {
  const factory({
    required String code,
    required LocalizedName name,
    required String? kana,
    required List<EarthquakeParameterCityItem> cities,
  }) = _EarthquakeParameterRegionItem;
}

@freezed
abstract class EarthquakeParameterCityItem with _$EarthquakeParameterCityItem {
  const factory({
    required String code,
    required LocalizedName name,
    required String? kana,
    required List<EarthquakeParameterStationItem> stations,
  }) = _EarthquakeParameterCityItem;
}

@freezed
abstract class EarthquakeParameterStationItem
    with _$EarthquakeParameterStationItem {
  const factory({
    required String code,
    required String noCode,
    required LocalizedName name,
    required String? kana,
    required EarthquakeStationStatus status,
    required String sourceStatus,
    required String owner,
    required LatLng location,
    double? arv400,
  }) = _EarthquakeParameterStationItem;
}

enum EarthquakeStationStatus {
  operating,
  changed,
  valueNew,
  abolished,
  unknown,
}
