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

    // region.code -> 各追跡項目のアキュムレータ
    final regionCodes = <String>[];
    final kind = <String, Tracked<TsunamiWarningKind>>{};
    final lastKind = <String, Tracked<TsunamiWarningKind>>{};
    final fcFirst = <String, Tracked<TsunamiForecastFirstHeight?>>{};
    final fcMax = <String, Tracked<TsunamiForecastMaxHeight?>>{};
    final esFirst = <String, Tracked<TsunamiEstimationFirstHeight?>>{};
    final esMax = <String, Tracked<TsunamiEstimationMaxHeight?>>{};
    final regionName = <String, String>{};
    // region.code -> station.code -> アキュムレータ
    final stationOrder = <String, List<String>>{};
    final stationName = <String, Map<String, String>>{};
    final stFc = <String, Map<String, Tracked<TsunamiStationForecast?>>>{};
    final stOb = <String, Map<String, Tracked<TsunamiStationObservation?>>>{};
    // offshore.code -> アキュムレータ
    final offshoreCodes = <String>[];
    final offshoreName = <String, String>{};
    final offFirst = <String, Tracked<TsunamiObservationFirstHeight>>{};
    final offMax = <String, Tracked<TsunamiObservationMaxHeight?>>{};

    for (final t in sorted) {
      final id = t.telegram.id;
      for (final r in t.state.regions) {
        if (!regionCodes.contains(r.code)) {
          regionCodes.add(r.code);
          kind[r.code] = [];
          lastKind[r.code] = [];
          fcFirst[r.code] = [];
          fcMax[r.code] = [];
          esFirst[r.code] = [];
          esMax[r.code] = [];
          stationOrder[r.code] = [];
          stationName[r.code] = {};
          stFc[r.code] = {};
          stOb[r.code] = {};
        }
        regionName[r.code] = r.name;
        _push(kind[r.code]!, r.kind.toDomain(), id);
        _push(lastKind[r.code]!, r.lastKind.toDomain(), id);
        _push(fcFirst[r.code]!, r.forecast?.firstHeight?.toDomain(), id);
        _push(fcMax[r.code]!, r.forecast?.maxHeight?.toDomain(), id);
        _push(esFirst[r.code]!, r.estimation?.firstHeight.toDomain(), id);
        _push(esMax[r.code]!, r.estimation?.maxHeight.toDomain(), id);
        for (final s in r.stations) {
          if (!stationOrder[r.code]!.contains(s.code)) {
            stationOrder[r.code]!.add(s.code);
            stFc[r.code]![s.code] = [];
            stOb[r.code]![s.code] = [];
          }
          stationName[r.code]![s.code] = s.name;
          _push(stFc[r.code]![s.code]!, s.forecast?.toDomain(), id);
          _push(stOb[r.code]![s.code]!, s.observation?.toDomain(), id);
        }
      }
      for (final o in t.state.offshoreStations) {
        if (!offshoreCodes.contains(o.code)) {
          offshoreCodes.add(o.code);
          offFirst[o.code] = [];
          offMax[o.code] = [];
        }
        offshoreName[o.code] = o.name;
        _push(offFirst[o.code]!, o.firstHeight.toDomain(), id);
        _push(offMax[o.code]!, o.maxHeight?.toDomain(), id);
      }
    }

    return TrackedTsunamiTimeline(
      telegrams: telegrams,
      regions: [
        for (final code in regionCodes)
          TrackedRegion(
            code: code,
            name: regionName[code]!,
            kind: kind[code]!,
            lastKind: lastKind[code]!,
            forecastFirstHeight: fcFirst[code]!,
            forecastMaxHeight: fcMax[code]!,
            estimationFirstHeight: esFirst[code]!,
            estimationMaxHeight: esMax[code]!,
            stations: [
              for (final sc in stationOrder[code]!)
                TrackedRegionStation(
                  code: sc,
                  name: stationName[code]![sc]!,
                  forecast: stFc[code]![sc]!,
                  observation: stOb[code]![sc]!,
                ),
            ],
          ),
      ],
      offshoreStations: [
        for (final code in offshoreCodes)
          TrackedOffshoreStation(
            code: code,
            name: offshoreName[code]!,
            firstHeight: offFirst[code]!,
            maxHeight: offMax[code]!,
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
