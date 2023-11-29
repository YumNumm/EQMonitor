import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsunami_forecast.freezed.dart';
part 'tsunami_forecast.g.dart';

@freezed
class TsunamiForecast with _$TsunamiForecast {
  const factory TsunamiForecast({
    required String code,
    required String name,

    /// 種別コードを用いる
    required String kind,
    required String lastKind,
    required TsunamiForecastFirstHeight? firstHeight,
    required TsunamiForecastMaxHeight? maxHeight,
    required List<TsunamiForecastStation>? stations,
  }) = _TsunamiForecast;

  factory TsunamiForecast.fromJson(Map<String, dynamic> json) =>
      _$TsunamiForecastFromJson(json);
}

@freezed
class TsunamiForecastFirstHeight with _$TsunamiForecastFirstHeight {
  const factory TsunamiForecastFirstHeight({
    required DateTime? arrivalTime,
    required TsunamiForecastCondition? condition,
  }) = _TsunamiForecastFirstHeight;
  factory TsunamiForecastFirstHeight.fromJson(Map<String, dynamic> json) =>
      _$TsunamiForecastFirstHeightFromJson(json);
}

@JsonEnum(valueField: 'type')
enum TsunamiForecastCondition {
  tsunamiArrival('津波到達中と推測'),
  tsunamiFirstArrival('第１波の到達を確認'),
  tsunamiImminent('ただちに津波来襲と予測');

  const TsunamiForecastCondition(this.type);
  final String type;
}

@freezed
class TsunamiForecastMaxHeight with _$TsunamiForecastMaxHeight {
  const factory TsunamiForecastMaxHeight({
    required double? value,
    required bool? isOver,
    required TsunamiForecastMaxHeightCondition? condition,
  }) = _TsunamiForecastMaxHeight;
  factory TsunamiForecastMaxHeight.fromJson(Map<String, dynamic> json) =>
      _$TsunamiForecastMaxHeightFromJson(json);
}

@JsonEnum(valueField: 'type')
enum TsunamiForecastMaxHeightCondition {
  high('高い'),
  huge('莫大');

  const TsunamiForecastMaxHeightCondition(this.type);
  final String type;
}

@freezed
class TsunamiForecastStation with _$TsunamiForecastStation {
  const factory TsunamiForecastStation({
    required String code,
    required String name,
    required DateTime highTideTime,
    required DateTime? firstHeightTime,
    required TsunamiForecastStationCondition? condition,
  }) = _TsunamiForecastStation;

  factory TsunamiForecastStation.fromJson(Map<String, dynamic> json) =>
      _$TsunamiForecastStationFromJson(json);
}

@JsonEnum(valueField: 'type')
enum TsunamiForecastStationCondition {
  tsunamiArrival('津波到達中と推測'),
  tsunamiFirstArrival('第１波の到達を確認');

  const TsunamiForecastStationCondition(this.type);
  final String type;
}
