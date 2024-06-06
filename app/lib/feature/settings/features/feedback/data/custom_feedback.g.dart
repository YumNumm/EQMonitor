// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

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
          feedbackType: $checkedConvert('feedbackType',
              (v) => $enumDecodeNullable(_$FeedbackTypeEnumMap, v)),
          isReplyRequested:
              $checkedConvert('isReplyRequested', (v) => v as bool?),
          isScreenshotAttached: $checkedConvert(
              'isScreenshotAttached', (v) => v as bool? ?? true),
        );
        return val;
      },
    );

Map<String, dynamic> _$$CustomFeedbackImplToJson(
        _$CustomFeedbackImpl instance) =>
    <String, dynamic>{
      'feedbackType': _$FeedbackTypeEnumMap[instance.feedbackType],
      'isReplyRequested': instance.isReplyRequested,
      'isScreenshotAttached': instance.isScreenshotAttached,
    };

const _$FeedbackTypeEnumMap = {
  FeedbackType.bugReport: 'bugReport',
  FeedbackType.featureRequest: 'featureRequest',
  FeedbackType.other: 'other',
};
