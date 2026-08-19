import 'package:eqmonitor/feature/seismicity/data/model/seismicity_color_mode.dart';
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
    return SegmentedButton<SeismicityColorMode>(
      segments: const [
        ButtonSegment(
          value: SeismicityColorMode.elapsedTime,
          label: Text('経過時間'),
          icon: Icon(Icons.schedule),
        ),
        ButtonSegment(
          value: SeismicityColorMode.magnitude,
          label: Text('マグニチュード'),
          icon: Icon(Icons.bubble_chart),
        ),
      ],
      selected: {value},
      onSelectionChanged: (selected) => onChanged(selected.single),
    );
  }
}
