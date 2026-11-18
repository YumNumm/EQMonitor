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

  /// レベルの下限にあたる震度の目安。
  ///
  /// 検知エンジンの `ShakeEventLevel.fromIntensity` の閾値に対応する。
  /// 微弱な揺れは下限を持たないため目安を出さない。
  String? get intensityGuideLabel => switch (this) {
    .weaker => null,
    .weak => '震度1程度〜',
    .medium => '震度3程度〜',
    .strong => '震度5弱程度〜',
    .stronger => '震度6弱程度〜',
  };

  /// 一行では選択中の表示が省略されるため、目安は二行目に置く。
  String get minLevelDropdownLabel => switch (intensityGuideLabel) {
    final guide? => '$minLevelThresholdLabel\n$guide',
    null => minLevelThresholdLabel,
  };

  bool get isDeprecatedForNotification => this == .weaker;

  String get notificationMinLevelDropdownLabel => isDeprecatedForNotification
      ? '$minLevelThresholdLabel\n非推奨'
      : minLevelDropdownLabel;
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
