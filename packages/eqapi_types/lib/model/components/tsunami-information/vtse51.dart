import 'package:eqapi_types/model/components/tsunami-information/tsunami_forecast.dart';
import 'package:eqapi_types/model/components/tsunami-information/tsunami_observations.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'vtse51.freezed.dart';
part 'vtse51.g.dart';

@freezed
class PublicBodyVtse51Tsunami with _$PublicBodyVtse51Tsunami {
  const factory PublicBodyVtse51Tsunami({
    required List<TsunamiForecast> forecasts,
    required List<TsunamiObservation>? observations,
  }) = _PublicBodyVtse51Tsunami;

  factory PublicBodyVtse51Tsunami.fromJson(Map<String, dynamic> json) =>
      _$PublicBodyVtse51TsunamiFromJson(json);
}
