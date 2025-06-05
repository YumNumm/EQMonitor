// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'intensity_color_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntensityColorConfiguration _$IntensityColorConfigurationFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_IntensityColorConfiguration',
  json,
  ($checkedConvert) {
    final val = _IntensityColorConfiguration(
      schemeType: $checkedConvert(
        'scheme_type',
        (v) => $enumDecode(_$PredefinedSchemeEnumMap, v),
      ),
      customColors: $checkedConvert(
        'custom_colors',
        (v) => v == null
            ? null
            : IntensityColorModel.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'schemeType': 'scheme_type',
    'customColors': 'custom_colors',
  },
);

Map<String, dynamic> _$IntensityColorConfigurationToJson(
  _IntensityColorConfiguration instance,
) => <String, dynamic>{
  'scheme_type': _$PredefinedSchemeEnumMap[instance.schemeType]!,
  'custom_colors': instance.customColors,
};
<<<<<<< HEAD
=======

const _$PredefinedSchemeEnumMap = {
  PredefinedScheme.eqmonitor: 'eqmonitor',
  PredefinedScheme.jma: 'jma',
  PredefinedScheme.earthQuickly: 'earthQuickly',
  PredefinedScheme.nhk: 'nhk',
};
>>>>>>> 669d7805 (不要なファイルを削除し、依存関係を更新しました。また、`pubspec.lock`のバージョンを更新し、`api_authentication_notifier`や`api_authentication_payload`に関連するコードを削除しました。さらに、`intensity_color`に関するインポートを整理し、コードの可読性を向上させました。)
