import 'package:freezed_annotation/freezed_annotation.dart';

part 'ws_shake_payload.freezed.dart';
part 'ws_shake_payload.g.dart';

@freezed
abstract class WsShakeLocationPayload with _$WsShakeLocationPayload {
  const factory WsShakeLocationPayload({
    required double latitude,
    required double longitude,
  }) = _WsShakeLocationPayload;

  factory WsShakeLocationPayload.fromJson(Map<String, dynamic> json) =>
      _$WsShakeLocationPayloadFromJson(json);
}

@freezed
abstract class WsShakeRegionPayload with _$WsShakeRegionPayload {
  const factory WsShakeRegionPayload({
    required WsShakeLocationPayload topLeft,
    required WsShakeLocationPayload bottomRight,
  }) = _WsShakeRegionPayload;

  factory WsShakeRegionPayload.fromJson(Map<String, dynamic> json) =>
      _$WsShakeRegionPayloadFromJson(json);
}
