// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_history_map_layer_parameter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeHistoryMapLayerParameter
_$EarthquakeHistoryMapLayerParameterFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_EarthquakeHistoryMapLayerParameter',
      json,
      ($checkedConvert) {
        final val = _EarthquakeHistoryMapLayerParameter(
          regionToCity: $checkedConvert(
            'region_to_city',
            (v) => (v as num?)?.toDouble() ?? 6,
          ),
          stationMinZoom: $checkedConvert(
            'station_min_zoom',
            (v) => (v as num?)?.toDouble() ?? 8,
          ),
          stationLabelMinZoom: $checkedConvert(
            'station_label_min_zoom',
            (v) => (v as num?)?.toDouble() ?? 9,
          ),
          stationTextZoom: $checkedConvert(
            'station_text_zoom',
            (v) => (v as num?)?.toDouble() ?? 9,
          ),
          hypocenterFadeZoom: $checkedConvert(
            'hypocenter_fade_zoom',
            (v) => (v as num?)?.toDouble() ?? 8,
          ),
          hypocenterErrorMinZoom: $checkedConvert(
            'hypocenter_error_min_zoom',
            (v) => (v as num?)?.toDouble() ?? 8,
          ),
          regionFillOpacity: $checkedConvert(
            'region_fill_opacity',
            (v) => (v as num?)?.toDouble() ?? 0.6,
          ),
          regionLineOpacity: $checkedConvert(
            'region_line_opacity',
            (v) => (v as num?)?.toDouble() ?? 0.8,
          ),
          cityFillOpacity: $checkedConvert(
            'city_fill_opacity',
            (v) => (v as num?)?.toDouble() ?? 0.6,
          ),
          stationCircleRadiusMin: $checkedConvert(
            'station_circle_radius_min',
            (v) => (v as num?)?.toDouble() ?? 2,
          ),
          stationCircleRadiusMax: $checkedConvert(
            'station_circle_radius_max',
            (v) => (v as num?)?.toDouble() ?? 8,
          ),
          stationIconSizeMin: $checkedConvert(
            'station_icon_size_min',
            (v) => (v as num?)?.toDouble() ?? 0.025,
          ),
          stationIconSizeMid: $checkedConvert(
            'station_icon_size_mid',
            (v) => (v as num?)?.toDouble() ?? 0.18,
          ),
          stationIconSizeMax: $checkedConvert(
            'station_icon_size_max',
            (v) => (v as num?)?.toDouble() ?? 0.6,
          ),
          hypocenterIconSizeMin: $checkedConvert(
            'hypocenter_icon_size_min',
            (v) => (v as num?)?.toDouble() ?? 0.15,
          ),
          hypocenterIconSizeMax: $checkedConvert(
            'hypocenter_icon_size_max',
            (v) => (v as num?)?.toDouble() ?? 0.4,
          ),
          hypocenterFadeOpacity: $checkedConvert(
            'hypocenter_fade_opacity',
            (v) => (v as num?)?.toDouble() ?? 0.6,
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'regionToCity': 'region_to_city',
        'stationMinZoom': 'station_min_zoom',
        'stationLabelMinZoom': 'station_label_min_zoom',
        'stationTextZoom': 'station_text_zoom',
        'hypocenterFadeZoom': 'hypocenter_fade_zoom',
        'hypocenterErrorMinZoom': 'hypocenter_error_min_zoom',
        'regionFillOpacity': 'region_fill_opacity',
        'regionLineOpacity': 'region_line_opacity',
        'cityFillOpacity': 'city_fill_opacity',
        'stationCircleRadiusMin': 'station_circle_radius_min',
        'stationCircleRadiusMax': 'station_circle_radius_max',
        'stationIconSizeMin': 'station_icon_size_min',
        'stationIconSizeMid': 'station_icon_size_mid',
        'stationIconSizeMax': 'station_icon_size_max',
        'hypocenterIconSizeMin': 'hypocenter_icon_size_min',
        'hypocenterIconSizeMax': 'hypocenter_icon_size_max',
        'hypocenterFadeOpacity': 'hypocenter_fade_opacity',
      },
    );

Map<String, dynamic> _$EarthquakeHistoryMapLayerParameterToJson(
  _EarthquakeHistoryMapLayerParameter instance,
) => <String, dynamic>{
  'region_to_city': instance.regionToCity,
  'station_min_zoom': instance.stationMinZoom,
  'station_label_min_zoom': instance.stationLabelMinZoom,
  'station_text_zoom': instance.stationTextZoom,
  'hypocenter_fade_zoom': instance.hypocenterFadeZoom,
  'hypocenter_error_min_zoom': instance.hypocenterErrorMinZoom,
  'region_fill_opacity': instance.regionFillOpacity,
  'region_line_opacity': instance.regionLineOpacity,
  'city_fill_opacity': instance.cityFillOpacity,
  'station_circle_radius_min': instance.stationCircleRadiusMin,
  'station_circle_radius_max': instance.stationCircleRadiusMax,
  'station_icon_size_min': instance.stationIconSizeMin,
  'station_icon_size_mid': instance.stationIconSizeMid,
  'station_icon_size_max': instance.stationIconSizeMax,
  'hypocenter_icon_size_min': instance.hypocenterIconSizeMin,
  'hypocenter_icon_size_max': instance.hypocenterIconSizeMax,
  'hypocenter_fade_opacity': instance.hypocenterFadeOpacity,
};
