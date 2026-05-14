import 'package:collection/collection.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/feature/location/data/jma_region_resolver.dart';
import 'package:eqmonitor/feature/parameter/data/notifier/parameter_set_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 地震通知用の地域選択ダイアログ結果。
///
/// - 「全国」モード: `regionId = 0`, `cityCode = null`
/// - 「一次細分化地域」モード: `regionId` のみ
/// - 「市区町村」モード: `regionId` (親 region) + `cityCode`
/// - 「現在地」モード: `isCurrentLocation = true`、対応する region/city を解決済
typedef EarthquakeNotificationRegionPickerResult = ({
  int regionId,
  String regionName,
  String? cityCode,
  String? cityName,
  bool isCurrentLocation,
  JmaIntensity minIntensity,
});

Future<EarthquakeNotificationRegionPickerResult?>
showEarthquakeNotificationRegionPickerDialog(
  BuildContext context, {
  bool allRegionAlreadyAdded = false,
  bool currentLocationAlreadyAdded = false,
}) => showAdaptiveDialog<EarthquakeNotificationRegionPickerResult>(
  context: context,
  builder: (_) => _EarthquakeRegionPickerDialog(
    allRegionAlreadyAdded: allRegionAlreadyAdded,
    currentLocationAlreadyAdded: currentLocationAlreadyAdded,
  ),
);

enum _Mode { all, region, city, currentLocation }

const List<JmaIntensity> _kIntensities = [
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

class _EarthquakeRegionPickerDialog extends HookConsumerWidget {
  const _EarthquakeRegionPickerDialog({
    required this.allRegionAlreadyAdded,
    required this.currentLocationAlreadyAdded,
  });

  final bool allRegionAlreadyAdded;
  final bool currentLocationAlreadyAdded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parameterSet = ref.watch(parameterSetProvider).value;
    final intensity = useState(JmaIntensity.four);
    final mode = useState<_Mode>(
      allRegionAlreadyAdded ? _Mode.region : _Mode.all,
    );

    // 一次細分化地域モード用
    final regions = useMemoized(
      () => _flattenRegions(parameterSet?.earthquake),
      [parameterSet?.earthquake],
    );
    final selectedRegionCode = useState<int?>(null);
    final selectedRegionName = useState<String?>(null);

    // 市区町村モード用
    final cities = useMemoized(
      () => _flattenCities(parameterSet?.earthquake),
      [parameterSet?.earthquake],
    );
    final selectedCity = useState<_CityEntry?>(null);

    // 現在地モード用
    final currentLocationResolved = useState<EarthquakeRegionResolution?>(null);
    final isResolvingLocation = useState<bool>(false);

    bool canSubmit() {
      switch (mode.value) {
        case _Mode.all:
          return !allRegionAlreadyAdded;
        case _Mode.region:
          return selectedRegionCode.value != null;
        case _Mode.city:
          return selectedCity.value != null;
        case _Mode.currentLocation:
          return !currentLocationAlreadyAdded &&
              currentLocationResolved.value != null;
      }
    }

    Future<void> resolveCurrentLocation() async {
      isResolvingLocation.value = true;
      try {
        final location = await _ensurePermissionAndGetLocation(context);
        if (location == null || !context.mounted) {
          return;
        }
        final resolver = await ref.read(jmaRegionResolverProvider.future);
        final resolution = resolver.resolveEarthquakeRegion(
          location.lat,
          location.lon,
        );
        if (resolution == null) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('現在地の市区町村を解決できませんでした')),
            );
          }
          return;
        }
        currentLocationResolved.value = resolution;
      } finally {
        isResolvingLocation.value = false;
      }
    }

    return AlertDialog.adaptive(
      title: const Text('地域を追加'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SegmentedButton<_Mode>(
              segments: [
                ButtonSegment(
                  value: _Mode.all,
                  label: const Text('全国'),
                  icon: const Icon(Icons.public_outlined),
                  enabled: !allRegionAlreadyAdded,
                ),
                const ButtonSegment(
                  value: _Mode.region,
                  label: Text('地域'),
                  icon: Icon(Icons.map_outlined),
                ),
                const ButtonSegment(
                  value: _Mode.city,
                  label: Text('市区町村'),
                  icon: Icon(Icons.location_city_outlined),
                ),
                ButtonSegment(
                  value: _Mode.currentLocation,
                  label: const Text('現在地'),
                  icon: const Icon(Icons.my_location_outlined),
                  enabled: !currentLocationAlreadyAdded,
                ),
              ],
              selected: {mode.value},
              onSelectionChanged: (s) {
                mode.value = s.first;
                selectedRegionCode.value = null;
                selectedRegionName.value = null;
                selectedCity.value = null;
                currentLocationResolved.value = null;
              },
            ),
            const SizedBox(height: 16),
            if (parameterSet == null)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator.adaptive(),
                ),
              )
            else
              switch (mode.value) {
                _Mode.all => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    '全国の地震情報を受信します',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                _Mode.region => _RegionPicker(
                  regions: regions,
                  selectedCode: selectedRegionCode.value,
                  onChanged: (entry) {
                    selectedRegionCode.value = entry?.code;
                    selectedRegionName.value = entry?.name;
                  },
                ),
                _Mode.city => _CityPicker(
                  cities: cities,
                  selected: selectedCity.value,
                  onChanged: (entry) => selectedCity.value = entry,
                ),
                _Mode.currentLocation => _CurrentLocationPanel(
                  resolution: currentLocationResolved.value,
                  isResolving: isResolvingLocation.value,
                  onResolve: resolveCurrentLocation,
                ),
              },
            const SizedBox(height: 16),
            DropdownMenu<JmaIntensity>(
              expandedInsets: EdgeInsets.zero,
              initialSelection: intensity.value,
              label: const Text('最小震度'),
              onSelected: (v) {
                if (v != null) {
                  intensity.value = v;
                }
              },
              dropdownMenuEntries: _kIntensities
                  .map(
                    (i) => DropdownMenuEntry(
                      value: i,
                      label: '震度${i.mainText}${i.suffix}以上',
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
        FilledButton(
          onPressed: canSubmit()
              ? () {
                  final result = _buildResult(
                    mode: mode.value,
                    intensity: intensity.value,
                    regionCode: selectedRegionCode.value,
                    regionName: selectedRegionName.value,
                    city: selectedCity.value,
                    currentLocation: currentLocationResolved.value,
                  );
                  if (result != null) {
                    Navigator.of(context).pop(result);
                  }
                }
              : null,
          child: const Text('追加'),
        ),
      ],
    );
  }
}

