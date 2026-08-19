import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_draft.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_hypocenter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_metadata.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_station.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/lpgm_intensity_tree.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:lat_lng/lat_lng.dart';

/// Debug drafts without source data always use this documented instant.
final earthquakeVxseDebugSampleReportedAt = DateTime.utc(2020, 1, 1);
final earthquakeVxseDebugSampleOriginTime = DateTime.utc(2020, 1, 1);
final earthquakeVxseDebugSampleArrivalTime = DateTime.utc(2020, 1, 1, 0, 1);

const earthquakeVxseDebugSampleMaxIntensity = JmaIntensity.four;
const earthquakeVxseDebugSampleMaxLpgmIntensity = JmaLpgmIntensity.two;
const earthquakeVxseDebugSampleEarthquakeType = EarthquakeType.normal;

const earthquakeVxseDebugSampleHypocenter = EarthquakeHypocenter(
  code: '477',
  name: '東京湾',
  coordinates: Coordinate.latLng(latitude: 35.5, longitude: 139.8),
  magnitude: EarthquakeMagnitude.value(value: 5),
  depth: EarthquakeDepth.value(value: 40),
  detailedCode: null,
  detailedName: null,
);

const earthquakeVxseDebugSampleStation = EarthquakeParameterStationItem(
  code: '1310100',
  noCode: '3500000',
  name: LocalizedName(ja: '東京千代田区大手町'),
  kana: 'トウキョウチヨダクオオテマチ',
  status: EarthquakeStationStatus.operating,
  sourceStatus: '現',
  owner: '気象庁',
  location: LatLng(35.6889, 139.7558),
  arv400: 1.43,
);

const earthquakeVxseDebugSampleCity = EarthquakeParameterCityItem(
  code: '1310100',
  name: LocalizedName(ja: '東京千代田区'),
  kana: 'トウキョウチヨダク',
  stations: [earthquakeVxseDebugSampleStation],
);

const earthquakeVxseDebugSampleRegion = EarthquakeParameterRegionItem(
  code: '350',
  name: LocalizedName(ja: '東京都２３区'),
  kana: 'トウキョウトニジュウサンク',
  cities: [earthquakeVxseDebugSampleCity],
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

const earthquakeVxseDebugSampleStationIntensity = IntensityStation(
  code: '1310100',
  name: '東京千代田区大手町',
  sva: 12.3,
  prePeriods: [
    PrePeriod(
      band: 1.6,
      lpgmIntensity: earthquakeVxseDebugSampleMaxLpgmIntensity,
      sva: 12.3,
    ),
  ],
  maxIntensity: earthquakeVxseDebugSampleMaxIntensity,
  maxLpgmIntensity: earthquakeVxseDebugSampleMaxLpgmIntensity,
);

const earthquakeVxseDebugSampleLpgmRegion = LpgmIntensityRegion(
  region: earthquakeVxseDebugSampleRegion,
  maxLpgmIntensity: earthquakeVxseDebugSampleMaxLpgmIntensity,
);

class EarthquakeVxseDebugDraftFactory {
  const new();

  EarthquakeVxseDebugDraft create({
    required Earthquake current,
    required EarthquakeTelegramType type,
  }) {
    final comments = current.telegramComments
        .where((comment) => comment.type == type)
        .toList();
    final reportedAt = latestEarthquakeTelegramReportedAt(
      metadata: current.telegramMetadata,
      type: type,
    );
    final hypocenter =
        current.hypocenter ?? earthquakeVxseDebugSampleHypocenter;
    final intensity = current.intensity;

    return switch (type) {
      .vxse51 => EarthquakeVxseDebugDraft.vxse51(
        eventId: current.eventId,
        reportedAt: reportedAt,
        status: current.status,
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
        status: current.status,
        arrivalTime:
            current.arrivalTime ?? earthquakeVxseDebugSampleArrivalTime,
        originTime: current.originTime ?? earthquakeVxseDebugSampleOriginTime,
        hypocenter: hypocenter,
        comments: comments,
      ),
      .vxse53 => EarthquakeVxseDebugDraft.vxse53(
        eventId: current.eventId,
        reportedAt: reportedAt,
        status: current.status,
        arrivalTime:
            current.arrivalTime ?? earthquakeVxseDebugSampleArrivalTime,
        originTime: current.originTime ?? earthquakeVxseDebugSampleOriginTime,
        hypocenter: hypocenter,
        earthquakeType:
            current.earthquakeType ?? earthquakeVxseDebugSampleEarthquakeType,
        maxIntensity:
            intensity?.maxIntensity ?? earthquakeVxseDebugSampleMaxIntensity,
        regions: intensityRegionsOrSample(regions: intensity?.regions),
        intensityTree: intensityTreeOrSample(tree: intensity?.intensityTree),
        comments: comments,
      ),
      .vxse61 => EarthquakeVxseDebugDraft.vxse61(
        eventId: current.eventId,
        reportedAt: reportedAt,
        status: current.status,
        arrivalTime:
            current.arrivalTime ?? earthquakeVxseDebugSampleArrivalTime,
        originTime: current.originTime ?? earthquakeVxseDebugSampleOriginTime,
        hypocenter: hypocenter,
        comments: comments,
      ),
      .vxse62 => EarthquakeVxseDebugDraft.vxse62(
        eventId: current.eventId,
        reportedAt: reportedAt,
        status: current.status,
        arrivalTime:
            current.arrivalTime ?? earthquakeVxseDebugSampleArrivalTime,
        originTime: current.originTime ?? earthquakeVxseDebugSampleOriginTime,
        hypocenter: hypocenter,
        maxIntensity:
            intensity?.maxIntensity ?? earthquakeVxseDebugSampleMaxIntensity,
        maxLpgmIntensity:
            intensity?.maxLpgmIntensity ??
            earthquakeVxseDebugSampleMaxLpgmIntensity,
        regions: intensityRegionsOrSample(regions: intensity?.regions),
        intensityTree: intensityTreeOrSample(tree: intensity?.intensityTree),
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

  DateTime latestEarthquakeTelegramReportedAt({
    required List<EarthquakeTelegramMetadata> metadata,
    required EarthquakeTelegramType type,
  }) {
    final reportedAt = metadata
        .where((entry) => entry.type == type)
        .map((entry) => entry.reportedAt)
        .toList();
    if (reportedAt.isEmpty) {
      return earthquakeVxseDebugSampleReportedAt;
    }
    return reportedAt.reduce(
      (latest, next) => next.isAfter(latest) ? next : latest,
    );
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
              cities: [
                CityIntensityNode(
                  city: earthquakeVxseDebugSampleCity,
                  maxIntensity: earthquakeVxseDebugSampleMaxIntensity,
                  stations: [
                    StationIntensityNode(
                      station: earthquakeVxseDebugSampleStation,
                      intensity: earthquakeVxseDebugSampleStationIntensity,
                    ),
                  ],
                  maxLpgmIntensity: earthquakeVxseDebugSampleMaxLpgmIntensity,
                ),
              ],
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
              cities: [
                CityLpgmIntensityNode(
                  city: earthquakeVxseDebugSampleCity,
                  maxLpgmIntensity: earthquakeVxseDebugSampleMaxLpgmIntensity,
                  stations: [
                    StationLpgmIntensityNode(
                      station: earthquakeVxseDebugSampleStation,
                      intensity: earthquakeVxseDebugSampleStationIntensity,
                    ),
                  ],
                ),
              ],
            ),
          ],
        }
      : tree;
}
