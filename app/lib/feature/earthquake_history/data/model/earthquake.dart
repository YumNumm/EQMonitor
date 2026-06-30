import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_hypocenter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake.freezed.dart';
part 'earthquake.g.dart';

@freezed
abstract class Earthquake with _$Earthquake {
  const factory Earthquake({
    required String eventId,
    required TelegramStatus status,
    required DateTime? originTime,
    required OriginTimePrecision originTimePrecision,
    required DateTime? arrivalTime,
    required EarthquakeDataSource dataSource,
    required List<EarthquakeTelegramType> telegramTypes,
    required EarthquakeHypocenter? hypocenter,
    required EarthquakeIntensity? intensity,

    /// 推計震度PMTilesのフルURL
    required String? estimatedIntensityTileUrl,
  }) = _Earthquake;

  factory Earthquake.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeFromJson(json);
}

extension EarthquakeApiExtension on api.Earthquake {
  Earthquake toEarthquake({
    required EarthquakeParameter parameter,
    ShindoDbStationsParameter? shindoDbStations,
  }) => Earthquake(
    eventId: eventId,
    status: status.toTelegramStatus,
    originTime: originTime,
    originTimePrecision: originTimePrecision.toOriginTimePrecision,
    arrivalTime: arrivalTime,
    dataSource: datasource.toEarthquakeDataSource,
    telegramTypes: telegrams
        .map((e) => e.telegram.type.toEarthquakeTelegramTypeOrNull)
        .whereType<EarthquakeTelegramType>()
        .toList(),
    hypocenter: hypocenter?.toEarthquakeHypocenter,
    estimatedIntensityTileUrl: estimatedIntensityTile,
    intensity: intensity?.toEarthquakeIntensity(
      parameter: parameter,
      shindoDbStations: shindoDbStations,
    ),
  );
}
