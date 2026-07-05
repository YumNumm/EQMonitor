import 'package:eqmonitor/core/component/selector/city_selector.dart';
import 'package:eqmonitor/core/component/selector/prefecture_selector.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef RegionIntensityResult = ({
  RegionSearchType searchType,
  String code,
  String name,
  JmaIntensity? intensityGte,
  JmaIntensity? intensityLte,
});

class RegionIntensityFilterChip extends StatelessWidget {
  const RegionIntensityFilterChip({
    this.regionSearchType,
    this.regionCode,
    this.regionName,
    this.regionIntensityGte,
    this.regionIntensityLte,
    this.onChanged,
    super.key,
  });

  final RegionSearchType? regionSearchType;
  final String? regionCode;
  final String? regionName;
  final JmaIntensity? regionIntensityGte;
  final JmaIntensity? regionIntensityLte;
  final void Function(RegionIntensityResult?)? onChanged;

  bool get _isActive => regionCode != null;

  @override
  Widget build(BuildContext context) {
    return RawChip(
      onSelected: (_) async {
        final result = await Navigator.of(context).push<RegionIntensityResult?>(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => _RegionIntensityPickerPage(
              initialSearchType: regionSearchType,
              initialCode: regionCode,
              initialName: regionName,
              initialIntensityGte: regionIntensityGte,
              initialIntensityLte: regionIntensityLte,
            ),
          ),
        );
        if (result != null) {
          onChanged?.call(result);
        }
      },
      label: _isActive
          ? Text(
              _buildLabel(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          : const Text('地域'),
      onDeleted: _isActive ? () => onChanged?.call(null) : null,
      selected: _isActive,
      selectedColor: context.designSystem.colorTheme.secondaryContainer,
    );
  }

  String _buildLabel() {
    final name = regionName ?? '';
    final intensityRange = _intensityRangeLabel();
    if (intensityRange != null) {
      return '$name ($intensityRange)';
    }
    return name;
  }

  String? _intensityRangeLabel() {
    final gte = regionIntensityGte;
    final lte = regionIntensityLte;
    if (gte == null && lte == null) {
      return null;
    }
    if (gte != null && lte != null) {
      if (gte == lte) {
        return '震度${gte.label}';
      }
      return '震度${gte.label}~${lte.label}';
    }
    if (gte != null) {
      return '震度${gte.label}以上';
    }
    return '震度${lte!.label}以下';
  }
}

class _RegionIntensityPickerPage extends HookConsumerWidget {
  const _RegionIntensityPickerPage({
    this.initialSearchType,
    this.initialCode,
    this.initialName,
    this.initialIntensityGte,
    this.initialIntensityLte,
  });

  final RegionSearchType? initialSearchType;
  final String? initialCode;
  final String? initialName;
  final JmaIntensity? initialIntensityGte;
  final JmaIntensity? initialIntensityLte;

