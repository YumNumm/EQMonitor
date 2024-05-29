import 'dart:io';

import 'package:jma_code_table_types/jma_code_table.pb.dart';

class JmaCodeTableConverter {
  Future<List<List<String>>> _getCsv(String fileName) async {
    final file = File(fileName);
    if (!file.existsSync()) {
      throw Exception("File not found: $fileName");
    }
    final lines = await file.readAsLines();
    return lines
        .map((line) => line.split(','))
        .where((e) => e.length != 0)
        .toList();
  }

  Future<AreaForecastLocalEew> convert22() async {
    final csv = await _getCsv("tmp/output_22.csv");
    // ["Code", "Name"]以降を取得
    final index = csv.indexWhere(
      (line) => line[0] == "Code" && line[1] == "Name",
    );
    final data = csv
        .sublist(index + 1)
        .where((e) => e.length == 4)
        .where((e) => e[0] != "None");
    return AreaForecastLocalEew(items: [
      for (final e in data)
        AreaForecastLocalEew_AreaForecastLocalEewItem(
          code: e[0],
          name: e[1],
          nameKana: e[2],
          description: e[3] == "None" ? "" : e[3],
        ),
    ]);
  }

  Future<AreaInformationPrefectureEarthquake> convert23() async {
    final csv = await _getCsv("tmp/output_23.csv");
    // ["Code", "Name"]以降を取得
    final index = csv.indexWhere(
      (line) => line[0] == "Code" && line[1] == "Name",
    );
    final data = csv
        .sublist(index + 1)
        .where((e) => e.length == 2)
        .where((e) => e[0] != "None");
    return AreaInformationPrefectureEarthquake(items: [
      for (final e in data)
        AreaInformationPrefectureEarthquake_AreaInformationPrefectureEarthquakeItem(
          code: e[0],
          name: e[1],
        ),
    ]);
  }

  Future<AreaEpicenter> convert41() async {
    final csv = await _getCsv("tmp/output_41.csv");
    // ["Code", "Name"]以降を取得
    final index = csv.indexWhere(
      (line) => line[0] == "Code" && line[1] == "Name",
    );
    final data = csv.sublist(index + 1).where((e) => e.length == 2);
    return AreaEpicenter(items: [
      for (final e in data)
        AreaEpicenter_AreaEpicenterItem(
          code: e[0],
          name: e[1],
        ),
    ]);
  }

  Future<AreaEpicenterAbbreviation> convert42() async {
    final csv = await _getCsv("tmp/output_42.csv");
    final index = csv.indexWhere(
      (line) => line[0] == "Code" && line[1] == "Name",
    );
    final data = csv.sublist(index + 1).where((e) => e.length == 3);
    return AreaEpicenterAbbreviation(items: [
      for (final e in data)
        AreaEpicenterAbbreviation_AreaEpicenterAbbreviationItem(
          code: e[0],
          name: e[1],
        ),
    ]);
  }

  Future<AreaEpicenterDetail> convert43() async {
    final csv = await _getCsv("tmp/output_43.csv");
    final index = csv.indexWhere(
      (line) => line[0] == "Code" && line[1] == "Name",
    );
    final data = csv.sublist(index + 1).where((e) => e.length == 2);
    return AreaEpicenterDetail(items: [
      for (final e in data)
        AreaEpicenterDetail_AreaEpicenterDetailItem(
          code: e[0],
          name: e[1],
        ),
    ]);
  }
}
