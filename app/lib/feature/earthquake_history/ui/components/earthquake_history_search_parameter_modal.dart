import 'dart:async';
import 'dart:ui';

import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:collection/collection.dart';
import 'package:eqmonitor/core/component/selector/city_selector.dart';
import 'package:eqmonitor/core/component/selector/prefecture_selector.dart';
import 'package:eqmonitor/core/component/sheet/app_sheet_route.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/jma_code_table_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/region_picker_map_page.dart';
import 'package:eqmonitor/feature/location/data/location.dart';
import 'package:eqmonitor/feature/location/data/nearest_jma_feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lat_lng/lat_lng.dart' as lat_lng;

class EarthquakeHistorySearchParameterModal extends HookConsumerWidget {
  const EarthquakeHistorySearchParameterModal({
    required this.initialParameter,
    super.key,
  });

  final EarthquakeHistoryParameter initialParameter;

  static Future<EarthquakeHistoryParameter?> show(
    BuildContext context, {
    EarthquakeHistoryParameter initialParameter =
        const EarthquakeHistoryParameter(),
  }) => Navigator.of(context).push<EarthquakeHistoryParameter>(
    AppSheetRoute(
      builder: (context) => ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        child: EarthquakeHistorySearchParameterModal(
          initialParameter: initialParameter,
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final backgroundColor = colorScheme.surfaceContainerLow;

    // 各フィルターの有効/無効状態（初期値から判定）
    final isDateRangeEnabled = useState<bool>(false);
    final isEpicenterEnabled = useState<bool>(
      initialParameter.epicenterCode != null,
    );
    final isIntensityEnabled = useState<bool>(
      initialParameter.intensityGte != null ||
          initialParameter.intensityLte != null,
    );
    final isRegionIntensityEnabled = useState<bool>(
      initialParameter.regionCode != null,
    );
    final isDepthEnabled = useState<bool>(
      initialParameter.depthGte != null || initialParameter.depthLte != null,
    );
    final isMagnitudeEnabled = useState<bool>(
      initialParameter.magnitudeGte != null ||
          initialParameter.magnitudeLte != null,
    );

    // 日付範囲
    final dateRange = useState<DateTimeRange>(
      DateTimeRange(
        start: DateTime(1919),
        end: DateTime.now(),
      ),
    );

    // 震央地名（初期値から設定）
    final selectedEpicenterCode = useState<String?>(
      initialParameter.epicenterCode?.toString(),
    );
    final selectedEpicenterName = useState<String?>(
      initialParameter.epicenterName,
    );

    // 最大震度（初期値から設定）
    final intensityMin = useState<JmaIntensity>(
      initialParameter.intensityGte ?? _IntensityRangeSelector.initialMin,
    );
    final intensityMax = useState<JmaIntensity>(
      initialParameter.intensityLte ?? _IntensityRangeSelector.initialMax,
    );

    // 地域の震度 - 都道府県/市区町村（初期値から設定）
    final selectedRegionCode = useState<String?>(
      initialParameter.regionCode,
    );
    final selectedRegionName = useState<String?>(
      initialParameter.regionName,
    );
    final selectedRegionType = useState<String>(
      initialParameter.regionSearchType?.name ?? 'prefecture',
    );
    final regionIntensityMin = useState<JmaIntensity>(
      initialParameter.regionIntensityGte ?? _IntensityRangeSelector.initialMin,
    );
    final regionIntensityMax = useState<JmaIntensity>(
      initialParameter.regionIntensityLte ?? _IntensityRangeSelector.initialMax,
    );

    // 震源の深さ（初期値から設定）
    final depthMin = useState<int>(
      initialParameter.depthGte ?? _DepthRangeSelector.initialMin,
    );
    final depthMax = useState<int>(
      initialParameter.depthLte ?? _DepthRangeSelector.initialMax,
    );

    // マグニチュード（初期値から設定）
    final magnitudeMin = useState<double>(
      initialParameter.magnitudeGte ?? _MagnitudeRangeSelector.initialMin,
    );
    final magnitudeMax = useState<double>(
      initialParameter.magnitudeLte ?? _MagnitudeRangeSelector.initialMax,
    );

    // 現在地から選択中フラグ
    final isResolvingLocation = useState(false);

    // 現在地から地域コードを解決する
    Future<void> resolveCurrentLocation() async {
      isResolvingLocation.value = true;
      try {
        var permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
        }
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          if (context.mounted) {
            AdaptiveSnackBar.show(context, message: '位置情報の権限がありません');
          }
          return;
        }

        final position =
            ref.read(locationStreamProvider).value ??
            await Geolocator.getCurrentPosition(
              locationSettings: const LocationSettings(
                accuracy: LocationAccuracy.low,
              ),
            );
        final latLng = lat_lng.LatLng(position.latitude, position.longitude);

        if (selectedRegionType.value == 'city') {
          final city = await ref.read(
            jmaMapAreaInformationCityInsideProvider(latLng).future,
          );
          if (city?.property != null) {
            selectedRegionCode.value = city!.property!.code;
            selectedRegionName.value = city.property!.name;
          }
        } else {
          final city = await ref.read(
            jmaMapAreaInformationCityInsideProvider(latLng).future,
          );
          if (city?.property != null) {
            final cityCode = city!.property!.code;
            final prefix = cityCode.length >= 2
                ? cityCode.substring(0, 2)
                : cityCode;
            final jmaCodeTable = ref.read(jmaCodeTableProvider).value;
            final prefecture = jmaCodeTable
                ?.codeTables
                .areaInformationPrefectureEarthquake
                .firstWhereOrNull(
                  (p) => p.code.startsWith(prefix),
                );
            if (prefecture != null) {
              selectedRegionCode.value = prefecture.code;
              selectedRegionName.value = prefecture.name.ja;
            }
          }
        }
      } on Exception catch (_) {
        if (context.mounted) {
          AdaptiveSnackBar.show(context, message: '現在地の取得に失敗しました');
        }
      } finally {
        isResolvingLocation.value = false;
      }
    }

    // 地図から選択
    Future<void> selectFromMap() async {
      final result = await RegionPickerMapPage.show(
        context,
        selectedType: selectedRegionType.value,
      );
      if (result != null) {
        selectedRegionCode.value = result.code;
        selectedRegionName.value = result.name;
      }
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        primary: true,
        slivers: [
          SliverAppBar(
            pinned: true,
            title: BackdropFilter(
              filter: ImageFilter.compose(
                outer: ImageFilter.blur(
                  sigmaX: 8,
                  sigmaY: 8,
                  tileMode: TileMode.mirror,
                ),
                inner: ColorFilter.mode(
                  colorScheme.surfaceContainerLow.withValues(alpha: 0.7),
                  BlendMode.srcATop,
                ),
              ),
              child: const Text(
                '検索条件',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            automaticallyImplyLeading: false,
            centerTitle: false,
            scrolledUnderElevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              IconButton.filledTonal(
                onPressed: () {
                  unawaited(HapticFeedback.lightImpact());
                  final parameter = EarthquakeHistoryParameter(
                    intensityGte:
                        isIntensityEnabled.value &&
                            intensityMin.value !=
                                _IntensityRangeSelector.initialMin
                        ? intensityMin.value
                        : null,
                    intensityLte:
                        isIntensityEnabled.value &&
                            intensityMax.value !=
                                _IntensityRangeSelector.initialMax
                        ? intensityMax.value
                        : null,
                    depthGte:
                        isDepthEnabled.value &&
                            depthMin.value != _DepthRangeSelector.initialMin
                        ? depthMin.value
                        : null,
                    depthLte:
                        isDepthEnabled.value &&
                            depthMax.value != _DepthRangeSelector.initialMax
                        ? depthMax.value
                        : null,
                    magnitudeGte:
                        isMagnitudeEnabled.value &&
                            magnitudeMin.value !=
                                _MagnitudeRangeSelector.initialMin
                        ? magnitudeMin.value
                        : null,
                    magnitudeLte:
                        isMagnitudeEnabled.value &&
                            magnitudeMax.value !=
                                _MagnitudeRangeSelector.initialMax
                        ? magnitudeMax.value
                        : null,
                    epicenterCode:
                        isEpicenterEnabled.value &&
                            selectedEpicenterCode.value != null
                        ? int.tryParse(selectedEpicenterCode.value!)
                        : null,
                    epicenterName:
                        isEpicenterEnabled.value &&
                            selectedEpicenterCode.value != null
                        ? selectedEpicenterName.value
                        : null,
                    regionSearchType:
                        isRegionIntensityEnabled.value &&
                            selectedRegionCode.value != null
                        ? (selectedRegionType.value == 'prefecture'
                              ? RegionSearchType.prefecture
                              : RegionSearchType.city)
                        : null,
                    regionCode: isRegionIntensityEnabled.value
                        ? selectedRegionCode.value
                        : null,
                    regionName: isRegionIntensityEnabled.value
                        ? selectedRegionName.value
                        : null,
                    regionIntensityGte:
                        isRegionIntensityEnabled.value &&
                            selectedRegionCode.value != null &&
                            regionIntensityMin.value !=
                                _IntensityRangeSelector.initialMin
                        ? regionIntensityMin.value
                        : null,
                    regionIntensityLte:
                        isRegionIntensityEnabled.value &&
                            selectedRegionCode.value != null &&
                            regionIntensityMax.value !=
                                _IntensityRangeSelector.initialMax
                        ? regionIntensityMax.value
                        : null,
                  );
                  Navigator.of(context).pop(parameter);
                },
                icon: const Icon(Icons.check),
              ),
            ],
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _SettingSection(
                  title: '期間',
                  description: '検索対象とする地震の発生期間を指定します',
                  isEnabled: isDateRangeEnabled.value,
                  onEnabledChanged: (value) => isDateRangeEnabled.value = value,
                  child: _DateRangeSelector(
                    dateRange: dateRange.value,
                    onChanged: (value) => dateRange.value = value,
                  ),
                ),
                _SettingSection(
                  title: '震央地名',
                  description: '震源地の地名で絞り込みます',
                  isEnabled: isEpicenterEnabled.value,
                  onEnabledChanged: (value) => isEpicenterEnabled.value = value,
                  child: _EpicenterSelector(
                    selectedCode: selectedEpicenterCode.value,
                    onChanged: (code, name) {
                      selectedEpicenterCode.value = code;
                      selectedEpicenterName.value = name;
                    },
                  ),
                ),
                _SettingSection(
                  title: '最大震度',
                  description: '地震の最大観測震度で絞り込みます',
                  isEnabled: isIntensityEnabled.value,
                  onEnabledChanged: (value) => isIntensityEnabled.value = value,
                  child: _IntensityRangeSelector(
                    min: intensityMin.value,
                    max: intensityMax.value,
                    onChanged: (min, max) {
                      intensityMin.value = min;
                      intensityMax.value = max;
                    },
                  ),
                ),
                _SettingSection(
                  title: '地域の震度',
                  description: '特定の都道府県・市区町村での観測震度で絞り込みます',
                  isEnabled: isRegionIntensityEnabled.value,
                  onEnabledChanged: (value) =>
                      isRegionIntensityEnabled.value = value,
                  child: _RegionIntensitySelector(
                    selectedCode: selectedRegionCode.value,
                    selectedName: selectedRegionName.value,
                    selectedType: selectedRegionType.value,
                    intensityMin: regionIntensityMin.value,
                    intensityMax: regionIntensityMax.value,
                    onRegionChanged: (code, name, type) {
                      selectedRegionCode.value = code;
                      selectedRegionName.value = name;
                      selectedRegionType.value = type;
                    },
                    onIntensityChanged: (min, max) {
                      regionIntensityMin.value = min;
                      regionIntensityMax.value = max;
                    },
                    onCurrentLocationPressed: isResolvingLocation.value
                        ? null
                        : () => unawaited(resolveCurrentLocation()),
                    onSelectFromMapPressed: isResolvingLocation.value
                        ? null
                        : () => unawaited(selectFromMap()),
                  ),
                ),
                _SettingSection(
                  title: '震源の深さ',
                  description: '震源の深さ（km）で絞り込みます',
                  isEnabled: isDepthEnabled.value,
                  onEnabledChanged: (value) => isDepthEnabled.value = value,
                  child: _DepthRangeSelector(
                    min: depthMin.value,
                    max: depthMax.value,
                    onChanged: (min, max) {
                      depthMin.value = min;
                      depthMax.value = max;
                    },
                  ),
                ),
                _SettingSection(
                  title: 'マグニチュード',
                  description: '地震の規模（マグニチュード）で絞り込みます',
                  isEnabled: isMagnitudeEnabled.value,
                  onEnabledChanged: (value) => isMagnitudeEnabled.value = value,
                  child: _MagnitudeRangeSelector(
                    min: magnitudeMin.value,
                    max: magnitudeMax.value,
                    onChanged: (min, max) {
                      magnitudeMin.value = min;
                      magnitudeMax.value = max;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('キャンセル'),
                      ),
                      const SizedBox(width: 8),
                      FilledButton(
                        onPressed: () {
                          // パラメータを構築
                          final parameter = EarthquakeHistoryParameter(
                            // 最大震度
                            intensityGte:
                                isIntensityEnabled.value &&
                                    intensityMin.value !=
                                        _IntensityRangeSelector.initialMin
                                ? intensityMin.value
                                : null,
                            intensityLte:
                                isIntensityEnabled.value &&
                                    intensityMax.value !=
                                        _IntensityRangeSelector.initialMax
                                ? intensityMax.value
                                : null,
                            // 震源の深さ
                            depthGte:
                                isDepthEnabled.value &&
                                    depthMin.value !=
                                        _DepthRangeSelector.initialMin
                                ? depthMin.value
                                : null,
                            depthLte:
                                isDepthEnabled.value &&
                                    depthMax.value !=
                                        _DepthRangeSelector.initialMax
                                ? depthMax.value
                                : null,
                            // マグニチュード
                            magnitudeGte:
                                isMagnitudeEnabled.value &&
                                    magnitudeMin.value !=
                                        _MagnitudeRangeSelector.initialMin
                                ? magnitudeMin.value
                                : null,
                            magnitudeLte:
                                isMagnitudeEnabled.value &&
                                    magnitudeMax.value !=
                                        _MagnitudeRangeSelector.initialMax
                                ? magnitudeMax.value
                                : null,
                            // 震央地名
                            epicenterCode:
                                isEpicenterEnabled.value &&
                                    selectedEpicenterCode.value != null
                                ? int.tryParse(selectedEpicenterCode.value!)
                                : null,
                            epicenterName:
                                isEpicenterEnabled.value &&
                                    selectedEpicenterCode.value != null
                                ? selectedEpicenterName.value
                                : null,
                            // 地域の震度
                            regionSearchType:
                                isRegionIntensityEnabled.value &&
                                    selectedRegionCode.value != null
                                ? (selectedRegionType.value == 'prefecture'
                                      ? RegionSearchType.prefecture
                                      : RegionSearchType.city)
                                : null,
                            regionCode: isRegionIntensityEnabled.value
                                ? selectedRegionCode.value
                                : null,
                            regionName: isRegionIntensityEnabled.value
                                ? selectedRegionName.value
                                : null,
                            regionIntensityGte:
                                isRegionIntensityEnabled.value &&
                                    selectedRegionCode.value != null &&
                                    regionIntensityMin.value !=
                                        _IntensityRangeSelector.initialMin
                                ? regionIntensityMin.value
                                : null,
                            regionIntensityLte:
                                isRegionIntensityEnabled.value &&
                                    selectedRegionCode.value != null &&
                                    regionIntensityMax.value !=
                                        _IntensityRangeSelector.initialMax
                                ? regionIntensityMax.value
                                : null,
                          );
                          Navigator.of(context).pop(parameter);
                        },
                        child: const Text('適用'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingSection extends StatelessWidget {
  const _SettingSection({
    required this.title,
    required this.child,
    required this.isEnabled,
    required this.onEnabledChanged,
    this.description,
  });

  final String title;
  final Widget child;
  final String? description;
  final bool isEnabled;
  final ValueChanged<bool> onEnabledChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => onEnabledChanged(!isEnabled),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Checkbox(
                    value: isEnabled,
                    onChanged: (value) => onEnabledChanged(value ?? false),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isEnabled
                                ? null
                                : colorScheme.onSurface.withValues(alpha: 0.5),
                          ),
                        ),
                        if (description != null)
                          Text(
                            description!,
                            style: textTheme.bodyMedium!.copyWith(
                              color: isEnabled
                                  ? colorScheme.onSurfaceVariant.withValues(
                                      alpha: 0.8,
                                    )
                                  : colorScheme.onSurfaceVariant.withValues(
                                      alpha: 0.4,
                                    ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isEnabled) ...[
            const SizedBox(height: 8),
            child,
          ],
        ],
      ),
    );
  }
}

class _DateRangeSelector extends StatelessWidget {
  const _DateRangeSelector({
    required this.dateRange,
    required this.onChanged,
  });

  final DateTimeRange dateRange;
  final ValueChanged<DateTimeRange> onChanged;

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('yyyy/MM/dd');
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        '${dateFormatter.format(dateRange.start)} 〜 ${dateFormatter.format(dateRange.end)}',
      ),
      trailing: const Icon(Icons.calendar_today),
      onTap: () async {
        final picked = await showDateRangePicker(
          context: context,
          firstDate: DateTime(1919),
          lastDate: DateTime.now(),
          initialEntryMode: DatePickerEntryMode.input,
          initialDateRange: dateRange,
          builder: (context, child) {
            return Theme(
              data: Theme.of(context),
              child: child!,
            );
          },
        );
        if (picked != null) {
          onChanged(picked);
        }
      },
    );
  }
}

class _EpicenterSelector extends HookConsumerWidget {
  const _EpicenterSelector({
    required this.selectedCode,
    required this.onChanged,
  });

  final String? selectedCode;
  final void Function(String? code, String? name) onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final epicenters =
        ref.watch(jmaCodeTableProvider).value?.codeTables.areaEpicenter ?? [];

    return DropdownMenu<String>(
      expandedInsets: EdgeInsets.zero,
      initialSelection: selectedCode,
      hintText: '震央地名を選択',
      onSelected: (code) {
        if (code != null && code.isNotEmpty) {
          final epicenter = epicenters.firstWhereOrNull((e) => e.code == code);
          if (epicenter == null) {
            return;
          }
          onChanged(code, epicenter.name.ja);
        } else {
          onChanged(null, null);
        }
      },
      dropdownMenuEntries: [
        const DropdownMenuEntry<String>(
          value: '',
          label: '指定しない',
        ),
        ...epicenters.map(
          (e) => DropdownMenuEntry(
            value: e.code,
            label: e.name.ja,
          ),
        ),
      ],
    );
  }
}

class _IntensityRangeSelector extends HookWidget {
  const _IntensityRangeSelector({
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final JmaIntensity min;
  final JmaIntensity max;
  final void Function(JmaIntensity, JmaIntensity) onChanged;

  static const JmaIntensity initialMin = JmaIntensity.one;
  static const JmaIntensity initialMax = JmaIntensity.seven;

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

  String _formatRange(JmaIntensity min, JmaIntensity max) {
    final isMinDefault = min == initialMin;
    final isMaxDefault = max == initialMax;

    if (isMinDefault && isMaxDefault) {
      return 'すべて';
    }
    if (min == max) {
      return '震度${min.label}';
    }
    if (isMaxDefault) {
      return '震度${min.label}以上';
    }
    if (isMinDefault) {
      return '震度${max.label}以下';
    }
    return '震度${min.label} 〜 震度${max.label}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    int valueToIndex(JmaIntensity v) =>
        _sliderValues.indexOf(v).clamp(0, _sliderValues.length - 1);
    JmaIntensity indexToValue(int i) =>
        _sliderValues[i.clamp(0, _sliderValues.length - 1)];

    return Column(
      children: [
        RangeSlider(
          values: RangeValues(
            valueToIndex(min).toDouble(),
            valueToIndex(max).toDouble(),
          ),
          max: (_sliderValues.length - 1).toDouble(),
          onChanged: (state) {
            onChanged(
              indexToValue(state.start.toInt()),
              indexToValue(state.end.toInt()),
            );
          },
          labels: RangeLabels('震度${min.label}', '震度${max.label}'),
          divisions: _sliderValues.length - 1,
        ),
        const SizedBox(height: 8),
        Text(
          _formatRange(min, max),
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _RegionIntensitySelector extends StatelessWidget {
  const _RegionIntensitySelector({
    required this.selectedCode,
    required this.selectedName,
    required this.selectedType,
    required this.intensityMin,
    required this.intensityMax,
    required this.onRegionChanged,
    required this.onIntensityChanged,
    this.onCurrentLocationPressed,
    this.onSelectFromMapPressed,
  });

  final String? selectedCode;
  final String? selectedName;
  final String selectedType;
  final JmaIntensity intensityMin;
  final JmaIntensity intensityMax;
  final void Function(String?, String?, String) onRegionChanged;
  final void Function(JmaIntensity, JmaIntensity) onIntensityChanged;
  final VoidCallback? onCurrentLocationPressed;
  final VoidCallback? onSelectFromMapPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 都道府県/市区町村の切り替えChip
        Row(
          children: [
            ChoiceChip(
              label: const Text('都道府県'),
              selected: selectedType == 'prefecture',
              onSelected: (selected) {
                if (selected) {
                  onRegionChanged(null, null, 'prefecture');
                }
              },
            ),
            const SizedBox(width: 8),
            ChoiceChip(
              label: const Text('市区町村'),
              selected: selectedType == 'city',
              onSelected: (selected) {
                if (selected) {
                  onRegionChanged(null, null, 'city');
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Selector
        if (selectedType == 'prefecture')
          PrefectureSelector(
            selectedCode: selectedCode,
            onChanged: (selection) {
              if (selection != null) {
                onRegionChanged(selection.code, selection.name, 'prefecture');
              } else {
                onRegionChanged(null, null, 'prefecture');
              }
            },
          )
        else
          CitySelector(
            selectedCode: selectedCode,
            selectedName: selectedName,
            onChanged: (selection) {
              if (selection != null) {
                onRegionChanged(selection.code, selection.name, 'city');
              } else {
                onRegionChanged(null, null, 'city');
              }
            },
          ),

        const SizedBox(height: 12),

        // 地図から選択・現在地ボタン
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onSelectFromMapPressed,
                icon: const Icon(Icons.map_outlined),
                label: const Text('地図から選択'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onCurrentLocationPressed,
                icon: const Icon(Icons.my_location),
                label: const Text('現在地'),
              ),
            ),
          ],
        ),

        // 選択中の地域と震度範囲
        if (selectedCode != null) ...[
          const SizedBox(height: 12),
          Text(
            '観測震度の範囲',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          _IntensityRangeSelector(
            min: intensityMin,
            max: intensityMax,
            onChanged: onIntensityChanged,
          ),
        ],
      ],
    );
  }
}

class _DepthRangeSelector extends HookWidget {
  const _DepthRangeSelector({
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final int min;
  final int max;
  final void Function(int, int) onChanged;

  static const initialMin = 0;
  static const initialMax = 700;

  String _formatRange(int min, int max) {
    final isMinDefault = min == initialMin;
    final isMaxDefault = max == initialMax;

    if (isMinDefault && isMaxDefault) {
      return 'すべて';
    }
    if (min == max) {
      return '${min}km';
    }
    if (isMaxDefault) {
      return '${min}km以上';
    }
    if (isMinDefault) {
      return '${max}km以下';
    }
    return '${min}km 〜 ${max}km';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        RangeSlider(
          values: RangeValues(min.toDouble(), max.toDouble()),
          max: 700,
          onChanged: (state) {
            onChanged(
              (state.start.toInt() / 10).roundToDouble().toInt() * 10,
              (state.end.toInt() / 10).roundToDouble().toInt() * 10,
            );
          },
          labels: RangeLabels('${min}km', '${max}km'),
          divisions: 70,
        ),
        const SizedBox(height: 8),
        Text(
          _formatRange(min, max),
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _MagnitudeRangeSelector extends HookWidget {
  const _MagnitudeRangeSelector({
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final double min;
  final double max;
  final void Function(double, double) onChanged;

  static const double initialMin = 0;
  static const double initialMax = 9;

  String _formatRange(double min, double max) {
    final isMinDefault = min == initialMin;
    final isMaxDefault = max == initialMax;

    if (isMinDefault && isMaxDefault) {
      return 'すべて';
    }
    if (min == max) {
      return 'M$min';
    }
    if (isMaxDefault) {
      return 'M$min以上';
    }
    if (isMinDefault) {
      return 'M$max以下';
    }
    return 'M$min 〜 M$max';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        RangeSlider(
          values: RangeValues(min, max),
          max: 9,
          onChanged: (state) {
            onChanged(
              (state.start * 10).floorToDouble() / 10,
              (state.end * 10).floorToDouble() / 10,
            );
          },
          labels: RangeLabels('M$min', 'M$max'),
          divisions: 90,
        ),
        const SizedBox(height: 8),
        Text(
          _formatRange(min, max),
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
