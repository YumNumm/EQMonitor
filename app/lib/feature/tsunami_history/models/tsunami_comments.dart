import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsunami_comments.freezed.dart';

/// 津波コメント情報
@freezed
abstract class TsunamiComments with _$TsunamiComments {
  const factory TsunamiComments({
    /// 自由形式のコメント
    String? free,

    /// 警告情報
    TsunamiWarningComment? warning,
  }) = _TsunamiComments;
}

/// 津波警告コメント
@freezed
abstract class TsunamiWarningComment with _$TsunamiWarningComment {
  const factory TsunamiWarningComment({
    required String text,
    required List<String> codes,
  }) = _TsunamiWarningComment;
}
