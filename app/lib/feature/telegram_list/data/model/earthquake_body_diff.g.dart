// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_body_diff.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntensityRegionDiffEntry _$IntensityRegionDiffEntryFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_IntensityRegionDiffEntry',
  json,
  ($checkedConvert) {
    final val = _IntensityRegionDiffEntry(
      code: $checkedConvert('code', (v) => v as String),
      name: $checkedConvert('name', (v) => v as String),
      intensity: $checkedConvert(
        'intensity',
        (v) => $enumDecode(_$JmaIntensityEnumMap, v),
      ),
      diffType: $checkedConvert(
        'diff_type',
        (v) => $enumDecode(_$IntensityDiffTypeEnumMap, v),
      ),
      previousIntensity: $checkedConvert(
        'previous_intensity',
        (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'diffType': 'diff_type',
    'previousIntensity': 'previous_intensity',
  },
);

Map<String, dynamic> _$IntensityRegionDiffEntryToJson(
  _IntensityRegionDiffEntry instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'intensity': _$JmaIntensityEnumMap[instance.intensity]!,
  'diff_type': _$IntensityDiffTypeEnumMap[instance.diffType]!,
  'previous_intensity': _$JmaIntensityEnumMap[instance.previousIntensity],
};

const _$JmaIntensityEnumMap = {
  JmaIntensity.unknown: 'unknown',
  JmaIntensity.zero: 'zero',
  JmaIntensity.one: 'one',
  JmaIntensity.two: 'two',
  JmaIntensity.three: 'three',
  JmaIntensity.four: 'four',
  JmaIntensity.fiveUnknown: 'fiveUnknown',
  JmaIntensity.fiveLower: 'fiveLower',
  JmaIntensity.fiveUpper: 'fiveUpper',
  JmaIntensity.sixUnknown: 'sixUnknown',
  JmaIntensity.sixLower: 'sixLower',
  JmaIntensity.sixUpper: 'sixUpper',
  JmaIntensity.seven: 'seven',
};

const _$IntensityDiffTypeEnumMap = {
  IntensityDiffType.same: 'same',
  IntensityDiffType.added: 'added',
  IntensityDiffType.upgraded: 'upgraded',
  IntensityDiffType.downgraded: 'downgraded',
};

_HypocenterDiff _$HypocenterDiffFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_HypocenterDiff',
      json,
      ($checkedConvert) {
        final val = _HypocenterDiff(
          oldMagnitude: $checkedConvert('old_magnitude', (v) => v as String?),
          newMagnitude: $checkedConvert('new_magnitude', (v) => v as String?),
          oldDepth: $checkedConvert('old_depth', (v) => v as num?),
          newDepth: $checkedConvert('new_depth', (v) => v as num?),
          oldEpicenterName: $checkedConvert(
            'old_epicenter_name',
            (v) => v as String?,
          ),
          newEpicenterName: $checkedConvert(
            'new_epicenter_name',
            (v) => v as String?,
          ),
          oldMaxIntensity: $checkedConvert(
            'old_max_intensity',
            (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
          ),
          newMaxIntensity: $checkedConvert(
            'new_max_intensity',
            (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'oldMagnitude': 'old_magnitude',
        'newMagnitude': 'new_magnitude',
        'oldDepth': 'old_depth',
        'newDepth': 'new_depth',
        'oldEpicenterName': 'old_epicenter_name',
        'newEpicenterName': 'new_epicenter_name',
        'oldMaxIntensity': 'old_max_intensity',
        'newMaxIntensity': 'new_max_intensity',
      },
    );

Map<String, dynamic> _$HypocenterDiffToJson(_HypocenterDiff instance) =>
    <String, dynamic>{
      'old_magnitude': instance.oldMagnitude,
      'new_magnitude': instance.newMagnitude,
      'old_depth': instance.oldDepth,
      'new_depth': instance.newDepth,
      'old_epicenter_name': instance.oldEpicenterName,
      'new_epicenter_name': instance.newEpicenterName,
      'old_max_intensity': _$JmaIntensityEnumMap[instance.oldMaxIntensity],
      'new_max_intensity': _$JmaIntensityEnumMap[instance.newMaxIntensity],
    };
