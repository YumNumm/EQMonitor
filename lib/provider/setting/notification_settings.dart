import 'dart:convert';

import '../../ui/theme/jma_intensity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/setting/notification_settings_model.dart';
import '../init/shared_preferences.dart';

final notificationSettingsProvider = StateNotifierProvider<
    NotificationSettingsNotifier, NotificationSettingsModel>(
  NotificationSettingsNotifier.new,
);

class NotificationSettingsNotifier
    extends StateNotifier<NotificationSettingsModel> {
  NotificationSettingsNotifier(this.ref)
      : super(
          NotificationSettingsModel.loadFromPrefs(
            ref.read(sharedPreferencesProvder),
          ),
        );

  final Ref ref;

  /// 設定を保存する
  Future<void> save() async => ref.read(sharedPreferencesProvder).setString(
        NotificationSettingsModel.key,
        jsonEncode(state.toJson()),
      );

  /// TTSの使用を切り替える
  void toggleUseTts() => state = state.copyWith(useTts: !state.useTts);

  void toggleTestNotification() =>
      state = state.copyWith(isRecieveTraining: !state.isRecieveTraining);

  void togglevzse40() =>
      state = state.copyWith(isRecieveVzse40: !state.isRecieveVzse40);

  /// 精度の低いEEW通知の使用を切り替える
  void toggleLowPrecision() =>
      state = state.copyWith(lowPrecision: !state.lowPrecision);

  /// 予想最大震度の閾値を設定
  void setIntensityThreshold(JmaIntensity intensity) {
    if (<JmaIntensity>[
      JmaIntensity.Error,
      JmaIntensity.Unknown,
      JmaIntensity.over
    ].contains(intensity)) {
      throw ArgumentError('Invalid intensity: $intensity');
    }
    state = state.copyWith(intensityThreshold: intensity);
  }

  void setMagnitudeThreshold(double magnitude) =>
      state = state.copyWith(magnitudeThreshold: magnitude);
}
