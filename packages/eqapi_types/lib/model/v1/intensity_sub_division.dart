import 'package:eqapi_types/model/model.dart';
import 'package:eqapi_types/model/v3/telegram_v3.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'intensity_sub_division.freezed.dart';
part 'intensity_sub_division.g.dart';

@freezed
class IntensitySubDivision with _$IntensitySubDivision {
  const factory IntensitySubDivision({
    required int id,
    required int eventId,
    required JmaIntensity maxIntensity,
    required JmaLgIntensity? maxLpgmIntensity,
  }) = _IntensitySubDivision;

  factory IntensitySubDivision.fromJson(Map<String, dynamic> json) =>
      _$IntensitySubDivisionFromJson(json);
}
