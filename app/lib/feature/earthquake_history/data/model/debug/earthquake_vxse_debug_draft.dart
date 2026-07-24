import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_hypocenter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_comment.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/lpgm_intensity_tree.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_vxse_debug_draft.freezed.dart';
part 'earthquake_vxse_debug_draft.g.dart';

@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.screamingSnake)
sealed class EarthquakeVxseDebugDraft with _$EarthquakeVxseDebugDraft {
  const factory EarthquakeVxseDebugDraft.vxse51({
    required String eventId,
    required DateTime reportedAt,
    required JmaIntensity maxIntensity,
    required Map<JmaIntensity, List<IntensityRegion>> regions,
    required Map<JmaIntensity, List<IntensityPrefecture>> prefectures,
    required List<EarthquakeTelegramComment> comments,
  }) = EarthquakeVxse51DebugDraft;

  const factory EarthquakeVxseDebugDraft.vxse52({
    required String eventId,
    required DateTime reportedAt,
    required EarthquakeHypocenter hypocenter,
    required List<EarthquakeTelegramComment> comments,
  }) = EarthquakeVxse52DebugDraft;

  const factory EarthquakeVxseDebugDraft.vxse53({
    required String eventId,
    required DateTime reportedAt,
    required EarthquakeHypocenter hypocenter,
    required JmaIntensity maxIntensity,
    required Map<JmaIntensity, List<IntensityRegion>> regions,
    required Map<JmaIntensity, List<PrefectureIntensityNode>> intensityTree,
    required List<EarthquakeTelegramComment> comments,
  }) = EarthquakeVxse53DebugDraft;

  const factory EarthquakeVxseDebugDraft.vxse61({
    required String eventId,
    required DateTime reportedAt,
    required EarthquakeHypocenter hypocenter,
    required List<EarthquakeTelegramComment> comments,
  }) = EarthquakeVxse61DebugDraft;

  const factory EarthquakeVxseDebugDraft.vxse62({
    required String eventId,
    required DateTime reportedAt,
    required EarthquakeHypocenter hypocenter,
    required JmaLpgmIntensity maxLpgmIntensity,
    required Map<JmaLpgmIntensity, List<LpgmIntensityRegion>> lpgmRegions,
    required Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>>
    lpgmIntensityTree,
    required List<EarthquakeTelegramComment> comments,
  }) = EarthquakeVxse62DebugDraft;

  factory EarthquakeVxseDebugDraft.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeVxseDebugDraftFromJson(json);
}
