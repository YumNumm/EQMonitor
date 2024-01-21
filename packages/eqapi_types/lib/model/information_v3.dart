import 'package:freezed_annotation/freezed_annotation.dart';

part 'information_v3.freezed.dart';
part 'information_v3.g.dart';

@freezed
class InformationV3Result with _$InformationV3Result {
  const factory InformationV3Result({
    required List<InformationV3> items,
  }) = _InformationV3Result;

  factory InformationV3Result.fromJson(Map<String, dynamic> json) =>
      _$InformationV3ResultFromJson(json);
}

@freezed
class InformationV3 with _$InformationV3 {
  const factory InformationV3({
    required int id,
    required String title,
    required String body,
    @JsonKey(unknownEnumValue: Author.unknown) required Author author,
    required DateTime createdAt,
    @JsonKey(unknownEnumValue: Level.info) required Level level,
    required int? eventId,
  }) = _InformationV3;

  factory InformationV3.fromJson(Map<String, dynamic> json) =>
      _$InformationV3FromJson(json);
}

enum Author {
  developer('開発者'),
  jma('気象庁'),
  unknown('不明'),
  ;

  const Author(this.name);
  final String name;
}

enum Level {
  info,
  warning,
  danger,
  ;
}

String tagToString(List<String> tag) {
  return tag.join(',');
}

List<String> tagFromString(String tag) {
  return tag.split(',');
}
