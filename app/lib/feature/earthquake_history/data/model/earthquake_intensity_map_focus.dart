import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_intensity_map_focus.freezed.dart';

/// 各地の震度ツリーで選ばれた、マップフォーカス対象（詳細マップ実装時にカメラへ渡す）。
enum EarthquakeIntensityMapFocusKind {
  prefectureRegion,
  city,
  station,
}

@freezed
abstract class EarthquakeIntensityMapFocus with _$EarthquakeIntensityMapFocus {
  const factory({
    required EarthquakeIntensityMapFocusKind kind,
    required String code,
  }) = _EarthquakeIntensityMapFocus;
}
