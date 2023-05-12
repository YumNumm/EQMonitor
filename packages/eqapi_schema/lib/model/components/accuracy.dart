import 'package:freezed_annotation/freezed_annotation.dart';

part 'accuracy.freezed.dart';
part 'accuracy.g.dart';

@freezed
class EewAccuracy with _$EewAccuracy {
  const factory EewAccuracy({
    required List<int> epicenters,
    required int depth,
    required int magnitudeCalculation,
    required int numberOfMagnitudeCalculation,
  }) = _EewAccuracy;

  factory EewAccuracy.fromJson(Map<String, dynamic> json) =>
      _$EewAccuracyFromJson(json);
}