EarthquakeNotificationRegionPickerResult? _buildResult({
  required _Mode mode,
  required JmaIntensity intensity,
  required int? regionCode,
  required String? regionName,
  required _CityEntry? city,
  required EarthquakeRegionResolution? currentLocation,
}) {
  switch (mode) {
    case _Mode.all:
      return (
        regionId: 0,
        regionName: '全国',
        cityCode: null,
        cityName: null,
        isCurrentLocation: false,
        minIntensity: intensity,
      );
    case _Mode.region:
      if (regionCode == null) {
        return null;
      }
      return (
        regionId: regionCode,
        regionName: regionName ?? '',
        cityCode: null,
        cityName: null,
        isCurrentLocation: false,
        minIntensity: intensity,
      );
    case _Mode.city:
      if (city == null) {
        return null;
      }
      return (
        regionId: city.regionCode,
        regionName: city.regionName,
        cityCode: city.cityCode,
        cityName: city.cityName,
        isCurrentLocation: false,
        minIntensity: intensity,
      );
    case _Mode.currentLocation:
      if (currentLocation == null) {
        return null;
      }
      return (
        regionId: currentLocation.regionCode,
        regionName: currentLocation.regionName,
        cityCode: currentLocation.cityCode,
        cityName: currentLocation.cityName,
        isCurrentLocation: true,
        minIntensity: intensity,
      );
  }
}

class _RegionEntry {
  const _RegionEntry({
    required this.code,
    required this.name,
  });

  final int code;
  final String name;
}

class _CityEntry {
  const _CityEntry({
    required this.cityCode,
    required this.cityName,
    required this.regionCode,
    required this.regionName,
  });

  final String cityCode;
  final String cityName;
  final int regionCode;
  final String regionName;
}

List<_RegionEntry> _flattenRegions(EarthquakeParameter? param) {
  if (param == null) {
    return const [];
  }
  final entries = <_RegionEntry>[];
  for (final prefecture in param.prefectures) {
    for (final region in prefecture.regions) {
      final code = int.tryParse(region.code);
      if (code == null) {
        continue;
      }
      entries.add(_RegionEntry(code: code, name: region.name.ja));
    }
  }
  // 同名重複を避けるため code 昇順で安定ソート。
  entries.sortBy<num>((e) => e.code);
  return entries;
}

