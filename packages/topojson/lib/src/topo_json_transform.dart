import 'package:freezed_annotation/freezed_annotation.dart';

part 'topo_json_transform.freezed.dart';
part 'topo_json_transform.g.dart';

@freezed
class TopoJsonTransform with _$TopoJsonTransform {
  const factory TopoJsonTransform({
    required List<double> scale,
    required List<double> translate,
  }) = _TopoJsonTransform;

  factory TopoJsonTransform.fromJson(Map<String, dynamic> json) =>
      _$TopoJsonTransformFromJson(json);
}
