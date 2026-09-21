import 'package:eqmonitor/feature/seismicity/data/model/seismicity_color_mode.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

class SeismicityColorModeSelector extends StatelessWidget {
  const new({
    required this.value,
    required this.onChanged,
    super.key,
  });

  final SeismicityColorMode value;
  final ValueChanged<SeismicityColorMode> onChanged;

  @override
  Widget build(BuildContext context) {
    return M3EToggleButtonGroup(
      type: M3EButtonGroupType.connected,
      actions: const [
        M3EToggleButtonGroupAction(
          label: Text('経過時間'),
          icon: Icon(Icons.schedule),
        ),
        M3EToggleButtonGroupAction(
          label: Text('マグニチュード'),
          icon: Icon(Icons.bubble_chart),
        ),
      ],
      selectedIndex: (<SeismicityColorMode>[
        SeismicityColorMode.elapsedTime,
        SeismicityColorMode.magnitude,
      ]).indexOf(value),
      onSelectedIndexChanged: (index) {
        if (index == null) return;
        final selected = <SeismicityColorMode>[
          SeismicityColorMode.elapsedTime,
          SeismicityColorMode.magnitude,
        ][index];
        onChanged(selected);
      },
    );
  }
}
