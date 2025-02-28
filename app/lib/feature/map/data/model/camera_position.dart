import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lat_lng/lat_lng.dart';

part 'camera_position.freezed.dart';
part 'camera_position.g.dart';

/// マップのカメラ位置を表すモデル
@freezed
class MapCameraPosition with _$MapCameraPosition {
  const factory MapCameraPosition({
    /// カメラの中心座標
    required LatLng target,

    /// ズームレベル
    @Default(5.0) double zoom,

    /// カメラの傾き (0-60)
    @Default(0.0) double tilt,

    /// カメラの向き (0-360)
    @Default(0.0) double bearing,
  }) = _MapCameraPosition;

  factory MapCameraPosition.fromJson(
    Map<String, dynamic> json,
  ) => _$MapCameraPositionFromJson(json);

  /// MapLibreのCameraPositionに変換
  const MapCameraPosition._();
}
