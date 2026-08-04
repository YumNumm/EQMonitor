import 'package:eqmonitor_map/src/geo/map_mercator_projection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_camera.freezed.dart';

/// 地図cameraの状態。永続化はしないがframe毎に読まれるimmutable snapshotで
/// あり、equality/copyWithの手書きコストを避けるためFreezedを使う
/// (brief指定)。bearing/pitchには未対応で、フィールドも追加しない。
@freezed
abstract class MapCamera with _$MapCamera {
  const factory MapCamera({
    required double centerLongitude,
    required double centerLatitude,
    required double zoom,
  }) = _MapCamera;

  const MapCamera._();

  /// camera中心をnormalized MercatorのworldSize単位(現在のzoom基準)へ
  /// 投影した座標。tile_matrixのorigin rebasingがcamera中心をworld原点
  /// へ寄せる際の基準点として使う。
  ({double x, double y}) worldCenter({
    MapMercatorProjection projection = const MapMercatorProjection(),
  }) {
    final normalized = projection.lngLatToNormalized(
      longitude: centerLongitude,
      latitude: centerLatitude,
    );
    final worldSize = projection.worldSizeForZoom(zoom);
    return (x: normalized.x * worldSize, y: normalized.y * worldSize);
  }
}
