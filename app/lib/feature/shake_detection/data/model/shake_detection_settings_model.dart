import 'package:freezed_annotation/freezed_annotation.dart';

part 'shake_detection_settings_model.freezed.dart';
part 'shake_detection_settings_model.g.dart';

@freezed
abstract class ShakeDetectionSettingsModel with _$ShakeDetectionSettingsModel {
  const factory({
    /// 端末内で揺れ検知を行うかどうか
    @Default(true) bool isEnabled,

    /// 検知の履歴が途切れたとき、直近のフレームを裏で取得して履歴を作り直すかどうか
    @Default(true) bool isBackfillEnabled,

    /// `ShakeDetectionTunable.name` をキーとする、初期値から変更したパラメータ
    @Default(<String, double>{}) Map<String, double> parameterOverrides,
  }) = _ShakeDetectionSettingsModel;

  factory fromJson(Map<String, dynamic> json) =>
      _$ShakeDetectionSettingsModelFromJson(json);
}
