import 'package:eqapi_schema/model/components/comments.dart';
import 'package:eqapi_schema/model/components/earthquake.dart';
import 'package:eqapi_schema/model/components/intensity.dart';
import 'package:eqapi_schema/model/components/tsunami-information/comments.dart';
import 'package:eqapi_schema/model/components/tsunami-information/tsunami_estimation.dart';
import 'package:eqapi_schema/model/components/tsunami-information/tsunami_forecast.dart';
import 'package:eqapi_schema/model/components/tsunami-information/tsunami_observations.dart';
import 'package:eqapi_schema/model/telegram_v3.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_history_item.freezed.dart';
part 'earthquake_history_item.g.dart';

@freezed
class EarthquakeHistoryItem with _$EarthquakeHistoryItem {
  const factory EarthquakeHistoryItem({
    required EarthquakeData earthquake,
    required TsunamiData tsunami,
    required List<TelegramV3> telegrams,
    required int eventId,
    required Vxse45? latestEew,
    required TelegramV3? latestEewTelegram,
  }) = _EarthquakeHistoryItem;

  factory EarthquakeHistoryItem.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeHistoryItemFromJson(json);
}

extension EarthquakeHistoryItemExtension on EarthquakeHistoryItem {
  List<TelegramV3> get eewList => telegrams
      .where((element) => element.type == TelegramType.vxse45)
      .toList(growable: false);
}

@freezed
class EarthquakeData with _$EarthquakeData {
  const factory EarthquakeData({
    required Earthquake? earthquake,
    required Intensity? intensity,
    required Intensity? lgIntensity,
    required CommentsOmitVar? comment,
    required bool isVolcano,
  }) = _EarthquakeData;

  factory EarthquakeData.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeDataFromJson(json);
}

@freezed
class TsunamiData with _$TsunamiData {
  const factory TsunamiData({
    required List<TsunamiForecast>? forecasts,
    required List<TsunamiEstimation>? estimations,
    required List<TsunamiObservation>? observations,
    required TsunamiComments? comments,
  }) = _TsunamiData;

  factory TsunamiData.fromJson(Map<String, dynamic> json) =>
      _$TsunamiDataFromJson(json);
}
