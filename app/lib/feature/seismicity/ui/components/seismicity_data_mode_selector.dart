import 'package:eqmonitor/feature/seismicity/data/model/seismicity_data_mode.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

class const SeismicityDataModeSelector({
  required final SeismicityDataMode value,
  required final ValueChanged<SeismicityDataMode> onChanged,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => M3EToggleButtonGroup(
    type: M3EButtonGroupType.connected,
    haptic: .light,
    actions: const [
      M3EToggleButtonGroupAction(label: Text('全震源')),
      M3EToggleButtonGroupAction(label: Text('有感地震')),
    ],
    selectedIndex: (<SeismicityDataMode>[
      .allHypocenters,
      .feltEarthquakes,
    ]).indexOf(value),
    onSelectedIndexChanged: (index) {
      if (index == null) return;
      final values = <SeismicityDataMode>[
        .allHypocenters,
        .feltEarthquakes,
      ][index];
      onChanged(values);
    },
  );
}
