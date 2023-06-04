import 'dart:convert';
import 'dart:io';

import 'package:topojson/topojson.dart';

Future<void> main() async {
  final data = await File("output.json").readAsBytes();
  // json parse
  final json = jsonDecode(
    utf8.decode(data),
  );
  final topoJson = TopoJson.fromJson(json);
}
