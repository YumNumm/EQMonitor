import 'dart:convert';

import 'package:eqmonitor/ui/theme/jma_intensity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    @Default(JmaIntensity.int0) JmaIntensity intensityThreshold,

    /// TTSのよる読み上げをするかどうか
    @Default(false) bool useTts,

    /// TTSの読み上げ速度
    /// 0(slowest)~1(fastest)
    @Default(0.4) double ttsSpeed,

    /// TTSの声の高さ
    /// 0.5~2.0
    @Default(0.4) double ttsPitch,

    /// TTSの音量
    @Default(1) double ttsVolume,

    /// 地震・津波に関する情報の通知を受信するかどうか
    @Default(false) bool isRecieveVzse40,

    /// 訓練報を受信するかどうか
    @Default(false) bool isRecieveTraining,
  }) = _NotificationSettingsModel;

  factory NotificationSettingsModel.loadFromPrefs(SharedPreferences prefs) {
    final json = prefs.getString(key);
    if (json == null) {
      return const NotificationSettingsModel();
    }
    return NotificationSettingsModel.fromJson(
      jsonDecode(json) as Map<String, dynamic>,
    );
  }

  factory NotificationSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingsModelFromJson(json);

  static const String key = 'notification_settings';
}
