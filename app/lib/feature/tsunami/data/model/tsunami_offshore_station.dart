import 'package:eqmonitor/feature/tsunami/data/model/tsunami_observation_first_height.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_observation_max_height.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsunami_offshore_station.freezed.dart';

/// 沖合津波観測点のドメインモデル
@freezed
abstract class TsunamiOffshoreStation with _$TsunamiOffshoreStation {
  const factory({
    required String code,
    required String name,
    required TsunamiObservationFirstHeight firstHeight,
    String? sensor,
    TsunamiObservationMaxHeight? maxHeight,
  }) = _TsunamiOffshoreStation;
}

extension TsunamiOffshoreStationApiExt on api.TsunamiOffshoreStation {
  TsunamiOffshoreStation toDomain() => TsunamiOffshoreStation(
    code: code,
    name: name,
    firstHeight: firstHeight.toDomain(),
    sensor: sensor,
    maxHeight: maxHeight?.toDomain(),
  );
}
