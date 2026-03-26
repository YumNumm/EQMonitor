// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsunami_list_item.freezed.dart';
part 'tsunami_list_item.g.dart';

@Freezed()
abstract class TsunamiListItem with _$TsunamiListItem {
  const factory TsunamiListItem({
    required String id,
    @JsonKey(name: 'event_ids') required List<String> eventIds,
  }) = _TsunamiListItem;

  factory TsunamiListItem.fromJson(Map<String, Object?> json) =>
      _$TsunamiListItemFromJson(json);
}
