// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'home_map_label_parameter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HomeMapLabelParameter _$HomeMapLabelParameterFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_HomeMapLabelParameter',
  json,
  ($checkedConvert) {
    final val = _HomeMapLabelParameter(
      showRegionLabel: $checkedConvert(
        'show_region_label',
        (v) => v as bool? ?? true,
      ),
      showCityLabel: $checkedConvert(
        'show_city_label',
        (v) => v as bool? ?? true,
      ),
      regionLabelMinZoom: $checkedConvert(
        'region_label_min_zoom',
        (v) => (v as num?)?.toDouble() ?? 5.0,
      ),
      cityLabelMinZoom: $checkedConvert(
        'city_label_min_zoom',
        (v) => (v as num?)?.toDouble() ?? 9.0,
      ),
      regionTextSize: $checkedConvert(
        'region_text_size',
        (v) => (v as num?)?.toDouble() ?? 14,
      ),
      cityTextSize: $checkedConvert(
        'city_text_size',
        (v) => (v as num?)?.toDouble() ?? 12,
      ),
      textHaloWidth: $checkedConvert(
        'text_halo_width',
        (v) => (v as num?)?.toDouble() ?? 1.0,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'showRegionLabel': 'show_region_label',
    'showCityLabel': 'show_city_label',
    'regionLabelMinZoom': 'region_label_min_zoom',
    'cityLabelMinZoom': 'city_label_min_zoom',
    'regionTextSize': 'region_text_size',
    'cityTextSize': 'city_text_size',
    'textHaloWidth': 'text_halo_width',
  },
);

Map<String, dynamic> _$HomeMapLabelParameterToJson(
  _HomeMapLabelParameter instance,
) => <String, dynamic>{
  'show_region_label': instance.showRegionLabel,
  'show_city_label': instance.showCityLabel,
  'region_label_min_zoom': instance.regionLabelMinZoom,
  'city_label_min_zoom': instance.cityLabelMinZoom,
  'region_text_size': instance.regionTextSize,
  'city_text_size': instance.cityTextSize,
  'text_halo_width': instance.textHaloWidth,
};
