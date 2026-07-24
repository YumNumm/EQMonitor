import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_draft.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_hypocenter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_comment.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/lpgm_intensity_tree.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';

/// Debug drafts without source data always use this documented instant.
final earthquakeVxseDebugSampleReportedAt = DateTime.utc(2020, 1, 1);

const earthquakeVxseDebugSampleMaxIntensity = JmaIntensity.four;
const earthquakeVxseDebugSampleMaxLpgmIntensity = JmaLpgmIntensity.two;

const earthquakeVxseDebugSampleHypocenter = EarthquakeHypocenter(
  code: '471',
  name: '東京湾',
  coordinates: Coordinate.latLng(latitude: 35.5, longitude: 139.8),
  magnitude: EarthquakeMagnitude.value(value: 5),
  depth: EarthquakeDepth.value(value: 40),
  detailedCode: null,
  detailedName: null,
);

const earthquakeVxseDebugSampleRegion = EarthquakeParameterRegionItem(
  code: '130000',
  name: LocalizedName(ja: '東京都'),
  kana: 'とうきょうと',
  cities: [],
);

const earthquakeVxseDebugSamplePrefecture = EarthquakeParameterPrefectureItem(
  code: '13',
  name: LocalizedName(ja: '東京都'),
  regions: [earthquakeVxseDebugSampleRegion],
);

const earthquakeVxseDebugSampleIntensityRegion = IntensityRegion(
  region: earthquakeVxseDebugSampleRegion,
  maxIntensity: earthquakeVxseDebugSampleMaxIntensity,
);

const earthquakeVxseDebugSampleIntensityPrefecture = IntensityPrefecture(
  prefecture: earthquakeVxseDebugSamplePrefecture,
  maxIntensity: earthquakeVxseDebugSampleMaxIntensity,
);

const earthquakeVxseDebugSampleLpgmRegion = LpgmIntensityRegion(
  region: earthquakeVxseDebugSampleRegion,
  maxLpgmIntensity: earthquakeVxseDebugSampleMaxLpgmIntensity,
);

class EarthquakeVxseDebugDraftFactory {
  const EarthquakeVxseDebugDraftFactory();

  EarthquakeVxseDebugDraft create({
    required Earthquake current,
    required EarthquakeTelegramType type,
  }) {
    final comments = current.telegramComments
        .where((comment) => comment.type == type)
        .toList();
    final reportedAt = latestReportedAt(comments: comments);
    final hypocenter =
        current.hypocenter ?? earthquakeVxseDebugSampleHypocenter;
    final intensity = current.intensity;

    return switch (type) {
      .vxse51 => EarthquakeVxseDebugDraft.vxse51(
        eventId: current.eventId,
        reportedAt: reportedAt,
        maxIntensity:
            intensity?.maxIntensity ?? earthquakeVxseDebugSampleMaxIntensity,
        regions: intensityRegionsOrSample(regions: intensity?.regions),
        prefectures: intensityPrefecturesOrSample(
          intensityTree: intensity?.intensityTree,
        ),
        comments: comments,
      ),
      .vxse52 => EarthquakeVxseDebugDraft.vxse52(
        eventId: current.eventId,
        reportedAt: reportedAt,
        hypocenter: hypocenter,
        comments: comments,
      ),
      .vxse53 => EarthquakeVxseDebugDraft.vxse53(
        eventId: current.eventId,
        reportedAt: reportedAt,
        hypocenter: hypocenter,
        maxIntensity:
            intensity?.maxIntensity ?? earthquakeVxseDebugSampleMaxIntensity,
        regions: intensityRegionsOrSample(regions: intensity?.regions),
        intensityTree: intensityTreeOrSample(tree: intensity?.intensityTree),
        comments: comments,
      ),
      .vxse61 => EarthquakeVxseDebugDraft.vxse61(
        eventId: current.eventId,
        reportedAt: reportedAt,
        hypocenter: hypocenter,
        comments: comments,
      ),
      .vxse62 => EarthquakeVxseDebugDraft.vxse62(
        eventId: current.eventId,
        reportedAt: reportedAt,
        hypocenter: hypocenter,
        maxLpgmIntensity:
            intensity?.maxLpgmIntensity ??
            earthquakeVxseDebugSampleMaxLpgmIntensity,
        lpgmRegions: lpgmRegionsOrSample(tree: intensity?.lpgmIntensityTree),
        lpgmIntensityTree: lpgmTreeOrSample(tree: intensity?.lpgmIntensityTree),
        comments: comments,
      ),
      .vxse45Forecast || .vxse45Warning => throw ArgumentError.value(
        type,
        'type',
        'VXSE51/52/53/61/62 only',
      ),
    };
  }
}

DateTime latestReportedAt({required List<EarthquakeTelegramComment> comments}) {
  if (comments.isEmpty) {
    return earthquakeVxseDebugSampleReportedAt;
  }
  return comments
      .map((comment) => comment.reportedAt)
      .reduce((latest, next) => next.isAfter(latest) ? next : latest);
}

Map<JmaIntensity, List<IntensityRegion>> intensityRegionsOrSample({
  required Map<JmaIntensity, List<IntensityRegion>>? regions,
}) => regions == null || regions.isEmpty
    ? const {
        earthquakeVxseDebugSampleMaxIntensity: [
          earthquakeVxseDebugSampleIntensityRegion,
        ],
      }
    : regions;

Map<JmaIntensity, List<IntensityPrefecture>> intensityPrefecturesOrSample({
  required Map<JmaIntensity, List<PrefectureIntensityNode>>? intensityTree,
}) {
  if (intensityTree == null || intensityTree.isEmpty) {
    return const {
      earthquakeVxseDebugSampleMaxIntensity: [
        earthquakeVxseDebugSampleIntensityPrefecture,
      ],
    };
  }
  return {
    for (final entry in intensityTree.entries)
      entry.key: entry.value.map((node) => node.prefecture).toList(),
  };
}

Map<JmaIntensity, List<PrefectureIntensityNode>> intensityTreeOrSample({
  required Map<JmaIntensity, List<PrefectureIntensityNode>>? tree,
}) => tree == null || tree.isEmpty
    ? const {
        earthquakeVxseDebugSampleMaxIntensity: [
          PrefectureIntensityNode(
            prefecture: earthquakeVxseDebugSampleIntensityPrefecture,
            cities: [],
          ),
        ],
      }
    : tree;

Map<JmaLpgmIntensity, List<LpgmIntensityRegion>> lpgmRegionsOrSample({
  required Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>>? tree,
}) {
  if (tree == null || tree.isEmpty) {
    return const {
      earthquakeVxseDebugSampleMaxLpgmIntensity: [
        earthquakeVxseDebugSampleLpgmRegion,
      ],
    };
  }
  return {
    for (final entry in tree.entries)
      entry.key: entry.value
          .map(
            (node) => LpgmIntensityRegion(
              region: node.region,
              maxLpgmIntensity: node.maxLpgmIntensity,
            ),
          )
          .toList(),
  };
}

Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>> lpgmTreeOrSample({
  required Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>>? tree,
}) => tree == null || tree.isEmpty
    ? const {
        earthquakeVxseDebugSampleMaxLpgmIntensity: [
          PrefectureLpgmIntensityNode(
            region: earthquakeVxseDebugSampleRegion,
            maxLpgmIntensity: earthquakeVxseDebugSampleMaxLpgmIntensity,
            cities: [],
          ),
        ],
      }
    : tree;
