import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;
import 'package:jma_parameter_types/earthquake_param.pb.dart';

import '../dmdata/earthquake.dart' as dmdata;

Future<EarthquakeParameter> fromDmdataEarthquakeParameter(
  dmdata.EarthquakeParameter parameter,
) async {
  final itemsFuture = parameter.items.map((e) async {
    final arv = await getArv(
      latitude: e.latitude,
      longitude: e.longitude,
    );
    return (
      e,
      EarthquakeParameterStationItem(
        code: e.code,
        name: e.name,
        latitude: e.latitude,
        longitude: e.longitude,
        arv400: arv,
      )
    );
  });
  // 直列実行
  final items =
      <(dmdata.EarthquakeParmaeterItem, EarthquakeParameterStationItem)>[];
  for (final item in itemsFuture) {
    items.add(await item);
  }

  final itemsGroupByRegion = items.groupListsBy(
    (e) => e.$1.region,
  );
  final itemsGroupByRegionAndCity = itemsGroupByRegion.map(
    (key, value) => MapEntry(
      key,
      value.groupListsBy(
        (e) => e.$1.city,
      ),
    ),
  );
  print("itemsGroupByRegionAndCity: ${itemsGroupByRegionAndCity.length}");
  final regions = itemsGroupByRegionAndCity.entries.map(
    (e) => EarthquakeParameterRegionItem(
      code: e.key.code,
      name: e.key.name,
      cities: e.value.entries.map(
        (e) => EarthquakeParameterCityItem(
          code: e.key.code,
          name: e.key.name,
          stations: (e.value.map(
            (e) => e.$2,
          )),
        ),
      ),
    ),
  );
  print("regions: ${regions.length}");
  return EarthquakeParameter(
    regions: regions,
  );
}

Future<double?> getArv({
  required double latitude,
  required double longitude,
}) async {
  // Cacheのチェック
  final cacheFile = File("cache/${latitude}_$longitude.json");
  if (await cacheFile.exists()) {
    print('Cache hit!: $cacheFile');
    final json =
        jsonDecode(await cacheFile.readAsString()) as Map<String, dynamic>;
    final arvStr = (((json["features"] as List<dynamic>?)?.first
            as Map<String, dynamic>?)?["properties"]
        as Map<String, dynamic>?)?["ARV"] as String?;
    final arv = double.tryParse(arvStr.toString());
    return arv;
  }
  print('Cache miss!: $cacheFile');
  final response = await http.get(
    Uri.parse(
        'https://www.j-shis.bosai.go.jp/map/api/sstrct/V2/meshinfo.geojson'
        '?position=$longitude,$latitude'
        '&epsg=4326'),
  );
  final json = jsonDecode(response.body) as Map<String, dynamic>;
  print(json);
  final arvStr = (((json["features"] as List<dynamic>?)?.first
          as Map<String, dynamic>?)?["properties"]
      as Map<String, dynamic>?)?["ARV"] as String?;
  final arv = double.tryParse(arvStr.toString());
  cacheFile.writeAsString(
    jsonEncode(json),
  );
  print("ARV: $arv");
  return null;
}
