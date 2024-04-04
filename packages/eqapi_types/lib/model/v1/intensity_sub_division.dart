import 'package:eqapi_types/eqapi_types.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'intensity_sub_division.freezed.dart';
part 'intensity_sub_division.g.dart';

@freezed
class IntensitySubDivision with _$IntensitySubDivision implements V1Database {
  const factory IntensitySubDivision({
    required int id,
    required int eventId,
    required String areaCode,
    required JmaIntensity maxIntensity,
    required JmaLgIntensity? maxLpgmIntensity,
  }) = _IntensitySubDivision;

  factory IntensitySubDivision.fromJson(Map<String, dynamic> json) =>
      _$IntensitySubDivisionFromJson(json);
}
