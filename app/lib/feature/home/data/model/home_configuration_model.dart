import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_configuration_model.freezed.dart';
part 'home_configuration_model.g.dart';

@freezed
abstract class HomeConfigurationModel with _$HomeConfigurationModel {
  const factory HomeConfigurationModel({
    /// 位置情報を表示するかどうか
    @Default(false) bool showLocation,
  }) = _HomeConfigurationModel;

  factory HomeConfigurationModel.fromJson(Map<String, dynamic> json) =>
      _$HomeConfigurationModelFromJson(json);
}
