// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'type.dart';
import 'regions.dart';
import 'hypocenter.dart';
import 'prefectures.dart';

part 'eews.freezed.dart';
part 'eews.g.dart';

@Freezed()
abstract class Eews with _$Eews {
  const factory Eews({
    required String eventId,
    required Type type,
    required num serialNo,
    required List<Regions> regions,
    required String reportTime,
    @JsonKey(includeIfNull: false)
    String? maxIntensity,
    @JsonKey(includeIfNull: false)
    String? headline,
    @JsonKey(includeIfNull: false)
    String? originTime,
    @JsonKey(includeIfNull: false)
    String? arrivalTime,
    @JsonKey(includeIfNull: false)
    Hypocenter? hypocenter,
    @JsonKey(includeIfNull: false)
    num? magnitude,
    @JsonKey(includeIfNull: false)
    bool? isWarning,
    @JsonKey(includeIfNull: false)
    bool? isLastInfo,
    @JsonKey(includeIfNull: false)
    bool? isCancel,
    @JsonKey(includeIfNull: false)
    String? hypocenterReduceName,
    @JsonKey(includeIfNull: false)
    bool? hasWarningZones,
    @JsonKey(includeIfNull: false)
    bool? isPlum,
    @JsonKey(includeIfNull: false)
    bool? isLevel,
    @JsonKey(includeIfNull: false)
    bool? isOnePoint,
    @JsonKey(includeIfNull: false)
    String? comment,
    @JsonKey(includeIfNull: false)
    List<Prefectures>? prefectures,
  }) = _Eews;
  
  factory Eews.fromJson(Map<String, Object?> json) => _$EewsFromJson(json);
}
