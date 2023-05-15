// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'world_map_property.freezed.dart';
part 'world_map_property.g.dart';

@freezed
class WorldMapProperty with _$WorldMapProperty {
  const factory WorldMapProperty({
    @JsonKey(name: 'NAME') required String name,
    @JsonKey(name: 'NAME_JA') required String nameJa,
  }) = _WorldMapProperty;

  factory WorldMapProperty.fromJson(Map<String, dynamic> json) =>
      _$WorldMapPropertyFromJson(json);
}
