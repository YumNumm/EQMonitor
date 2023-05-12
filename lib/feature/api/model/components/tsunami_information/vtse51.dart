import 'package:eqmonitor/feature/api/model/components/tsunami_information/tsunami_forecast.dart';
import 'package:eqmonitor/feature/api/model/components/tsunami_information/tsunami_observations.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'vtse51.freezed.dart';
part 'vtse51.g.dart';

@freezed
class PublicBodyVtse51Tsunami with _$PublicBodyVtse51Tsunami {
  const factory PublicBodyVtse51Tsunami({
    required List<TsunamiForecast> forecast,
    required List<TsunamiObservation>? observation,
  }) = _PublicBodyVtse51Tsunami;

  factory PublicBodyVtse51Tsunami.fromJson(Map<String, dynamic> json) =>
      _$PublicBodyVtse51TsunamiFromJson(json);
}
