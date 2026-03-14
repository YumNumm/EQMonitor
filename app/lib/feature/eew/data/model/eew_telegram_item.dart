import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor_api/export.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_telegram_item.freezed.dart';

@Freezed()
abstract class EewTelegramItem with _$EewTelegramItem {

  const factory EewTelegramItem({
    required String eventId,
    required TelegramStatus status,
    required TelegramInfoType infoType,
    required int serialNo,
    required bool isCanceled, required bool isLastInfo, required DateTime reportTime, required bool isPlum, String? headline,
    bool? isWarning,
    DateTime? originTime,
    DateTime? arrivalTime,
    String? editorialOffice,
    EewHypocenterInfo? hypocenter,
    EewForecastIntensityInfo? forecastIntensity,
    EewWarningInfo? warning,
    EewAccuracyInfo? accuracy,
  }) = _EewTelegramItem;
  const EewTelegramItem._();

  bool get isWarningOrFallback =>
      isWarning ?? headline?.contains('強い揺れ') ?? false;
}

@Freezed()
abstract class EewHypocenterInfo with _$EewHypocenterInfo {
  const factory EewHypocenterInfo({
    required String code,
    required String name,
    required bool hasLatLng, String? detailedCode,
    String? detailedName,
    double? latitude,
    double? longitude,
    String? coordinateCondition,
    double? magnitude,
    int? depth,
  }) = _EewHypocenterInfo;
}

@Freezed()
abstract class EewForecastIntensityInfo with _$EewForecastIntensityInfo {
  const factory EewForecastIntensityInfo({
    required List<EewForecastRegionInfo> regions,
    // TODO(eqmonitor_api): EewIntensityValue.value は Intensity 型（codegen バグ）
    JmaIntensity? maxIntensity,
    @Default(false) bool maxIntensityIsOver,
    JmaLpgmIntensity? maxLpgmIntensity,
    @Default(false) bool maxLpgmIntensityIsOver,
  }) = _EewForecastIntensityInfo;
}

@Freezed()
abstract class EewForecastRegionInfo with _$EewForecastRegionInfo {
  const factory EewForecastRegionInfo({
    required String code,
    required String name,
    required bool isPlum,
    required bool isWarning,
    // TODO(eqmonitor_api): EewIntensityValue.value は Intensity 型（codegen バグ）
    required JmaIntensity intensity,
    required bool intensityIsOver,
    JmaLpgmIntensity? lpgmIntensity,
    @Default(false) bool lpgmIntensityIsOver,
  }) = _EewForecastRegionInfo;
}

@Freezed()
abstract class EewWarningInfo with _$EewWarningInfo {
  const factory EewWarningInfo({
    required List<EewWarningZoneInfo> zones,
    required List<EewWarningZoneInfo> prefectures,
    required List<EewWarningZoneInfo> regions,
  }) = _EewWarningInfo;
}

@Freezed()
abstract class EewWarningZoneInfo with _$EewWarningZoneInfo {
  const factory EewWarningZoneInfo({
    required String code,
    required String name,
    required bool hadWarning,
  }) = _EewWarningZoneInfo;
}

@Freezed()
abstract class EewAccuracyInfo with _$EewAccuracyInfo {
  const factory EewAccuracyInfo({
    required int epicenter,
    required int hypocenter,
    required int depth,
    required int magnitudeCalculation,
    required int numberOfMagnitudeCalculation,
  }) = _EewAccuracyInfo;
}

// --- Conversion Extensions ---

extension EewItemWithRelationsConverter on api.EewItemWithRelations {
  EewTelegramItem toEewTelegramItem() => EewTelegramItem(
    eventId: eventId,
    status: status.toTelegramStatus,
    infoType: infoType.toTelegramInfoType,
    serialNo: serialNo.toInt(),
    headline: headline,
    isCanceled: isCanceled,
    isWarning: isWarning,
    isLastInfo: isLastInfo,
    originTime: originTime,
    arrivalTime: arrivalTime,
    reportTime: reportTime,
    isPlum: isPlum,
    editorialOffice: editorialOffice,
    hypocenter: hypocenter?._toEewHypocenterInfo(),
    forecastIntensity: forecastIntensity?._toEewForecastIntensityInfo(),
    warning: warning?._toEewWarningInfo(),
    accuracy: accuracy?._toEewAccuracyInfo(),
  );
}

extension on api.EewHypocenter {
  EewHypocenterInfo _toEewHypocenterInfo() {
    final isLatLng = coordinates.type == api.CoordinateType.latLng;
    return EewHypocenterInfo(
      code: value.code,
      name: value.name,
      detailedCode: detailed?.code,
      detailedName: detailed?.name,
      latitude: isLatLng ? coordinates.latitude?.toDouble() : null,
      longitude: isLatLng ? coordinates.longitude?.toDouble() : null,
      hasLatLng: isLatLng,
      coordinateCondition: coordinates.condition,
      magnitude: magnitude?.toDouble(),
      depth: depth?.toInt(),
    );
  }
}

extension on api.EewIntensity {
  EewForecastIntensityInfo _toEewForecastIntensityInfo() =>
      EewForecastIntensityInfo(
        regions: regions.map((r) => r._toEewForecastRegionInfo()).toList(),
        // TODO(eqmonitor_api): EewIntensityValue.value は Intensity 型（codegen バグ）
        maxIntensity: JmaIntensity.unknown,
        maxIntensityIsOver: maxIntensity?.isOver ?? false,
        maxLpgmIntensity:
            maxLpgmIntensity?.value.toJmaLpgmIntensity,
        maxLpgmIntensityIsOver: maxLpgmIntensity?.isOver ?? false,
      );
}

extension on api.EewIntensityItem {
  EewForecastRegionInfo _toEewForecastRegionInfo() => EewForecastRegionInfo(
    code: value.code,
    name: value.name,
    isPlum: isPlum,
    isWarning: isWarning,
    // TODO(eqmonitor_api): EewIntensityValue.value は Intensity 型（codegen バグ）
    intensity: JmaIntensity.unknown,
    intensityIsOver: intensity.isOver,
    lpgmIntensity: lpgmIntensity?.value.toJmaLpgmIntensity,
    lpgmIntensityIsOver: lpgmIntensity?.isOver ?? false,
  );
}

extension on api.EewWarning {
  EewWarningInfo _toEewWarningInfo() => EewWarningInfo(
    zones: zones.map((z) => z._toEewWarningZoneInfo()).toList(),
    prefectures: prefectures.map((p) => p._toEewWarningZoneInfo()).toList(),
    regions: regions.map((r) => r._toEewWarningZoneInfo()).toList(),
  );
}

extension on api.EewWarningZoneItem {
  EewWarningZoneInfo _toEewWarningZoneInfo() => EewWarningZoneInfo(
    code: value.code,
    name: value.name,
    hadWarning: hadWarning,
  );
}

extension on api.EewAccuracy {
  EewAccuracyInfo _toEewAccuracyInfo() => EewAccuracyInfo(
    epicenter: epicenter.toInt(),
    hypocenter: hypocenter.toInt(),
    depth: depth.toInt(),
    magnitudeCalculation: magnitudeCalculation.toInt(),
    numberOfMagnitudeCalculation: numberOfMagnitudeCalculation.toInt(),
  );
}
