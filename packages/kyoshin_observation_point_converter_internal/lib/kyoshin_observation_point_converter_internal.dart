import 'dart:convert';
import 'dart:io';

import 'package:geojson_vi/geojson_vi.dart';
import 'package:http/http.dart' as http;
import 'package:kyoshin_observation_point_types/kyoshin_observation_point.pb.dart';
import 'package:maps_toolkit/maps_toolkit.dart';

class KyoshinObservationPointConverter {
  Future<List<ObservationModel>> readFile(String path) async {
    final file = File(path);
    final body = await file.readAsString();
    final json = jsonDecode(body) as List<dynamic>;
    final result = json
        .map((e) {
          try {
            return ObservationModel.fromJson(e as Map<String, dynamic>);
          } catch (_) {
            return null;
          }
        })
        .whereType<ObservationModel>()
        .toList();
    return result;
  }

  Future<GeoJSON> loadMap() async {
    final file = File("AreaForecastLocalE.json");

    final geojson = GeoJSON.fromJSON(await file.readAsString());
    return geojson;
  }

  Future<KyoshinObservationPoints> convert(
    List<ObservationModel> points,
    GeoJSON map,
  ) async {
    final result = <KyoshinObservationPoint>[];
    for (final point in points) {
      print(point.code);

      result.add(KyoshinObservationPoint(
        code: point.code,
        location: KyoshinObservationPoint_LatLng(
          latitude: point.latitude,
          longitude: point.longitude,
        ),
        name: point.name,
        point: KyoshinObservationPoint_Point(
          x: point.x,
          y: point.y,
        ),
        region: point.region,
        arv400: await _getArv(
          latitude: point.latitude,
          longitude: point.longitude,
        ),
      ));
    }
    return KyoshinObservationPoints(
      points: result,
    );
  }

  Future<double?> _getArv({
    required double latitude,
    required double longitude,
  }) async {
    // Cacheのチェック
    final cacheFile = File("cache/${latitude}_$longitude.json");
    if (await cacheFile.exists()) {
      final json =
          jsonDecode(await cacheFile.readAsString()) as Map<String, dynamic>;
      final arvStr = (((json["features"] as List<dynamic>?)?.first
              as Map<String, dynamic>?)?["properties"]
          as Map<String, dynamic>?)?["ARV"] as String?;
      final arv = double.tryParse(arvStr.toString());
      return arv;
    }

    final response = await http.get(
      Uri.parse(
          'https://www.j-shis.bosai.go.jp/map/api/sstrct/V2/meshinfo.geojson'
          '?position=${longitude},${latitude}'
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

  int? _getRegionCode(GeoJSON map, double latitude, double longitude) {
    bool checkPolygon(List<List<List<double>>> polygon) {
      for (final p in polygon) {
        final latlngs = p.map((e) => LatLng(e[1], e[0])).toList();
        if (PolygonUtil.containsLocation(
            LatLng(latitude, longitude), latlngs, true)) {
          print("Found");
          return true;
        }
      }
      return false;
    }

    for (final feature in (map as GeoJSONFeatureCollection).features) {
      if (feature!.geometry.type == GeoJSONType.multiPolygon) {
        final g = feature.geometry as GeoJSONMultiPolygon;
        final code = int.tryParse(feature.properties!["code"] as String)!;
        for (final polygon in g.coordinates) {
          if (checkPolygon(polygon)) {
            return code;
          }
        }
      }
      if (feature.geometry.type == GeoJSONType.polygon) {
        final g = feature.geometry as GeoJSONPolygon;
        final code = int.tryParse(feature.properties!["code"] as String)!;
        if (checkPolygon(g.coordinates)) {
          return code;
        }
      }
    }

    return null;
  }
}

class ObservationModel {
  final String code;
  final String name;
  final String region;
  final double latitude;
  final double longitude;
  final int x;
  final int y;

  ObservationModel({
    required this.code,
    required this.name,
    required this.region,
    required this.latitude,
    required this.longitude,
    required this.x,
    required this.y,
  });

  factory ObservationModel.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey("Point")) {
      throw ArgumentError("Code is required.");
    }
    return ObservationModel(
      code: json["Code"],
      name: json["Name"],
      region: json["Region"],
      latitude:
          (json["Location"] as Map<String, dynamic>)["Latitude"] as double,
      longitude:
          (json["Location"] as Map<String, dynamic>)["Longitude"] as double,
      x: (json["Point"] as Map<String, dynamic>)["X"] as int,
      y: (json["Point"] as Map<String, dynamic>)["Y"] as int,
    );
  }
}
