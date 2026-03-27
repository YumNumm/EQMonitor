// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'tsunami_comments.dart';
import 'tsunami_earthquake.dart';
import 'tsunami_estimation.dart';
import 'tsunami_forecast.dart';
import 'tsunami_observation.dart';

part 'tsunami_telegram_body.freezed.dart';
part 'tsunami_telegram_body.g.dart';

@Freezed()
abstract class TsunamiTelegramBody with _$TsunamiTelegramBody {
  const factory TsunamiTelegramBody({
    @JsonKey(includeIfNull: false)
    List<TsunamiForecast>? forecasts,
    @JsonKey(includeIfNull: false)
    List<TsunamiObservation>? observations,
    @JsonKey(includeIfNull: false)
    List<TsunamiEstimation>? estimations,
    @JsonKey(includeIfNull: false)
    List<TsunamiEarthquake>? earthquakes,
    @JsonKey(includeIfNull: false)
    String? text,
    @JsonKey(includeIfNull: false)
    TsunamiComments? comments,
  }) = _TsunamiTelegramBody;
  
  factory TsunamiTelegramBody.fromJson(Map<String, Object?> json) => _$TsunamiTelegramBodyFromJson(json);
}
