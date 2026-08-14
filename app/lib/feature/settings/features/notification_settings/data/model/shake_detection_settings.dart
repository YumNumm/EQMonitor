import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shake_detection_settings.freezed.dart';

@freezed
abstract class ShakeDetectionEntry with _$ShakeDetectionEntry {
  const factory ShakeDetectionEntry({
    required String id,
    required String? subRegionId,
    required String? subRegionName,
    required ShakeDetectionLevel minLevel,
    required bool isCurrentLocation,
    String? prefectureCode,
    String? cityCode,
  }) = _ShakeDetectionEntry;
}

@freezed
abstract class ShakeDetectionSubRegion with _$ShakeDetectionSubRegion {
  const factory ShakeDetectionSubRegion({
    required String id,
    required String code,
    required String name,
  }) = _ShakeDetectionSubRegion;
}

typedef ShakeDetectionState = ({
  List<ShakeDetectionEntry> entries,
  List<ShakeDetectionSubRegion> availableSubRegions,
});
