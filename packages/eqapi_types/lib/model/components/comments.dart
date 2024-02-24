import 'package:freezed_annotation/freezed_annotation.dart';

part 'comments.freezed.dart';
part 'comments.g.dart';

@freezed
class Comments with _$Comments {
  @JsonSerializable(fieldRename: FieldRename.none)
  const factory Comments({
    required String? free,
    required ForecastComments? forecast,
    @JsonValue('var') required VarComments? varComments,
  }) = _Comments;

  factory Comments.fromJson(Map<String, dynamic> json) =>
      _$CommentsFromJson(json);
}

@freezed
class CommentsOmitVar with _$CommentsOmitVar {
  @JsonSerializable(fieldRename: FieldRename.none)
  const factory CommentsOmitVar({
    required String? free,
    required ForecastComments? forecast,
  }) = _CommentsOmitVar;

  factory CommentsOmitVar.fromJson(Map<String, dynamic> json) =>
      _$CommentsOmitVarFromJson(json);
}

@freezed
class ForecastComments with _$ForecastComments {
  @JsonSerializable(fieldRename: FieldRename.none)
  const factory ForecastComments({
    required String text,
    required List<String> codes,
  }) = _ForecastComments;

  factory ForecastComments.fromJson(Map<String, dynamic> json) =>
      _$ForecastCommentsFromJson(json);
}

@freezed
class VarComments with _$VarComments {
  @JsonSerializable(fieldRename: FieldRename.none)
  const factory VarComments({
    required String text,
    required List<String> codes,
  }) = _VarComments;

  factory VarComments.fromJson(Map<String, dynamic> json) =>
      _$VarCommentsFromJson(json);
}

@freezed
class CommentsOnlyFree with _$CommentsOnlyFree {
  @JsonSerializable(fieldRename: FieldRename.none)
  const factory CommentsOnlyFree({
    required String free,
  }) = _CommentsOnlyFree;

  factory CommentsOnlyFree.fromJson(Map<String, dynamic> json) =>
      _$CommentsOnlyFreeFromJson(json);
}
