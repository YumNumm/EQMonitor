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
    required List<TsunamiForecast> forecasts,
    required List<TsunamiObservation> observations,
    required List<TsunamiEstimation> estimations,
    required List<TsunamiEarthquake> earthquakes,
    required TsunamiComments comments,
    @JsonKey(includeIfNull: false)
    String? text,
  }) = _TsunamiTelegramBody;
  
  factory TsunamiTelegramBody.fromJson(Map<String, Object?> json) => _$TsunamiTelegramBodyFromJson(json);
}
