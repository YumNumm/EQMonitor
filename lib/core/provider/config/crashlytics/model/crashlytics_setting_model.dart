import 'package:freezed_annotation/freezed_annotation.dart';

part 'crashlytics_setting_model.freezed.dart';
part 'crashlytics_setting_model.g.dart';

@freezed
class CrashlyticsSettingModel with _$CrashlyticsSettingModel {
  const factory CrashlyticsSettingModel({
    @Default(true) bool isEnabled,
  }) = _CrashlyticsSettingModel;

  factory CrashlyticsSettingModel.fromJson(Map<String, dynamic> json) =>
      _$CrashlyticsSettingModelFromJson(json);
}
