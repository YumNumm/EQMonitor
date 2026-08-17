import 'package:eqmonitor/feature/tsunami/data/model/timeline/offshore_station_timeline.dart';
import 'package:eqmonitor/feature/tsunami/data/model/timeline/region_timeline.dart';
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
