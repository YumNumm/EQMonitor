import 'package:eqmonitor/core/component/chip/depth_filter_chip.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'DepthFilterChip',
  type: DepthFilterChip,
)
Widget depthFilterChip(BuildContext context) {
  return DepthFilterChip(
    min: context.knobs.int.slider(label: 'Min', max: 700),
    max: context.knobs.int.slider(label: 'Max', max: 700, initialValue: 700),
  );
}
