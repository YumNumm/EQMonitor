import 'package:eqmonitor/core/component/chip/magnitude_filter_chip.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'MagnitudeFilterChip',
  type: MagnitudeFilterChip,
)
Widget intensityFilterChip(BuildContext context) {
  return const MagnitudeFilterChip();
}
