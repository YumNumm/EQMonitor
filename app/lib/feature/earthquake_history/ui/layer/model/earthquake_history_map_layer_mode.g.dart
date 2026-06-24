// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_history_map_layer_mode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeHistoryMapLayerAvailability
_$EarthquakeHistoryMapLayerAvailabilityFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_EarthquakeHistoryMapLayerAvailability', json, (
      $checkedConvert,
    ) {
      final val = _EarthquakeHistoryMapLayerAvailability(
        region: $checkedConvert('region', (v) => v as bool),
        city: $checkedConvert('city', (v) => v as bool),
        station: $checkedConvert('station', (v) => v as bool),
      );
      return val;
    });

Map<String, dynamic> _$EarthquakeHistoryMapLayerAvailabilityToJson(
  _EarthquakeHistoryMapLayerAvailability instance,
) => <String, dynamic>{
  'region': instance.region,
  'city': instance.city,
  'station': instance.station,
};

_EarthquakeHistoryMapLayerZoomThresholds
_$EarthquakeHistoryMapLayerZoomThresholdsFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_EarthquakeHistoryMapLayerZoomThresholds',
      json,
      ($checkedConvert) {
        final val = _EarthquakeHistoryMapLayerZoomThresholds(
          regionToCity: $checkedConvert(
            'region_to_city',
            (v) => (v as num?)?.toDouble() ?? 8,
          ),
          stationMinZoom: $checkedConvert(
            'station_min_zoom',
            (v) => (v as num?)?.toDouble() ?? 8,
          ),
          stationLabelMinZoom: $checkedConvert(
            'station_label_min_zoom',
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
        );
        return val;
      },
      fieldKeyMap: const {
        'regionToCity': 'region_to_city',
        'stationMinZoom': 'station_min_zoom',
        'stationLabelMinZoom': 'station_label_min_zoom',
        'hypocenterFadeZoom': 'hypocenter_fade_zoom',
        'hypocenterErrorMinZoom': 'hypocenter_error_min_zoom',
      },
    );

Map<String, dynamic> _$EarthquakeHistoryMapLayerZoomThresholdsToJson(
  _EarthquakeHistoryMapLayerZoomThresholds instance,
) => <String, dynamic>{
  'region_to_city': instance.regionToCity,
  'station_min_zoom': instance.stationMinZoom,
  'station_label_min_zoom': instance.stationLabelMinZoom,
  'hypocenter_fade_zoom': instance.hypocenterFadeZoom,
  'hypocenter_error_min_zoom': instance.hypocenterErrorMinZoom,
};
