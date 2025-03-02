// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'custom_feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomFeedbackImpl _$$CustomFeedbackImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$CustomFeedbackImpl',
      json,
      ($checkedConvert) {
        final val = _$CustomFeedbackImpl(
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

Map<String, dynamic> _$$CustomFeedbackImplToJson(
  _$CustomFeedbackImpl instance,
) => <String, dynamic>{
  'feedback_type': _$FeedbackTypeEnumMap[instance.feedbackType],
  'is_reply_requested': instance.isReplyRequested,
  'is_screenshot_attached': instance.isScreenshotAttached,
};

const _$FeedbackTypeEnumMap = {
  FeedbackType.bugReport: 'bugReport',
  FeedbackType.featureRequest: 'featureRequest',
  FeedbackType.other: 'other',
};
