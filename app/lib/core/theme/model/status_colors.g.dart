// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'status_colors.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StatusColors _$StatusColorsFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_StatusColors', json, ($checkedConvert) {
      final val = _StatusColors(
        success: $checkedConvert(
          'success',
          (v) => const ColorJsonConverter().fromJson(v as String),
        ),
        warning: $checkedConvert(
          'warning',
          (v) => const ColorJsonConverter().fromJson(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$StatusColorsToJson(_StatusColors instance) =>
    <String, dynamic>{
      'success': const ColorJsonConverter().toJson(instance.success),
      'warning': const ColorJsonConverter().toJson(instance.warning),
    };
