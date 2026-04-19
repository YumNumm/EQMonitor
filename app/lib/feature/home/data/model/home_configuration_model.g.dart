// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'home_configuration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HomeConfigurationModel _$HomeConfigurationModelFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_HomeConfigurationModel',
  json,
  ($checkedConvert) {
    final val = _HomeConfigurationModel(
      showLocation: $checkedConvert(
        'show_location',
        (v) => v as bool? ?? false,
      ),
      earthquakeHistoryScope: $checkedConvert(
        'earthquake_history_scope',
        (v) =>
            $enumDecodeNullable(_$HomeEarthquakeHistoryScopeEnumMap, v) ??
            HomeEarthquakeHistoryScope.nationwide,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'showLocation': 'show_location',
    'earthquakeHistoryScope': 'earthquake_history_scope',
  },
);

Map<String, dynamic> _$HomeConfigurationModelToJson(
  _HomeConfigurationModel instance,
) => <String, dynamic>{
  'show_location': instance.showLocation,
  'earthquake_history_scope':
      _$HomeEarthquakeHistoryScopeEnumMap[instance.earthquakeHistoryScope]!,
};

const _$HomeEarthquakeHistoryScopeEnumMap = {
  HomeEarthquakeHistoryScope.nationwide: 'nationwide',
  HomeEarthquakeHistoryScope.currentLocation: 'currentLocation',
  HomeEarthquakeHistoryScope.designatedRegion: 'designatedRegion',
};
