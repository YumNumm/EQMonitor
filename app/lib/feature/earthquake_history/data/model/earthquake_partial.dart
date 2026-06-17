import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_hypocenter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_partial.freezed.dart';
part 'earthquake_partial.g.dart';

@freezed
abstract class EarthquakePartial with _$EarthquakePartial {
  const factory EarthquakePartial({
    required String eventId,
    required TelegramStatus status,
    required DateTime? originTime,
    required OriginTimePrecision originTimePrecision,
    required DateTime? arrivalTime,
    required EarthquakeDataSource dataSource,
    required EarthquakeHypocenter? hypocenter,
    required EarthquakeIntensityPartial? intensity,
    required EarthquakeType earthquakeType,
    required List<EarthquakeTelegramType> telegramTypes,
    required String? estimatedIntensityTileUrl,
  }) = _EarthquakePartial;

  factory EarthquakePartial.fromJson(Map<String, dynamic> json) =>
      _$EarthquakePartialFromJson(json);
}

extension EarthquakePartialApiExtension on api.EarthquakePartial {
  EarthquakePartial toEarthquakePartial({
    required EarthquakeParameter parameter,
  }) => EarthquakePartial(
    eventId: eventId,
    status: status.toTelegramStatus,
    originTime: originTime,
    originTimePrecision: originTimePrecision.toOriginTimePrecision,
    arrivalTime: arrivalTime,
    dataSource: datasource.toEarthquakeDataSource,
    hypocenter: hypocenter?.toEarthquakeHypocenter,
    earthquakeType: earthquakeType.toEarthquakeType,
    telegramTypes: telegramTypes
        .map((e) => e.toEarthquakeTelegramType)
        .toList(),
    estimatedIntensityTileUrl: estimatedIntensityTile,
    intensity: intensity?.toEarthquakeIntensityPartial(
      parameter: parameter,
    ),
  );
}
