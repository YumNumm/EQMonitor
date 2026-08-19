import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_telegram_item.freezed.dart';

@Freezed()
abstract class EewTelegramItem with _$EewTelegramItem {
  const factory({
    required String eventId,
    required TelegramStatus status,
    required TelegramInfoType infoType,
    required int serialNo,
    required bool isCanceled,
    required bool isLastInfo,
    required DateTime reportTime,
    required bool isPlum,
    String? headline,
    bool? isWarning,
    DateTime? originTime,
    DateTime? arrivalTime,
    String? editorialOffice,
    EewHypocenterInfo? hypocenter,
    EewForecastIntensityInfo? forecastIntensity,
    EewWarningInfo? warning,
    EewAccuracyInfo? accuracy,
  }) = _EewTelegramItem;
  const new _();

  bool get isLowPreciseHypocenter =>
      isPlum || accuracy == null || accuracy?.epicenter == 1;

  /// レベル法: 震央精度が1点相当かつ発震時刻なし（Live Activity `isLevel` と同義）
  bool get isLevelMethod => accuracy?.epicenter == 1 && originTime == null;

  /// IPF法1点検知: 震央精度1点相当・発震時刻あり・PLUMでない（Live Activity `isOnePoint` と同義）
  bool get isOnePointDetection =>
      accuracy?.epicenter == 1 && originTime != null && !isPlum;

  /// PLUM / レベル法 / 1点のいずれか（M・深さを出さない）
  bool get shouldHideMagnitudeAndDepth =>
      isPlum || isLevelMethod || isOnePointDetection;
}

@Freezed()
abstract class EewHypocenterInfo with _$EewHypocenterInfo {
  const factory({
    required String code,
    required String name,
    String? detailedCode,
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
  const factory({
    required List<EewForecastRegionInfo> regions,
    JmaIntensity? maxIntensity,
    @Default(false) bool maxIntensityIsOver,
    JmaLpgmIntensity? maxLpgmIntensity,
    @Default(false) bool maxLpgmIntensityIsOver,
  }) = _EewForecastIntensityInfo;
}

@Freezed()
abstract class EewForecastRegionInfo with _$EewForecastRegionInfo {
  const factory({
    required String code,
    required String name,
    required bool isPlum,
    required bool isWarning,
    required JmaIntensity intensity,
    required bool intensityIsOver,
    DateTime? arrivalTime,
    @Default(false) bool isArrived,
    JmaLpgmIntensity? lpgmIntensity,
    @Default(false) bool lpgmIntensityIsOver,
  }) = _EewForecastRegionInfo;
}

@Freezed()
abstract class EewWarningInfo with _$EewWarningInfo {
  const factory({
    required List<EewWarningZoneInfo> zones,
    required List<EewWarningZoneInfo> prefectures,
    required List<EewWarningZoneInfo> regions,
  }) = _EewWarningInfo;
}

@Freezed()
abstract class EewWarningZoneInfo with _$EewWarningZoneInfo {
  const factory({
    required String code,
    required String name,
    required bool hadWarning,
  }) = _EewWarningZoneInfo;
}

@Freezed()
abstract class EewAccuracyInfo with _$EewAccuracyInfo {
  /* See: https://github.com/YumNumm/eqmonitor-backend/blob/b08ea2a864962074278e59a7c3012c2eb9822c44/packages/database/src/transformers/eew-transformer.ts#L128-L138
    {
      epicenter: eew.accuracy.epicenters[0],
      hypocenter: eew.accuracy.epicenters[1],
      depth: eew.accuracy.depth,
      magnitude_calculation: eew.accuracy.magnitudeCalculation,
      number_of_magnitude_calculation:
        eew.accuracy.numberOfMagnitudeCalculation,
    }
    */
  const factory({
    /// 震央位置の精度値（0〜9）
    ///
    /// 0 : 不明
    /// 1 : P波/S波レベル越え、IPF法(1点)、または「仮定震源要素」の場合（気象庁データ）
    /// 2 : IPF法(2点)（気象庁データ）
    /// 3 : IPF法(3点/4点)（気象庁データ）
    /// 4 : IPF法(5点以上)（気象庁データ）
    /// 5 : 防災科研システム(4点以下、または精度情報なし)（2023-09-26 14時以降は出現しない）
    /// 6 : 防災科研システム(5点以上)（Hi-netデータ）（2023-09-26 14時以降は出現しない）
    /// 7 : EPOS(海域[観測網外])（2023-09-26 14時以降は出現しない）
    /// 8 : EPOS(内陸[観測網内])（2023-09-26 14時以降は出現しない）
    required int epicenter,

    /// 震源位置の精度値（0〜9）
    ///
    /// 値が 1, 9 以外については気象庁の部内システムでの利用（予告無く変更することがあります）。
    ///
    /// 0 : 不明
    /// 1 : P波/S波レベル越え、IPF法(1点)、または「仮定震源要素」の場合
    /// 2 : IPF法(2点)
    /// 3 : IPF法(3点/4点)
    /// 4 : IPF法(5点以上)
    /// 9 : 震源とマグニチュードに基づく震度予測手法での精度が最終報相当
    ///     （推定震源とマグニチュードはこれ以降変化しません。
    ///     ただし、PLUM法により予測震度が今後変化する可能性はあります。）
    required int hypocenter,

    /// 深さの精度値（0〜9）
    ///
    /// 0 : 不明
    /// 1 : P波/S波レベル越え、IPF法(1点)、または「仮定震源要素」の場合
    /// 2 : IPF法(2点)
    /// 3 : IPF法(3点/4点)
    /// 4 : IPF法(5点以上)
    /// 5 : 防災科研システム(4点以下、または精度情報なし)（2023-09-26 14時以降は出現しない）
    /// 6 : 防災科研システム(5点以上)（Hi-netデータ）（2023-09-26 14時以降は出現しない）
    /// 7 : EPOS(海域[観測網外])（2023-09-26 14時以降は出現しない）
    /// 8 : EPOS(内陸[観測網内])（2023-09-26 14時以降は出現しない）
    required int depth,

    /// マグニチュードの精度値（0〜9）
    ///
    /// 0 : 不明
    /// 2 : 速度マグニチュード（2023-09-26 14時から）、
    ///     防災科研システム（Hi-netデータ）（2023-09-26 14時まで）
    /// 3 : 全相P相
    /// 4 : P相/全相混在
    /// 5 : 全点全相
    /// 6 : EPOS
    /// 8 : P波/S波レベル越え、または「仮定震源要素」の場合
    required int magnitudeCalculation,

    /// マグニチュード計算使用観測点数（0〜9）
    ///
    /// 0 : 不明
    /// 1 : 1点、P波/S波レベル越え、または「仮定震源要素」の場合
    /// 2 : 2点
    /// 3 : 3点
    /// 4 : 4点
    /// 5 : 5点以上
    required int numberOfMagnitudeCalculation,
  }) = _EewAccuracyInfo;
}

// --- Conversion Extensions ---

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
