import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/core/util/date_time_format.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_apply_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_draft.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_draft_factory.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_draft_identity_generator.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_draft_level_mover.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_comment.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_station.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/lpgm_intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_vxse_debug_editor_controller.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/action/earthquake_vxse_debug_action.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/modal/earthquake_vxse_debug_editor_semantic_key.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const _semanticKey = EarthquakeVxseDebugEditorSemanticKey();

class EarthquakeVxseDebugEditor extends HookConsumerWidget {
  const new({required this.current, super.key});

  final Earthquake current;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = earthquakeVxseDebugEditorControllerProvider(
      EarthquakeVxseDebugEditorSession(current: current),
    );
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);
    useEffect(() {
      notifier.updateCurrent(current);
      return null;
    }, [notifier, current]);
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
  const new({required this.state, required this.notifier});

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
          _ControlledDropdown<EarthquakeTelegramType>(
            key: const Key('vxse-type-dropdown'),
            value: state.selectedType,
            label: '電文種類',
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
          _ControlledDropdown<EarthquakeVxseApplyMode>(
            value: state.applyMode,
            label: '適用方法',
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
          _ControlledTextFormField(
            fieldKey: const Key('reported-at-field'),
            fieldId: 'reportedAt',
            value: state.draft.reportedAt.tokyoDateTime.toIso8601String(),
            label: '発表時刻 (ISO 8601)',
            notifier: notifier,
            validation: (value) =>
                DateTime.tryParse(value) == null ? '日時を入力してください' : null,
            onValidChanged: (value) =>
                notifier.setReportedAt(DateTime.parse(value)),
          ),
          const SizedBox(height: 8),
          _ControlledDropdown<TelegramStatus>(
            value: state.draft.status,
            label: 'ステータス',
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
  const new({required this.draft, required this.notifier});

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
    final coordinateType = switch (hypocenter.coordinates) {
      null => _CoordinateEditorType.none,
      CoordinateUnknown() => _CoordinateEditorType.unknown,
      CoordinateLatLng() => _CoordinateEditorType.latLng,
    };
    final latitude = switch (hypocenter.coordinates) {
      CoordinateLatLng(:final latitude) => latitude,
      _ => 35.5,
    };
    final longitude = switch (hypocenter.coordinates) {
      CoordinateLatLng(:final longitude) => longitude,
      _ => 139.8,
    };
    final magnitudeType = switch (hypocenter.magnitude) {
      EarthquakeMagnitudeValue() => _MagnitudeEditorType.value,
      EarthquakeMagnitudeUnknown() => _MagnitudeEditorType.unknown,
      EarthquakeMagnitudeOverM8() => _MagnitudeEditorType.overM8,
    };
    final magnitude = switch (hypocenter.magnitude) {
      EarthquakeMagnitudeValue(:final value) => value,
      _ => 5.0,
    };
    final depthType = switch (hypocenter.depth) {
      EarthquakeDepthShallow() => _DepthEditorType.shallow,
      EarthquakeDepthValue() => _DepthEditorType.value,
      EarthquakeDepthOver700km() => _DepthEditorType.over700km,
      EarthquakeDepthUnknown() => _DepthEditorType.unknown,
    };
    final depth = switch (hypocenter.depth) {
      EarthquakeDepthValue(:final value) => value,
      _ => 40,
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
            _ControlledTextFormField(
              fieldId: 'arrivalTime',
              value: arrivalTime?.tokyoDateTime.toIso8601String() ?? '',
              label: '検知時刻',
              notifier: notifier,
              validation: (value) =>
                  value.isNotEmpty && DateTime.tryParse(value) == null
                  ? '日時を入力してください'
                  : null,
              onValidChanged: (value) => notifier.setArrivalTime(
                value.isEmpty ? null : DateTime.parse(value),
              ),
            ),
            const SizedBox(height: 8),
            _ControlledTextFormField(
              fieldId: 'originTime',
              value: originTime?.tokyoDateTime.toIso8601String() ?? '',
              label: '発生時刻',
              notifier: notifier,
              validation: (value) =>
                  value.isNotEmpty && DateTime.tryParse(value) == null
                  ? '日時を入力してください'
                  : null,
              onValidChanged: (value) => notifier.setOriginTime(
                value.isEmpty ? null : DateTime.parse(value),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                SizedBox(
                  width: 140,
                  child: _ControlledTextFormField(
                    fieldId: 'hypocenter.code',
                    value: hypocenter.code ?? '',
                    label: '震央コード',
                    notifier: notifier,
                    onValidChanged: (value) => notifier.setHypocenter(
                      hypocenter.copyWith(code: value),
                    ),
                  ),
                ),
                SizedBox(
                  width: 220,
                  child: _ControlledTextFormField(
                    fieldId: 'hypocenter.name',
                    value: hypocenter.name ?? '',
                    label: '震央名',
                    notifier: notifier,
                    onValidChanged: (value) => notifier.setHypocenter(
                      hypocenter.copyWith(name: value),
                    ),
                  ),
                ),
                SizedBox(
                  width: 140,
                  child: _ControlledTextFormField(
                    fieldKey: const Key('hypocenter-detailed-code'),
                    fieldId: 'hypocenter.detailedCode',
                    value: hypocenter.detailedCode ?? '',
                    label: '詳細震央コード',
                    notifier: notifier,
                    onValidChanged: (value) => notifier.setHypocenter(
                      hypocenter.copyWith(detailedCode: value),
                    ),
                  ),
                ),
                SizedBox(
                  width: 140,
                  child: _ControlledTextFormField(
                    fieldId: 'hypocenter.detailedName',
                    value: hypocenter.detailedName ?? '',
                    label: '詳細震央名',
                    notifier: notifier,
                    onValidChanged: (value) => notifier.setHypocenter(
                      hypocenter.copyWith(detailedName: value),
                    ),
                  ),
                ),
                SizedBox(
                  width: 140,
                  child: _ControlledDropdown<_CoordinateEditorType>(
                    key: const Key('coordinate-type-dropdown'),
                    value: coordinateType,
                    label: '座標種別',
                    items: _CoordinateEditorType.values
                        .map(
                          (value) => DropdownMenuItem(
                            value: value,
                            child: Text(value.name),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        notifier.setHypocenter(
                          hypocenter.copyWith(
                            coordinates: switch (value) {
                              .none => null,
                              .unknown => const Coordinate.unknown(),
                              .latLng => Coordinate.latLng(
                                latitude: latitude,
                                longitude: longitude,
                              ),
                            },
                          ),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 140,
                  child: _ControlledDropdown<_MagnitudeEditorType>(
                    key: const Key('magnitude-type-dropdown'),
                    value: magnitudeType,
                    label: 'M種別',
                    items: _MagnitudeEditorType.values
                        .map(
                          (value) => DropdownMenuItem(
                            value: value,
                            child: Text(value.name),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        notifier.setHypocenter(
                          hypocenter.copyWith(
                            magnitude: switch (value) {
                              .value => EarthquakeMagnitude.value(
                                value: magnitude,
                              ),
                              .unknown => const EarthquakeMagnitude.unknown(),
                              .overM8 => const EarthquakeMagnitude.overM8(),
                            },
                          ),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 140,
                  child: _ControlledDropdown<_DepthEditorType>(
                    key: const Key('depth-type-dropdown'),
                    value: depthType,
                    label: '深さ種別',
                    items: _DepthEditorType.values
                        .map(
                          (value) => DropdownMenuItem(
                            value: value,
                            child: Text(value.name),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        notifier.setHypocenter(
                          hypocenter.copyWith(
                            depth: switch (value) {
                              .shallow => const EarthquakeDepth.shallow(),
                              .value => EarthquakeDepth.value(value: depth),
                              .over700km => const EarthquakeDepth.over700km(),
                              .unknown => const EarthquakeDepth.unknown(),
                            },
                          ),
                        );
                      }
                    },
                  ),
                ),
                if (coordinateType == _CoordinateEditorType.latLng) ...[
                  SizedBox(
                    width: 140,
                    child: _ControlledTextFormField(
                      fieldId: 'hypocenter.latitude',
                      value: latitude.toString(),
                      label: '緯度',
                      notifier: notifier,
                      keyboardType: TextInputType.number,
                      validation: (value) =>
                          double.tryParse(value) == null ? '数値を入力してください' : null,
                      onValidChanged: (value) => notifier.setHypocenter(
                        hypocenter.copyWith(
                          coordinates: Coordinate.latLng(
                            latitude: double.parse(value),
                            longitude: longitude,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 140,
                    child: _ControlledTextFormField(
                      fieldId: 'hypocenter.longitude',
                      value: longitude.toString(),
                      label: '経度',
                      notifier: notifier,
                      keyboardType: TextInputType.number,
                      validation: (value) =>
                          double.tryParse(value) == null ? '数値を入力してください' : null,
                      onValidChanged: (value) => notifier.setHypocenter(
                        hypocenter.copyWith(
                          coordinates: Coordinate.latLng(
                            latitude: latitude,
                            longitude: double.parse(value),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                if (magnitudeType == _MagnitudeEditorType.value)
                  SizedBox(
                    width: 140,
                    child: _ControlledTextFormField(
                      fieldId: 'hypocenter.magnitude',
                      value: magnitude.toString(),
                      label: 'マグニチュード',
                      notifier: notifier,
                      keyboardType: TextInputType.number,
                      validation: (value) =>
                          double.tryParse(value) == null ? '数値を入力してください' : null,
                      onValidChanged: (value) => notifier.setHypocenter(
                        hypocenter.copyWith(
                          magnitude: EarthquakeMagnitude.value(
                            value: double.parse(value),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (depthType == _DepthEditorType.value)
                  SizedBox(
                    width: 140,
                    child: _ControlledTextFormField(
                      fieldId: 'hypocenter.depth',
                      value: depth.toString(),
                      label: '深さ (km)',
                      notifier: notifier,
                      keyboardType: TextInputType.number,
                      validation: (value) =>
                          int.tryParse(value) == null ? '整数を入力してください' : null,
                      onValidChanged: (value) => notifier.setHypocenter(
                        hypocenter.copyWith(
                          depth: EarthquakeDepth.value(value: int.parse(value)),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            if (draft case EarthquakeVxse53DebugDraft(
              :final earthquakeType,
            )) ...[
              const SizedBox(height: 8),
              _ControlledDropdown<EarthquakeType>(
                value: earthquakeType,
                label: '地震種別',
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

enum _CoordinateEditorType { none, unknown, latLng }

enum _MagnitudeEditorType { value, unknown, overM8 }

enum _DepthEditorType { shallow, value, over700km, unknown }

class _SeismicIntensityFields extends StatelessWidget {
  const new({required this.draft, required this.notifier});

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
            _ControlledDropdown<JmaIntensity>(
              value: maxIntensity,
              label: '最大震度',
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
                  notifier: notifier,
                  fieldPrefix: _semanticKey.prefix('ordinaryRegion', [
                    entry.key.name,
                    region.region.code,
                    entry.value
                        .take(index)
                        .where(
                          (candidate) =>
                              candidate.region.code == region.region.code,
                        )
                        .length
                        .toString(),
                  ]),
                  level: entry.key,
                  region: region,
                  onChanged: (updated) {
                    final maxIntensity = updated.maxIntensity;
                    return notifier.setRegions(
                      maxIntensity != null && maxIntensity != entry.key
                          ? const EarthquakeVxseDebugDraftLevelMover()
                                .moveIntensityRegionLevel(
                                  source: regions,
                                  from: entry.key,
                                  index: index,
                                  to: maxIntensity,
                                )
                          : {
                              for (final currentEntry in regions.entries)
                                currentEntry.key: [
                                  for (final (currentIndex, current)
                                      in currentEntry.value.indexed)
                                    currentEntry.key == entry.key &&
                                            currentIndex == index
                                        ? updated
                                        : current,
                                ],
                            },
                    );
                  },
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
                onPressed: () {
                  final code = const EarthquakeVxseDebugDraftIdentityGenerator()
                      .nextCode(
                        prefix: 'debug-region',
                        usedCodes: regions.values
                            .expand((nodes) => nodes)
                            .map((node) => node.region.code)
                            .toSet(),
                      );
                  notifier.setRegions({
                    ...regions,
                    maxIntensity: [
                      ...regions[maxIntensity] ?? const [],
                      earthquakeVxseDebugSampleIntensityRegion.copyWith(
                        region: earthquakeVxseDebugSampleIntensityRegion.region
                            .copyWith(code: code),
                      ),
                    ],
                  });
                },
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
                ownsStationDetails: draft is EarthquakeVxse62DebugDraft,
                notifier: notifier,
              ),
          ],
        ),
      ),
    );
  }
}

class _Vxse51PrefectureFields extends StatelessWidget {
  const new({
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
            notifier: notifier,
            fieldPrefix: _semanticKey.prefix('vxse51Prefecture', [
              entry.key.name,
              prefecture.prefecture.code,
              entry.value
                  .take(index)
                  .where(
                    (candidate) =>
                        candidate.prefecture.code == prefecture.prefecture.code,
                  )
                  .length
                  .toString(),
            ]),
            level: entry.key,
            prefecture: prefecture,
            onChanged: (updated) {
              final maxIntensity = updated.maxIntensity;
              return notifier.setPrefectures(
                maxIntensity != null && maxIntensity != entry.key
                    ? const EarthquakeVxseDebugDraftLevelMover()
                          .moveIntensityPrefectureLevel(
                            source: prefectures,
                            from: entry.key,
                            index: index,
                            to: maxIntensity,
                          )
                    : {
                        for (final currentEntry in prefectures.entries)
                          currentEntry.key: [
                            for (final (currentIndex, current)
                                in currentEntry.value.indexed)
                              currentEntry.key == entry.key &&
                                      currentIndex == index
                                  ? updated
                                  : current,
                          ],
                      },
              );
            },
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
          onPressed: () {
            final code = const EarthquakeVxseDebugDraftIdentityGenerator()
                .nextCode(
                  prefix: 'debug-prefecture',
                  usedCodes: prefectures.values
                      .expand((nodes) => nodes)
                      .map((node) => node.prefecture.code)
                      .toSet(),
                );
            notifier.setPrefectures({
              ...prefectures,
              maxIntensity: [
                ...prefectures[maxIntensity] ?? const [],
                earthquakeVxseDebugSampleIntensityPrefecture.copyWith(
                  prefecture: earthquakeVxseDebugSampleIntensityPrefecture
                      .prefecture
                      .copyWith(code: code),
                ),
              ],
            });
          },
          icon: const Icon(Icons.add),
          label: const Text('都道府県を追加'),
        ),
      ),
    ],
  );
}

class _OrdinaryTreeFields extends StatelessWidget {
  const new({
    required this.tree,
    required this.maxIntensity,
    required this.ownsCities,
    required this.ownsStationDetails,
    required this.notifier,
  });

  final Map<JmaIntensity, List<PrefectureIntensityNode>> tree;
  final JmaIntensity maxIntensity;
  final bool ownsCities;
  final bool ownsStationDetails;
  final EarthquakeVxseDebugEditorController notifier;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text('都道府県・市区町村・観測点', style: Theme.of(context).textTheme.titleSmall),
      for (final entry in tree.entries)
        for (final (prefectureIndex, prefecture) in entry.value.indexed) ...[
          _OrdinaryPrefectureRow(
            notifier: notifier,
            fieldPrefix: _semanticKey.prefix('ordinaryPrefecture', [
              entry.key.name,
              prefecture.prefecture.prefecture.code,
              entry.value
                  .take(prefectureIndex)
                  .where(
                    (candidate) =>
                        candidate.prefecture.prefecture.code ==
                        prefecture.prefecture.prefecture.code,
                  )
                  .length
                  .toString(),
            ]),
            level: entry.key,
            prefecture: prefecture.prefecture,
            onChanged: (updated) {
              final maxIntensity = updated.maxIntensity;
              return notifier.setIntensityTree(
                maxIntensity != null && maxIntensity != entry.key
                    ? const EarthquakeVxseDebugDraftLevelMover()
                          .moveIntensityTreePrefectureLevel(
                            source: tree,
                            from: entry.key,
                            index: prefectureIndex,
                            to: maxIntensity,
                          )
                    : {
                        for (final currentEntry in tree.entries)
                          currentEntry.key: [
                            for (final (currentIndex, current)
                                in currentEntry.value.indexed)
                              currentEntry.key == entry.key &&
                                      currentIndex == prefectureIndex
                                  ? current.copyWith(prefecture: updated)
                                  : current,
                          ],
                      },
              );
            },
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
                notifier: notifier,
                fieldPrefix: _semanticKey.prefix('ordinaryCity', [
                  entry.key.name,
                  prefecture.prefecture.prefecture.code,
                  city.city.code,
                  prefecture.cities
                      .take(cityIndex)
                      .where(
                        (candidate) => candidate.city.code == city.city.code,
                      )
                      .length
                      .toString(),
                ]),
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
                notifier: notifier,
                fieldPrefix: _semanticKey.prefix('ordinaryStation', [
                  entry.key.name,
                  prefecture.prefecture.prefecture.code,
                  city.city.code,
                  station.station.code,
                  city.stations
                      .take(stationIndex)
                      .where(
                        (candidate) =>
                            candidate.station.code == station.station.code,
                      )
                      .length
                      .toString(),
                ]),
                ownsStationDetails: ownsStationDetails,
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
                notifier: notifier,
                fieldPrefix: _semanticKey.prefix('ordinaryParentCity', [
                  entry.key.name,
                  prefecture.prefecture.prefecture.code,
                  city.city.code,
                  prefecture.cities
                      .take(cityIndex)
                      .where(
                        (candidate) => candidate.city.code == city.city.code,
                      )
                      .length
                      .toString(),
                ]),
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
            onPressed: () {
              final code = const EarthquakeVxseDebugDraftIdentityGenerator()
                  .nextCode(
                    prefix: 'debug-prefecture',
                    usedCodes: tree.values
                        .expand((nodes) => nodes)
                        .map((node) => node.prefecture.prefecture.code)
                        .toSet(),
                  );
              notifier.setIntensityTree({
                ...tree,
                maxIntensity: [
                  ...tree[maxIntensity] ?? const [],
                  PrefectureIntensityNode(
                    prefecture: earthquakeVxseDebugSampleIntensityPrefecture
                        .copyWith(
                          prefecture:
                              earthquakeVxseDebugSampleIntensityPrefecture
                                  .prefecture
                                  .copyWith(code: code),
                        ),
                    cities: const [],
                  ),
                ],
              });
            },
            icon: const Icon(Icons.add),
            label: const Text('都道府県'),
          ),
          if (ownsCities)
            TextButton.icon(
              key: const Key('ordinary-city-add'),
              onPressed: () {
                final values = tree[maxIntensity] ?? const [];
                final code = const EarthquakeVxseDebugDraftIdentityGenerator()
                    .nextCode(
                      prefix: 'debug-city',
                      usedCodes: tree.values
                          .expand((nodes) => nodes)
                          .expand((node) => node.cities)
                          .map((node) => node.city.code)
                          .toSet(),
                    );
                final addedCity = CityIntensityNode(
                  city: earthquakeVxseDebugSampleCity.copyWith(code: code),
                  maxIntensity: earthquakeVxseDebugSampleMaxIntensity,
                  stations: const [],
                );
                notifier.setIntensityTree({
                  ...tree,
                  maxIntensity: values.isEmpty
                      ? [
                          PrefectureIntensityNode(
                            prefecture:
                                earthquakeVxseDebugSampleIntensityPrefecture,
                            cities: [addedCity],
                          ),
                        ]
                      : [
                          values.first.copyWith(
                            cities: [...values.first.cities, addedCity],
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
              final stationCode =
                  const EarthquakeVxseDebugDraftIdentityGenerator().nextCode(
                    prefix: 'debug-station',
                    usedCodes: tree.values
                        .expand((nodes) => nodes)
                        .expand((node) => node.cities)
                        .expand((node) => node.stations)
                        .map((node) => node.station.code)
                        .toSet(),
                  );
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
                          StationIntensityNode(
                            station: earthquakeVxseDebugSampleStation.copyWith(
                              code: stationCode,
                            ),
                            intensity: earthquakeVxseDebugSampleStationIntensity
                                .copyWith(code: stationCode),
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
  const new({required this.draft, required this.notifier});

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
          _ControlledDropdown<JmaLpgmIntensity>(
            value: draft.maxLpgmIntensity,
            label: '最大長周期地震動階級',
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
                notifier: notifier,
                fieldPrefix: _semanticKey.prefix('lpgmRegion', [
                  entry.key.name,
                  region.region.code,
                  entry.value
                      .take(index)
                      .where(
                        (candidate) =>
                            candidate.region.code == region.region.code,
                      )
                      .length
                      .toString(),
                ]),
                level: entry.key,
                region: region,
                onChanged: (updated) {
                  final maxLpgmIntensity = updated.maxLpgmIntensity;
                  return notifier.setLpgmRegions(
                    maxLpgmIntensity != null && maxLpgmIntensity != entry.key
                        ? const EarthquakeVxseDebugDraftLevelMover()
                              .moveLpgmRegionLevel(
                                source: draft.lpgmRegions,
                                from: entry.key,
                                index: index,
                                to: maxLpgmIntensity,
                              )
                        : {
                            for (final currentEntry
                                in draft.lpgmRegions.entries)
                              currentEntry.key: [
                                for (final (currentIndex, current)
                                    in currentEntry.value.indexed)
                                  currentEntry.key == entry.key &&
                                          currentIndex == index
                                      ? updated
                                      : current,
                              ],
                          },
                  );
                },
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
            onPressed: () {
              final code = const EarthquakeVxseDebugDraftIdentityGenerator()
                  .nextCode(
                    prefix: 'debug-lpgm-region',
                    usedCodes: draft.lpgmRegions.values
                        .expand((nodes) => nodes)
                        .map((node) => node.region.code)
                        .toSet(),
                  );
              notifier.setLpgmRegions({
                ...draft.lpgmRegions,
                draft.maxLpgmIntensity: [
                  ...draft.lpgmRegions[draft.maxLpgmIntensity] ?? const [],
                  earthquakeVxseDebugSampleLpgmRegion.copyWith(
                    region: earthquakeVxseDebugSampleLpgmRegion.region.copyWith(
                      code: code,
                    ),
                  ),
                ],
              });
            },
            icon: const Icon(Icons.add),
            label: const Text('地域を追加'),
          ),
          Text('地域階級・市区町村・観測点', style: Theme.of(context).textTheme.titleSmall),
          for (final entry in draft.lpgmIntensityTree.entries)
            for (final (prefectureIndex, prefecture)
                in entry.value.indexed) ...[
              _LpgmPrefectureRow(
                notifier: notifier,
                fieldPrefix: _semanticKey.prefix('lpgmPrefecture', [
                  entry.key.name,
                  prefecture.region.code,
                  entry.value
                      .take(prefectureIndex)
                      .where(
                        (candidate) =>
                            candidate.region.code == prefecture.region.code,
                      )
                      .length
                      .toString(),
                ]),
                level: entry.key,
                prefecture: prefecture,
                onChanged: (updated) {
                  final maxLpgmIntensity = updated.maxLpgmIntensity;
                  return notifier.setLpgmIntensityTree(
                    maxLpgmIntensity != null && maxLpgmIntensity != entry.key
                        ? const EarthquakeVxseDebugDraftLevelMover()
                              .moveLpgmPrefectureLevel(
                                source: draft.lpgmIntensityTree,
                                from: entry.key,
                                index: prefectureIndex,
                                to: maxLpgmIntensity,
                              )
                        : {
                            for (final currentEntry
                                in draft.lpgmIntensityTree.entries)
                              currentEntry.key: [
                                for (final (currentIndex, current)
                                    in currentEntry.value.indexed)
                                  currentEntry.key == entry.key &&
                                          currentIndex == prefectureIndex
                                      ? updated
                                      : current,
                              ],
                          },
                  );
                },
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
                  notifier: notifier,
                  fieldPrefix: _semanticKey.prefix('lpgmParentCity', [
                    entry.key.name,
                    prefecture.region.code,
                    city.city.code,
                    prefecture.cities
                        .take(cityIndex)
                        .where(
                          (candidate) => candidate.city.code == city.city.code,
                        )
                        .length
                        .toString(),
                  ]),
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
                    notifier: notifier,
                    fieldPrefix: _semanticKey.prefix('lpgmStation', [
                      entry.key.name,
                      prefecture.region.code,
                      city.city.code,
                      station.station.code,
                      city.stations
                          .take(stationIndex)
                          .where(
                            (candidate) =>
                                candidate.station.code == station.station.code,
                          )
                          .length
                          .toString(),
                    ]),
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
                onPressed: () {
                  final code = const EarthquakeVxseDebugDraftIdentityGenerator()
                      .nextCode(
                        prefix: 'debug-lpgm-prefecture',
                        usedCodes: draft.lpgmIntensityTree.values
                            .expand((nodes) => nodes)
                            .map((node) => node.region.code)
                            .toSet(),
                      );
                  notifier.setLpgmIntensityTree({
                    ...draft.lpgmIntensityTree,
                    draft.maxLpgmIntensity: [
                      ...draft.lpgmIntensityTree[draft.maxLpgmIntensity] ??
                          const [],
                      PrefectureLpgmIntensityNode(
                        region: earthquakeVxseDebugSampleRegion.copyWith(
                          code: code,
                        ),
                        maxLpgmIntensity:
                            earthquakeVxseDebugSampleMaxLpgmIntensity,
                        cities: const [],
                      ),
                    ],
                  });
                },
                icon: const Icon(Icons.add),
                label: const Text('地域階級'),
              ),
              TextButton.icon(
                key: const Key('lpgm-station-add'),
                onPressed: () {
                  final values =
                      draft.lpgmIntensityTree[draft.maxLpgmIntensity] ??
                      const [];
                  final stationCode =
                      const EarthquakeVxseDebugDraftIdentityGenerator()
                          .nextCode(
                            prefix: 'debug-lpgm-station',
                            usedCodes: draft.lpgmIntensityTree.values
                                .expand((nodes) => nodes)
                                .expand((node) => node.cities)
                                .expand((node) => node.stations)
                                .map((node) => node.station.code)
                                .toSet(),
                          );
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
                              StationLpgmIntensityNode(
                                station: earthquakeVxseDebugSampleStation
                                    .copyWith(code: stationCode),
                                intensity:
                                    earthquakeVxseDebugSampleStationIntensity
                                        .copyWith(code: stationCode),
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
  const new({
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
              fieldPrefix: _semanticKey.prefix('comment', [
                selectedType.name,
                comment.reportedAt.toIso8601String(),
                draft.comments
                    .take(index)
                    .where(
                      (candidate) =>
                          candidate.type == comment.type &&
                          candidate.reportedAt == comment.reportedAt,
                    )
                    .length
                    .toString(),
              ]),
              comment: comment,
              notifier: notifier,
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
            key: const Key('comment-add'),
            onPressed: () => notifier.setComments([
              ...draft.comments,
              EarthquakeTelegramComment(
                type: selectedType,
                reportedAt: const EarthquakeVxseDebugDraftIdentityGenerator()
                    .nextCommentTime(
                      base: draft.reportedAt,
                      usedTimes: draft.comments
                          .where((comment) => comment.type == selectedType)
                          .map((comment) => comment.reportedAt)
                          .toSet(),
                    ),
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
  const new({required this.state, required this.notifier});

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
      // controller は useTextEditingController が返す不変の参照。
      // ignore_keys: controller
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
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(fontFamily: 'monospace'),
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
  const new({
    required this.notifier,
    required this.fieldPrefix,
    required this.level,
    required this.region,
    required this.onChanged,
    required this.onRemove,
  });

  final EarthquakeVxseDebugEditorController notifier;
  final String fieldPrefix;
  final JmaIntensity level;
  final IntensityRegion region;
  final ValueChanged<IntensityRegion> onChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) => KeyedSubtree(
    key: ValueKey('ordinary-region-row.$fieldPrefix'),
    child: Card(
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
              child: _ControlledTextFormField(
                fieldKey: const Key('ordinary-region-code'),
                fieldId: '$fieldPrefix.code',
                value: region.region.code,
                label: '地域コード',
                notifier: notifier,
                onValidChanged: (value) {
                  notifier.migrateTypedInputPrefix(
                    from: fieldPrefix,
                    to: _semanticKey.withComponent(
                      prefix: fieldPrefix,
                      segmentIndex: 2,
                      value: value,
                    ),
                  );
                  onChanged(
                    region.copyWith(
                      region: region.region.copyWith(code: value),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: 180,
              child: _ControlledTextFormField(
                fieldKey: const Key('ordinary-region-name'),
                fieldId: '$fieldPrefix.name',
                value: region.region.name.ja,
                label: '地域名',
                notifier: notifier,
                onValidChanged: (value) => onChanged(
                  region.copyWith(
                    region: region.region.copyWith(
                      name: region.region.name.copyWith(ja: value),
                    ),
                  ),
                ),
              ),
            ),
            DropdownButton<JmaIntensity>(
              key: const Key('ordinary-region-max'),
              value: region.maxIntensity ?? level,
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
                  if (value != level) {
                    notifier.migrateTypedInputPrefix(
                      from: fieldPrefix,
                      to: _semanticKey.withComponent(
                        prefix: fieldPrefix,
                        segmentIndex: 1,
                        value: value.name,
                      ),
                    );
                  }
                  onChanged(region.copyWith(maxIntensity: value));
                }
              },
            ),
            IconButton(
              key: const Key('ordinary-region-remove'),
              onPressed: () {
                notifier.pruneTypedInputPrefix(fieldPrefix);
                onRemove();
              },
              tooltip: '地域を削除',
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ),
      ),
    ),
  );
}

class _OrdinaryPrefectureRow extends StatelessWidget {
  const new({
    required this.notifier,
    required this.fieldPrefix,
    required this.level,
    required this.prefecture,
    required this.onChanged,
    required this.onRemove,
  });

  final EarthquakeVxseDebugEditorController notifier;
  final String fieldPrefix;
  final JmaIntensity level;
  final IntensityPrefecture prefecture;
  final ValueChanged<IntensityPrefecture> onChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) => KeyedSubtree(
    key: ValueKey('ordinary-prefecture-row.$fieldPrefix'),
    child: Card(
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
              child: _ControlledTextFormField(
                fieldKey: const Key('ordinary-prefecture-code'),
                fieldId: '$fieldPrefix.code',
                value: prefecture.prefecture.code,
                label: '都道府県コード',
                notifier: notifier,
                onValidChanged: (value) {
                  notifier.migrateTypedInputPrefix(
                    from: fieldPrefix,
                    to: _semanticKey.withComponent(
                      prefix: fieldPrefix,
                      segmentIndex: 2,
                      value: value,
                    ),
                  );
                  onChanged(
                    prefecture.copyWith(
                      prefecture: prefecture.prefecture.copyWith(code: value),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: 180,
              child: _ControlledTextFormField(
                fieldKey: const Key('ordinary-prefecture-name'),
                fieldId: '$fieldPrefix.name',
                value: prefecture.prefecture.name.ja,
                label: '都道府県名',
                notifier: notifier,
                onValidChanged: (value) => onChanged(
                  prefecture.copyWith(
                    prefecture: prefecture.prefecture.copyWith(
                      name: prefecture.prefecture.name.copyWith(ja: value),
                    ),
                  ),
                ),
              ),
            ),
            DropdownButton<JmaIntensity>(
              key: const Key('ordinary-prefecture-max'),
              value: prefecture.maxIntensity ?? level,
              items: JmaIntensity.values
                  .map(
                    (value) => DropdownMenuItem<JmaIntensity>(
                      value: value,
                      child: Text(value.label),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != level) {
                  notifier.migrateTypedInputPrefix(
                    from: fieldPrefix,
                    to: _semanticKey.withComponent(
                      prefix: fieldPrefix,
                      segmentIndex: 1,
                      value: value?.name ?? level.name,
                    ),
                  );
                }
                onChanged(prefecture.copyWith(maxIntensity: value));
              },
            ),
            IconButton(
              key: const Key('ordinary-prefecture-remove'),
              onPressed: () {
                notifier.pruneTypedInputPrefix(fieldPrefix);
                onRemove();
              },
              tooltip: '都道府県を削除',
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ),
      ),
    ),
  );
}

class _OrdinaryCityRow extends StatelessWidget {
  const new({
    required this.notifier,
    required this.fieldPrefix,
    required this.city,
    required this.onChanged,
    required this.onRemove,
  });

  final EarthquakeVxseDebugEditorController notifier;
  final String fieldPrefix;
  final CityIntensityNode city;
  final ValueChanged<CityIntensityNode> onChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) => KeyedSubtree(
    key: ValueKey('ordinary-city-row.$fieldPrefix'),
    child: Padding(
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
                child: _ControlledTextFormField(
                  fieldKey: const Key('ordinary-city-code'),
                  fieldId: '$fieldPrefix.code',
                  value: city.city.code,
                  label: '市区町村コード',
                  notifier: notifier,
                  onValidChanged: (value) {
                    notifier.migrateTypedInputPrefix(
                      from: fieldPrefix,
                      to: _semanticKey.withComponent(
                        prefix: fieldPrefix,
                        segmentIndex: 3,
                        value: value,
                      ),
                    );
                    onChanged(
                      city.copyWith(city: city.city.copyWith(code: value)),
                    );
                  },
                ),
              ),
              SizedBox(
                width: 180,
                child: _ControlledTextFormField(
                  fieldKey: const Key('ordinary-city-name'),
                  fieldId: '$fieldPrefix.name',
                  value: city.city.name.ja,
                  label: '市区町村名',
                  notifier: notifier,
                  onValidChanged: (value) => onChanged(
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
                onPressed: () {
                  notifier.pruneTypedInputPrefix(fieldPrefix);
                  onRemove();
                },
                tooltip: '市区町村を削除',
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _StationParentCityLocator extends StatelessWidget {
  const new({
    required this.notifier,
    required this.fieldPrefix,
    required this.currentCode,
    required this.currentName,
    required this.onCodeChanged,
    required this.onNameChanged,
  });

  final EarthquakeVxseDebugEditorController notifier;
  final String fieldPrefix;
  final String currentCode;
  final String currentName;
  final ValueChanged<String> onCodeChanged;
  final ValueChanged<String> onNameChanged;

  @override
  Widget build(BuildContext context) => KeyedSubtree(
    key: ValueKey('station-parent-city-locator.$fieldPrefix'),
    child: Padding(
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
                child: _ControlledTextFormField(
                  fieldKey: const Key('station-parent-city-code'),
                  fieldId: '$fieldPrefix.code',
                  value: currentCode,
                  label: '親市区町村コード',
                  notifier: notifier,
                  onValidChanged: (value) {
                    notifier.migrateTypedInputPrefix(
                      from: fieldPrefix,
                      to: _semanticKey.withComponent(
                        prefix: fieldPrefix,
                        segmentIndex: 3,
                        value: value,
                      ),
                    );
                    onCodeChanged(value);
                  },
                ),
              ),
              SizedBox(
                width: 180,
                child: _ControlledTextFormField(
                  fieldKey: const Key('station-parent-city-name'),
                  fieldId: '$fieldPrefix.name',
                  value: currentName,
                  label: '親市区町村名',
                  notifier: notifier,
                  onValidChanged: onNameChanged,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _OrdinaryStationRow extends StatelessWidget {
  const new({
    required this.notifier,
    required this.fieldPrefix,
    required this.ownsStationDetails,
    required this.station,
    required this.onChanged,
    required this.onRemove,
  });

  final EarthquakeVxseDebugEditorController notifier;
  final String fieldPrefix;
  final bool ownsStationDetails;
  final StationIntensityNode station;
  final ValueChanged<StationIntensityNode> onChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final intensity =
        station.intensity ?? earthquakeVxseDebugSampleStationIntensity;
    return KeyedSubtree(
      key: ValueKey('ordinary-station-row.$fieldPrefix'),
      child: Padding(
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
                  child: _ControlledTextFormField(
                    fieldKey: const Key('ordinary-station-code'),
                    fieldId: '$fieldPrefix.code',
                    value: station.station.code,
                    label: '観測点コード',
                    notifier: notifier,
                    onValidChanged: (value) {
                      notifier.migrateTypedInputPrefix(
                        from: fieldPrefix,
                        to: _semanticKey.withComponent(
                          prefix: fieldPrefix,
                          segmentIndex: 4,
                          value: value,
                        ),
                      );
                      onChanged(
                        station.copyWith(
                          station: station.station.copyWith(code: value),
                          intensity: intensity.copyWith(code: value),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: 180,
                  child: _ControlledTextFormField(
                    fieldKey: const Key('ordinary-station-name'),
                    fieldId: '$fieldPrefix.name',
                    value: station.station.name.ja,
                    label: '観測点名',
                    notifier: notifier,
                    onValidChanged: (value) => onChanged(
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
                if (ownsStationDetails)
                  _StationDetailsFields(
                    key: const Key('ordinary-station-details'),
                    fieldPrefix: fieldPrefix,
                    intensity: intensity,
                    notifier: notifier,
                    onChanged: (updated) =>
                        onChanged(station.copyWith(intensity: updated)),
                  ),
                IconButton(
                  key: const Key('ordinary-station-remove'),
                  onPressed: () {
                    notifier.pruneTypedInputPrefix(fieldPrefix);
                    onRemove();
                  },
                  tooltip: '観測点を削除',
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LpgmRegionRow extends StatelessWidget {
  const new({
    required this.notifier,
    required this.fieldPrefix,
    required this.level,
    required this.region,
    required this.onChanged,
    required this.onRemove,
  });

  final EarthquakeVxseDebugEditorController notifier;
  final String fieldPrefix;
  final JmaLpgmIntensity level;
  final LpgmIntensityRegion region;
  final ValueChanged<LpgmIntensityRegion> onChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) => KeyedSubtree(
    key: ValueKey('lpgm-region-row.$fieldPrefix'),
    child: Card(
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
              child: _ControlledTextFormField(
                fieldKey: const Key('lpgm-region-code'),
                fieldId: '$fieldPrefix.code',
                value: region.region.code,
                label: '地域コード',
                notifier: notifier,
                onValidChanged: (value) {
                  notifier.migrateTypedInputPrefix(
                    from: fieldPrefix,
                    to: _semanticKey.withComponent(
                      prefix: fieldPrefix,
                      segmentIndex: 2,
                      value: value,
                    ),
                  );
                  onChanged(
                    region.copyWith(
                      region: region.region.copyWith(code: value),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: 180,
              child: _ControlledTextFormField(
                fieldKey: const Key('lpgm-region-name'),
                fieldId: '$fieldPrefix.name',
                value: region.region.name.ja,
                label: '地域名',
                notifier: notifier,
                onValidChanged: (value) => onChanged(
                  region.copyWith(
                    region: region.region.copyWith(
                      name: region.region.name.copyWith(ja: value),
                    ),
                  ),
                ),
              ),
            ),
            DropdownButton<JmaLpgmIntensity>(
              value: region.maxLpgmIntensity ?? level,
              key: const Key('lpgm-region-max'),
              items: JmaLpgmIntensity.values
                  .map(
                    (value) => DropdownMenuItem<JmaLpgmIntensity>(
                      value: value,
                      child: Text(value.label),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != level) {
                  notifier.migrateTypedInputPrefix(
                    from: fieldPrefix,
                    to: _semanticKey.withComponent(
                      prefix: fieldPrefix,
                      segmentIndex: 1,
                      value: value?.name ?? level.name,
                    ),
                  );
                }
                onChanged(region.copyWith(maxLpgmIntensity: value));
              },
            ),
            IconButton(
              key: const Key('lpgm-region-remove'),
              onPressed: () {
                notifier.pruneTypedInputPrefix(fieldPrefix);
                onRemove();
              },
              tooltip: '地域を削除',
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ),
      ),
    ),
  );
}

class _LpgmPrefectureRow extends StatelessWidget {
  const new({
    required this.notifier,
    required this.fieldPrefix,
    required this.level,
    required this.prefecture,
    required this.onChanged,
    required this.onRemove,
  });

  final EarthquakeVxseDebugEditorController notifier;
  final String fieldPrefix;
  final JmaLpgmIntensity level;
  final PrefectureLpgmIntensityNode prefecture;
  final ValueChanged<PrefectureLpgmIntensityNode> onChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) => KeyedSubtree(
    key: ValueKey('lpgm-prefecture-row.$fieldPrefix'),
    child: Card(
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
              child: _ControlledTextFormField(
                fieldKey: const Key('lpgm-prefecture-code'),
                fieldId: '$fieldPrefix.code',
                value: prefecture.region.code,
                label: '地域コード',
                notifier: notifier,
                onValidChanged: (value) {
                  notifier.migrateTypedInputPrefix(
                    from: fieldPrefix,
                    to: _semanticKey.withComponent(
                      prefix: fieldPrefix,
                      segmentIndex: 2,
                      value: value,
                    ),
                  );
                  onChanged(
                    prefecture.copyWith(
                      region: prefecture.region.copyWith(code: value),
                    ),
                  );
                },
              ),
            ),
            DropdownButton<JmaLpgmIntensity>(
              key: const Key('lpgm-prefecture-max'),
              value: prefecture.maxLpgmIntensity ?? level,
              items: JmaLpgmIntensity.values
                  .map(
                    (value) => DropdownMenuItem(
                      value: value,
                      child: Text(value.label),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  if (value != level) {
                    notifier.migrateTypedInputPrefix(
                      from: fieldPrefix,
                      to: _semanticKey.withComponent(
                        prefix: fieldPrefix,
                        segmentIndex: 1,
                        value: value.name,
                      ),
                    );
                  }
                  onChanged(prefecture.copyWith(maxLpgmIntensity: value));
                }
              },
            ),
            SizedBox(
              width: 180,
              child: _ControlledTextFormField(
                fieldKey: const Key('lpgm-prefecture-name'),
                fieldId: '$fieldPrefix.name',
                value: prefecture.region.name.ja,
                label: '地域名',
                notifier: notifier,
                onValidChanged: (value) => onChanged(
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
              onPressed: () {
                notifier.pruneTypedInputPrefix(fieldPrefix);
                onRemove();
              },
              tooltip: '地域階級を削除',
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ),
      ),
    ),
  );
}

class _LpgmStationRow extends StatelessWidget {
  const new({
    required this.notifier,
    required this.fieldPrefix,
    required this.station,
    required this.onChanged,
    required this.onRemove,
  });

  final EarthquakeVxseDebugEditorController notifier;
  final String fieldPrefix;
  final StationLpgmIntensityNode station;
  final ValueChanged<StationLpgmIntensityNode> onChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final intensity =
        station.intensity ?? earthquakeVxseDebugSampleStationIntensity;
    return KeyedSubtree(
      key: ValueKey('lpgm-station-row.$fieldPrefix'),
      child: Padding(
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
                  child: _ControlledTextFormField(
                    fieldKey: const Key('lpgm-station-code'),
                    fieldId: '$fieldPrefix.code',
                    value: station.station.code,
                    label: '観測点コード',
                    notifier: notifier,
                    onValidChanged: (value) {
                      notifier.migrateTypedInputPrefix(
                        from: fieldPrefix,
                        to: _semanticKey.withComponent(
                          prefix: fieldPrefix,
                          segmentIndex: 4,
                          value: value,
                        ),
                      );
                      onChanged(
                        station.copyWith(
                          station: station.station.copyWith(code: value),
                          intensity: intensity.copyWith(code: value),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: 180,
                  child: _ControlledTextFormField(
                    fieldKey: const Key('lpgm-station-name'),
                    fieldId: '$fieldPrefix.name',
                    value: station.station.name.ja,
                    label: '観測点名',
                    notifier: notifier,
                    onValidChanged: (value) => onChanged(
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
                _StationDetailsFields(
                  key: const Key('lpgm-station-details'),
                  fieldPrefix: fieldPrefix,
                  intensity: intensity,
                  notifier: notifier,
                  onChanged: (updated) =>
                      onChanged(station.copyWith(intensity: updated)),
                ),
                IconButton(
                  key: const Key('lpgm-station-remove'),
                  onPressed: () {
                    notifier.pruneTypedInputPrefix(fieldPrefix);
                    onRemove();
                  },
                  tooltip: '観測点を削除',
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StationDetailsFields extends StatelessWidget {
  const new({
    required this.fieldPrefix,
    required this.intensity,
    required this.notifier,
    required this.onChanged,
    super.key,
  });

  final String fieldPrefix;
  final IntensityStation intensity;
  final EarthquakeVxseDebugEditorController notifier;
  final ValueChanged<IntensityStation> onChanged;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 320,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _ControlledTextFormField(
          fieldKey: const Key('station-sva'),
          fieldId: '$fieldPrefix.sva',
          value: intensity.sva?.toString() ?? '',
          label: '絶対速度応答スペクトル (SVA)',
          notifier: notifier,
          keyboardType: TextInputType.number,
          validation: (value) =>
              value.isNotEmpty && double.tryParse(value) == null
              ? '数値を入力してください'
              : null,
          onValidChanged: (value) => onChanged(
            intensity.copyWith(sva: value.isEmpty ? null : double.parse(value)),
          ),
        ),
        for (final (index, prePeriod)
            in (intensity.prePeriods ?? const []).indexed)
          Card.outlined(
            key: ValueKey(
              _semanticKey.prePeriodPrefix(
                stationPrefix: fieldPrefix,
                band: prePeriod.band.toString(),
                occurrence: (intensity.prePeriods ?? const [])
                    .take(index)
                    .where((candidate) => candidate.band == prePeriod.band)
                    .length
                    .toString(),
              ),
            ),
            child: Padding(
              key: const Key('pre-period-row'),
              padding: const EdgeInsets.all(8),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  SizedBox(
                    width: 90,
                    child: _ControlledTextFormField(
                      fieldKey: const Key('pre-period-band'),
                      fieldId:
                          '${_semanticKey.prePeriodPrefix(stationPrefix: fieldPrefix, band: prePeriod.band.toString(), occurrence: (intensity.prePeriods ?? const []).take(index).where((candidate) => candidate.band == prePeriod.band).length.toString())}.band',
                      value: prePeriod.band.toString(),
                      label: '周期帯',
                      notifier: notifier,
                      keyboardType: TextInputType.number,
                      validation: (value) =>
                          double.tryParse(value) == null ? '数値を入力してください' : null,
                      onValidChanged: (value) {
                        final prefix = _semanticKey.prePeriodPrefix(
                          stationPrefix: fieldPrefix,
                          band: prePeriod.band.toString(),
                          occurrence: (intensity.prePeriods ?? const [])
                              .take(index)
                              .where(
                                (candidate) => candidate.band == prePeriod.band,
                              )
                              .length
                              .toString(),
                        );
                        notifier.migrateTypedInputPrefix(
                          from: prefix,
                          to: _semanticKey.withComponent(
                            prefix: prefix,
                            segmentIndex: 7,
                            value: double.parse(value).toString(),
                          ),
                        );
                        onChanged(
                          intensity.copyWith(
                            prePeriods: [
                              for (final (currentIndex, current)
                                  in (intensity.prePeriods ?? const []).indexed)
                                currentIndex == index
                                    ? current.copyWith(
                                        band: double.parse(value),
                                      )
                                    : current,
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: 110,
                    child: _ControlledDropdown<JmaLpgmIntensity>(
                      value: prePeriod.lpgmIntensity,
                      label: '長周期階級',
                      items: JmaLpgmIntensity.values
                          .map(
                            (value) => DropdownMenuItem(
                              value: value,
                              child: Text(value.label),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          onChanged(
                            intensity.copyWith(
                              prePeriods: [
                                for (final (currentIndex, current)
                                    in (intensity.prePeriods ?? const [])
                                        .indexed)
                                  currentIndex == index
                                      ? current.copyWith(lpgmIntensity: value)
                                      : current,
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 90,
                    child: _ControlledTextFormField(
                      fieldKey: const Key('pre-period-sva'),
                      fieldId:
                          '${_semanticKey.prePeriodPrefix(stationPrefix: fieldPrefix, band: prePeriod.band.toString(), occurrence: (intensity.prePeriods ?? const []).take(index).where((candidate) => candidate.band == prePeriod.band).length.toString())}.sva',
                      value: prePeriod.sva.toString(),
                      label: 'SVA',
                      notifier: notifier,
                      keyboardType: TextInputType.number,
                      validation: (value) =>
                          double.tryParse(value) == null ? '数値を入力してください' : null,
                      onValidChanged: (value) => onChanged(
                        intensity.copyWith(
                          prePeriods: [
                            for (final (currentIndex, current)
                                in (intensity.prePeriods ?? const []).indexed)
                              currentIndex == index
                                  ? current.copyWith(sva: double.parse(value))
                                  : current,
                          ],
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    key: const Key('pre-period-remove'),
                    tooltip: '周期帯を削除',
                    onPressed: () {
                      notifier.pruneTypedInputPrefix(
                        _semanticKey.prePeriodPrefix(
                          stationPrefix: fieldPrefix,
                          band: prePeriod.band.toString(),
                          occurrence: (intensity.prePeriods ?? const [])
                              .take(index)
                              .where(
                                (candidate) => candidate.band == prePeriod.band,
                              )
                              .length
                              .toString(),
                        ),
                      );
                      onChanged(
                        intensity.copyWith(
                          prePeriods: [
                            for (final (currentIndex, current)
                                in (intensity.prePeriods ?? const []).indexed)
                              if (currentIndex != index) current,
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.delete_outline),
                  ),
                ],
              ),
            ),
          ),
        TextButton.icon(
          key: const Key('pre-period-add'),
          onPressed: () => onChanged(
            intensity.copyWith(
              prePeriods: [
                ...intensity.prePeriods ?? const [],
                PrePeriod(
                  band: const EarthquakeVxseDebugDraftIdentityGenerator()
                      .nextPrePeriodBand(
                        usedBands: (intensity.prePeriods ?? const [])
                            .map((prePeriod) => prePeriod.band)
                            .toSet(),
                      ),
                  lpgmIntensity: earthquakeVxseDebugSampleMaxLpgmIntensity,
                  sva: 12.3,
                ),
              ],
            ),
          ),
          icon: const Icon(Icons.add),
          label: const Text('周期帯を追加'),
        ),
      ],
    ),
  );
}

class _CommentRow extends StatelessWidget {
  const new({
    required this.fieldPrefix,
    required this.comment,
    required this.notifier,
    required this.onChanged,
    required this.onRemove,
  });

  final String fieldPrefix;
  final EarthquakeTelegramComment comment;
  final EarthquakeVxseDebugEditorController notifier;
  final ValueChanged<EarthquakeTelegramComment> onChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) => KeyedSubtree(
    key: ValueKey('comment-row.$fieldPrefix'),
    child: Card(
      key: const Key('comment-row'),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            _ControlledTextFormField(
              fieldKey: const Key('comment-reported-at'),
              fieldId: '$fieldPrefix.reportedAt',
              value: comment.reportedAt.tokyoDateTime.toIso8601String(),
              label: 'コメント発表時刻',
              notifier: notifier,
              validation: (value) =>
                  DateTime.tryParse(value) == null ? '日時を入力してください' : null,
              onValidChanged: (value) {
                notifier.migrateTypedInputPrefix(
                  from: fieldPrefix,
                  to: _semanticKey.withComponent(
                    prefix: fieldPrefix,
                    segmentIndex: 2,
                    value: DateTime.parse(value).toIso8601String(),
                  ),
                );
                onChanged(comment.copyWith(reportedAt: DateTime.parse(value)));
              },
            ),
            _ControlledTextFormField(
              fieldKey: const Key('comment-additional'),
              fieldId: '$fieldPrefix.additional',
              value: comment.additional ?? '',
              label: '固定付加文',
              notifier: notifier,
              maxLines: null,
              onValidChanged: (value) =>
                  onChanged(comment.copyWith(additional: value)),
            ),
            _ControlledTextFormField(
              fieldId: '$fieldPrefix.free',
              value: comment.free ?? '',
              label: '自由付加文',
              notifier: notifier,
              maxLines: null,
              onValidChanged: (value) =>
                  onChanged(comment.copyWith(free: value)),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                key: const Key('comment-remove'),
                onPressed: () {
                  notifier.pruneTypedInputPrefix(fieldPrefix);
                  onRemove();
                },
                tooltip: 'コメントを削除',
                icon: const Icon(Icons.delete_outline),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _ControlledTextFormField extends HookWidget {
  const new({
    required this.fieldId,
    required this.value,
    required this.label,
    required this.notifier,
    required this.onValidChanged,
    this.validation,
    this.keyboardType,
    this.maxLines = 1,
    this.fieldKey,
  });

  final String fieldId;
  final String value;
  final String label;
  final EarthquakeVxseDebugEditorController notifier;
  final ValueChanged<String> onValidChanged;
  final String? Function(String value)? validation;
  final TextInputType? keyboardType;
  final int? maxLines;
  final Key? fieldKey;

  @override
  Widget build(BuildContext context) {
    final displayed = notifier.typedInputText(
      fieldId: fieldId,
      fallback: value,
    );
    final controller = useTextEditingController(text: displayed);
    useEffect(() {
      if (controller.text != displayed) {
        controller.value = TextEditingValue(
          text: displayed,
          selection: TextSelection.collapsed(offset: displayed.length),
        );
      }
      return null;
      // controller は useTextEditingController が返す不変の参照。
      // ignore_keys: controller
    }, [displayed]);
    return TextFormField(
      key: fieldKey,
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        errorText: notifier.typedInputError(fieldId: fieldId),
      ),
      onChanged: (text) {
        final error = validation?.call(text);
        notifier.setTypedInput(fieldId: fieldId, text: text, error: error);
        if (error == null) {
          onValidChanged(text);
        }
      },
    );
  }
}

class _ControlledDropdown<T> extends StatelessWidget {
  const new({
    required this.value,
    required this.label,
    required this.items,
    required this.onChanged,
    super.key,
  });

  final T value;
  final String label;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) => InputDecorator(
    decoration: InputDecoration(labelText: label),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<T>(
        value: value,
        isExpanded: true,
        items: items,
        onChanged: onChanged,
      ),
    ),
  );
}
