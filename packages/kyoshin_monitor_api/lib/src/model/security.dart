import 'package:freezed_annotation/freezed_annotation.dart';

part 'security.freezed.dart';
part 'security.g.dart';

@freezed
class Security with _$Security {
  const factory Security({
    required String? realm,
    required String? hash,
  }) = _Security;

  factory Security.fromJson(Map<String, dynamic> json) =>
      _$SecurityFromJson(json);
}
