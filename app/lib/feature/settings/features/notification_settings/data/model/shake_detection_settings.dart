import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
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

extension ShakeDetectionSettingResponseConverter
    on api.ShakeDetectionSettingResponse {
  /// API レスポンスをアプリ用モデルへ変換する。
  /// [ShakeDetectionEntry.subRegionName] は一覧取得後に別途名称解決するため
  /// ここでは常に null を返す。
  ShakeDetectionEntry toModel() => ShakeDetectionEntry(
    id: id,
    subRegionId: subRegionId,
    subRegionName: null,
    prefectureCode: prefectureCode,
    cityCode: cityCode,
    minLevel: minLevel.toShakeDetectionLevelModel,
    isCurrentLocation: isCurrentLocation,
  );
}

extension ShakeDetectionEntryRequestConverter on ShakeDetectionEntry {
  api.ShakeDetectionSettingRequest toApiRequest() =>
      api.ShakeDetectionSettingRequest(
        subRegionId: subRegionId,
        prefectureCode: prefectureCode,
        cityCode: cityCode,
        minLevel: minLevel.toApiShakeDetectionLevel,
        isCurrentLocation: isCurrentLocation,
      );
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
