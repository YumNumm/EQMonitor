import 'package:eqmonitor/core/component/slider/accessible_range_slider.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

class LpgmIntensityFilterChip extends StatelessWidget {
  const new({
    this.min,
    this.max,
    this.onChanged,
    super.key,
  });

  final JmaLpgmIntensity? min;
  final JmaLpgmIntensity? max;
  final void Function(JmaLpgmIntensity?, JmaLpgmIntensity?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final isDefault = min == null && max == null;

    return RawChip(
      onSelected: (_) async {
        final result =
            await showM3EModalBottomSheet<
              (JmaLpgmIntensity?, JmaLpgmIntensity?)?
            >(
              isScrollControlled: false,
              useSafeArea: false,
              style: const M3EBottomSheetStyle(padding: EdgeInsets.zero),
              clipBehavior: .antiAlias,
              context: context,
              builder: (context) =>
                  _LpgmIntensityFilterModal(currentMin: min, currentMax: max),
            );
        if (result != null) {
          onChanged?.call(result.$1, result.$2);
        }
      },
      label: isDefault
          ? const Text('長周期')
          : Text(
              _rangeString(min, max),
              style: const TextStyle(fontWeight: .bold),
            ),
      onDeleted: isDefault ? null : () => onChanged?.call(null, null),
      selected: !isDefault,
      selectedColor: context.designSystem.colorTheme.secondaryContainer,
    );
  }

  static String _rangeString(JmaLpgmIntensity? min, JmaLpgmIntensity? max) {
    if (min != null && max != null) {
      if (min == max) {
        return '階級${min.label}';
      }
      return '階級${min.label}〜${max.label}';
    }
    if (min != null) {
      return '階級${min.label}以上';
    }
    if (max != null) {
      return '階級${max.label}以下';
    }
    return '全て';
  }
}

class _LpgmIntensityFilterModal extends HookWidget {
  const new({this.currentMin, this.currentMax});

  final JmaLpgmIntensity? currentMin;
  final JmaLpgmIntensity? currentMax;

  static const List<JmaLpgmIntensity> _values = [
    JmaLpgmIntensity.zero,
    JmaLpgmIntensity.one,
    JmaLpgmIntensity.two,
    JmaLpgmIntensity.three,
    JmaLpgmIntensity.four,
  ];

  @override
  Widget build(BuildContext context) {
    final min = useState<JmaLpgmIntensity>(currentMin ?? _values.first);
    final max = useState<JmaLpgmIntensity>(currentMax ?? _values.last);

    final theme = Theme.of(context);
    final designSystem = context.designSystem;
    final sheetBar = Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: 36,
      height: 4,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: designSystem.colorTheme.onSurface,
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.black12, blurRadius: 12),
        ],
      ),
    );

    int valueToIndex(JmaLpgmIntensity v) =>
        _values.indexOf(v).clamp(0, _values.length - 1);
    JmaLpgmIntensity indexToValue(int i) =>
        _values[i.clamp(0, _values.length - 1)];

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            Center(child: sheetBar),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                '長周期地震動階級',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: .bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            AccessibleRangeSlider(
              semanticFormatterCallback: (value) =>
                  '階級${indexToValue(value.toInt()).label}',
              value: RangeValues(
                valueToIndex(min.value).toDouble(),
                valueToIndex(max.value).toDouble(),
              ),
              max: (_values.length - 1).toDouble(),
              onChanged: (state) {
                min.value = indexToValue(state.start.toInt());
                max.value = indexToValue(state.end.toInt());
              },
              label: '階級${min.value.label} ～ 階級${max.value.label}',
              divisions: _values.length - 1,
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                LpgmIntensityFilterChip._rangeString(min.value, max.value),
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: .bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: .end,
              children: [
                M3ETextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('キャンセル'),
                ),
                M3ETextButton(
                  onPressed: () {
                    final isDefault =
                        min.value == _values.first && max.value == _values.last;
                    Navigator.of(context)
                        .pop(isDefault ? (null, null) : (min.value, max.value));
                  },
                  child: const Text('完了'),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
