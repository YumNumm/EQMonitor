import 'package:freezed_annotation/freezed_annotation.dart';

part 'headless_api_identity.freezed.dart';
part 'headless_api_identity.g.dart';

@freezed
abstract class HeadlessApiIdentity with _$HeadlessApiIdentity {
  const factory({
    required String userAgent,
    required String version,
    required String platform,
    required String deviceId,
  }) = _HeadlessApiIdentity;

  factory fromJson(Map<String, dynamic> json) =>
      _$HeadlessApiIdentityFromJson(json);
}
