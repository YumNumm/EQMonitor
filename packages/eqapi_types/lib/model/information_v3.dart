import 'package:eqapi_types/eqapi_types.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'information_v3.freezed.dart';
part 'information_v3.g.dart';

@freezed
class InformationV3Result with _$InformationV3Result {
  const factory InformationV3Result({
    @Default([]) List<InformationV3> results,
    required bool success,
    required D1DbExecutionResult meta,
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
    @JsonKey(fromJson: tagFromString, toJson: tagToString)
    required List<String> tag,
    required int? eventId,
  }) = _InformationV3;

  factory InformationV3.fromJson(Map<String, dynamic> json) =>
      _$InformationV3FromJson(json);
}

enum Author {
  developer,
  jma,
  unknown,
  ;
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
