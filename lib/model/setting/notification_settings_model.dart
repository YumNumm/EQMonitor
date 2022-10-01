import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../const/kmoni/jma_intensity.dart';

part 'notification_settings_model.freezed.dart';
part 'notification_settings_model.g.dart';

@freezed
class NotificationSettingsModel with _$NotificationSettingsModel {
  const factory NotificationSettingsModel({
    /// 精度の低い地震の通知をするかどうか
    @Default(false) bool lowPrecision,

    /// マグニチュードの閾値
    /// この値以上の地震が発生した場合に通知する
    @Default(0.0) double magnitudeThreshold,

    /// 予想最大震度の閾値
    /// この値以上の地震が発生した場合に通知する
    @Default(JmaIntensity.Int0) JmaIntensity intensityThreshold,

    /// TTSのよる読み上げをするかどうか
    @Default(false) bool useTts,

    /// TTSの読み上げ速度
    @Default(1) double ttsSpeed,

    /// TTSの声の高さ
    @Default(1) double ttsPitch,

    /// TTSの音量
    @Default(1) double ttsVolume,
  }) = _NotificationSettingsModel;

  factory NotificationSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingsModelFromJson(json);

  static const String key = 'notification_settings';



  static NotificationSettingsModel load(SharedPreferences prefs) {
    final json = prefs.getString(key);
    if (json == null) {
      return const NotificationSettingsModel();
    }
    return NotificationSettingsModel.fromJson(jsonDecode(json));
  }
}
