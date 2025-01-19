import 'package:freezed_annotation/freezed_annotation.dart';

part 'kyoshin_color_map_model.freezed.dart';
part 'kyoshin_color_map_model.g.dart';

@freezed
class KyoshinColorMapModel with _$KyoshinColorMapModel {
  const factory KyoshinColorMapModel({
    required double intensity,
    required int r,
    required int g,
    required int b,
  }) = _KyoshinColorMapModel;

  factory KyoshinColorMapModel.fromJson(Map<String, dynamic> json) =>
      _$KyoshinColorMapModelFromJson(json);
}
