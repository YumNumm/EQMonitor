import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:kyoshin_observation_point_types/kyoshin_observation_point.pb.dart';

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

  Future<KyoshinObservationPoints> convert(
      List<ObservationModel> points) async {
    final result = <KyoshinObservationPoint>[];
    for (final point in points) {
      print(point.code);
      final response = await http.get(
        Uri.parse(
            'https://www.j-shis.bosai.go.jp/map/api/sstrct/V2/meshinfo.geojson'
            '?position=${point.longitude},${point.latitude}'
            '&epsg=4326'),
      );
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      print(json);
      final arvStr = (((json["features"] as List<dynamic>?)?.first
              as Map<String, dynamic>?)?["properties"]
          as Map<String, dynamic>?)?["ARV"] as String?;
      final arv = double.tryParse(arvStr.toString());
      print("ARV: $arv");
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
        arv400: arv,
      ));
    }
    return KyoshinObservationPoints(
      points: result,
    );
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

  ObservationModel(
      {required this.code,
      required this.name,
      required this.region,
      required this.latitude,
      required this.longitude,
      required this.x,
      required this.y});

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
