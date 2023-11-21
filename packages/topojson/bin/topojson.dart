// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:topojson/topojson.dart';

Future<void> main() async {
  final data = File('sample.json').readAsStringSync();
  final stopwatch = Stopwatch()..start();

  final json = jsonDecode(data) as Map<String, dynamic>;
  final topoJson = TopoJson.fromJson(json);
  stopwatch.stop();
  print(topoJson.objects.keys);
  topoJson.objects.forEach((key, value) {
    if (value.type == TopoJsonGeometryType.geometryCollection) {
      final geometryCollection = value as GeometryCollection;
      print('*****  loop  *****');
      for (final element in geometryCollection.geometries) {
        print(element.type);
      }
      print(
        '*****  end (items: ${geometryCollection.geometries.length}) *****',
      );
    }
  });
  print('');
  print(
    '*****  parse end (time: ${stopwatch.elapsedMicroseconds / 1000} ms) *****',
  );
}
