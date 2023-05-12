import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsunami_observations.freezed.dart';
part 'tsunami_observations.g.dart';

@freezed
class TsunamiObservation with _$TsunamiObservation {
  const factory TsunamiObservation({
    required String? code,
    required String? name,
    required List<TsunamiObservationStation> stations,
  }) = _TsunamiObservation;

  factory TsunamiObservation.fromJson(Map<String, dynamic> json) =>
      _$TsunamiObservationFromJson(json);
}

@freezed
class TsunamiObservationStation with _$TsunamiObservationStation {
  const factory TsunamiObservationStation({
    required String code,
    required String name,

    /// nullの時は`識別不能`
    required DateTime? firstHeightArrivalTime,
    required TsunamiObservationFirstHeightInitial? firstHeightInitial,
    required DateTime? maxHeightTime,
    required double? maxHeightValue,

    /// `maxHeightValue`「以上」かどうか
    required bool? maxHeightIsOver,

    ///  上昇中かどうか
    required bool? maxHeightIsRising,
    required TsunamiObservationStationCondition? condition,
  }) = _TsunamiObservationStation;

  factory TsunamiObservationStation.fromJson(Map<String, dynamic> json) =>
      _$TsunamiObservationStationFromJson(json);
}

@JsonEnum(valueField: 'type')
enum TsunamiObservationFirstHeightInitial {
  push('押し'),
  pull('引き');

  const TsunamiObservationFirstHeightInitial(this.type);
  final String type;
}

@JsonEnum(valueField: 'type')
enum TsunamiObservationStationCondition {
  weak('微弱'),
  observing('観測中'),
  important('重要');

  const TsunamiObservationStationCondition(this.type);
  final String type;
}
