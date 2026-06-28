import 'package:freezed_annotation/freezed_annotation.dart';

part 'nearby_earthquake_parameter.freezed.dart';

/// 震源近傍の地震探索パラメータ
@freezed
abstract class NearbyEarthquakeParameter with _$NearbyEarthquakeParameter {
  const factory NearbyEarthquakeParameter({
    /// 緯度オフセット (度): ±この値の範囲を検索
    @Default(0.5) double latitudeOffset,

    /// 経度オフセット (度): ±この値の範囲を検索
    @Default(0.5) double longitudeOffset,

    /// 深さオフセット (km): ±この値の範囲を検索
    @Default(50) int depthOffset,
  }) = _NearbyEarthquakeParameter;
}
