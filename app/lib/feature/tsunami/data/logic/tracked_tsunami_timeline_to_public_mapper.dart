import 'package:eqmonitor/feature/tsunami/data/model/timeline/estimation_timeline_entry.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/first_height_timeline_entry.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/kind_timeline_entry.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/max_height_timeline_entry.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/observation_timeline_entry.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/offshore_station_timeline.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/region_timeline.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/station_timeline.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/station_timeline_entry.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/tsunami_timeline.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tracking/tracked_tsunami_timeline.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tracking/tracked_value.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_estimation_first_height.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_estimation_max_height.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_forecast_first_height.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_forecast_max_height.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_observation_first_height.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_observation_max_height.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_station_forecast.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_station_observation.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_telegram_meta.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/tsunami_warning_kind.dart';

/// 中間表現を公開型へ変換する extension。
/// トップレベル関数禁止のため private クラス経由で変換を行う。
extension TrackedTsunamiTimelineMapping on TrackedTsunamiTimeline {
  TsunamiTimeline toPublic() => _TsunamiTimelineMapper(this).map();
}

class _TsunamiTimelineMapper {
  new(this._tracked)
    : _metaById = {for (final m in _tracked.telegrams) m.telegramId: m};

  final TrackedTsunamiTimeline _tracked;
  final Map<String, TsunamiTelegramMeta> _metaById;

