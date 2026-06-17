// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'latest_telegram.dart';
import 'merged_forecast_region.dart';
import 'merged_offshore_observation.dart';
import 'tsunami_state_earthquake.dart';

part 'tsunami_state.freezed.dart';
part 'tsunami_state.g.dart';

@Freezed()
abstract class TsunamiState with _$TsunamiState {
  const factory TsunamiState({
    required String id,
    @JsonKey(name: 'event_ids')
    required List<String> eventIds,
    @JsonKey(name: 'is_active')
    required bool isActive,
    @JsonKey(name: 'is_canceled')
    required bool isCanceled,
    @JsonKey(name: 'updated_at')
    required DateTime updatedAt,
    @JsonKey(includeIfNull: true)
    required TsunamiStateEarthquake? earthquake,
    @JsonKey(name: 'latest_telegrams')
    required List<LatestTelegram> latestTelegrams,
    @JsonKey(name: 'forecast_regions')
    required List<MergedForecastRegion> forecastRegions,
    @JsonKey(name: 'offshore_observations')
    required List<MergedOffshoreObservation> offshoreObservations,
  }) = _TsunamiState;
  
  factory TsunamiState.fromJson(Map<String, Object?> json) => _$TsunamiStateFromJson(json);
}
