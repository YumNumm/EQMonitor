import 'package:eqmonitor/feature/tsunami/data/model/tracking/tracked_value.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_observation_first_height.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_observation_max_height.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tracked_offshore_station.freezed.dart';

@freezed
abstract class TrackedOffshoreStation with _$TrackedOffshoreStation {
  const factory TrackedOffshoreStation({
    required String code,
    required String name,
    required Tracked<TsunamiObservationFirstHeight> firstHeight,
    required Tracked<TsunamiObservationMaxHeight?> maxHeight,
  }) = _TrackedOffshoreStation;
}
