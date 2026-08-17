import 'package:eqmonitor/core/theme/model/intensity_text_color.dart';
import 'package:eqmonitor/core/util/converter/color_converter.dart';
import 'package:material_ui/material_ui.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'intensity_color_entry.freezed.dart';
part 'intensity_color_entry.g.dart';

@freezed
abstract class IntensityColorEntry with _$IntensityColorEntry {
  const factory IntensityColorEntry({
    @ColorJsonConverter() required Color background,
    required IntensityTextColor foreground,
  }) = _IntensityColorEntry;

  factory IntensityColorEntry.fromJson(Map<String, dynamic> json) =>
      _$IntensityColorEntryFromJson(json);

  const IntensityColorEntry._();

  Color get resolvedForeground => switch (foreground) {
    IntensityTextColorAuto() =>
      background.computeLuminance() > 0.5 ? Colors.black : Colors.white,
    IntensityTextColorManual(:final color) => color,
  };
}
