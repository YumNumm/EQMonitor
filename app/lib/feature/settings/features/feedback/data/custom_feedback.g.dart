// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'custom_feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CustomFeedback _$CustomFeedbackFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_CustomFeedback',
      json,
      ($checkedConvert) {
        final val = _CustomFeedback(
          feedbackType: $checkedConvert(
            'feedback_type',
            (v) => $enumDecodeNullable(_$FeedbackTypeEnumMap, v),
          ),
          isReplyRequested: $checkedConvert(
            'is_reply_requested',
            (v) => v as bool?,
          ),
          isScreenshotAttached: $checkedConvert(
            'is_screenshot_attached',
            (v) => v as bool? ?? true,
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'feedbackType': 'feedback_type',
        'isReplyRequested': 'is_reply_requested',
        'isScreenshotAttached': 'is_screenshot_attached',
      },
    );

Map<String, dynamic> _$CustomFeedbackToJson(_CustomFeedback instance) =>
    <String, dynamic>{
      'feedback_type': _$FeedbackTypeEnumMap[instance.feedbackType],
      'is_reply_requested': instance.isReplyRequested,
      'is_screenshot_attached': instance.isScreenshotAttached,
    };

const _$FeedbackTypeEnumMap = {
  FeedbackType.bugReport: 'bugReport',
  FeedbackType.featureRequest: 'featureRequest',
  FeedbackType.other: 'other',
};
