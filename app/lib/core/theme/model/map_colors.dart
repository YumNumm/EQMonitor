import 'package:eqmonitor/core/util/converter/color_converter.dart';
import 'package:material_ui/material_ui.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_colors.freezed.dart';
part 'map_colors.g.dart';

@freezed
abstract class MapColors with _$MapColors {
  const factory({
    @ColorJsonConverter() required Color background,
    @ColorJsonConverter() required Color worldLand,
    @ColorJsonConverter() required Color worldLine,
    @ColorJsonConverter() required Color japanLand,
    @ColorJsonConverter() required Color japanLine,
  }) = _MapColors;

  factory fromJson(Map<String, dynamic> json) =>
      _$MapColorsFromJson(json);
}
