import 'package:freezed_annotation/freezed_annotation.dart';

part 'security.freezed.dart';
part 'security.g.dart';

@freezed
abstract class Security with _$Security {
  const factory({required String? realm, required String? hash}) =
      _Security;

  factory fromJson(Map<String, dynamic> json) =>
      _$SecurityFromJson(json);
}
