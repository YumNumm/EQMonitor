import 'package:eqapi_schema/model/components/tsunami-information/tsunami_estimation.dart';
import 'package:eqapi_schema/model/components/tsunami-information/tsunami_observations.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'vtse52.freezed.dart';
part 'vtse52.g.dart';

@freezed
class PublicBodyVtse52Tsunami with _$PublicBodyVtse52Tsunami {
  const factory PublicBodyVtse52Tsunami({
    required List<TsunamiObservation>? observation,
    required List<TsunamiEstimation>? estimations,
  }) = _PublicBodyVtse52Tsunami;

  factory PublicBodyVtse52Tsunami.fromJson(Map<String, dynamic> json) =>
      _$PublicBodyVtse52TsunamiFromJson(json);
}
