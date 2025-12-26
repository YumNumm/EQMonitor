import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_accuracy.freezed.dart';
part 'eew_accuracy.g.dart';

/// EEWの精度情報
@freezed
abstract class EewAccuracy with _$EewAccuracy {
  const factory EewAccuracy({
    required List<int> epicenters,
    required int depth,
    required int magnitudeCalculation,
    required int numberOfMagnitudeCalculation,
  }) = _EewAccuracy;

  factory EewAccuracy.fromJson(Map<String, dynamic> json) =>
      _$EewAccuracyFromJson(json);
}
