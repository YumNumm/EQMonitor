import 'package:eqapi_types/src/model/v2/earthquake/hypocenter.dart';
import 'package:eqapi_types/src/model/v2/earthquake/intensity.dart';
import 'package:eqapi_types/src/model/v2/earthquake/telegram_ref.dart';
import 'package:eqapi_types/src/model/v2/enum/telegram_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake.freezed.dart';
part 'earthquake.g.dart';

/// 地震情報（詳細）
@freezed
abstract class Earthquake with _$Earthquake {
  const factory Earthquake({
    /// yyyyMMddHHmmss形式のイベントID
    required String eventId,
    required TelegramStatus status,
    DateTime? originTime,
    DateTime? arrivalTime,
    Hypocenter? hypocenter,
    Intensity? intensity,
    required List<EarthquakeTelegramRef> telegrams,
  }) = _Earthquake;

  factory Earthquake.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeFromJson(json);
}

/// 地震情報（一覧用、部分的）
@freezed
abstract class EarthquakePartial with _$EarthquakePartial {
  const factory EarthquakePartial({
    /// yyyyMMddHHmmss形式のイベントID
    required String eventId,
    required TelegramStatus status,
    DateTime? originTime,
    DateTime? arrivalTime,
    Hypocenter? hypocenter,
    IntensityPartial? intensity,
  }) = _EarthquakePartial;

  factory EarthquakePartial.fromJson(Map<String, dynamic> json) =>
      _$EarthquakePartialFromJson(json);
}
