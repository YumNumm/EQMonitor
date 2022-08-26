import 'dart:convert';

import '../../model/setting/notification_settings_model.dart';
import '../init/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationSettingsProvider = StateNotifierProvider<
    NotificationSettingsNotifier, NotificationSettingsModel>(
  NotificationSettingsNotifier.new,
);

class NotificationSettingsNotifier
    extends StateNotifier<NotificationSettingsModel> {
  NotificationSettingsNotifier(this.ref)
      : super(
          NotificationSettingsModel.fromJson(
            jsonDecode(
              ref.read(sharedPreferencesProvder).getString(key) ?? '{}',
            ),
          ),
        );

  final Ref ref;
  static const String key = 'notification_settings';

  Future<void> save() async => ref.read(sharedPreferencesProvder).setString(
        key,
        jsonEncode(state),
      );
}
