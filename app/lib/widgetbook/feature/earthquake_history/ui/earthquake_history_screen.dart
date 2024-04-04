import 'package:eqmonitor/feature/earthquake_history/ui/earthquake_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'EarthquakeHistoryScreen',
  type: EarthquakeHistoryScreen,
)
Widget earthquakeHistoryScreen(BuildContext context) {
  return const EarthquakeHistoryScreen();
}
