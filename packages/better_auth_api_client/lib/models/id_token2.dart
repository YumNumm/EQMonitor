// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'id_token2.freezed.dart';
part 'id_token2.g.dart';

@Freezed()
abstract class IdToken2 with _$IdToken2 {
  const factory IdToken2({
    required String token,
    @JsonKey(includeIfNull: false)
    String? nonce,
    @JsonKey(includeIfNull: false)
    String? accessToken,
    @JsonKey(includeIfNull: false)
    String? refreshToken,
    @JsonKey(includeIfNull: false)
    List<dynamic>? scopes,
  }) = _IdToken2;
  
  factory IdToken2.fromJson(Map<String, Object?> json) => _$IdToken2FromJson(json);
}
