import 'package:eqmonitor/feature/parameter/data/model/common/parameter_common.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_metadata.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lat_lng/lat_lng.dart';

part 'tsunami_parameter.freezed.dart';
part 'tsunami_parameter.g.dart';

@freezed
abstract class TsunamiParameter with _$TsunamiParameter {
  const factory({
    required ParameterMetadata metadata,
    required List<TsunamiParameterPrefectureItem> prefectures,
  }) = _TsunamiParameter;

  factory fromJson(Map<String, dynamic> json) =>
      _$TsunamiParameterFromJson(json);
}

@freezed
abstract class TsunamiParameterPrefectureItem
    with _$TsunamiParameterPrefectureItem {
  const factory({
    required String code,
    required LocalizedName name,
    required List<TsunamiParameterAreaItem> areas,
  }) = _TsunamiParameterPrefectureItem;

  factory fromJson(Map<String, dynamic> json) =>
      _$TsunamiParameterPrefectureItemFromJson(json);
}

@freezed
abstract class TsunamiParameterAreaItem with _$TsunamiParameterAreaItem {
  const factory({
    required LocalizedName? name,
    required List<TsunamiParameterStationItem> stations,
  }) = _TsunamiParameterAreaItem;

  factory fromJson(Map<String, dynamic> json) =>
      _$TsunamiParameterAreaItemFromJson(json);
}

@freezed
abstract class TsunamiParameterStationItem with _$TsunamiParameterStationItem {
  const factory({
    required String code,
    required LocalizedName name,
    required String? kana,
    required String owner,
    required LatLng location,
  }) = _TsunamiParameterStationItem;

  factory fromJson(Map<String, dynamic> json) =>
      _$TsunamiParameterStationItemFromJson(json);
}
