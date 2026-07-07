import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_preset_notifier.g.dart';

enum NotificationPreset { recommended, custom }

@Riverpod(keepAlive: true)
class NotificationPresetNotifier extends _$NotificationPresetNotifier {
  @override
  Future<NotificationPreset> build() async {
    final dataSource = await ref.watch(
      sharedPreferencesDataSourceProvider.future,
    );
    final stored = await dataSource.getString(
      key: SharedPreferencesKey.notificationPreset,
    );
    return stored == NotificationPreset.custom.name
        ? NotificationPreset.custom
        : NotificationPreset.recommended;
  }

  Future<void> select(NotificationPreset preset) async {
    final dataSource = await ref.read(
      sharedPreferencesDataSourceProvider.future,
    );
    await dataSource.setString(
      key: SharedPreferencesKey.notificationPreset,
      value: preset.name,
    );
    state = AsyncData(preset);
  }
}
