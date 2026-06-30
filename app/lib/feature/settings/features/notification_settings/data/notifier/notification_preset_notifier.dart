import 'dart:async';

import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_preset_notifier.g.dart';

enum NotificationPreset { recommended, custom }

@Riverpod(keepAlive: true)
class NotificationPresetNotifier extends _$NotificationPresetNotifier {
  static const _key = 'notification_preset';

  @override
  NotificationPreset build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final stored = prefs.getString(_key);
    return stored == 'custom'
        ? NotificationPreset.custom
        : NotificationPreset.recommended;
  }

  void select(NotificationPreset preset) {
    final prefs = ref.read(sharedPreferencesProvider);
    unawaited(prefs.setString(_key, preset.name));
    state = preset;
  }
}
