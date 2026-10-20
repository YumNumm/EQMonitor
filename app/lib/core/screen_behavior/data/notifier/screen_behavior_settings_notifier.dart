import 'package:eqmonitor/core/screen_behavior/data/model/screen_behavior_settings.dart';
import 'package:eqmonitor/core/screen_behavior/data/repository/screen_behavior_settings_repository.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'screen_behavior_settings_notifier.g.dart';

@Riverpod(keepAlive: true)
class ScreenBehaviorSettingsNotifier extends _$ScreenBehaviorSettingsNotifier {
  @override
  Future<ScreenBehaviorSettings> build() async {
    final repository = await ref.watch(
      screenBehaviorSettingsRepositoryProvider.future,
    );
    return repository.load();
  }

  static final keepScreenAwakeMutation = Mutation<void>();

  Future<void> setKeepScreenAwake({required bool enabled}) async {
    final repository = await ref.read(
      screenBehaviorSettingsRepositoryProvider.future,
    );
    try {
      await repository.setKeepScreenAwake(enabled: enabled);
    } catch (_) {
      final settings = await repository.load();
      if (ref.mounted) state = AsyncData(settings);
      rethrow;
    }
    if (!ref.mounted) return;
    state = AsyncData(state.requireValue.copyWith(keepScreenAwake: enabled));
  }

  static final showWhenLockedMutation = Mutation<void>();

  Future<void> setShowWhenLocked({required bool enabled}) async {
    final repository = await ref.read(
      screenBehaviorSettingsRepositoryProvider.future,
    );
    try {
      await repository.setShowWhenLocked(enabled: enabled);
    } catch (_) {
      final settings = await repository.load();
      if (ref.mounted) state = AsyncData(settings);
      rethrow;
    }
    if (!ref.mounted) return;
    state = AsyncData(state.requireValue.copyWith(showWhenLocked: enabled));
  }
}
