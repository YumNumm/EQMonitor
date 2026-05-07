import 'package:eqmonitor/feature/parameter/data/model/common/parameter_common.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_metadata.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lat_lng/lat_lng.dart';

part 'earthquake_parameter.freezed.dart';
part 'earthquake_parameter.g.dart';

@freezed
abstract class EarthquakeParameter with _$EarthquakeParameter {
  const factory EarthquakeParameter({
    required ParameterMetadata metadata,
    required List<EarthquakeParameterPrefectureItem> prefectures,
  }) = _EarthquakeParameter;

  factory EarthquakeParameter.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeParameterFromJson(json);
}

@freezed
abstract class EarthquakeParameterPrefectureItem
    with _$EarthquakeParameterPrefectureItem {
  const factory EarthquakeParameterPrefectureItem({
    required String code,
    required LocalizedName name,
    required List<EarthquakeParameterRegionItem> regions,
  }) = _EarthquakeParameterPrefectureItem;

  factory EarthquakeParameterPrefectureItem.fromJson(
    Map<String, dynamic> json,
  ) => _$EarthquakeParameterPrefectureItemFromJson(json);
}

@freezed
abstract class EarthquakeParameterRegionItem
    with _$EarthquakeParameterRegionItem {
  const factory EarthquakeParameterRegionItem({
    required String code,
    required LocalizedName name,
    required String? kana,
    required List<EarthquakeParameterCityItem> cities,
  }) = _EarthquakeParameterRegionItem;

  factory EarthquakeParameterRegionItem.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeParameterRegionItemFromJson(json);
}

@freezed
abstract class EarthquakeParameterCityItem with _$EarthquakeParameterCityItem {
  const factory EarthquakeParameterCityItem({
    required String code,
    required LocalizedName name,
    required String? kana,
    required List<EarthquakeParameterStationItem> stations,
  }) = _EarthquakeParameterCityItem;

  factory EarthquakeParameterCityItem.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeParameterCityItemFromJson(json);
}

@freezed
abstract class EarthquakeParameterStationItem
    with _$EarthquakeParameterStationItem {
  @JsonSerializable(fieldRename: .snake)
  const factory EarthquakeParameterStationItem({
    required String code,
    required String noCode,
    required LocalizedName name,
    required String? kana,
    required EarthquakeStationStatus status,
    required String sourceStatus,
    required String owner,
    required LatLng location,
    @JsonKey(name: 'arv_400') double? arv400,
  }) = _EarthquakeParameterStationItem;

  factory EarthquakeParameterStationItem.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeParameterStationItemFromJson(json);
}

@JsonEnum(fieldRename: FieldRename.snake)
enum EarthquakeStationStatus {
  operating,
  changed,
  @JsonValue('new')
  valueNew,
  abolished,
  unknown,
}
