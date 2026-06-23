import 'package:freezed_annotation/freezed_annotation.dart';

part 'ws_estimated_intensity_payload.freezed.dart';
part 'ws_estimated_intensity_payload.g.dart';

@freezed
abstract class WsEstimatedIntensityPayload with _$WsEstimatedIntensityPayload {
  const factory WsEstimatedIntensityPayload({
    required String eventId,
    required String estimatedIntensityKey,
    required DateTime createdAt,
    WsEstimatedIntensityHypocenter? hypocenter,
  }) = _WsEstimatedIntensityPayload;

  factory WsEstimatedIntensityPayload.fromJson(Map<String, dynamic> json) =>
      _$WsEstimatedIntensityPayloadFromJson(json);
}

@freezed
abstract class WsEstimatedIntensityHypocenter
    with _$WsEstimatedIntensityHypocenter {
  const factory WsEstimatedIntensityHypocenter({
    required int regionCode,
    required DateTime originTime,
    String? regionName,
    double? magnitude,
    double? depthKm,
  }) = _WsEstimatedIntensityHypocenter;

  factory WsEstimatedIntensityHypocenter.fromJson(
    Map<String, dynamic> json,
  ) => _$WsEstimatedIntensityHypocenterFromJson(json);
}
