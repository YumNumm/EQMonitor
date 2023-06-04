import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:topojson/topojson.dart';

part 'topo_json.freezed.dart';
part 'topo_json.g.dart';

@freezed
class TopoJson with _$TopoJson {
  const factory TopoJson({
    required String type,
    required TopoJsonTransform? transform,
    required Map<String, TopoJsonGeometryObject> objects,
    required List<List<List<int>>> arcs,
  }) = _TopoJson;

  factory TopoJson.fromJson(Map<String, dynamic> json) =>
      _$TopoJsonFromJson(json);
}

extension TopoJsonArcs on TopoJson {
  List<List<IntVector>> get getArcs {
    return arcs
        .map(
          (e1) => e1
              .map(
                (e2) => IntVector(
                  x: e2[1],
                  y: e2[0],
                ),
              )
              .toList(),
        )
        .toList();
  }
}
