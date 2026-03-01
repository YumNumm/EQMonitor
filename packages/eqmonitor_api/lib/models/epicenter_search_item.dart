// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'earthquake_partial.dart';
import 'epicenter_info.dart';

part 'epicenter_search_item.freezed.dart';
part 'epicenter_search_item.g.dart';

@Freezed()
abstract class EpicenterSearchItem with _$EpicenterSearchItem {
  const factory EpicenterSearchItem({
    @JsonKey(name: 'event_id') required String eventId,
    required EpicenterInfo epicenter,
    required EarthquakePartial earthquake,
  }) = _EpicenterSearchItem;

  factory EpicenterSearchItem.fromJson(Map<String, Object?> json) =>
      _$EpicenterSearchItemFromJson(json);
}