  static const List<JmaIntensity> _sliderValues = [
    JmaIntensity.one,
    JmaIntensity.two,
    JmaIntensity.three,
    JmaIntensity.four,
    JmaIntensity.fiveLower,
    JmaIntensity.fiveUpper,
    JmaIntensity.sixLower,
    JmaIntensity.sixUpper,
    JmaIntensity.seven,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final searchType = useState(initialSearchType ?? .prefecture);
    final selectedCode = useState<String?>(initialCode);
    final selectedName = useState<String?>(initialName);
    final intensityGte = useState<JmaIntensity?>(initialIntensityGte);
    final intensityLte = useState<JmaIntensity?>(initialIntensityLte);
    final useIntensityFilter = useState(
      initialIntensityGte != null || initialIntensityLte != null,
    );

    final canApply =
        selectedCode.value != null && selectedCode.value!.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('地域の震度で絞り込み'),
        actions: [
          TextButton(
            onPressed: canApply
                ? () => Navigator.of(context).pop((
                    searchType: searchType.value,
                    code: selectedCode.value!,
                    name: selectedName.value ?? '',
                    intensityGte: useIntensityFilter.value
                        ? intensityGte.value
                        : null,
                    intensityLte: useIntensityFilter.value
                        ? intensityLte.value
                        : null,
                  ))
                : null,
            child: const Text('決定'),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              '地域を選択して、その地域で観測された震度で絞り込みます。',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ChoiceChip(
                  label: const Text('都道府県'),
                  selected: searchType.value == RegionSearchType.prefecture,
                  onSelected: (s) {
                    if (s) {
                      searchType.value = RegionSearchType.prefecture;
                      selectedCode.value = null;
                      selectedName.value = null;
                    }
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('市区町村'),
                  selected: searchType.value == .city,
                  onSelected: (s) {
                    if (s) {
                      searchType.value = .city;
                      selectedCode.value = null;
                      selectedName.value = null;
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (searchType.value == RegionSearchType.prefecture)
              PrefectureSelector(
                selectedCode: selectedCode.value,
                onChanged: (selection) {
                  if (selection != null) {
                    selectedCode.value = selection.code;
                    selectedName.value = selection.name;
                  } else {
                    selectedCode.value = null;
                    selectedName.value = null;
                  }
                },
              )
            else
              CitySelector(
                selectedCode: selectedCode.value,
                selectedName: selectedName.value,
                onChanged: (selection) {
                  if (selection != null) {
                    selectedCode.value = selection.code;
                    selectedName.value = selection.name;
                  } else {
                    selectedCode.value = null;
                    selectedName.value = null;
                  }
                },
              ),
            if (selectedName.value != null &&
                selectedName.value!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.place_outlined),
                  title: Text(selectedName.value!),
                  subtitle: Text(
                    searchType.value == RegionSearchType.prefecture
                        ? '都道府県'
                        : '市区町村',
                  ),
                ),
              ),
            ],
            const SizedBox(height: 24),
            SwitchListTile(
              title: const Text('震度で絞り込む'),
              subtitle: const Text('選択した地域で観測された震度の範囲を指定'),
              value: useIntensityFilter.value,
              onChanged: (v) => useIntensityFilter.value = v,
            ),
            if (useIntensityFilter.value) ...[
              const SizedBox(height: 8),
              _IntensityRangeSelector(
                min: intensityGte.value ?? JmaIntensity.one,
                max: intensityLte.value ?? JmaIntensity.seven,
                sliderValues: _sliderValues,
                onChanged: (min, max) {
                  intensityGte.value = min == JmaIntensity.one ? null : min;
                  intensityLte.value = max == JmaIntensity.seven ? null : max;
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _IntensityRangeSelector extends HookWidget {
  const _IntensityRangeSelector({
    required this.min,
    required this.max,
    required this.sliderValues,
    required this.onChanged,
  });

  final JmaIntensity min;
  final JmaIntensity max;
  final List<JmaIntensity> sliderValues;
  final void Function(JmaIntensity min, JmaIntensity max) onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    int valueToIndex(JmaIntensity v) =>
        sliderValues.indexOf(v).clamp(0, sliderValues.length - 1);
    JmaIntensity indexToValue(int i) =>
        sliderValues[i.clamp(0, sliderValues.length - 1)];

    return Column(
      children: [
        RangeSlider(
          values: RangeValues(
            valueToIndex(min).toDouble(),
            valueToIndex(max).toDouble(),
          ),
          max: (sliderValues.length - 1).toDouble(),
          onChanged: (state) {
            onChanged(
              indexToValue(state.start.toInt()),
              indexToValue(state.end.toInt()),
            );
          },
          labels: RangeLabels('震度${min.label}', '震度${max.label}'),
          divisions: sliderValues.length - 1,
        ),
        Text(
          _rangeLabel(),
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  String _rangeLabel() {
    if (min == JmaIntensity.one && max == JmaIntensity.seven) {
      return '全て';
    }
    if (min == max) {
      return '震度${min.label}';
    }
    if (min == JmaIntensity.one) {
      return '震度${max.label} 以下';
    }
    if (max == JmaIntensity.seven) {
      return '震度${min.label} 以上';
    }
    return '震度${min.label} ~ 震度${max.label}';
  }
}
