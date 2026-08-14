import 'package:eqmonitor/feature/tsunami/data/model/tracking/tracked_offshore_station.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tracking/tracked_region.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tracking/tracked_region_station.dart';
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
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

/// 中間表現を公開型へ変換する extension。
/// トップレベル関数禁止のため private クラス経由で変換を行う。
extension TsunamiTelegramsResponseApiExt on api.TsunamiTelegramsResponse {
  TrackedTsunamiTimeline toTrackedTimeline() =>
      _TrackedTimelineBuilder(this).build();
}

/// region.code ごとの追跡状態を保持するアキュムレータ。
///
/// `Map`（`LinkedHashMap`）はキーの挿入順を保持するため、
/// 別途「出現順のリスト」を持つ必要がない。
class _RegionAccumulator {
  _RegionAccumulator({required this.name});

  String name;
  final Tracked<TsunamiWarningKind> kind = [];
  final Tracked<TsunamiWarningKind> lastKind = [];
  final Tracked<TsunamiForecastFirstHeight?> forecastFirstHeight = [];
  final Tracked<TsunamiForecastMaxHeight?> forecastMaxHeight = [];
  final Tracked<TsunamiEstimationFirstHeight?> estimationFirstHeight = [];
  final Tracked<TsunamiEstimationMaxHeight?> estimationMaxHeight = [];
  final Map<String, _StationAccumulator> stations = {};
}

/// region 内の station.code ごとの追跡状態を保持するアキュムレータ。
class _StationAccumulator {
  _StationAccumulator({required this.name});

  String name;
  final Tracked<TsunamiStationForecast?> forecast = [];
  final Tracked<TsunamiStationObservation?> observation = [];
}

/// offshore.code ごとの追跡状態を保持するアキュムレータ。
class _OffshoreAccumulator {
  _OffshoreAccumulator({required this.name});

  String name;
  final Tracked<TsunamiObservationFirstHeight> firstHeight = [];
  final Tracked<TsunamiObservationMaxHeight?> maxHeight = [];
}

class _TrackedTimelineBuilder {
  _TrackedTimelineBuilder(this._response);

  final api.TsunamiTelegramsResponse _response;

  TrackedTsunamiTimeline build() {
    final sorted = [..._response.telegrams]
      ..sort((a, b) {
        final byTime = a.telegram.pressedAt.compareTo(b.telegram.pressedAt);
        if (byTime != 0) {
          return byTime;
        }
        return (a.telegram.serialNo ?? 0).compareTo(b.telegram.serialNo ?? 0);
      });

    final telegrams = [for (final t in sorted) t.telegram.toTelegramMeta()];

    final regions = <String, _RegionAccumulator>{};
    final offshoreStations = <String, _OffshoreAccumulator>{};

    for (final t in sorted) {
      final id = t.telegram.id;
      for (final r in t.state.regions) {
        final region = regions.putIfAbsent(
          r.code,
          () => _RegionAccumulator(name: r.name),
        );
        region.name = r.name;
        _push(region.kind, r.kind.toDomain(), id);
        _push(region.lastKind, r.lastKind.toDomain(), id);
        _push(
          region.forecastFirstHeight,
          r.forecast?.firstHeight?.toDomain(),
          id,
        );
        _push(region.forecastMaxHeight, r.forecast?.maxHeight?.toDomain(), id);
        _push(
          region.estimationFirstHeight,
          r.estimation?.firstHeight.toDomain(),
          id,
        );
        _push(
          region.estimationMaxHeight,
          r.estimation?.maxHeight.toDomain(),
          id,
        );
        for (final s in r.stations) {
          final station = region.stations.putIfAbsent(
            s.code,
            () => _StationAccumulator(name: s.name),
          );
          station.name = s.name;
          _push(station.forecast, s.forecast?.toDomain(), id);
          _push(station.observation, s.observation?.toDomain(), id);
        }
      }
      for (final o in t.state.offshoreStations) {
        final offshore = offshoreStations.putIfAbsent(
          o.code,
          () => _OffshoreAccumulator(name: o.name),
        );
        offshore.name = o.name;
        _push(offshore.firstHeight, o.firstHeight.toDomain(), id);
        _push(offshore.maxHeight, o.maxHeight?.toDomain(), id);
      }
    }

    return TrackedTsunamiTimeline(
      telegrams: telegrams,
      regions: [
        for (final entry in regions.entries)
          TrackedRegion(
            code: entry.key,
            name: entry.value.name,
            kind: entry.value.kind,
            lastKind: entry.value.lastKind,
            forecastFirstHeight: entry.value.forecastFirstHeight,
            forecastMaxHeight: entry.value.forecastMaxHeight,
            estimationFirstHeight: entry.value.estimationFirstHeight,
            estimationMaxHeight: entry.value.estimationMaxHeight,
            stations: [
              for (final stationEntry in entry.value.stations.entries)
                TrackedRegionStation(
                  code: stationEntry.key,
                  name: stationEntry.value.name,
                  forecast: stationEntry.value.forecast,
                  observation: stationEntry.value.observation,
                ),
            ],
          ),
      ],
      offshoreStations: [
        for (final entry in offshoreStations.entries)
          TrackedOffshoreStation(
            code: entry.key,
            name: entry.value.name,
            firstHeight: entry.value.firstHeight,
            maxHeight: entry.value.maxHeight,
          ),
      ],
    );
  }

  /// 直前と値が異なる場合のみ変化点を追加する。
  void _push<T>(List<TrackedValue<T>> acc, T value, String telegramId) {
    if (acc.isNotEmpty && acc.last.value == value) {
      return;
    }
    acc.add(TrackedValue<T>(value: value, telegramId: telegramId));
  }
}
