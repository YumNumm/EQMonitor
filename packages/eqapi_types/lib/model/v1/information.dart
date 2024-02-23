import 'package:freezed_annotation/freezed_annotation.dart';

part 'information.freezed.dart';
part 'information.g.dart';

@freezed
class InformationV1 with _$InformationV1 {
  const factory InformationV1({
    @JsonKey(
      unknownEnumValue: InformationAuthor.unknown,
      defaultValue: InformationAuthor.unknown,
    )
    required InformationAuthor author,
    required Map<String, dynamic> body,
    required DateTime createdAt,
    required int id,
    @JsonKey(
      unknownEnumValue: InformationLevel.info,
      defaultValue: InformationLevel.info,
    )
    required InformationLevel level,
    required String title,
    required String type,
  }) = _InformationV1;

  factory InformationV1.fromJson(Map<String, dynamic> json) =>
      _$InformationV1FromJson(json);
}

enum InformationAuthor {
  jma,
  developer,
  unknown,
}

enum InformationLevel {
  info,
  warning,
  critical,
}
