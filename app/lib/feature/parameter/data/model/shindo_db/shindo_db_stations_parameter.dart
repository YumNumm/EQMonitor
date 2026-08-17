import 'package:eqmonitor/feature/parameter/data/model/common/parameter_common.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_metadata.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lat_lng/lat_lng.dart';

part 'shindo_db_stations_parameter.freezed.dart';
part 'shindo_db_stations_parameter.g.dart';

@freezed
abstract class ShindoDbStationsParameter with _$ShindoDbStationsParameter {
  const factory ShindoDbStationsParameter({
    required ParameterMetadata metadata,
    required List<ShindoDbStationItem> stations,
  }) = _ShindoDbStationsParameter;

  factory ShindoDbStationsParameter.fromJson(Map<String, dynamic> json) =>
      _$ShindoDbStationsParameterFromJson(json);
}

@Freezed(fromJson: false)
abstract class ShindoDbStationItem with _$ShindoDbStationItem {
  const factory ShindoDbStationItem({
    required String code,
    required String name,
    required LatLng location,
    String? cityCode,
  }) = _ShindoDbStationItem;

  factory ShindoDbStationItem.fromJson(Map<String, dynamic> json) =>
      ShindoDbStationItem(
        code: json['code'] as String,
        name: json['name'] as String,
        location: LatLng(
          (json['latitude'] as num).toDouble(),
          (json['longitude'] as num).toDouble(),
        ),
        cityCode: json['city_code'] as String?,
      );
}

extension ShindoDbStationItemExtension on ShindoDbStationItem {
  EarthquakeParameterStationItem toEarthquakeParameterStationItem() =>
      EarthquakeParameterStationItem(
        code: code,
        noCode: '',
        name: LocalizedName(ja: name),
        kana: null,
        status: EarthquakeStationStatus.unknown,
        sourceStatus: '',
        owner: '',
        location: location,
      );
}
