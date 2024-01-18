import 'package:collection/collection.dart';
import 'package:jma_parameter_types/earthquake_param.pb.dart';

import '../dmdata/earthquake.dart' as dmdata;

EarthquakeParameter fromDmdataEarthquakeParameter(
    dmdata.EarthquakeParameter parameter) {
  final itemsGroupByRegion = parameter.items.groupListsBy(
    (e) => e.region,
  );
  final itemsGroupByRegionAndCity = itemsGroupByRegion.map(
    (key, value) => MapEntry(
      key,
      value.groupListsBy(
        (e) => e.city,
      ),
    ),
  );
  return EarthquakeParameter(
    regions: itemsGroupByRegionAndCity.entries
        .map(
          (e) => EarthquakeParameterRegionItem(
            code: e.key.code,
            name: e.key.name,
            cities: e.value.entries
                .map(
                  (e) => EarthquakeParameterCityItem(
                    code: e.key.code,
                    name: e.key.name,
                    stations: e.value
                        .map(
                          (e) => EarthquakeParameterStationItem(
                            code: e.code,
                            name: e.name,
                            latitude: e.latitude,
                            longitude: e.longitude,
                          ),
                        )
                        .toList(),
                  ),
                )
                .toList(),
          ),
        )
        .toList(),
  );
}
