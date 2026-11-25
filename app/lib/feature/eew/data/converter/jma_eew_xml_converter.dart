import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:jma_eew_xml/jma_eew_xml.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'jma_eew_xml_converter.g.dart';

@riverpod
JmaEewXmlConverter jmaEewXmlConverter(Ref ref) => const JmaEewXmlConverter();

class const JmaEewXmlConverter() {
  EewTelegramItem convert(JmaEewTelegram telegram) {
    final earthquake = telegram.earthquake;
    final forecast = telegram.intensityForecast;
    final accuracy = earthquake?.hypocenter.accuracy;
    return EewTelegramItem(
      eventId: telegram.eventId,
      status: switch (telegram.status) {
        .normal => .normal,
        .training => .training,
        .test => .test,
      },
      infoType: switch (telegram.infoType) {
        .publication => .publication,
        .correction => .correction,
        .delay => .delay,
        .cancellation => .cancellation,
      },
      serialNo: telegram.serial,
      isCanceled: telegram.isCanceled,
      // 取消報に NextAdvisory は付かないが、取消でその地震 ID の報は終わる。
      isLastInfo: telegram.isCanceled || telegram.isLastInfo,
      reportTime: telegram.reportDateTime,
      isPlum: earthquake?.isAssumedHypocenter ?? false,
      headline: telegram.headlineText,
      isWarning: telegram.isCanceled ? null : telegram.hasWarning,
      originTime: earthquake?.originTime,
      arrivalTime: earthquake?.arrivalTime,
      editorialOffice: telegram.editorialOffice,
      hypocenter: earthquake == null ? null : hypocenter(earthquake),
      forecastIntensity: forecast == null ? null : forecastIntensity(forecast),
      warning: telegram.warningItems.isEmpty
          ? null
          : warning(telegram.warningItems),
      accuracy: accuracy == null
          ? null
          : EewAccuracyInfo(
              epicenter: accuracy.epicenterRank,
              hypocenter: accuracy.epicenterRank2,
              depth: accuracy.depthRank,
              magnitudeCalculation: accuracy.magnitudeCalculationRank,
              numberOfMagnitudeCalculation:
                  accuracy.numberOfMagnitudeCalculation,
            ),
    );
  }

  // EQMonitor API と同じく、詳細な震源名には短縮用震央地名を入れる。
  EewHypocenterInfo hypocenter(JmaEewEarthquake earthquake) {
    final hypocenter = earthquake.hypocenter;
    final coordinate = hypocenter.coordinate;
    return EewHypocenterInfo(
      code: hypocenter.code,
      name: hypocenter.name,
      detailedCode: hypocenter.reduceCode,
      detailedName: hypocenter.reduceName,
      latitude: coordinate?.latitude,
      longitude: coordinate?.longitude,
      magnitude: earthquake.magnitude.value,
      depth: coordinate?.depthKilometers,
    );
  }

  EewForecastIntensityInfo? forecastIntensity(
    JmaEewIntensityForecast forecast,
  ) {
    final maxIntensity = intensity(
      forecast.maxIntensity.to ?? forecast.maxIntensity.from,
    );
    final maxLgIntensity = forecast.maxLgIntensity;
    final maxLpgmIntensity = maxLgIntensity == null
        ? null
        : lpgmIntensity(maxLgIntensity.to ?? maxLgIntensity.from);
    final regions = [for (final area in forecast.areas) forecastRegion(area)];
    if (regions.isEmpty && maxIntensity == .unknown) {
      return null;
    }
    return EewForecastIntensityInfo(
      regions: regions,
      maxIntensity: maxIntensity == .unknown ? null : maxIntensity,
      maxIntensityIsOver: forecast.maxIntensity.isOver,
      maxLpgmIntensity: maxLpgmIntensity == .unknown ? null : maxLpgmIntensity,
      maxLpgmIntensityIsOver: maxLgIntensity?.isOver ?? false,
    );
  }

  EewForecastRegionInfo forecastRegion(JmaEewForecastArea area) {
    final lgIntensity = area.lgIntensity;
    return EewForecastRegionInfo(
      code: area.code,
      name: area.name,
      isPlum: area.isPlum,
      isWarning: area.isWarning,
      intensity: intensity(area.intensity.to ?? area.intensity.from),
      intensityIsOver: area.intensity.isOver,
      arrivalTime: area.arrivalTime,
      isArrived: area.arrivalTime == null,
      lpgmIntensity: lgIntensity == null
          ? null
          : lpgmIntensity(lgIntensity.to ?? lgIntensity.from),
      lpgmIntensityIsOver: lgIntensity?.isOver ?? false,
    );
  }

  EewWarningInfo warning(List<JmaEewWarningItem> items) {
    List<EewWarningZoneInfo> zones(JmaEewWarningAreaLevel level) => [
      for (final item in items)
        if (item.level == level)
          for (final area in item.areas)
            EewWarningZoneInfo(
              code: area.code,
              name: area.name,
              hadWarning: item.hadWarning,
            ),
    ];
    return EewWarningInfo(
      zones: zones(.region),
      prefectures: zones(.prefecture),
      regions: zones(.area),
    );
  }

  JmaIntensity intensity(JmaEewIntensity value) => switch (value) {
    .zero => .zero,
    .one => .one,
    .two => .two,
    .three => .three,
    .four => .four,
    .fiveLower => .fiveLower,
    .fiveUpper => .fiveUpper,
    .sixLower => .sixLower,
    .sixUpper => .sixUpper,
    .seven => .seven,
    .unknown => .unknown,
  };

  JmaLpgmIntensity lpgmIntensity(JmaEewLgIntensity value) => switch (value) {
    .zero => .zero,
    .one => .one,
    .two => .two,
    .three => .three,
    .four => .four,
    .unknown => .unknown,
  };
}
