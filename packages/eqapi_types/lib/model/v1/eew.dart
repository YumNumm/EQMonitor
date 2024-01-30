import 'package:eqapi_types/lib.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew.freezed.dart';
part 'eew.g.dart';

@freezed
class EewV1 with _$EewV1 {
  const factory EewV1({
    required int id,
    required int eventId,
    required String type,
    required String schemaType,
    required String status,
    required String infoType,
    int? serialno,
    String? headline,
    required bool isCanceled,
    bool? isWarning,
    required bool isLastInfo,
    DateTime? originTime,
    DateTime? arrivalTime,
    String? hypoName,
    int? depth,
    double? magnitude,
    JmaForecastIntensity? forecastMaxIntensity,
    JmaForecastLgIntensity? forecastMaxLpgmIntensity,
  }) = _EewV1;

  factory EewV1.fromJson(Map<String, dynamic> json) => _$EewV1FromJson(json);
}
