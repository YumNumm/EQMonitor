import 'package:meta/meta.dart';

/// 各地の震度ツリーで選ばれた、マップフォーカス対象（詳細マップ実装時にカメラへ渡す）。
enum EarthquakeIntensityMapFocusKind {
  prefectureRegion,
  city,
  station,
}

@immutable
class EarthquakeIntensityMapFocus {
  const EarthquakeIntensityMapFocus({
    required this.kind,
    required this.code,
  });

  final EarthquakeIntensityMapFocusKind kind;
  final String code;
}
