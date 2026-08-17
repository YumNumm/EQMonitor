import 'package:eqmonitor/core/util/converter/color_converter.dart';
import 'package:material_ui/material_ui.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'status_colors.freezed.dart';
part 'status_colors.g.dart';

@freezed
abstract class StatusColors with _$StatusColors {
  const factory StatusColors({
    @ColorJsonConverter() required Color success,
    @ColorJsonConverter() required Color warning,
  }) = _StatusColors;

  factory StatusColors.fromJson(Map<String, dynamic> json) =>
      _$StatusColorsFromJson(json);
}
