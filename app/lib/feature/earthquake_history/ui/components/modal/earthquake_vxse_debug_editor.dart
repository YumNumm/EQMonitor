import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_apply_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_draft.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_draft_factory.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_comment.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/lpgm_intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_vxse_debug_editor_controller.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/action/earthquake_vxse_debug_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EarthquakeVxseDebugEditor extends HookConsumerWidget {
  const EarthquakeVxseDebugEditor({required this.current, super.key});

  final Earthquake current;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = earthquakeVxseDebugEditorControllerProvider(current);
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);
    final draft = state.draft;
    final ownsHypocenter = draft is! EarthquakeVxse51DebugDraft;
    final ownsIntensity =
        draft is EarthquakeVxse51DebugDraft ||
        draft is EarthquakeVxse53DebugDraft ||
        draft is EarthquakeVxse62DebugDraft;

    return CustomScrollView(
      key: const Key('vxse-editor-scroll'),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList.list(
            children: [
              _SharedReportFields(state: state, notifier: notifier),
              if (ownsHypocenter) ...[
                const SizedBox(height: 16),
                _HypocenterFields(draft: draft, notifier: notifier),
              ],
              if (ownsIntensity) ...[
                const SizedBox(height: 16),
                _SeismicIntensityFields(draft: draft, notifier: notifier),
              ],
              if (draft is EarthquakeVxse62DebugDraft) ...[
                const SizedBox(height: 16),
                _LpgmFields(draft: draft, notifier: notifier),
              ],
              const SizedBox(height: 16),
              _CommentsFields(
                selectedType: state.selectedType,
                draft: draft,
                notifier: notifier,
              ),
              const SizedBox(height: 16),
              _JsonEditor(state: state, notifier: notifier),
              const SizedBox(height: 16),
              FilledButton.icon(
                key: const Key('vxse-apply-button'),
                onPressed: state.canApply
                    ? () => ref
                          .read(earthquakeVxseDebugActionProvider)
                          .apply(
                            ref: ref,
                            context: context,
                            current: current,
                            editorState: state,
                          )
                    : null,
                icon: const Icon(Icons.play_arrow_rounded),
                label: const Text('適用'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SharedReportFields extends StatelessWidget {
  const _SharedReportFields({required this.state, required this.notifier});

  final EarthquakeVxseDebugEditorState state;
  final EarthquakeVxseDebugEditorController notifier;

  @override
  Widget build(BuildContext context) => Card.outlined(
    key: const Key('shared-report-fields'),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('電文', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          DropdownButtonFormField<EarthquakeTelegramType>(
            key: const Key('vxse-type-dropdown'),
            initialValue: state.selectedType,
            isExpanded: true,
            decoration: const InputDecoration(labelText: '電文種類'),
            items:
                const [
                      EarthquakeTelegramType.vxse51,
                      EarthquakeTelegramType.vxse52,
                      EarthquakeTelegramType.vxse53,
                      EarthquakeTelegramType.vxse61,
                      EarthquakeTelegramType.vxse62,
                    ]
                    .map(
                      (type) => DropdownMenuItem(
                        value: type,
                        child: Text(type.name.toUpperCase()),
                      ),
                    )
                    .toList(),
            onChanged: (value) {
              if (value != null) {
                notifier.selectType(value);
              }
            },
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<EarthquakeVxseApplyMode>(
            initialValue: state.applyMode,
            isExpanded: true,
            decoration: const InputDecoration(labelText: '適用方法'),
            items: EarthquakeVxseApplyMode.values
                .map(
                  (mode) => DropdownMenuItem(
                    value: mode,
                    child: Text(switch (mode) {
                      .merge => 'マージ',
                      .clearAndApply => '所有フィールドを消去して適用',
                    }),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                notifier.setApplyMode(value);
              }
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            key: const Key('reported-at-field'),
            initialValue: state.draft.reportedAt.toIso8601String(),
            decoration: const InputDecoration(labelText: '発表時刻 (ISO 8601)'),
            onChanged: (value) {
              final parsed = DateTime.tryParse(value);
              if (parsed != null) {
                notifier.setReportedAt(parsed);
              }
            },
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<TelegramStatus>(
            initialValue: state.draft.status,
            isExpanded: true,
            decoration: const InputDecoration(labelText: 'ステータス'),
            items: TelegramStatus.values
                .map(
                  (status) =>
                      DropdownMenuItem(value: status, child: Text(status.name)),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                notifier.setStatus(value);
              }
            },
          ),
        ],
      ),
    ),
  );
}

class _HypocenterFields extends StatelessWidget {
  const _HypocenterFields({required this.draft, required this.notifier});

  final EarthquakeVxseDebugDraft draft;
  final EarthquakeVxseDebugEditorController notifier;

  @override
  Widget build(BuildContext context) {
    final arrivalTime = switch (draft) {
      EarthquakeVxse52DebugDraft(:final arrivalTime) ||
      EarthquakeVxse53DebugDraft(:final arrivalTime) ||
      EarthquakeVxse61DebugDraft(:final arrivalTime) ||
      EarthquakeVxse62DebugDraft(:final arrivalTime) => arrivalTime,
      EarthquakeVxse51DebugDraft() => null,
    };
    final originTime = switch (draft) {
      EarthquakeVxse52DebugDraft(:final originTime) ||
      EarthquakeVxse53DebugDraft(:final originTime) ||
      EarthquakeVxse61DebugDraft(:final originTime) ||
      EarthquakeVxse62DebugDraft(:final originTime) => originTime,
      EarthquakeVxse51DebugDraft() => null,
    };
    final hypocenter = switch (draft) {
      EarthquakeVxse52DebugDraft(:final hypocenter) ||
      EarthquakeVxse53DebugDraft(:final hypocenter) ||
      EarthquakeVxse61DebugDraft(:final hypocenter) ||
      EarthquakeVxse62DebugDraft(:final hypocenter) => hypocenter,
      EarthquakeVxse51DebugDraft() => earthquakeVxseDebugSampleHypocenter,
    };
    final latitude = switch (hypocenter.coordinates) {
      CoordinateLatLng(:final latitude) => latitude,
      _ => 35.5,
    };
    final longitude = switch (hypocenter.coordinates) {
      CoordinateLatLng(:final longitude) => longitude,
      _ => 139.8,
    };
    final magnitude = switch (hypocenter.magnitude) {
      EarthquakeMagnitudeValue(:final value) => value,
      _ => 0,
    };
    final depth = switch (hypocenter.depth) {
      EarthquakeDepthValue(:final value) => value,
      _ => 0,
    };

    return Card.outlined(
      key: const Key('hypocenter-fields'),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('震源', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: arrivalTime?.toIso8601String() ?? '',
              decoration: const InputDecoration(labelText: '検知時刻'),
              onChanged: (value) =>
                  notifier.setArrivalTime(DateTime.tryParse(value)),
            ),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: originTime?.toIso8601String() ?? '',
              decoration: const InputDecoration(labelText: '発生時刻'),
              onChanged: (value) =>
                  notifier.setOriginTime(DateTime.tryParse(value)),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                SizedBox(
                  width: 140,
                  child: TextFormField(
                    initialValue: hypocenter.code ?? '',
                    decoration: const InputDecoration(labelText: '震央コード'),
                    onChanged: (value) => notifier.setHypocenter(
                      hypocenter.copyWith(code: value),
                    ),
                  ),
                ),
                SizedBox(
                  width: 220,
                  child: TextFormField(
                    initialValue: hypocenter.name ?? '',
                    decoration: const InputDecoration(labelText: '震央名'),
                    onChanged: (value) => notifier.setHypocenter(
                      hypocenter.copyWith(name: value),
                    ),
                  ),
                ),
                SizedBox(
                  width: 140,
                  child: TextFormField(
                    initialValue: latitude.toString(),
                    decoration: const InputDecoration(labelText: '緯度'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      final parsed = double.tryParse(value);
                      if (parsed != null) {
                        notifier.setHypocenter(
                          hypocenter.copyWith(
                            coordinates: Coordinate.latLng(
                              latitude: parsed,
                              longitude: longitude,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 140,
                  child: TextFormField(
                    initialValue: longitude.toString(),
                    decoration: const InputDecoration(labelText: '経度'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      final parsed = double.tryParse(value);
                      if (parsed != null) {
                        notifier.setHypocenter(
                          hypocenter.copyWith(
                            coordinates: Coordinate.latLng(
                              latitude: latitude,
                              longitude: parsed,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 140,
                  child: TextFormField(
                    initialValue: magnitude.toString(),
                    decoration: const InputDecoration(labelText: 'マグニチュード'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      final parsed = double.tryParse(value);
                      if (parsed != null) {
                        notifier.setHypocenter(
                          hypocenter.copyWith(
                            magnitude: EarthquakeMagnitude.value(value: parsed),
                          ),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 140,
                  child: TextFormField(
                    initialValue: depth.toString(),
                    decoration: const InputDecoration(labelText: '深さ (km)'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      final parsed = int.tryParse(value);
                      if (parsed != null) {
                        notifier.setHypocenter(
                          hypocenter.copyWith(
                            depth: EarthquakeDepth.value(value: parsed),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            if (draft case EarthquakeVxse53DebugDraft(
              :final earthquakeType,
            )) ...[
              const SizedBox(height: 8),
              DropdownButtonFormField<EarthquakeType>(
                initialValue: earthquakeType,
                decoration: const InputDecoration(labelText: '地震種別'),
                items: EarthquakeType.values
                    .map(
                      (value) => DropdownMenuItem(
                        value: value,
                        child: Text(value.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    notifier.setEarthquakeType(value);
                  }
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SeismicIntensityFields extends StatelessWidget {
  const _SeismicIntensityFields({required this.draft, required this.notifier});

  final EarthquakeVxseDebugDraft draft;
  final EarthquakeVxseDebugEditorController notifier;

  @override
  Widget build(BuildContext context) {
    final maxIntensity = switch (draft) {
      EarthquakeVxse51DebugDraft(:final maxIntensity) ||
      EarthquakeVxse53DebugDraft(:final maxIntensity) ||
      EarthquakeVxse62DebugDraft(:final maxIntensity) => maxIntensity,
      _ => JmaIntensity.unknown,
    };
    final regions = switch (draft) {
      EarthquakeVxse51DebugDraft(:final regions) ||
      EarthquakeVxse53DebugDraft(:final regions) ||
      EarthquakeVxse62DebugDraft(:final regions) => regions,
      _ => const <JmaIntensity, List<IntensityRegion>>{},
    };
    final vxse51Prefectures = switch (draft) {
      EarthquakeVxse51DebugDraft(:final prefectures) => prefectures,
      _ => const <JmaIntensity, List<IntensityPrefecture>>{},
    };
    final tree = switch (draft) {
      EarthquakeVxse53DebugDraft(:final intensityTree) ||
      EarthquakeVxse62DebugDraft(:final intensityTree) => intensityTree,
      _ => const <JmaIntensity, List<PrefectureIntensityNode>>{},
    };

    return Card.outlined(
      key: const Key('seismic-intensity-fields'),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('震度', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            DropdownButtonFormField<JmaIntensity>(
              initialValue: maxIntensity,
              decoration: const InputDecoration(labelText: '最大震度'),
              items: JmaIntensity.values
                  .map(
                    (value) => DropdownMenuItem(
                      value: value,
                      child: Text(value.label),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  notifier.setMaxIntensity(value);
                }
              },
            ),
            const SizedBox(height: 12),
            Text('地域', style: Theme.of(context).textTheme.titleSmall),
            for (final entry in regions.entries)
              for (final (index, region) in entry.value.indexed)
                _OrdinaryRegionRow(
                  level: entry.key,
                  region: region,
                  onChanged: (updated) => notifier.setRegions({
                    for (final currentEntry in regions.entries)
                      currentEntry.key: [
                        for (final (currentIndex, current)
                            in currentEntry.value.indexed)
                          currentEntry.key == entry.key && currentIndex == index
                              ? updated
                              : current,
                      ],
                  }),
                  onRemove: () => notifier.setRegions({
                    for (final currentEntry in regions.entries)
                      if (currentEntry.key != entry.key ||
                          currentEntry.value.length > 1)
                        currentEntry.key: [
                          for (final (currentIndex, current)
                              in currentEntry.value.indexed)
                            if (currentEntry.key != entry.key ||
                                currentIndex != index)
                              current,
                        ],
                  }),
                ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                key: const Key('ordinary-region-add'),
                onPressed: () => notifier.setRegions({
                  ...regions,
                  maxIntensity: [
                    ...regions[maxIntensity] ?? const [],
                    earthquakeVxseDebugSampleIntensityRegion,
                  ],
                }),
                icon: const Icon(Icons.add),
                label: const Text('地域を追加'),
              ),
            ),
            if (draft is EarthquakeVxse51DebugDraft)
              _Vxse51PrefectureFields(
                prefectures: vxse51Prefectures,
                maxIntensity: maxIntensity,
                notifier: notifier,
              )
            else
              _OrdinaryTreeFields(
                tree: tree,
                maxIntensity: maxIntensity,
                ownsCities: draft is EarthquakeVxse53DebugDraft,
                notifier: notifier,
              ),
          ],
        ),
      ),
    );
  }
}

class _Vxse51PrefectureFields extends StatelessWidget {
  const _Vxse51PrefectureFields({
    required this.prefectures,
    required this.maxIntensity,
    required this.notifier,
  });

  final Map<JmaIntensity, List<IntensityPrefecture>> prefectures;
  final JmaIntensity maxIntensity;
  final EarthquakeVxseDebugEditorController notifier;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text('都道府県', style: Theme.of(context).textTheme.titleSmall),
      for (final entry in prefectures.entries)
        for (final (index, prefecture) in entry.value.indexed)
          _OrdinaryPrefectureRow(
            prefecture: prefecture,
            onChanged: (updated) => notifier.setPrefectures({
              for (final currentEntry in prefectures.entries)
                currentEntry.key: [
                  for (final (currentIndex, current)
                      in currentEntry.value.indexed)
                    currentEntry.key == entry.key && currentIndex == index
                        ? updated
                        : current,
                ],
            }),
            onRemove: () => notifier.setPrefectures({
              for (final currentEntry in prefectures.entries)
                if (currentEntry.key != entry.key ||
                    currentEntry.value.length > 1)
                  currentEntry.key: [
                    for (final (currentIndex, current)
                        in currentEntry.value.indexed)
                      if (currentEntry.key != entry.key ||
                          currentIndex != index)
                        current,
                  ],
            }),
          ),
      Align(
        alignment: Alignment.centerLeft,
        child: TextButton.icon(
          key: const Key('ordinary-prefecture-add'),
          onPressed: () => notifier.setPrefectures({
            ...prefectures,
            maxIntensity: [
              ...prefectures[maxIntensity] ?? const [],
              earthquakeVxseDebugSampleIntensityPrefecture,
            ],
          }),
          icon: const Icon(Icons.add),
          label: const Text('都道府県を追加'),
        ),
      ),
    ],
  );
}

class _OrdinaryTreeFields extends StatelessWidget {
  const _OrdinaryTreeFields({
    required this.tree,
    required this.maxIntensity,
    required this.ownsCities,
    required this.notifier,
  });

  final Map<JmaIntensity, List<PrefectureIntensityNode>> tree;
  final JmaIntensity maxIntensity;
  final bool ownsCities;
  final EarthquakeVxseDebugEditorController notifier;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text('都道府県・市区町村・観測点', style: Theme.of(context).textTheme.titleSmall),
      for (final entry in tree.entries)
        for (final (prefectureIndex, prefecture) in entry.value.indexed) ...[
          _OrdinaryPrefectureRow(
            prefecture: prefecture.prefecture,
            onChanged: (updated) => notifier.setIntensityTree({
              for (final currentEntry in tree.entries)
                currentEntry.key: [
                  for (final (currentIndex, current)
                      in currentEntry.value.indexed)
                    currentEntry.key == entry.key &&
                            currentIndex == prefectureIndex
                        ? current.copyWith(prefecture: updated)
                        : current,
                ],
            }),
            onRemove: () => notifier.setIntensityTree({
              for (final currentEntry in tree.entries)
                if (currentEntry.key != entry.key ||
                    currentEntry.value.length > 1)
                  currentEntry.key: [
                    for (final (currentIndex, current)
                        in currentEntry.value.indexed)
                      if (currentEntry.key != entry.key ||
                          currentIndex != prefectureIndex)
                        current,
                  ],
            }),
          ),
          for (final (cityIndex, city) in prefecture.cities.indexed) ...[
            if (ownsCities)
              _OrdinaryCityRow(
                city: city,
                onChanged: (updated) => notifier.setIntensityTree({
                  for (final currentEntry in tree.entries)
                    currentEntry.key: [
                      for (final (currentPrefectureIndex, currentPrefecture)
                          in currentEntry.value.indexed)
                        currentEntry.key == entry.key &&
                                currentPrefectureIndex == prefectureIndex
                            ? currentPrefecture.copyWith(
                                cities: [
                                  for (final (currentCityIndex, currentCity)
                                      in currentPrefecture.cities.indexed)
                                    currentCityIndex == cityIndex
                                        ? updated
                                        : currentCity,
                                ],
                              )
                            : currentPrefecture,
                    ],
                }),
                onRemove: () => notifier.setIntensityTree({
                  for (final currentEntry in tree.entries)
                    currentEntry.key: [
                      for (final (currentPrefectureIndex, currentPrefecture)
                          in currentEntry.value.indexed)
                        currentEntry.key == entry.key &&
                                currentPrefectureIndex == prefectureIndex
                            ? currentPrefecture.copyWith(
                                cities: [
                                  for (final (currentCityIndex, currentCity)
                                      in currentPrefecture.cities.indexed)
                                    if (currentCityIndex != cityIndex)
                                      currentCity,
                                ],
                              )
                            : currentPrefecture,
                    ],
                }),
              ),
            for (final (stationIndex, station) in city.stations.indexed)
              _OrdinaryStationRow(
                station: station,
                onChanged: (updated) => notifier.setIntensityTree({
                  for (final currentEntry in tree.entries)
                    currentEntry.key: [
                      for (final (currentPrefectureIndex, currentPrefecture)
                          in currentEntry.value.indexed)
                        currentEntry.key == entry.key &&
                                currentPrefectureIndex == prefectureIndex
                            ? currentPrefecture.copyWith(
                                cities: [
                                  for (final (currentCityIndex, currentCity)
                                      in currentPrefecture.cities.indexed)
                                    currentCityIndex == cityIndex
                                        ? currentCity.copyWith(
                                            stations: [
                                              for (final (
                                                    currentStationIndex,
                                                    currentStation,
                                                  )
                                                  in currentCity
                                                      .stations
                                                      .indexed)
                                                currentStationIndex ==
                                                        stationIndex
                                                    ? updated
                                                    : currentStation,
                                            ],
                                          )
                                        : currentCity,
                                ],
                              )
                            : currentPrefecture,
                    ],
                }),
                onRemove: () => notifier.setIntensityTree({
                  for (final currentEntry in tree.entries)
                    currentEntry.key: [
                      for (final (currentPrefectureIndex, currentPrefecture)
                          in currentEntry.value.indexed)
                        currentEntry.key == entry.key &&
                                currentPrefectureIndex == prefectureIndex
                            ? currentPrefecture.copyWith(
                                cities: [
                                  for (final (currentCityIndex, currentCity)
                                      in currentPrefecture.cities.indexed)
                                    currentCityIndex == cityIndex
                                        ? currentCity.copyWith(
                                            stations: [
                                              for (final (
                                                    currentStationIndex,
                                                    currentStation,
                                                  )
                                                  in currentCity
                                                      .stations
                                                      .indexed)
                                                if (currentStationIndex !=
                                                    stationIndex)
                                                  currentStation,
                                            ],
                                          )
                                        : currentCity,
                                ],
                              )
                            : currentPrefecture,
                    ],
                }),
              ),
            if (!ownsCities)
              _StationParentCityLocator(
                currentCode: city.city.code,
                currentName: city.city.name.ja,
                onCodeChanged: (value) => notifier.setVxse62StationParentCity(
                  currentCode: city.city.code,
                  code: value,
                  name: city.city.name.ja,
                ),
                onNameChanged: (value) => notifier.setVxse62StationParentCity(
                  currentCode: city.city.code,
                  code: city.city.code,
                  name: value,
                ),
              ),
          ],
        ],
      Wrap(
        spacing: 8,
        children: [
          TextButton.icon(
            key: const Key('ordinary-prefecture-add'),
            onPressed: () => notifier.setIntensityTree({
              ...tree,
              maxIntensity: [
                ...tree[maxIntensity] ?? const [],
                const PrefectureIntensityNode(
                  prefecture: earthquakeVxseDebugSampleIntensityPrefecture,
                  cities: [],
                ),
              ],
            }),
            icon: const Icon(Icons.add),
            label: const Text('都道府県'),
          ),
          if (ownsCities)
            TextButton.icon(
              key: const Key('ordinary-city-add'),
              onPressed: () {
                final values = tree[maxIntensity] ?? const [];
                notifier.setIntensityTree({
                  ...tree,
                  maxIntensity: values.isEmpty
                      ? const [
                          PrefectureIntensityNode(
                            prefecture:
                                earthquakeVxseDebugSampleIntensityPrefecture,
                            cities: [
                              CityIntensityNode(
                                city: earthquakeVxseDebugSampleCity,
                                maxIntensity:
                                    earthquakeVxseDebugSampleMaxIntensity,
                                stations: [],
                              ),
                            ],
                          ),
                        ]
                      : [
                          values.first.copyWith(
                            cities: [
                              ...values.first.cities,
                              const CityIntensityNode(
                                city: earthquakeVxseDebugSampleCity,
                                maxIntensity:
                                    earthquakeVxseDebugSampleMaxIntensity,
                                stations: [],
                              ),
                            ],
                          ),
                          ...values.skip(1),
                        ],
                });
              },
              icon: const Icon(Icons.add),
              label: const Text('市区町村'),
            ),
          TextButton.icon(
            key: const Key('ordinary-station-add'),
            onPressed: () {
              final values = tree[maxIntensity] ?? const [];
              final base = values.isEmpty
                  ? const PrefectureIntensityNode(
                      prefecture: earthquakeVxseDebugSampleIntensityPrefecture,
                      cities: [],
                    )
                  : values.first;
              final cities = base.cities;
              final city = cities.isEmpty
                  ? const CityIntensityNode(
                      city: earthquakeVxseDebugSampleCity,
                      maxIntensity: earthquakeVxseDebugSampleMaxIntensity,
                      stations: [],
                    )
                  : cities.first;
              notifier.setIntensityTree({
                ...tree,
                maxIntensity: [
                  base.copyWith(
                    cities: [
                      city.copyWith(
                        stations: [
                          ...city.stations,
                          const StationIntensityNode(
                            station: earthquakeVxseDebugSampleStation,
                            intensity:
                                earthquakeVxseDebugSampleStationIntensity,
                          ),
                        ],
                      ),
                      ...cities.skip(1),
                    ],
                  ),
                  ...values.skip(1),
                ],
              });
            },
            icon: const Icon(Icons.add),
            label: const Text('観測点'),
          ),
        ],
      ),
    ],
  );
}

class _LpgmFields extends StatelessWidget {
  const _LpgmFields({required this.draft, required this.notifier});

  final EarthquakeVxse62DebugDraft draft;
  final EarthquakeVxseDebugEditorController notifier;

  @override
  Widget build(BuildContext context) => Card.outlined(
    key: const Key('lpgm-fields'),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('長周期地震動', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          DropdownButtonFormField<JmaLpgmIntensity>(
            initialValue: draft.maxLpgmIntensity,
            decoration: const InputDecoration(labelText: '最大長周期地震動階級'),
            items: JmaLpgmIntensity.values
                .map(
                  (value) =>
                      DropdownMenuItem(value: value, child: Text(value.label)),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                notifier.setMaxLpgmIntensity(value);
              }
            },
          ),
          Text('地域', style: Theme.of(context).textTheme.titleSmall),
          for (final entry in draft.lpgmRegions.entries)
            for (final (index, region) in entry.value.indexed)
              _LpgmRegionRow(
                region: region,
                onChanged: (updated) => notifier.setLpgmRegions({
                  for (final currentEntry in draft.lpgmRegions.entries)
                    currentEntry.key: [
                      for (final (currentIndex, current)
                          in currentEntry.value.indexed)
                        currentEntry.key == entry.key && currentIndex == index
                            ? updated
                            : current,
                    ],
                }),
                onRemove: () => notifier.setLpgmRegions({
                  for (final currentEntry in draft.lpgmRegions.entries)
                    if (currentEntry.key != entry.key ||
                        currentEntry.value.length > 1)
                      currentEntry.key: [
                        for (final (currentIndex, current)
                            in currentEntry.value.indexed)
                          if (currentEntry.key != entry.key ||
                              currentIndex != index)
                            current,
                      ],
                }),
              ),
          TextButton.icon(
            key: const Key('lpgm-region-add'),
            onPressed: () => notifier.setLpgmRegions({
              ...draft.lpgmRegions,
              draft.maxLpgmIntensity: [
                ...draft.lpgmRegions[draft.maxLpgmIntensity] ?? const [],
                earthquakeVxseDebugSampleLpgmRegion,
              ],
            }),
            icon: const Icon(Icons.add),
            label: const Text('地域を追加'),
          ),
          Text('地域階級・市区町村・観測点', style: Theme.of(context).textTheme.titleSmall),
          for (final entry in draft.lpgmIntensityTree.entries)
            for (final (prefectureIndex, prefecture)
                in entry.value.indexed) ...[
              _LpgmPrefectureRow(
                prefecture: prefecture,
                onChanged: (updated) => notifier.setLpgmIntensityTree({
                  for (final currentEntry in draft.lpgmIntensityTree.entries)
                    currentEntry.key: [
                      for (final (currentIndex, current)
                          in currentEntry.value.indexed)
                        currentEntry.key == entry.key &&
                                currentIndex == prefectureIndex
                            ? updated
                            : current,
                    ],
                }),
                onRemove: () => notifier.setLpgmIntensityTree({
                  for (final currentEntry in draft.lpgmIntensityTree.entries)
                    if (currentEntry.key != entry.key ||
                        currentEntry.value.length > 1)
                      currentEntry.key: [
                        for (final (currentIndex, current)
                            in currentEntry.value.indexed)
                          if (currentEntry.key != entry.key ||
                              currentIndex != prefectureIndex)
                            current,
                      ],
                }),
              ),
              for (final (cityIndex, city) in prefecture.cities.indexed) ...[
                _StationParentCityLocator(
                  currentCode: city.city.code,
                  currentName: city.city.name.ja,
                  onCodeChanged: (value) => notifier.setVxse62StationParentCity(
                    currentCode: city.city.code,
                    code: value,
                    name: city.city.name.ja,
                  ),
                  onNameChanged: (value) => notifier.setVxse62StationParentCity(
                    currentCode: city.city.code,
                    code: city.city.code,
                    name: value,
                  ),
                ),
                for (final (stationIndex, station) in city.stations.indexed)
                  _LpgmStationRow(
                    station: station,
                    onChanged: (updated) => notifier.setLpgmIntensityTree({
                      for (final currentEntry
                          in draft.lpgmIntensityTree.entries)
                        currentEntry.key: [
                          for (final (currentPrefectureIndex, currentPrefecture)
                              in currentEntry.value.indexed)
                            currentEntry.key == entry.key &&
                                    currentPrefectureIndex == prefectureIndex
                                ? currentPrefecture.copyWith(
                                    cities: [
                                      for (final (currentCityIndex, currentCity)
                                          in currentPrefecture.cities.indexed)
                                        currentCityIndex == cityIndex
                                            ? currentCity.copyWith(
                                                stations: [
                                                  for (final (
                                                        currentStationIndex,
                                                        currentStation,
                                                      )
                                                      in currentCity
                                                          .stations
                                                          .indexed)
                                                    currentStationIndex ==
                                                            stationIndex
                                                        ? updated
                                                        : currentStation,
                                                ],
                                              )
                                            : currentCity,
                                    ],
                                  )
                                : currentPrefecture,
                        ],
                    }),
                    onRemove: () => notifier.setLpgmIntensityTree({
                      for (final currentEntry
                          in draft.lpgmIntensityTree.entries)
                        currentEntry.key: [
                          for (final (currentPrefectureIndex, currentPrefecture)
                              in currentEntry.value.indexed)
                            currentEntry.key == entry.key &&
                                    currentPrefectureIndex == prefectureIndex
                                ? currentPrefecture.copyWith(
                                    cities: [
                                      for (final (currentCityIndex, currentCity)
                                          in currentPrefecture.cities.indexed)
                                        currentCityIndex == cityIndex
                                            ? currentCity.copyWith(
                                                stations: [
                                                  for (final (
                                                        currentStationIndex,
                                                        currentStation,
                                                      )
                                                      in currentCity
                                                          .stations
                                                          .indexed)
                                                    if (currentStationIndex !=
                                                        stationIndex)
                                                      currentStation,
                                                ],
                                              )
                                            : currentCity,
                                    ],
                                  )
                                : currentPrefecture,
                        ],
                    }),
                  ),
              ],
            ],
          Wrap(
            spacing: 8,
            children: [
              TextButton.icon(
                key: const Key('lpgm-prefecture-add'),
                onPressed: () => notifier.setLpgmIntensityTree({
                  ...draft.lpgmIntensityTree,
                  draft.maxLpgmIntensity: [
                    ...draft.lpgmIntensityTree[draft.maxLpgmIntensity] ??
                        const [],
                    const PrefectureLpgmIntensityNode(
                      region: earthquakeVxseDebugSampleRegion,
                      maxLpgmIntensity:
                          earthquakeVxseDebugSampleMaxLpgmIntensity,
                      cities: [],
                    ),
                  ],
                }),
                icon: const Icon(Icons.add),
                label: const Text('地域階級'),
              ),
              TextButton.icon(
                key: const Key('lpgm-station-add'),
                onPressed: () {
                  final values =
                      draft.lpgmIntensityTree[draft.maxLpgmIntensity] ??
                      const [];
                  final base = values.isEmpty
                      ? const PrefectureLpgmIntensityNode(
                          region: earthquakeVxseDebugSampleRegion,
                          maxLpgmIntensity:
                              earthquakeVxseDebugSampleMaxLpgmIntensity,
                          cities: [],
                        )
                      : values.first;
                  final cities = base.cities;
                  final city = cities.isEmpty
                      ? const CityLpgmIntensityNode(
                          city: earthquakeVxseDebugSampleCity,
                          maxLpgmIntensity:
                              earthquakeVxseDebugSampleMaxLpgmIntensity,
                          stations: [],
                        )
                      : cities.first;
                  notifier.setLpgmIntensityTree({
                    ...draft.lpgmIntensityTree,
                    draft.maxLpgmIntensity: [
                      base.copyWith(
                        cities: [
                          city.copyWith(
                            stations: [
                              ...city.stations,
                              const StationLpgmIntensityNode(
                                station: earthquakeVxseDebugSampleStation,
                                intensity:
                                    earthquakeVxseDebugSampleStationIntensity,
                              ),
                            ],
                          ),
                          ...cities.skip(1),
                        ],
                      ),
                      ...values.skip(1),
                    ],
                  });
                },
                icon: const Icon(Icons.add),
                label: const Text('観測点'),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class _CommentsFields extends StatelessWidget {
  const _CommentsFields({
    required this.selectedType,
    required this.draft,
    required this.notifier,
  });

  final EarthquakeTelegramType selectedType;
  final EarthquakeVxseDebugDraft draft;
  final EarthquakeVxseDebugEditorController notifier;

  @override
  Widget build(BuildContext context) => Card.outlined(
    key: const Key('comments-fields'),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('コメント', style: Theme.of(context).textTheme.titleMedium),
          for (final (index, comment) in draft.comments.indexed)
            _CommentRow(
              comment: comment,
              onChanged: (updated) => notifier.setComments([
                for (final (currentIndex, current) in draft.comments.indexed)
                  currentIndex == index ? updated : current,
              ]),
              onRemove: () => notifier.setComments([
                for (final (currentIndex, current) in draft.comments.indexed)
                  if (currentIndex != index) current,
              ]),
            ),
          TextButton.icon(
            onPressed: () => notifier.setComments([
              ...draft.comments,
              EarthquakeTelegramComment(
                type: selectedType,
                reportedAt: draft.reportedAt,
                additional: '',
                free: '',
              ),
            ]),
            icon: const Icon(Icons.add),
            label: const Text('コメントを追加'),
          ),
        ],
      ),
    ),
  );
}

class _JsonEditor extends HookWidget {
  const _JsonEditor({required this.state, required this.notifier});

  final EarthquakeVxseDebugEditorState state;
  final EarthquakeVxseDebugEditorController notifier;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: state.jsonText);
    useEffect(() {
      if (controller.text != state.jsonText) {
        controller.value = controller.value.copyWith(
          text: state.jsonText,
          selection: TextSelection.collapsed(offset: state.jsonText.length),
          composing: TextRange.empty,
        );
      }
      return null;
    }, [state.jsonText]);

    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('JSON', style: Theme.of(context).textTheme.titleMedium),
            TextField(
              key: const Key('vxse-json-field'),
              controller: controller,
              minLines: 6,
              maxLines: null,
              autocorrect: false,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontFamily: 'monospace'),
              decoration: InputDecoration(errorText: state.validationError),
              onChanged: notifier.validateJson,
            ),
          ],
        ),
      ),
    );
  }
}

class _OrdinaryRegionRow extends StatelessWidget {
  const _OrdinaryRegionRow({
    required this.level,
    required this.region,
    required this.onChanged,
    required this.onRemove,
  });

  final JmaIntensity level;
  final IntensityRegion region;
  final ValueChanged<IntensityRegion> onChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) => Card(
    key: const Key('ordinary-region-row'),
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox(
            width: 110,
            child: TextFormField(
              key: const Key('ordinary-region-code'),
              initialValue: region.region.code,
              decoration: const InputDecoration(labelText: '地域コード'),
              onChanged: (value) => onChanged(
                region.copyWith(region: region.region.copyWith(code: value)),
              ),
            ),
          ),
          SizedBox(
            width: 180,
            child: TextFormField(
              initialValue: region.region.name.ja,
              decoration: const InputDecoration(labelText: '地域名'),
              onChanged: (value) => onChanged(
                region.copyWith(
                  region: region.region.copyWith(
                    name: region.region.name.copyWith(ja: value),
                  ),
                ),
              ),
            ),
          ),
          DropdownButton<JmaIntensity>(
            value: region.maxIntensity ?? level,
            items: JmaIntensity.values
                .map(
                  (value) =>
                      DropdownMenuItem(value: value, child: Text(value.label)),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                onChanged(region.copyWith(maxIntensity: value));
              }
            },
          ),
          IconButton(
            key: const Key('ordinary-region-remove'),
            onPressed: onRemove,
            tooltip: '地域を削除',
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
    ),
  );
}

class _OrdinaryPrefectureRow extends StatelessWidget {
  const _OrdinaryPrefectureRow({
    required this.prefecture,
    required this.onChanged,
    required this.onRemove,
  });

  final IntensityPrefecture prefecture;
  final ValueChanged<IntensityPrefecture> onChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) => Card(
    key: const Key('ordinary-prefecture-row'),
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox(
            width: 100,
            child: TextFormField(
              initialValue: prefecture.prefecture.code,
              decoration: const InputDecoration(labelText: '都道府県コード'),
              onChanged: (value) => onChanged(
                prefecture.copyWith(
                  prefecture: prefecture.prefecture.copyWith(code: value),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 180,
            child: TextFormField(
              initialValue: prefecture.prefecture.name.ja,
              decoration: const InputDecoration(labelText: '都道府県名'),
              onChanged: (value) => onChanged(
                prefecture.copyWith(
                  prefecture: prefecture.prefecture.copyWith(
                    name: prefecture.prefecture.name.copyWith(ja: value),
                  ),
                ),
              ),
            ),
          ),
          DropdownButton<JmaIntensity?>(
            value: prefecture.maxIntensity,
            items: JmaIntensity.values
                .map(
                  (value) => DropdownMenuItem<JmaIntensity?>(
                    value: value,
                    child: Text(value.label),
                  ),
                )
                .toList(),
            onChanged: (value) =>
                onChanged(prefecture.copyWith(maxIntensity: value)),
          ),
          IconButton(
            key: const Key('ordinary-prefecture-remove'),
            onPressed: onRemove,
            tooltip: '都道府県を削除',
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
    ),
  );
}

class _OrdinaryCityRow extends StatelessWidget {
  const _OrdinaryCityRow({
    required this.city,
    required this.onChanged,
    required this.onRemove,
  });

  final CityIntensityNode city;
  final ValueChanged<CityIntensityNode> onChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(left: 16),
    child: Card(
      key: const Key('ordinary-city-row'),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SizedBox(
              width: 120,
              child: TextFormField(
                initialValue: city.city.code,
                decoration: const InputDecoration(labelText: '市区町村コード'),
                onChanged: (value) => onChanged(
                  city.copyWith(city: city.city.copyWith(code: value)),
                ),
              ),
            ),
            SizedBox(
              width: 180,
              child: TextFormField(
                initialValue: city.city.name.ja,
                decoration: const InputDecoration(labelText: '市区町村名'),
                onChanged: (value) => onChanged(
                  city.copyWith(
                    city: city.city.copyWith(
                      name: city.city.name.copyWith(ja: value),
                    ),
                  ),
                ),
              ),
            ),
            DropdownButton<JmaIntensity?>(
              value: city.maxIntensity,
              items: JmaIntensity.values
                  .map(
                    (value) => DropdownMenuItem<JmaIntensity?>(
                      value: value,
                      child: Text(value.label),
                    ),
                  )
                  .toList(),
              onChanged: (value) =>
                  onChanged(city.copyWith(maxIntensity: value)),
            ),
            IconButton(
              key: const Key('ordinary-city-remove'),
              onPressed: onRemove,
              tooltip: '市区町村を削除',
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ),
      ),
    ),
  );
}

class _StationParentCityLocator extends StatelessWidget {
  const _StationParentCityLocator({
    required this.currentCode,
    required this.currentName,
    required this.onCodeChanged,
    required this.onNameChanged,
  });

  final String currentCode;
  final String currentName;
  final ValueChanged<String> onCodeChanged;
  final ValueChanged<String> onNameChanged;

  @override
  Widget build(BuildContext context) => Padding(
    key: const Key('station-parent-city-locator'),
    padding: const EdgeInsets.only(left: 16),
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            SizedBox(
              width: 120,
              child: TextFormField(
                key: const Key('station-parent-city-code'),
                initialValue: currentCode,
                decoration: const InputDecoration(labelText: '親市区町村コード'),
                onChanged: onCodeChanged,
              ),
            ),
            SizedBox(
              width: 180,
              child: TextFormField(
                key: const Key('station-parent-city-name'),
                initialValue: currentName,
                decoration: const InputDecoration(labelText: '親市区町村名'),
                onChanged: onNameChanged,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _OrdinaryStationRow extends StatelessWidget {
  const _OrdinaryStationRow({
    required this.station,
    required this.onChanged,
    required this.onRemove,
  });

  final StationIntensityNode station;
  final ValueChanged<StationIntensityNode> onChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final intensity =
        station.intensity ?? earthquakeVxseDebugSampleStationIntensity;
    return Padding(
      padding: const EdgeInsets.only(left: 32),
      child: Card(
        key: const Key('ordinary-station-row'),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              SizedBox(
                width: 120,
                child: TextFormField(
                  initialValue: station.station.code,
                  decoration: const InputDecoration(labelText: '観測点コード'),
                  onChanged: (value) => onChanged(
                    station.copyWith(
                      station: station.station.copyWith(code: value),
                      intensity: intensity.copyWith(code: value),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 180,
                child: TextFormField(
                  initialValue: station.station.name.ja,
                  decoration: const InputDecoration(labelText: '観測点名'),
                  onChanged: (value) => onChanged(
                    station.copyWith(
                      station: station.station.copyWith(
                        name: station.station.name.copyWith(ja: value),
                      ),
                      intensity: intensity.copyWith(name: value),
                    ),
                  ),
                ),
              ),
              DropdownButton<JmaIntensity?>(
                value: intensity.maxIntensity,
                items: JmaIntensity.values
                    .map(
                      (value) => DropdownMenuItem<JmaIntensity?>(
                        value: value,
                        child: Text(value.label),
                      ),
                    )
                    .toList(),
                onChanged: (value) => onChanged(
                  station.copyWith(
                    intensity: intensity.copyWith(maxIntensity: value),
                  ),
                ),
              ),
              IconButton(
                key: const Key('ordinary-station-remove'),
                onPressed: onRemove,
                tooltip: '観測点を削除',
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LpgmRegionRow extends StatelessWidget {
  const _LpgmRegionRow({
    required this.region,
    required this.onChanged,
    required this.onRemove,
  });

  final LpgmIntensityRegion region;
  final ValueChanged<LpgmIntensityRegion> onChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) => Card(
    key: const Key('lpgm-region-row'),
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox(
            width: 120,
            child: TextFormField(
              initialValue: region.region.code,
              decoration: const InputDecoration(labelText: '地域コード'),
              onChanged: (value) => onChanged(
                region.copyWith(region: region.region.copyWith(code: value)),
              ),
            ),
          ),
          SizedBox(
            width: 180,
            child: TextFormField(
              initialValue: region.region.name.ja,
              decoration: const InputDecoration(labelText: '地域名'),
              onChanged: (value) => onChanged(
                region.copyWith(
                  region: region.region.copyWith(
                    name: region.region.name.copyWith(ja: value),
                  ),
                ),
              ),
            ),
          ),
          DropdownButton<JmaLpgmIntensity?>(
            value: region.maxLpgmIntensity,
            items: JmaLpgmIntensity.values
                .map(
                  (value) => DropdownMenuItem<JmaLpgmIntensity?>(
                    value: value,
                    child: Text(value.label),
                  ),
                )
                .toList(),
            onChanged: (value) =>
                onChanged(region.copyWith(maxLpgmIntensity: value)),
          ),
          IconButton(
            key: const Key('lpgm-region-remove'),
            onPressed: onRemove,
            tooltip: '地域を削除',
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
    ),
  );
}

class _LpgmPrefectureRow extends StatelessWidget {
  const _LpgmPrefectureRow({
    required this.prefecture,
    required this.onChanged,
    required this.onRemove,
  });

  final PrefectureLpgmIntensityNode prefecture;
  final ValueChanged<PrefectureLpgmIntensityNode> onChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) => Card(
    key: const Key('lpgm-prefecture-row'),
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox(
            width: 120,
            child: TextFormField(
              initialValue: prefecture.region.code,
              decoration: const InputDecoration(labelText: '地域コード'),
              onChanged: (value) => onChanged(
                prefecture.copyWith(
                  region: prefecture.region.copyWith(code: value),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 180,
            child: TextFormField(
              initialValue: prefecture.region.name.ja,
              decoration: const InputDecoration(labelText: '地域名'),
              onChanged: (value) => onChanged(
                prefecture.copyWith(
                  region: prefecture.region.copyWith(
                    name: prefecture.region.name.copyWith(ja: value),
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            key: const Key('lpgm-prefecture-remove'),
            onPressed: onRemove,
            tooltip: '地域階級を削除',
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
    ),
  );
}

class _LpgmStationRow extends StatelessWidget {
  const _LpgmStationRow({
    required this.station,
    required this.onChanged,
    required this.onRemove,
  });

  final StationLpgmIntensityNode station;
  final ValueChanged<StationLpgmIntensityNode> onChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final intensity =
        station.intensity ?? earthquakeVxseDebugSampleStationIntensity;
    return Padding(
      padding: const EdgeInsets.only(left: 32),
      child: Card(
        key: const Key('lpgm-station-row'),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              SizedBox(
                width: 120,
                child: TextFormField(
                  initialValue: station.station.code,
                  decoration: const InputDecoration(labelText: '観測点コード'),
                  onChanged: (value) => onChanged(
                    station.copyWith(
                      station: station.station.copyWith(code: value),
                      intensity: intensity.copyWith(code: value),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 180,
                child: TextFormField(
                  initialValue: station.station.name.ja,
                  decoration: const InputDecoration(labelText: '観測点名'),
                  onChanged: (value) => onChanged(
                    station.copyWith(
                      station: station.station.copyWith(
                        name: station.station.name.copyWith(ja: value),
                      ),
                      intensity: intensity.copyWith(name: value),
                    ),
                  ),
                ),
              ),
              DropdownButton<JmaLpgmIntensity?>(
                value: intensity.maxLpgmIntensity,
                items: JmaLpgmIntensity.values
                    .map(
                      (value) => DropdownMenuItem<JmaLpgmIntensity?>(
                        value: value,
                        child: Text(value.label),
                      ),
                    )
                    .toList(),
                onChanged: (value) => onChanged(
                  station.copyWith(
                    intensity: intensity.copyWith(maxLpgmIntensity: value),
                  ),
                ),
              ),
              IconButton(
                key: const Key('lpgm-station-remove'),
                onPressed: onRemove,
                tooltip: '観測点を削除',
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CommentRow extends StatelessWidget {
  const _CommentRow({
    required this.comment,
    required this.onChanged,
    required this.onRemove,
  });

  final EarthquakeTelegramComment comment;
  final ValueChanged<EarthquakeTelegramComment> onChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) => Card(
    key: const Key('comment-row'),
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          TextFormField(
            initialValue: comment.additional ?? '',
            decoration: const InputDecoration(labelText: '固定付加文'),
            maxLines: null,
            onChanged: (value) =>
                onChanged(comment.copyWith(additional: value)),
          ),
          TextFormField(
            initialValue: comment.free ?? '',
            decoration: const InputDecoration(labelText: '自由付加文'),
            maxLines: null,
            onChanged: (value) => onChanged(comment.copyWith(free: value)),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: onRemove,
              tooltip: 'コメントを削除',
              icon: const Icon(Icons.delete_outline),
            ),
          ),
        ],
      ),
    ),
  );
}
