import 'package:eqmonitor/feature/parameter/data/model/common/parameter_common.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_metadata.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lat_lng/lat_lng.dart';

part 'tsunami_parameter.freezed.dart';
part 'tsunami_parameter.g.dart';

@freezed
abstract class TsunamiParameter with _$TsunamiParameter {
  const factory TsunamiParameter({
    required ParameterMetadata metadata,
    required List<TsunamiParameterPrefectureItem> prefectures,
  }) = _TsunamiParameter;

  factory TsunamiParameter.fromJson(Map<String, dynamic> json) =>
      _$TsunamiParameterFromJson(json);
}

@freezed
abstract class TsunamiParameterPrefectureItem
    with _$TsunamiParameterPrefectureItem {
  const factory TsunamiParameterPrefectureItem({
    required String code,
    required LocalizedName name,
    required List<TsunamiParameterAreaItem> areas,
  }) = _TsunamiParameterPrefectureItem;

  factory TsunamiParameterPrefectureItem.fromJson(Map<String, dynamic> json) =>
      _$TsunamiParameterPrefectureItemFromJson(json);
}

@freezed
abstract class TsunamiParameterAreaItem with _$TsunamiParameterAreaItem {
  const factory TsunamiParameterAreaItem({
    required LocalizedName? name,
    required List<TsunamiParameterStationItem> stations,
  }) = _TsunamiParameterAreaItem;

  factory TsunamiParameterAreaItem.fromJson(Map<String, dynamic> json) =>
      _$TsunamiParameterAreaItemFromJson(json);
}

@freezed
abstract class TsunamiParameterStationItem with _$TsunamiParameterStationItem {
  const factory TsunamiParameterStationItem({
    required String code,
    required LocalizedName name,
    required String? kana,
    required String owner,
    required LatLng location,
  }) = _TsunamiParameterStationItem;

  factory TsunamiParameterStationItem.fromJson(Map<String, dynamic> json) =>
      _$TsunamiParameterStationItemFromJson(json);
}
