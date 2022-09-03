import 'dart:convert';

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
          NotificationSettingsModel.load(
            ref.read(sharedPreferencesProvder),
          ),
        );

  final Ref ref;

  Future<void> save() async => ref.read(sharedPreferencesProvder).setString(
        NotificationSettingsModel.key,
        jsonEncode(state.toJson()),
      );

  void toggleUseTts() => state = state.copyWith(useTts: !state.useTts);
}
