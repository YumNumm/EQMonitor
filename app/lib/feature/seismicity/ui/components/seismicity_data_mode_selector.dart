import 'package:eqmonitor/feature/seismicity/data/model/seismicity_data_mode.dart';
import 'package:flutter/material.dart';

class SeismicityDataModeSelector extends StatelessWidget {
  const SeismicityDataModeSelector({
    required this.value,
    required this.onChanged,
    super.key,
  });

  final SeismicityDataMode value;
  final ValueChanged<SeismicityDataMode> onChanged;

  @override
  Widget build(BuildContext context) => SegmentedButton<SeismicityDataMode>(
    segments: const [
      ButtonSegment(value: .allHypocenters, label: Text('全震源')),
      ButtonSegment(value: .feltEarthquakes, label: Text('有感地震')),
    ],
    selected: {value},
    onSelectionChanged: (values) => onChanged(values.single),
  );
}
