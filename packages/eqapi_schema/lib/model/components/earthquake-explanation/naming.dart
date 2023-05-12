import 'package:freezed_annotation/freezed_annotation.dart';
part 'naming.freezed.dart';
part 'naming.g.dart';

@freezed
class Naming with _$Naming {
  const factory Naming({
    required String text,
    required String? en,
  }) = _Naming;


  factory Naming.fromJson(Map<String, dynamic> json) =>
    _$NamingFromJson(json);
}