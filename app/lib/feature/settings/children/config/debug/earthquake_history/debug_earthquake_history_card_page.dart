import 'dart:math';

import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_hypocenter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_station.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/region_intensity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum _DebugMode {
  preliminary('速報値'),
  confirmed('確定値');

  const _DebugMode(this.label);

  final String label;
}

class DebugEarthquakeHistoryCardPage extends HookConsumerWidget {
  const DebugEarthquakeHistoryCardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paramAsync = ref.watch(jmaParameterProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('地震履歴 Debug')),
      body: switch (paramAsync) {
        AsyncLoading() => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
        AsyncError(:final error) => Center(child: Text('エラー: $error')),
        AsyncData(:final value) => _DebugBody(param: value.earthquake),
      },
    );
  }
}

class _DebugBody extends HookWidget {
  const _DebugBody({required this.param});

  final EarthquakeParameter param;

  @override
  Widget build(BuildContext context) {
    final mode = useState(_DebugMode.preliminary);
    final maxIntensity = useState(JmaIntensity.four);
    final count = useState(10);
    final seedText = useTextEditingController(text: '42');
    final seed = useState(42);

    final earthquake = useMemoized(
      () => _buildFakeEarthquake(
        param: param,
        mode: mode.value,
        maxIntensity: maxIntensity.value,
        count: count.value,
        seed: seed.value,
      ),
      [mode.value, maxIntensity.value, count.value, seed.value],
    );

    return ListView(
      children: [
        _ParamCard(
          title: 'パラメータ',
          child: Column(
            children: [
              _LabeledRow(
                label: 'モード',
                child: SegmentedButton<_DebugMode>(
                  segments: _DebugMode.values
                      .map(
                        (e) => ButtonSegment(value: e, label: Text(e.label)),
                      )
                      .toList(),
                  selected: {mode.value},
                  onSelectionChanged: (s) => mode.value = s.first,
                ),
              ),
              _LabeledRow(
                label: '最大震度',
                child: DropdownButton<JmaIntensity>(
                  value: maxIntensity.value,
                  isDense: true,
                  items: JmaIntensity.values
                      .where((e) => e != JmaIntensity.unknown)
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.label),
                        ),
                      )
                      .toList(),
                  onChanged: (v) {
                    if (v != null) {
                      maxIntensity.value = v;
                    }
                  },
                ),
              ),
              _LabeledRow(
                label: '観測数: ${count.value}',
                child: Slider(
                  value: count.value.toDouble(),
                  min: 1,
                  max: 100,
                  divisions: 99,
                  label: '${count.value}',
                  onChanged: (v) => count.value = v.round(),
                ),
              ),
              _LabeledRow(
                label: 'シード',
                child: SizedBox(
                  width: 120,
                  child: TextField(
                    controller: seedText,
                    decoration: const InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    onSubmitted: (v) {
                      final n = int.tryParse(v);
                      if (n != null) {
                        seed.value = n;
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        JmaIntensityContent(item: earthquake),
      ],
    );
  }

  Earthquake _buildFakeEarthquake({
    required EarthquakeParameter param,
    required _DebugMode mode,
    required JmaIntensity maxIntensity,
    required int count,
    required int seed,
  }) {
    final rng = Random(seed);
    final validIntensities = JmaIntensity.values
        .where(
          (i) =>
              i != JmaIntensity.unknown &&
              i.orderIndex <= maxIntensity.orderIndex,
        )
        .toList();

    if (validIntensities.isEmpty) {
      validIntensities.add(JmaIntensity.one);
    }

    JmaIntensity randomIntensity() =>
        validIntensities[rng.nextInt(validIntensities.length)];

    final EarthquakeIntensity intensity;

    if (mode == _DebugMode.preliminary) {
      final allRegions = [
        for (final pref in param.prefectures)
          for (final region in pref.regions) region,
      ];
      allRegions.shuffle(rng);
      final selected = allRegions.take(count).toList();

      final regionsMap = <JmaIntensity, List<IntensityRegion>>{};
      for (final region in selected) {
        final i = randomIntensity();
        regionsMap
            .putIfAbsent(i, () => [])
            .add(
              IntensityRegion(region: region, maxIntensity: i),
            );
      }

      intensity = EarthquakeIntensity(
        maxIntensity: maxIntensity,
        maxLpgmIntensity: null,
        regions: regionsMap,
        intensityTree: {},
        lpgmIntensityTree: {},
      );
    } else {
      final entries = <_StationEntry>[];
      for (final pref in param.prefectures) {
        for (final region in pref.regions) {
          for (final city in region.cities) {
            for (final station in city.stations) {
              entries.add(
                _StationEntry(pref: pref, city: city, station: station),
              );
            }
          }
        }
      }
      entries.shuffle(rng);
      final selected = entries.take(count).toList();

      final prefMap = <String, _PrefectureAccumulator>{};
      for (final e in selected) {
        final prefAcc = prefMap.putIfAbsent(
          e.pref.code,
          () => _PrefectureAccumulator(pref: e.pref),
        );
        prefAcc.cityMap
            .putIfAbsent(e.city.code, () => _CityAccumulator(city: e.city))
            .stations
            .add(
              _SelectedStation(
                station: e.station,
                intensity: randomIntensity(),
              ),
            );
      }

      final tree = <JmaIntensity, List<PrefectureIntensityNode>>{};
      for (final prefAcc in prefMap.values) {
        JmaIntensity? prefMax;
        final cities = <CityIntensityNode>[];
        for (final cityAcc in prefAcc.cityMap.values) {
          JmaIntensity? cityMax;
          final stationNodes = <StationIntensityNode>[];
          for (final sel in cityAcc.stations) {
            if (cityMax == null ||
                sel.intensity.orderIndex > cityMax.orderIndex) {
              cityMax = sel.intensity;
            }
            stationNodes.add(
              StationIntensityNode(
                station: sel.station,
                intensity: IntensityStation(
                  code: sel.station.code,
                  name: sel.station.name.ja,
                  sva: null,
                  prePeriods: null,
                  maxIntensity: sel.intensity,
                  maxLpgmIntensity: null,
                ),
              ),
            );
          }
          if (prefMax == null ||
              (cityMax != null && cityMax.orderIndex > prefMax.orderIndex)) {
            prefMax = cityMax;
          }
          cities.add(
            CityIntensityNode(
              city: cityAcc.city,
              maxIntensity: cityMax,
              stations: stationNodes,
            ),
          );
        }
        final node = PrefectureIntensityNode(
          prefecture: IntensityPrefecture(
            prefecture: prefAcc.pref,
            maxIntensity: prefMax,
          ),
          cities: cities,
        );
        final key = prefMax ?? JmaIntensity.unknown;
        tree.putIfAbsent(key, () => []).add(node);
      }

      intensity = EarthquakeIntensity(
        maxIntensity: maxIntensity,
        maxLpgmIntensity: null,
        regions: {},
        intensityTree: tree,
        lpgmIntensityTree: {},
      );
    }

    return Earthquake(
      eventId: 'debug-$seed',
      status: TelegramStatus.normal,
      originTime: DateTime(2024, 1, 1, 12),
      originTimePrecision: OriginTimePrecision.second,
      arrivalTime: null,
      dataSources: [EarthquakeDataSource.jmaDisasterInformationXml],
      telegramTypes: const [],
      hypocenter: const EarthquakeHypocenter(
        code: '330',
        name: '東京都',
        coordinates: Coordinate.latLng(
          latitude: 35.689,
          longitude: 139.692,
        ),
        magnitude: EarthquakeMagnitude.value(value: 5),
        depth: EarthquakeDepth.value(value: 10),
        detailedCode: null,
        detailedName: null,
      ),
      intensity: intensity,
      estimatedIntensityTileUrl: null,
    );
  }
}

class _StationEntry {
  _StationEntry({
    required this.pref,
    required this.city,
    required this.station,
  });

  final EarthquakeParameterPrefectureItem pref;
  final EarthquakeParameterCityItem city;
  final EarthquakeParameterStationItem station;
}

class _SelectedStation {
  _SelectedStation({required this.station, required this.intensity});

  final EarthquakeParameterStationItem station;
  final JmaIntensity intensity;
}

class _PrefectureAccumulator {
  _PrefectureAccumulator({required this.pref});

  final EarthquakeParameterPrefectureItem pref;
  final cityMap = <String, _CityAccumulator>{};
}

class _CityAccumulator {
  _CityAccumulator({required this.city});

  final EarthquakeParameterCityItem city;
  final stations = <_SelectedStation>[];
}

class _ParamCard extends StatelessWidget {
  const _ParamCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}

class _LabeledRow extends StatelessWidget {
  const _LabeledRow({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
