// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'test_live_activity_end_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TestLiveActivityEndRequest _$TestLiveActivityEndRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_TestLiveActivityEndRequest',
  json,
  ($checkedConvert) {
    final val = _TestLiveActivityEndRequest(
      contentState: $checkedConvert(
        'content_state',
        (v) => v as Map<String, dynamic>?,
      ),
    );
    return val;
  },
  fieldKeyMap: const {'contentState': 'content_state'},
);

Map<String, dynamic> _$TestLiveActivityEndRequestToJson(
  _TestLiveActivityEndRequest instance,
) => <String, dynamic>{'content_state': ?instance.contentState};
