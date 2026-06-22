import 'package:eqmonitor/feature/tsunami/data/model/timeline/estimation_timeline_entry.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/first_height_timeline_entry.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/kind_timeline_entry.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/max_height_timeline_entry.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/observation_timeline_entry.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/station_timeline_entry.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tracking/tracked_tsunami_timeline.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_telegram_meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsunami_timeline.freezed.dart';

/// 津波タイムライン公開ルート型（UI が参照）。
@freezed
abstract class TsunamiTimeline with _$TsunamiTimeline {
  const factory TsunamiTimeline({
    required List<TsunamiTelegramMeta> telegrams,
    required List<RegionTimeline> regions,
    required List<OffshoreStationTimeline> offshoreStations,
  }) = _TsunamiTimeline;
}

/// 地域ごとのタイムライン。
@freezed
abstract class RegionTimeline with _$RegionTimeline {
  const factory RegionTimeline({
    required String code,
    required String name,
    required KindTimeline kind,
    required KindTimeline lastKind,
    required FirstHeightTimeline forecastFirstHeight,
    required MaxHeightTimeline forecastMaxHeight,
    required EstimationFirstHeightTimeline estimationFirstHeight,
    required EstimationMaxHeightTimeline estimationMaxHeight,
    required List<StationTimeline> stations,
  }) = _RegionTimeline;
}

/// 観測点ごとのタイムライン。
@freezed
abstract class StationTimeline with _$StationTimeline {
  const factory StationTimeline({
    required String code,
    required String name,
    required StationForecastTimeline forecast,
    required StationObservationTimeline observation,
  }) = _StationTimeline;
}

/// 沖合観測局ごとのタイムライン。
@freezed
abstract class OffshoreStationTimeline with _$OffshoreStationTimeline {
  const factory OffshoreStationTimeline({
    required String code,
    required String name,
    required ObservationFirstHeightTimeline firstHeight,
    required ObservationMaxHeightTimeline maxHeight,
  }) = _OffshoreStationTimeline;
}

/// 中間表現を公開型へ変換する extension。
/// トップレベル関数禁止のため private クラス経由で変換を行う。
extension TrackedTsunamiTimelineMapping on TrackedTsunamiTimeline {
  TsunamiTimeline toPublic() => _TsunamiTimelineMapper(this).map();
}

class _TsunamiTimelineMapper {
  _TsunamiTimelineMapper(this._tracked)
    : _metaById = {
        for (final m in _tracked.telegrams) m.telegramId: m,
      };

  final TrackedTsunamiTimeline _tracked;
  final Map<String, TsunamiTelegramMeta> _metaById;

