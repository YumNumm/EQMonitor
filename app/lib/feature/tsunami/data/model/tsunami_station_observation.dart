import 'package:eqmonitor/feature/tsunami/data/model/tsunami_observation_first_height.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_observation_max_height.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsunami_station_observation.freezed.dart';

@freezed
abstract class TsunamiStationObservation with _$TsunamiStationObservation {
  const factory TsunamiStationObservation({
    required String? sensor,
    required TsunamiObservationFirstHeight firstHeight,
    required TsunamiObservationMaxHeight? maxHeight,
  }) = _TsunamiStationObservation;
}

extension TsunamiStationObservationApiExt on api.TsunamiStationObservation {
  TsunamiStationObservation toDomain() => TsunamiStationObservation(
    sensor: sensor,
    firstHeight: firstHeight.toDomain(),
    maxHeight: maxHeight?.toDomain(),
  );
}
