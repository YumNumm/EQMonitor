// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_hypocenter.freezed.dart';
part 'event_hypocenter.g.dart';

@Freezed()
abstract class EventHypocenter with _$EventHypocenter {
  const factory EventHypocenter({
    required num latitude,
    required num longitude,
    required num depth,
    @JsonKey(includeIfNull: false) String? name,
  }) = _EventHypocenter;

  factory EventHypocenter.fromJson(Map<String, Object?> json) =>
      _$EventHypocenterFromJson(json);
}
