import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';
part 'shake_detection_settings.freezed.dart';

enum ShakeDetectionTargetType { currentLocation, nationwide, region }

@freezed
abstract class ShakeDetectionEntry with _$ShakeDetectionEntry {
  const factory({
    required String id,
    required ShakeDetectionTargetType targetType,
    required String? regionCode,
    required bool enabled,
    required ShakeDetectionLevel minLevel,
  }) = _ShakeDetectionEntry;
}

extension ShakeDetectionLevelThresholdLabel on ShakeDetectionLevel {
  String get minLevelThresholdLabel => switch (this) {
    .weaker => '微弱な揺れ以上',
    .weak => '弱い揺れ以上',
    .medium => 'やや強い揺れ以上',
    .strong => '強い揺れ以上',
    .stronger => '非常に強い揺れ',
  };
}

extension ShakeDetectionEntryX on ShakeDetectionEntry {
  bool get isCurrentLocation =>
      targetType == ShakeDetectionTargetType.currentLocation;
  api.ShakeDetectionSettingRequest toApiRequest() =>
      api.ShakeDetectionSettingRequest(
        targetType: switch (targetType) {
          .currentLocation => api.ShakeDetectionTargetType.currentLocation,
          .nationwide => api.ShakeDetectionTargetType.nationwide,
          .region => api.ShakeDetectionTargetType.region,
        },
        regionCode: regionCode,
        enabled: enabled,
        minLevel: minLevel.toApiShakeDetectionLevel,
      );
}

extension ShakeDetectionSettingResponseConverter
    on api.ShakeDetectionSettingResponse {
  ShakeDetectionEntry toModel() => ShakeDetectionEntry(
    id: id,
    targetType: switch (targetType) {
      api.ShakeDetectionTargetType.currentLocation => .currentLocation,
      api.ShakeDetectionTargetType.nationwide => .nationwide,
      api.ShakeDetectionTargetType.region => .region,
    },
    regionCode: regionCode,
    enabled: enabled,
    minLevel: minLevel.toShakeDetectionLevelModel,
  );
}

typedef ShakeDetectionState = ({
  List<ShakeDetectionEntry> entries,
  bool requiresReconfiguration,
});
