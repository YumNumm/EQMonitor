import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_hypocenter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_station.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_partial.freezed.dart';
part 'earthquake_partial.g.dart';

@freezed
sealed class EarthquakePartial with _$EarthquakePartial {
  const factory normal({
    required String eventId,
    required TelegramStatus status,
    required DateTime? originTime,
    required OriginTimePrecision originTimePrecision,
    required DateTime? arrivalTime,
    required List<EarthquakeDataSource> dataSources,
    required EarthquakeHypocenter? hypocenter,
    required EarthquakeIntensityPartial? intensity,
    required EarthquakeType earthquakeType,
    required List<EarthquakeTelegramType> telegramTypes,
    required String? estimatedIntensityTileUrl,
  }) = EarthquakePartialNormal;

  const factory prefecture({
    required JmaIntensity prefectureIntensity,
    required EarthquakePartialNormal earthquake,
  }) = EarthquakePartialPrefecture;

  const factory region({
    required JmaIntensity regionIntensity,
    required EarthquakePartialNormal earthquake,
  }) = EarthquakePartialRegion;

  const factory city({
    required JmaIntensity cityIntensity,
    required EarthquakePartialNormal earthquake,
  }) = EarthquakePartialCity;

  const factory station({
    required JmaIntensity stationIntensity,
    required EarthquakePartialNormal earthquake,
  }) = EarthquakePartialStation;

  factory fromJson(Map<String, dynamic> json) =>
      _$EarthquakePartialFromJson(json);

  const new _();

  EarthquakePartialNormal get earthquake => switch (this) {
    final EarthquakePartialNormal value => value,
    EarthquakePartialPrefecture(:final EarthquakePartialNormal earthquake) =>
      earthquake,
    EarthquakePartialRegion(:final EarthquakePartialNormal earthquake) =>
      earthquake,
    EarthquakePartialCity(:final EarthquakePartialNormal earthquake) =>
      earthquake,
    EarthquakePartialStation(:final EarthquakePartialNormal earthquake) =>
      earthquake,
  };
}

@freezed
abstract class IntensityAreaInfo with _$IntensityAreaInfo {
  const factory({
    required String code,
    required LocalizedName name,
    required JmaIntensity intensity,
    required JmaLpgmIntensity? lpgmIntensity,
  }) = _IntensityAreaInfo;

  factory fromJson(Map<String, dynamic> json) =>
      _$IntensityAreaInfoFromJson(json);
}

@freezed
abstract class StationSearchInfo with _$StationSearchInfo {
  const factory({
    required String code,
    required LocalizedName name,
    required JmaIntensity? intensity,
    required JmaLpgmIntensity? lpgmIntensity,
    required double? sva,
    required List<PrePeriod>? prePeriods,
  }) = _StationSearchInfo;

  factory fromJson(Map<String, dynamic> json) =>
      _$StationSearchInfoFromJson(json);
}

extension EarthquakePartialApiExtension on api.EarthquakePartial {
  EarthquakePartialNormal toEarthquakePartial({
    required EarthquakeParameter parameter,
  }) => EarthquakePartialNormal(
    eventId: eventId,
    status: status.toTelegramStatus,
    originTime: originTime,
    originTimePrecision: originTimePrecision.toOriginTimePrecision,
    arrivalTime: arrivalTime,
    dataSources: datasources.map((e) => e.toEarthquakeDataSource).toList(),
    hypocenter: hypocenter?.toEarthquakeHypocenter,
    earthquakeType: earthquakeType.toEarthquakeType,
    telegramTypes: telegramTypes
        .map((e) => e.toEarthquakeTelegramType)
        .toList(),
    estimatedIntensityTileUrl: estimatedIntensityTile,
    intensity: intensity?.toEarthquakeIntensityPartial(parameter: parameter),
  );
}
