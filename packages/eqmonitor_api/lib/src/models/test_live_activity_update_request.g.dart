// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'test_live_activity_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TestLiveActivityUpdateRequest _$TestLiveActivityUpdateRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_TestLiveActivityUpdateRequest',
  json,
  ($checkedConvert) {
    final val = _TestLiveActivityUpdateRequest(
      contentState: $checkedConvert(
        'content_state',
        (v) => v as Map<String, dynamic>,
      ),
    );
    return val;
  },
  fieldKeyMap: const {'contentState': 'content_state'},
);

Map<String, dynamic> _$TestLiveActivityUpdateRequestToJson(
  _TestLiveActivityUpdateRequest instance,
) => <String, dynamic>{'content_state': instance.contentState};
