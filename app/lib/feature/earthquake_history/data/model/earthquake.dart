import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_catalog.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_hypocenter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_comment.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
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
    required List<EarthquakeDataSource> dataSources,
    required List<EarthquakeTelegramType> telegramTypes,

    /// 電文コメント（固定付加文・自由付加文）
    @Default([]) List<EarthquakeTelegramComment> telegramComments,
    required EarthquakeHypocenter? hypocenter,
    required EarthquakeIntensity? intensity,
    EarthquakeType? earthquakeType,

    /// 推計震度PMTilesのフルURL
    required String? estimatedIntensityTileUrl,
    @JsonKey(includeFromJson: false, includeToJson: false)
    EarthquakeCatalog? catalog,
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
    dataSources: datasources.map((e) => e.toEarthquakeDataSource).toList(),
    telegramTypes: telegrams
        .map((e) => e.telegram.type.toEarthquakeTelegramTypeOrNull)
        .whereType<EarthquakeTelegramType>()
        .toList(),
    telegramComments: extractTelegramComments(telegrams),
    hypocenter: hypocenter?.toEarthquakeHypocenter,
    estimatedIntensityTileUrl: estimatedIntensityTile,
    catalog: catalog?.toEarthquakeCatalog,
    intensity: intensity?.toEarthquakeIntensity(
      parameter: parameter,
      shindoDbStations: shindoDbStations,
    ),
    earthquakeType: null,
  );
}
