import 'package:freezed_annotation/freezed_annotation.dart';

part 'ws_estimated_intensity_payload.freezed.dart';
part 'ws_estimated_intensity_payload.g.dart';

@freezed
abstract class WsEstimatedIntensityPayload with _$WsEstimatedIntensityPayload {
  const factory({
    required String eventId,
    required String estimatedIntensityKey,
    required DateTime createdAt,
    WsEstimatedIntensityHypocenter? hypocenter,
  }) = _WsEstimatedIntensityPayload;

  factory fromJson(Map<String, dynamic> json) =>
      _$WsEstimatedIntensityPayloadFromJson(json);
}

@freezed
abstract class WsEstimatedIntensityHypocenter
    with _$WsEstimatedIntensityHypocenter {
  const factory({
    required int regionCode,
    required DateTime originTime,
    String? regionName,
    double? magnitude,
    double? depthKm,
  }) = _WsEstimatedIntensityHypocenter;

  factory fromJson(
    Map<String, dynamic> json,
  ) => _$WsEstimatedIntensityHypocenterFromJson(json);
}
