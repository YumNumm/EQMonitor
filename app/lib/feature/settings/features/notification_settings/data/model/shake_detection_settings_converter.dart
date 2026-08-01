import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_settings.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

extension ShakeDetectionSettingResponseConverter
    on api.ShakeDetectionSettingResponse {
  ShakeDetectionEntry toShakeDetectionEntry() => ShakeDetectionEntry(
    id: id,
    subRegionId: subRegionId,
    subRegionName: null,
    prefectureCode: prefectureCode,
    cityCode: cityCode,
    minLevel: minLevel,
    isCurrentLocation: isCurrentLocation,
  );
}

extension ShakeDetectionEntryConverter on ShakeDetectionEntry {
  api.ShakeDetectionSettingRequest toApiRequest() =>
      api.ShakeDetectionSettingRequest(
        subRegionId: subRegionId,
        prefectureCode: prefectureCode,
        cityCode: cityCode,
        minLevel: minLevel,
        isCurrentLocation: isCurrentLocation,
      );
}
