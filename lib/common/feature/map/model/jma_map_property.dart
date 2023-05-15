import 'package:freezed_annotation/freezed_annotation.dart';

part 'jma_map_property.freezed.dart';
part 'jma_map_property.g.dart';

/*
{"code":"100","name":"石狩地方北部","namekana":"いしかりちほうほくぶ"}
*/
@freezed
class JmaMapProperty with _$JmaMapProperty {
  const factory JmaMapProperty({
    required String code,
    required String name,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'namekana') required String nameKana,
  }) = _JmaMapProperty;

  factory JmaMapProperty.fromJson(Map<String, dynamic> json) =>
      _$JmaMapPropertyFromJson(json);
}
