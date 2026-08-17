import 'package:freezed_annotation/freezed_annotation.dart';

part 'seismicity_bounds.freezed.dart';

/// 地図上で矩形選択された緯度経度範囲。
@freezed
abstract class SeismicityBounds with _$SeismicityBounds {
  const factory({
    required double minLatitude,
    required double maxLatitude,
    required double minLongitude,
    required double maxLongitude,
  }) = _SeismicityBounds;
}
