import 'package:eqmonitor/feature/seismicity/data/model/seismicity_span.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

class SeismicitySpanSelector extends StatelessWidget {
  const new({
    required this.value,
    required this.onChanged,
    super.key,
  });

  final SeismicitySpan value;
  final ValueChanged<SeismicitySpan> onChanged;

  @override
  Widget build(BuildContext context) {
    return M3EToggleButtonGroup(
      type: M3EButtonGroupType.connected,
      actions: const [
        M3EToggleButtonGroupAction(label: Text('1ヶ月')),
        M3EToggleButtonGroupAction(label: Text('3ヶ月')),
        M3EToggleButtonGroupAction(label: Text('12ヶ月')),
      ],
      selectedIndex: (<SeismicitySpan>[
        SeismicitySpan.p1m,
        SeismicitySpan.p3m,
        SeismicitySpan.p12m,
      ]).indexOf(value),
      onSelectedIndexChanged: (index) {
        if (index == null) return;
        final selected = <SeismicitySpan>[
          SeismicitySpan.p1m,
          SeismicitySpan.p3m,
          SeismicitySpan.p12m,
        ][index];
        onChanged(selected);
      },
    );
  }
}
