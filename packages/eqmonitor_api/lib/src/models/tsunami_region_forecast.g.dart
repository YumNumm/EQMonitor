// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_region_forecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiRegionForecast _$TsunamiRegionForecastFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_TsunamiRegionForecast',
  json,
  ($checkedConvert) {
    final val = _TsunamiRegionForecast(
      firstHeight: $checkedConvert(
        'first_height',
        (v) => v == null
            ? null
            : TsunamiRegionForecastFirstHeight.fromJson(
                v as Map<String, dynamic>,
              ),
      ),
      maxHeight: $checkedConvert(
        'max_height',
        (v) => v == null
            ? null
            : TsunamiRegionForecastMaxHeight.fromJson(
                v as Map<String, dynamic>,
              ),
      ),
    );
    return val;
  },
  fieldKeyMap: const {'firstHeight': 'first_height', 'maxHeight': 'max_height'},
);

Map<String, dynamic> _$TsunamiRegionForecastToJson(
  _TsunamiRegionForecast instance,
) => <String, dynamic>{
  'first_height': ?instance.firstHeight,
  'max_height': ?instance.maxHeight,
};
