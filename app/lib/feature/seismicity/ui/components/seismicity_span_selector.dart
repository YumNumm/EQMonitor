import 'package:eqmonitor/feature/seismicity/data/model/seismicity_span.dart';
import 'package:material_ui/material_ui.dart';

class SeismicitySpanSelector extends StatelessWidget {
  const SeismicitySpanSelector({
    required this.value,
    required this.onChanged,
    super.key,
  });

  final SeismicitySpan value;
  final ValueChanged<SeismicitySpan> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<SeismicitySpan>(
      segments: const [
        ButtonSegment(value: SeismicitySpan.p1m, label: Text('1ヶ月')),
        ButtonSegment(value: SeismicitySpan.p3m, label: Text('3ヶ月')),
        ButtonSegment(value: SeismicitySpan.p12m, label: Text('12ヶ月')),
      ],
      selected: {value},
      onSelectionChanged: (selected) => onChanged(selected.single),
    );
  }
}
