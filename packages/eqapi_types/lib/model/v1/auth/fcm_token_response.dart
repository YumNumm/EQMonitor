import 'package:freezed_annotation/freezed_annotation.dart';

part 'fcm_token_response.freezed.dart';
part 'fcm_token_response.g.dart';

@freezed
class FcmTokenUpdateResponse with _$FcmTokenUpdateResponse {
  const factory FcmTokenUpdateResponse({
    required String? token,
    required String? fcmVerify,
  }) = _FcmTokenUpdateResponse;

  factory FcmTokenUpdateResponse.fromJson(Map<String, dynamic> json) =>
      _$FcmTokenUpdateResponseFromJson(json);
}
