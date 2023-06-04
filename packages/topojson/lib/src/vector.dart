import 'package:freezed_annotation/freezed_annotation.dart';

part 'vector.freezed.dart';
part 'vector.g.dart';

@freezed
class DoubleVector with _$DoubleVector {
  const factory DoubleVector({
    required double x,
    required double y,
  }) = _DoubleVector;

  factory DoubleVector.fromJson(Map<String, dynamic> json) =>
      _$DoubleVectorFromJson(json);
}

@freezed
class IntVector with _$IntVector {
  const factory IntVector({
    required int x,
    required int y,
  }) = _IntVector;

  factory IntVector.fromJson(Map<String, dynamic> json) =>
      _$IntVectorFromJson(json);
}
