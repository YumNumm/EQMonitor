import 'package:freezed_annotation/freezed_annotation.dart';

part 'device.freezed.dart';
part 'device.g.dart';

/// デバイスタイプ
@JsonEnum(valueField: 'value')
enum DeviceType {
  @JsonValue('IOS')
  ios('IOS'),
  @JsonValue('ANDROID')
  android('ANDROID')
  ;

  const DeviceType(this.value);
  final String value;
}

/// デバイス情報
@freezed
abstract class Device with _$Device {
  const factory Device({
    required String id,
    required DeviceType type,
    required String userId,
    required String createdAt,
    required String updatedAt,
  }) = _Device;

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);
}

/// APNsトークンタイプ
@JsonEnum(valueField: 'value')
enum ApnsTokenType {
  @JsonValue('NOTIFICATION')
  notification('NOTIFICATION'),
  @JsonValue('LIVE_ACTIVITY_START')
  liveActivityStart('LIVE_ACTIVITY_START')
  ;

  const ApnsTokenType(this.value);
  final String value;
}

/// APNsトークン
@freezed
abstract class ApnsToken with _$ApnsToken {
  const factory ApnsToken({
    required ApnsTokenType type,
    required String token,
  }) = _ApnsToken;

  factory ApnsToken.fromJson(Map<String, dynamic> json) =>
      _$ApnsTokenFromJson(json);
}

/// APNsトークンリクエスト
@freezed
abstract class ApnsTokenRequest with _$ApnsTokenRequest {
  const factory ApnsTokenRequest({
    required String token,
  }) = _ApnsTokenRequest;

  factory ApnsTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$ApnsTokenRequestFromJson(json);
}

/// FCMトークン
@freezed
abstract class FcmToken with _$FcmToken {
  const factory FcmToken({
    required String token,
  }) = _FcmToken;

  factory FcmToken.fromJson(Map<String, dynamic> json) =>
      _$FcmTokenFromJson(json);
}

/// FCMトークンリクエスト
@freezed
abstract class FcmTokenRequest with _$FcmTokenRequest {
  const factory FcmTokenRequest({
    required String token,
  }) = _FcmTokenRequest;

  factory FcmTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$FcmTokenRequestFromJson(json);
}
