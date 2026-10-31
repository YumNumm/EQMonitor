import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_camera.freezed.dart';

@freezed
abstract class MapCamera with _$MapCamera {
  const factory({
    required double centerLongitude,
    required double centerLatitude,
    required double zoom,
  }) = _MapCamera;
}
