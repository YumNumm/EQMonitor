import 'package:freezed_annotation/freezed_annotation.dart';

part 'accuracy.freezed.dart';
part 'accuracy.g.dart';

@freezed
class EewAccuracy with _$EewAccuracy {
  const factory EewAccuracy({
    required List<String> epicenters,
    required String depth,
    required String magnitudeCalculation,
    required String numberOfMagnitudeCalculation,
  }) = _EewAccuracy;

  factory EewAccuracy.fromJson(Map<String, dynamic> json) =>
      _$EewAccuracyFromJson(json);
}
