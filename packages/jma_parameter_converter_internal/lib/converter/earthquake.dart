import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;
import 'package:jma_parameter_converter_internal/dmdata/earthquake.dart'
    as dmdata;
import 'package:jma_parameter_types/earthquake_param.pb.dart';

Future<EarthquakeParameter> fromDmdataEarthquakeParameter(
  dmdata.EarthquakeParameter parameter,
) async {
  final itemsFuture = parameter.items.map((e) async {
    final arv = await getArv(latitude: e.latitude, longitude: e.longitude);
    return (
      e,
      EarthquakeParameterStationItem(
        code: e.code,
        name: e.name,
        nameKana: e.kana,
        latitude: e.latitude,
        longitude: e.longitude,
        arv400: arv,
        status: _parseStationStatus(e.status),
        owner: _parseStationOwner(e.owner),
      ),
    );
  });
  // 直列実行
  final items =
      <(dmdata.EarthquakeParmaeterItem, EarthquakeParameterStationItem)>[];
  for (final item in itemsFuture) {
    items.add(await item);
  }

  final itemsGroupByRegion = items.groupListsBy((e) => e.$1.region);
  final itemsGroupByRegionAndCity = itemsGroupByRegion.map(
    (key, value) => MapEntry(key, value.groupListsBy((e) => e.$1.city)),
  );
  print('itemsGroupByRegionAndCity: ${itemsGroupByRegionAndCity.length}');
  final regions = itemsGroupByRegionAndCity.entries.map(
    (e) => EarthquakeParameterRegionItem(
      code: e.key.code,
      name: e.key.name,
      nameKana: e.key.kana,
      cities: e.value.entries.map(
        (e) => EarthquakeParameterCityItem(
          code: e.key.code,
          name: e.key.name,
          nameKana: e.key.kana,
          stations: e.value.map((e) => e.$2),
        ),
      ),
    ),
  );
  print('regions: ${regions.length}');
  return EarthquakeParameter(
    header: EarthquakeParameterHeader(
      version: parameter.version,
      changeTime: parameter.changeTime.toIso8601String(),
    ),
    regions: regions,
  );
}

StationStatus _parseStationStatus(String status) {
  switch (status) {
    case '現':
      return StationStatus.OPERATIONAL;
    case '変':
      return StationStatus.CHANGE;
    case '新':
      return StationStatus.CREATED;
    case '廃':
      return StationStatus.DISCONTINUED;
    default:
      return StationStatus.OPERATIONAL;
  }
}

StationOwner _parseStationOwner(String owner) {
  switch (owner) {
    case '気象庁':
      return StationOwner.JMA;
    case '都道府県':
      return StationOwner.PREFECTURE;
    case '市町村':
      return StationOwner.CITY;
    case '防災科研':
      return StationOwner.NIED;
    default:
      return StationOwner.OTHERS;
  }
}

Future<double?> getArv({
  required double latitude,
  required double longitude,
}) async {
  // Cacheのチェック
  final cacheFile = File('cache/${latitude}_$longitude.json');
  if (cacheFile.existsSync()) {
    print('Cache hit!: $cacheFile');
    final json =
        jsonDecode(await cacheFile.readAsString()) as Map<String, dynamic>;
    final arvStr =
        (((json['features'] as List<dynamic>?)?.first
                    as Map<String, dynamic>?)?['properties']
                as Map<String, dynamic>?)?['ARV']
            as String?;
    final arv = double.tryParse(arvStr.toString());
    return arv;
  }
  print('Cache miss!: $cacheFile');
  final response = await http.get(
    Uri.parse(
      'https://www.j-shis.bosai.go.jp/map/api/sstrct/V2/meshinfo.geojson'
      '?position=$longitude,$latitude'
      '&epsg=4326',
    ),
  );
  final json = jsonDecode(response.body) as Map<String, dynamic>;
  print(json);
  final arvStr =
      (((json['features'] as List<dynamic>?)?.first
                  as Map<String, dynamic>?)?['properties']
              as Map<String, dynamic>?)?['ARV']
          as String?;
  final arv = double.tryParse(arvStr.toString());
  cacheFile.writeAsStringSync(jsonEncode(json));
  print('ARV: $arv');
  return null;
}
