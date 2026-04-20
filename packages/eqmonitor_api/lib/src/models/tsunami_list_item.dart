// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'status.dart';
import 'telegram_types.dart';
import 'tsunami_warning_kind.dart';

part 'tsunami_list_item.freezed.dart';
part 'tsunami_list_item.g.dart';

@Freezed()
abstract class TsunamiListItem with _$TsunamiListItem {
  const factory TsunamiListItem({
    required String id,
    @JsonKey(name: 'event_ids') required List<String> eventIds,
    @JsonKey(name: 'is_canceled') required bool isCanceled,
    @JsonKey(name: 'forecast_region_count') required num forecastRegionCount,
    @JsonKey(name: 'telegram_count') required num telegramCount,
    @JsonKey(name: 'telegram_types') required List<TelegramTypes> telegramTypes,
    @JsonKey(includeIfNull: false) String? headline,
    @JsonKey(includeIfNull: false, name: 'latest_created_at')
    String? latestCreatedAt,
    @JsonKey(includeIfNull: false, name: 'latest_press_at')
    String? latestPressAt,
    @JsonKey(includeIfNull: false) Status? status,
    @JsonKey(includeIfNull: false, name: 'max_forecast_grade')
    TsunamiWarningKind? maxForecastGrade,
    @JsonKey(includeIfNull: false, name: 'earthquake_hypocenter_name')
    String? earthquakeHypocenterName,
    @JsonKey(includeIfNull: false, name: 'earthquake_origin_time')
    String? earthquakeOriginTime,
    @JsonKey(includeIfNull: false, name: 'earthquake_magnitude')
    num? earthquakeMagnitude,
  }) = _TsunamiListItem;

  factory TsunamiListItem.fromJson(Map<String, Object?> json) =>
      _$TsunamiListItemFromJson(json);
}
