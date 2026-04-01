// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'admin_replay_file_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AdminReplayFileDetailResponse _$AdminReplayFileDetailResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_AdminReplayFileDetailResponse', json, ($checkedConvert) {
  final val = _AdminReplayFileDetailResponse(
    item: $checkedConvert(
      'item',
      (v) =>
          AdminReplayFileDetailResponseItem.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$AdminReplayFileDetailResponseToJson(
  _AdminReplayFileDetailResponse instance,
) => <String, dynamic>{'item': instance.item};
