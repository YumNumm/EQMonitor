import 'package:eqmonitor/core/component/chip/intensity_filter_chip.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'IntensityFilterChip',
  type: IntensityFilterChip,
)
Widget intensityFilterChip(BuildContext context) {
  return const IntensityFilterChip();
}
