// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiDetailResponse _$TsunamiDetailResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_TsunamiDetailResponse', json, ($checkedConvert) {
  final val = _TsunamiDetailResponse(
    tsunami: $checkedConvert(
      'tsunami',
      (v) => TsunamiDetail.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$TsunamiDetailResponseToJson(
  _TsunamiDetailResponse instance,
) => <String, dynamic>{'tsunami': instance.tsunami};
