import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shake_detection_settings.freezed.dart';

@freezed
abstract class ShakeDetectionEntry with _$ShakeDetectionEntry {
  const factory ShakeDetectionEntry({
    required String id,
    required String? subRegionId,
    required String? subRegionName,
    required api.ShakeDetectionLevel minLevel,
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
