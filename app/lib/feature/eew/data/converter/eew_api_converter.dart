import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

extension EewItemWithRelationsConverter on api.EewItemWithRelations {
  EewTelegramItem get toEewTelegramItem => EewTelegramItem(
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
    return EewHypocenterInfo(
      code: code,
      name: name,
      detailedCode: detailed?.code,
      detailedName: detailed?.name,
      latitude: coordinates?.latitude.toDouble(),
      longitude: coordinates?.longitude.toDouble(),
      magnitude: magnitude?.toDouble(),
      depth: depth,
    );
  }
}

extension on api.EewIntensity {
  EewForecastIntensityInfo _toEewForecastIntensityInfo() =>
      EewForecastIntensityInfo(
        regions: regions.map((r) => r._toEewForecastRegionInfo()).toList(),
        maxIntensity: maxIntensity?.value.toJmaIntensity,
        maxIntensityIsOver: maxIntensity?.isOver ?? false,
        maxLpgmIntensity: maxLpgmIntensity?.value.toJmaLpgmIntensity,
        maxLpgmIntensityIsOver: maxLpgmIntensity?.isOver ?? false,
      );
}

extension on api.EewIntensityItem {
  EewForecastRegionInfo _toEewForecastRegionInfo() => EewForecastRegionInfo(
    code: code,
    name: name,
    isPlum: isPlum,
    isWarning: isWarning,
    intensity: intensity.value.toJmaIntensity,
    intensityIsOver: intensity.isOver,
    arrivalTime: arrivalTime.type == api.EewIntensityRegionArrivalTimeType.time
        ? arrivalTime.value
        : null,
    isArrived:
        arrivalTime.type == api.EewIntensityRegionArrivalTimeType.arrived,
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
  EewWarningZoneInfo _toEewWarningZoneInfo() =>
      EewWarningZoneInfo(code: code, name: name, hadWarning: hadWarning);
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