  TsunamiTimeline map() => TsunamiTimeline(
    telegrams: _tracked.telegrams,
    regions: [
      for (final r in _tracked.regions)
        RegionTimeline(
          code: r.code,
          name: r.name,
          kind: [for (final v in r.kind) _kindEntry(v)],
          lastKind: [for (final v in r.lastKind) _kindEntry(v)],
          forecastFirstHeight: [
            for (final v in r.forecastFirstHeight) _forecastFirstHeightEntry(v),
          ],
          forecastMaxHeight: [
            for (final v in r.forecastMaxHeight) _forecastMaxHeightEntry(v),
          ],
          estimationFirstHeight: [
            for (final v in r.estimationFirstHeight)
              _estimationFirstHeightEntry(v),
          ],
          estimationMaxHeight: [
            for (final v in r.estimationMaxHeight) _estimationMaxHeightEntry(v),
          ],
          stations: [
            for (final s in r.stations)
              StationTimeline(
                code: s.code,
                name: s.name,
                forecast: [
                  for (final v in s.forecast) _stationForecastEntry(v),
                ],
                observation: [
                  for (final v in s.observation) _stationObservationEntry(v),
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
            for (final v in o.firstHeight) _observationFirstHeightEntry(v),
          ],
          maxHeight: [
            for (final v in o.maxHeight) _observationMaxHeightEntry(v),
          ],
        ),
    ],
  );

  KindTimelineEntry _kindEntry(TrackedValue<TsunamiWarningKind> v) {
    final meta = _meta(v.telegramId);
    return KindTimelineEntry(
      kind: v.value,
      telegramId: v.telegramId,
      headline: meta.headline,
      title: meta.title,
      publishedAt: meta.publishedAt,
      revokedAt: meta.revokedAt,
    );
  }

  FirstHeightTimelineEntry _forecastFirstHeightEntry(
    TrackedValue<TsunamiForecastFirstHeight?> v,
  ) {
    final meta = _meta(v.telegramId);
    return FirstHeightTimelineEntry(
      arrivalTime: v.value?.arrivalTime,
      condition: v.value?.condition,
      revise: v.value?.revise,
      telegramId: v.telegramId,
      headline: meta.headline,
      title: meta.title,
      publishedAt: meta.publishedAt,
      revokedAt: meta.revokedAt,
    );
  }

  MaxHeightTimelineEntry _forecastMaxHeightEntry(
    TrackedValue<TsunamiForecastMaxHeight?> v,
  ) {
    final meta = _meta(v.telegramId);
    return MaxHeightTimelineEntry(
      value: v.value?.value,
      isOver: v.value?.isOver,
      qualitative: v.value?.qualitative,
      isImportant: v.value?.isImportant,
      revise: v.value?.revise,
      telegramId: v.telegramId,
      headline: meta.headline,
      title: meta.title,
      publishedAt: meta.publishedAt,
      revokedAt: meta.revokedAt,
    );
  }

  EstimationFirstHeightTimelineEntry _estimationFirstHeightEntry(
    TrackedValue<TsunamiEstimationFirstHeight?> v,
  ) {
    final meta = _meta(v.telegramId);
    return EstimationFirstHeightTimelineEntry(
      arrivalTime: v.value?.arrivalTime,
      isAlreadyArrived: v.value?.isAlreadyArrived,
      revise: v.value?.revise,
      telegramId: v.telegramId,
      headline: meta.headline,
      title: meta.title,
      publishedAt: meta.publishedAt,
      revokedAt: meta.revokedAt,
    );
  }

  EstimationMaxHeightTimelineEntry _estimationMaxHeightEntry(
    TrackedValue<TsunamiEstimationMaxHeight?> v,
  ) {
    final meta = _meta(v.telegramId);
    return EstimationMaxHeightTimelineEntry(
      dateTime: v.value?.dateTime,
      value: v.value?.value,
      isOver: v.value?.isOver,
      qualitative: v.value?.qualitative,
      isObserving: v.value?.isObserving,
      revise: v.value?.revise,
      telegramId: v.telegramId,
      headline: meta.headline,
      title: meta.title,
      publishedAt: meta.publishedAt,
      revokedAt: meta.revokedAt,
    );
  }

  StationForecastTimelineEntry _stationForecastEntry(
    TrackedValue<TsunamiStationForecast?> v,
  ) {
    final meta = _meta(v.telegramId);
    return StationForecastTimelineEntry(
      highTideAt: v.value?.highTideAt,
      firstHeightArrivalTime: v.value?.firstHeight?.arrivalTime,
      firstHeightCondition: v.value?.firstHeight?.condition,
      firstHeightRevise: v.value?.firstHeight?.revise,
      telegramId: v.telegramId,
      headline: meta.headline,
      title: meta.title,
      publishedAt: meta.publishedAt,
      revokedAt: meta.revokedAt,
    );
  }

  StationObservationTimelineEntry _stationObservationEntry(
    TrackedValue<TsunamiStationObservation?> v,
  ) {
    final meta = _meta(v.telegramId);
    return StationObservationTimelineEntry(
      sensor: v.value?.sensor,
      firstHeightArrivalTime: v.value?.firstHeight.arrivalTime,
      firstHeightInitial: v.value?.firstHeight.initial,
      firstHeightIsUnidentifiable: v.value?.firstHeight.isUnidentifiable,
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
      headline: meta.headline,
      title: meta.title,
      publishedAt: meta.publishedAt,
      revokedAt: meta.revokedAt,
    );
  }

  ObservationFirstHeightTimelineEntry _observationFirstHeightEntry(
    TrackedValue<TsunamiObservationFirstHeight> v,
  ) {
    final meta = _meta(v.telegramId);
    return ObservationFirstHeightTimelineEntry(
      arrivalTime: v.value.arrivalTime,
      initial: v.value.initial,
      isUnidentifiable: v.value.isUnidentifiable,
      isMissing: v.value.isMissing,
      revise: v.value.revise,
      telegramId: v.telegramId,
      headline: meta.headline,
      title: meta.title,
      publishedAt: meta.publishedAt,
      revokedAt: meta.revokedAt,
    );
  }

  ObservationMaxHeightTimelineEntry _observationMaxHeightEntry(
    TrackedValue<TsunamiObservationMaxHeight?> v,
  ) {
    final meta = _meta(v.telegramId);
    return ObservationMaxHeightTimelineEntry(
      dateTime: v.value?.dateTime,
      value: v.value?.value,
      isOver: v.value?.isOver,
      isRising: v.value?.isRising,
      condition: v.value?.condition,
      isMissing: v.value?.isMissing,
      revise: v.value?.revise,
      telegramId: v.telegramId,
      headline: meta.headline,
      title: meta.title,
      publishedAt: meta.publishedAt,
      revokedAt: meta.revokedAt,
    );
  }

  TsunamiTelegramMeta _meta(String telegramId) {
    final meta = _metaById[telegramId];
    if (meta == null) {
      throw ArgumentError.value(
        telegramId,
        'telegramId',
        'no telegram meta for id',
      );
    }
    return meta;
  }
}