List<_CityEntry> _flattenCities(EarthquakeParameter? param) {
  if (param == null) {
    return const [];
  }
  final entries = <_CityEntry>[];
  for (final prefecture in param.prefectures) {
    for (final region in prefecture.regions) {
      final regionCode = int.tryParse(region.code);
      if (regionCode == null) {
        continue;
      }
      for (final city in region.cities) {
        entries.add(
          _CityEntry(
            cityCode: city.code,
            cityName: city.name.ja,
            regionCode: regionCode,
            regionName: region.name.ja,
          ),
        );
      }
    }
  }
  // 市区町村コード順で安定ソート。
  entries.sortBy((e) => e.cityCode);
  return entries;
}

class _RegionPicker extends StatelessWidget {
  const _RegionPicker({
    required this.regions,
    required this.selectedCode,
    required this.onChanged,
  });

  final List<_RegionEntry> regions;
  final int? selectedCode;
  final ValueChanged<_RegionEntry?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<int>(
      expandedInsets: EdgeInsets.zero,
      initialSelection: selectedCode,
      label: const Text('一次細分化地域'),
      hintText: '地域を選択',
      onSelected: (code) {
        if (code == null) {
          onChanged(null);
          return;
        }
        final entry = regions.firstWhereOrNull((r) => r.code == code);
        onChanged(entry);
      },
      dropdownMenuEntries: regions
          .map(
            (e) => DropdownMenuEntry<int>(
              value: e.code,
              label: e.name,
            ),
          )
          .toList(),
    );
  }
}

class _CityPicker extends StatelessWidget {
  const _CityPicker({
    required this.cities,
    required this.selected,
    required this.onChanged,
  });

  final List<_CityEntry> cities;
  final _CityEntry? selected;
  final ValueChanged<_CityEntry?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DropdownMenu<String>(
          expandedInsets: EdgeInsets.zero,
          initialSelection: selected?.cityCode,
          label: const Text('市区町村'),
          hintText: '市区町村を検索',
          enableFilter: true,
          onSelected: (code) {
            if (code == null) {
              onChanged(null);
              return;
            }
            onChanged(cities.firstWhereOrNull((c) => c.cityCode == code));
          },
          dropdownMenuEntries: cities
              .map(
                (e) => DropdownMenuEntry<String>(
                  value: e.cityCode,
                  label: '${e.cityName} (${e.regionName})',
                ),
              )
              .toList(),
        ),
        if (selected != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              '所属一次細分化地域: ${selected!.regionName} (${selected!.regionCode})',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}

class _CurrentLocationPanel extends StatelessWidget {
  const _CurrentLocationPanel({
    required this.resolution,
    required this.isResolving,
    required this.onResolve,
  });

  final EarthquakeRegionResolution? resolution;
  final bool isResolving;
  final Future<void> Function() onResolve;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (resolution == null)
          Text(
            '位置情報を取得して市区町村・一次細分化地域を解決します。',
            style: TextStyle(color: colors.onSurfaceVariant),
          )
        else
          Card.outlined(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '市区町村: ${resolution!.cityName} (${resolution!.cityCode})',
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '所属地域: ${resolution!.regionName} (${resolution!.regionCode})',
                  ),
                ],
              ),
            ),
          ),
        const SizedBox(height: 8),
        FilledButton.tonalIcon(
          onPressed: isResolving ? null : onResolve,
          icon: isResolving
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator.adaptive(strokeWidth: 2),
                )
              : const Icon(Icons.my_location_outlined),
          label: Text(resolution == null ? '現在地を取得' : '現在地を再取得'),
        ),
      ],
    );
  }
}

/// 現在地通知のために位置情報の常時許可を取得し、現在位置を返す。
/// 権限が無い場合や whileInUse の場合は設定アプリ誘導ダイアログを表示する。
Future<({double lat, double lon})?> _ensurePermissionAndGetLocation(
  BuildContext context,
) async {
  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }

  if (permission == LocationPermission.denied ||
      permission == LocationPermission.deniedForever) {
    if (!context.mounted) {
      return null;
    }
    final shouldOpen = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog.adaptive(
        title: const Text('位置情報の許可が必要です'),
        content: const Text(
          '現在地通知には位置情報の許可が必要です。\n'
          '設定アプリで権限を変更してください。',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('キャンセル'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('設定を開く'),
          ),
        ],
      ),
    );
    if (shouldOpen ?? false) {
      await Geolocator.openAppSettings();
    }
    return null;
  }

  try {
    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.medium,
      ),
    );
    return (lat: position.latitude, lon: position.longitude);
  } on Object {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('現在地の取得に失敗しました')),
      );
    }
    return null;
  }
}
