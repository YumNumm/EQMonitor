import 'package:eqapi_types/model/components/tsunami-information/tsunami_forecast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'vtse41.freezed.dart';
part 'vtse41.g.dart';

@freezed
class PublicBodyVtse41Tsunami with _$PublicBodyVtse41Tsunami {
  const factory PublicBodyVtse41Tsunami({
    required List<TsunamiForecast> forecasts,
  }) = _PublicBodyVtse41Tsunami;

  factory PublicBodyVtse41Tsunami.fromJson(Map<String, dynamic> json) =>
      _$PublicBodyVtse41TsunamiFromJson(json);
}
