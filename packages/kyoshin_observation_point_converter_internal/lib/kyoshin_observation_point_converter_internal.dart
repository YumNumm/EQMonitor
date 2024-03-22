import 'dart:convert';
import 'dart:io';

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

  KyoshinObservationPoints convert(List<ObservationModel> points) =>
      KyoshinObservationPoints(
        points: points.map(
          (point) => KyoshinObservationPoint(
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
          ),
        ),
      );
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
