import 'package:eqmonitor/feature/tsunami/data/model/tracking/tracked_offshore_station.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tracking/tracked_region.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_telegram_meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tracked_tsunami_timeline.freezed.dart';

@freezed
abstract class TrackedTsunamiTimeline with _$TrackedTsunamiTimeline {
  const factory({
    required List<TsunamiTelegramMeta> telegrams,
    required List<TrackedRegion> regions,
    required List<TrackedOffshoreStation> offshoreStations,
  }) = _TrackedTsunamiTimeline;
}
