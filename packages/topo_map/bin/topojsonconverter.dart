import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:topo_map/src/enum/land_layer_type.dart';
import 'package:topo_map/src/model/topology_map.dart';
import 'package:topo_map/util/create_map.dart';
import 'package:topojson/topojson.dart';

Future<void> main(
  List<String> arguments,
) async {
  print('***** TopoJsonConverter *****');
  print('TopoJsonが入ったフォルダ: ');
  final inputFolder = stdin.readLineSync().toString();
  print('TopologyMapの出力先: ');
  final outputFileName = stdin.readLineSync().toString();

  final inputDir = Directory(inputFolder);

  if (!inputDir.existsSync()) {
    print('入力フォルダが存在しません');
    return;
  }

  final inputFiles = inputDir.listSync();

  final topologyMaps = <LandLayerType, TopologyMap>{};
  for (final inputFile in inputFiles) {
    // 拡張子を除くファイル名を取得
    final fileName = inputFile.path.split('/').last.split('.').first;
    if (fileName == '') {
      continue;
    }
    final type =
        LandLayerType.values.firstWhereOrNull((e) => e.name == fileName);
    if (type == null) {
      print('ファイル名が不正です: $fileName');
      continue;
    }
    final data = File(inputFile.path).readAsStringSync();
    final json = jsonDecode(data) as Map<String, dynamic>;
    final topoJson = TopoJson.fromJson(json);
    final topologyMap = createMap(topoJson, type);
    topologyMaps[type] = topologyMap;
  }
  // 出力
  final outPutFile = File(outputFileName);
  await outPutFile.create(recursive: true);
  await outPutFile.writeAsString(
    jsonEncode(topologyMaps.map((key, value) => MapEntry(key.name, value))),
  );
}
