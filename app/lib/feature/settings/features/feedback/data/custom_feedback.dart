import 'package:freezed_annotation/freezed_annotation.dart';

part 'custom_feedback.freezed.dart';
part 'custom_feedback.g.dart';

@freezed
class CustomFeedback with _$CustomFeedback {
  const factory CustomFeedback({
    FeedbackType? feedbackType,

    /// 返信を希望するかどうか
    bool? isReplyRequested,

    /// スクリーンショットを添付するかどうか
    @Default(true)  bool isScreenshotAttached,
  }) = _CustomFeedback;

  factory CustomFeedback.fromJson(Map<String, dynamic> json) =>
      _$CustomFeedbackFromJson(json);
}

enum FeedbackType {
  bugReport('バグ報告'),
  featureRequest('機能リクエスト'),
  other('その他'),
  ;

  const FeedbackType(this.label);
  final String label;
}
