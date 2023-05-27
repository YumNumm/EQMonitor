import 'package:freezed_annotation/freezed_annotation.dart';

part 'kmoni_observation_point.freezed.dart';

@freezed
class KmoniObservationPoint with _$KmoniObservationPoint {
  const factory KmoniObservationPoint({
    required String code,
    required String prefecture,
    required String name,
    required double latitude,
    required double longitude,
    required double x,
    required double y,
    required double arv,
  }) = _KmoniObservationPoint;
  const KmoniObservationPoint._();

  factory KmoniObservationPoint.fromList(List<String> list) {
    return KmoniObservationPoint(
      code: list[0],
      prefecture: list[1],
      name: list[2],
      latitude: double.parse(list[3]),
      longitude: double.parse(list[4]),
      x: double.parse(list[5]),
      y: double.parse(list[6]),
      arv: double.parse(list[7]),
    );
  }
}
