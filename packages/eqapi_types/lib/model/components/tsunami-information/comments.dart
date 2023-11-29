import 'package:freezed_annotation/freezed_annotation.dart';

part 'comments.freezed.dart';
part 'comments.g.dart';

@freezed
class TsunamiComments with _$TsunamiComments {
  const factory TsunamiComments({
    required String? free,
    required TsunamiForecastCommentWarning? warning,
  }) = _TsunamiComments;

  factory TsunamiComments.fromJson(Map<String, dynamic> json) =>
      _$TsunamiCommentsFromJson(json);
}

@freezed
class TsunamiForecastCommentWarning with _$TsunamiForecastCommentWarning {
  const factory TsunamiForecastCommentWarning({
    required String text,
    required List<String> codes,
  }) = _TsunamiForecastCommentWarning;

  factory TsunamiForecastCommentWarning.fromJson(Map<String, dynamic> json) =>
      _$TsunamiForecastCommentWarningFromJson(json);
}
