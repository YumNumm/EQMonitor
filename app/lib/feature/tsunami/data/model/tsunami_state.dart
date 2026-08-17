import 'package:eqmonitor/feature/tsunami/data/model/tsunami_offshore_station.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_region.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_state_earthquake.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_telegram_meta.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsunami_state.freezed.dart';

/// 津波情報全体のドメインモデル
@freezed
abstract class TsunamiState with _$TsunamiState {
  const factory({
    required String id,
    required List<String> eventIds,
    required bool isActive,
    required bool isCanceled,
    required DateTime updatedAt,
    required List<TsunamiStateEarthquake> earthquakes,
    required List<TsunamiTelegramMeta> latestTelegrams,
    required List<TsunamiRegion> regions,
    required List<TsunamiOffshoreStation> offshoreStations,
  }) = _TsunamiState;
}

extension TsunamiStateApiExt on api.TsunamiState {
  TsunamiState toDomain() => TsunamiState(
    id: id,
    eventIds: eventIds,
    isActive: isActive,
    isCanceled: isCanceled,
    updatedAt: updatedAt,
    earthquakes: earthquakes.map((e) => e.toDomain()).toList(),
    latestTelegrams: latestTelegrams.map((e) => e.toTelegramMeta()).toList(),
    regions: regions.map((e) => e.toDomain()).toList(),
    offshoreStations: offshoreStations.map((e) => e.toDomain()).toList(),
  );
}