  TsunamiTimeline map() => TsunamiTimeline(
    telegrams: _tracked.telegrams,
    regions: [
      for (final r in _tracked.regions)
        RegionTimeline(
          code: r.code,
          name: r.name,
          kind: [
            for (final v in r.kind)
              KindTimelineEntry(
                kind: v.value,
                telegramId: v.telegramId,
                headline: _meta(v.telegramId).headline,
                title: _meta(v.telegramId).title,
                publishedAt: _meta(v.telegramId).publishedAt,
                revokedAt: _meta(v.telegramId).revokedAt,
              ),
          ],
          lastKind: [
            for (final v in r.lastKind)
              KindTimelineEntry(
                kind: v.value,
                telegramId: v.telegramId,
                headline: _meta(v.telegramId).headline,
                title: _meta(v.telegramId).title,
                publishedAt: _meta(v.telegramId).publishedAt,
                revokedAt: _meta(v.telegramId).revokedAt,
              ),
          ],
          forecastFirstHeight: [
            for (final v in r.forecastFirstHeight)
              FirstHeightTimelineEntry(
                arrivalTime: v.value?.arrivalTime,
                condition: v.value?.condition,
                revise: v.value?.revise,
                telegramId: v.telegramId,
                headline: _meta(v.telegramId).headline,
                title: _meta(v.telegramId).title,
                publishedAt: _meta(v.telegramId).publishedAt,
                revokedAt: _meta(v.telegramId).revokedAt,
              ),
          ],
          forecastMaxHeight: [
            for (final v in r.forecastMaxHeight)
              MaxHeightTimelineEntry(
                value: v.value?.value,
                isOver: v.value?.isOver,
                qualitative: v.value?.qualitative,
                isImportant: v.value?.isImportant,
                revise: v.value?.revise,
                telegramId: v.telegramId,
                headline: _meta(v.telegramId).headline,
                title: _meta(v.telegramId).title,
                publishedAt: _meta(v.telegramId).publishedAt,
                revokedAt: _meta(v.telegramId).revokedAt,
              ),
          ],
          estimationFirstHeight: [
            for (final v in r.estimationFirstHeight)
              EstimationFirstHeightTimelineEntry(
                arrivalTime: v.value?.arrivalTime,
                isAlreadyArrived: v.value?.isAlreadyArrived,
                revise: v.value?.revise,
                telegramId: v.telegramId,
                headline: _meta(v.telegramId).headline,
                title: _meta(v.telegramId).title,
                publishedAt: _meta(v.telegramId).publishedAt,
                revokedAt: _meta(v.telegramId).revokedAt,
              ),
          ],
          estimationMaxHeight: [
            for (final v in r.estimationMaxHeight)
              EstimationMaxHeightTimelineEntry(
                dateTime: v.value?.dateTime,
                value: v.value?.value,
                isOver: v.value?.isOver,
                qualitative: v.value?.qualitative,
                isObserving: v.value?.isObserving,
                revise: v.value?.revise,
                telegramId: v.telegramId,
                headline: _meta(v.telegramId).headline,
                title: _meta(v.telegramId).title,
                publishedAt: _meta(v.telegramId).publishedAt,
                revokedAt: _meta(v.telegramId).revokedAt,
              ),
          ],
          stations: [
            for (final s in r.stations)
              StationTimeline(
                code: s.code,
                name: s.name,
                forecast: [
                  for (final v in s.forecast)
                    StationForecastTimelineEntry(
                      highTideAt: v.value?.highTideAt,
                      firstHeightArrivalTime: v.value?.firstHeight?.arrivalTime,
                      firstHeightCondition: v.value?.firstHeight?.condition,
                      firstHeightRevise: v.value?.firstHeight?.revise,
                      telegramId: v.telegramId,
                      headline: _meta(v.telegramId).headline,
                      title: _meta(v.telegramId).title,
                      publishedAt: _meta(v.telegramId).publishedAt,
                      revokedAt: _meta(v.telegramId).revokedAt,
                    ),
                ],
                observation: [
                  for (final v in s.observation)
                    StationObservationTimelineEntry(
                      sensor: v.value?.sensor,
                      firstHeightArrivalTime: v.value?.firstHeight.arrivalTime,
                      firstHeightInitial: v.value?.firstHeight.initial,
                      firstHeightIsUnidentifiable:
                          v.value?.firstHeight.isUnidentifiable,
                      firstHeightIsMissing: v.value?.firstHeight.isMissing,
                      firstHeightRevise: v.value?.firstHeight.revise,
                      maxHeightDateTime: v.value?.maxHeight?.dateTime,
                      maxHeightValue: v.value?.maxHeight?.value,
                      maxHeightIsOver: v.value?.maxHeight?.isOver,
                      maxHeightIsRising: v.value?.maxHeight?.isRising,
                      maxHeightCondition: v.value?.maxHeight?.condition,
                      maxHeightIsMissing: v.value?.maxHeight?.isMissing,
                      maxHeightRevise: v.value?.maxHeight?.revise,
                      telegramId: v.telegramId,
                      headline: _meta(v.telegramId).headline,
                      title: _meta(v.telegramId).title,
                      publishedAt: _meta(v.telegramId).publishedAt,
                      revokedAt: _meta(v.telegramId).revokedAt,
                    ),
                ],
              ),
          ],
        ),
    ],
    offshoreStations: [
      for (final o in _tracked.offshoreStations)
        OffshoreStationTimeline(
          code: o.code,
          name: o.name,
          firstHeight: [
            for (final v in o.firstHeight)
              ObservationFirstHeightTimelineEntry(
                arrivalTime: v.value.arrivalTime,
                initial: v.value.initial,
                isUnidentifiable: v.value.isUnidentifiable,
                isMissing: v.value.isMissing,
                revise: v.value.revise,
                telegramId: v.telegramId,
                headline: _meta(v.telegramId).headline,
                title: _meta(v.telegramId).title,
                publishedAt: _meta(v.telegramId).publishedAt,
                revokedAt: _meta(v.telegramId).revokedAt,
              ),
          ],
          maxHeight: [
            for (final v in o.maxHeight)
              ObservationMaxHeightTimelineEntry(
                dateTime: v.value?.dateTime,
                value: v.value?.value,
                isOver: v.value?.isOver,
                isRising: v.value?.isRising,
                condition: v.value?.condition,
                isMissing: v.value?.isMissing,
                revise: v.value?.revise,
                telegramId: v.telegramId,
                headline: _meta(v.telegramId).headline,
                title: _meta(v.telegramId).title,
                publishedAt: _meta(v.telegramId).publishedAt,
                revokedAt: _meta(v.telegramId).revokedAt,
              ),
          ],
        ),
    ],
  );

  TsunamiTelegramMeta _meta(String telegramId) => _metaById[telegramId]!;
}
