import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:eqmonitor/feature/devices/data/persistence/shared_preferences_workflow_persistence.dart';
import 'package:eqmonitor/feature/notification/data/notifier/general_notification_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/action/notification_preset_slots_builder.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_warning_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_custom_snapshot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot_draft.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/earthquake_global_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/eew_global_settings_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/eew_warning_config_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_preset_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/notifier/notification_slots_notifier.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/repository/notification_custom_snapshot_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:workflows/workflows.dart';

part 'notification_preset_applier.g.dart';

const _workflowInstanceId = 'notification-preset-apply-v1';

// UI から ref.read で取得後、API 呼び出しの await を跨いで Ref を使うため
// autoDispose だと途中で dispose され UnmountedRefException になる
@Riverpod(keepAlive: true)
NotificationPresetApplier notificationPresetApplier(Ref ref) =>
    NotificationPresetApplier(ref);

class NotificationPresetApplier {
  new(this._ref);

  final Ref _ref;

  /// プリセットを適用する。
  ///
  /// カスタムから離脱する場合は現在の設定をスナップショットへ退避し、カスタムを
  /// 選び直した場合はスナップショットから復元する。スロットはサーバ側で全件置換
  /// する。中断しても同じ instanceId で再開すると未完了ステップから続行する。
  Future<void> apply(NotificationPreset preset) async {
    final previous = await _ref.read(notificationPresetProvider.future);
    final runner = WorkflowRunner(
      persistence: SharedPreferencesWorkflowPersistence(
        _ref.read(sharedPreferencesProvider),
      ),
    );

    await runner.run<void>(
      instanceId: _workflowInstanceId,
      workflow: (step) async {
        if (previous == NotificationPreset.custom &&
            preset != NotificationPreset.custom) {
          await step('saveCustomSnapshot', _saveCustomSnapshot);
        }

        final snapshot = preset == NotificationPreset.custom
            ? await _ref
                  .read(notificationCustomSnapshotRepositoryProvider.future)
                  .then((repo) => repo.load())
            : null;

        await step('replaceSlots', () => _replaceSlots(preset, snapshot));
        await step('updateGeneral', () => _updateGeneral(preset, snapshot));
        await step('updateGlobals', () => _updateGlobals(preset, snapshot));
        if (preset == NotificationPreset.custom && snapshot != null) {
          await step('restoreCustomExtras', () => _restoreExtras(snapshot));
        }
        if (preset == NotificationPreset.all) {
          // updateGlobals の warningEnabled: true でサーバ側の target が
          // current_location_only にリセットされるため、その後に全国対象へ上書きする
          await step('applyNationwideWarning', _applyNationwideWarning);
        }
        await step('selectPreset', () async {
          await _ref.read(notificationPresetProvider.notifier).select(preset);
        });
      },
    );

    await runner.clear(_workflowInstanceId);
  }

  Future<void> _saveCustomSnapshot() async {
    final slots = await _ref.read(notificationSlotsProvider.future);
    final eewWarning = await _ref.read(eewWarningConfigProvider.future);
    final eewGlobal = await _ref.read(eewGlobalSettingsProvider.future);
    final earthquakeGlobal = await _ref.read(
      earthquakeGlobalSettingsProvider.future,
    );
    final general = await _ref.read(generalNotificationSettingsProvider.future);

    final snapshot = NotificationCustomSnapshot(
      schemaVersion: notificationCustomSnapshotSchemaVersion,
      slots: slots.map((s) => s.toDraft()).toList(),
      eewWarning: eewWarning,
      eewGlobal: eewGlobal,
      earthquakeGlobal: earthquakeGlobal,
      general: general,
    );
    final repo = await _ref.read(
      notificationCustomSnapshotRepositoryProvider.future,
    );
    await repo.save(snapshot);
  }

  Future<void> _replaceSlots(
    NotificationPreset preset,
    NotificationCustomSnapshot? snapshot,
  ) async {
    final builder = _ref.read(notificationPresetSlotsBuilderProvider);
    final List<NotificationSlotDraft> slots =
        preset == NotificationPreset.custom && snapshot != null
        ? snapshot.slots
        : builder.build(preset);
    await _ref.read(notificationSlotsProvider.notifier).replaceSlots(slots);
  }

  Future<void> _updateGeneral(
    NotificationPreset preset,
    NotificationCustomSnapshot? snapshot,
  ) async {
    final notifier = _ref.read(generalNotificationSettingsProvider.notifier);
    switch (preset) {
      case NotificationPreset.none:
        await notifier.updateSettings(notificationEnabled: false);
      case NotificationPreset.recommended:
        await notifier.updateSettings(notificationEnabled: true);
      case NotificationPreset.all:
        await notifier.updateSettings(
          notificationEnabled: true,
          nankaiExtraordinaryEnabled: true,
          nankaiRegularEnabled: true,
          vyse60Enabled: true,
          earthquakeNoticeEnabled: true,
        );
      case NotificationPreset.custom:
        final general = snapshot?.general;
        await notifier.updateSettings(
          notificationEnabled: general?.notificationEnabled ?? true,
          tsunamiEnabled: general?.tsunamiEnabled,
          trainingEnabled: general?.trainingEnabled,
          nankaiExtraordinaryEnabled: general?.nankaiExtraordinaryEnabled,
          nankaiRegularEnabled: general?.nankaiRegularEnabled,
          vyse60Enabled: general?.vyse60Enabled,
          earthquakeNoticeEnabled: general?.earthquakeNoticeEnabled,
        );
    }
  }

  Future<void> _updateGlobals(
    NotificationPreset preset,
    NotificationCustomSnapshot? snapshot,
  ) async {
    final eewNotifier = _ref.read(eewGlobalSettingsProvider.notifier);
    final earthquakeNotifier = _ref.read(
      earthquakeGlobalSettingsProvider.notifier,
    );
    if (preset == NotificationPreset.custom) {
      final eew = snapshot?.eewGlobal;
      final earthquake = snapshot?.earthquakeGlobal;
      await eewNotifier.updateSettings(
        enabled: true,
        defaultSound: eew?.defaultSound,
        defaultInterruptionLevel: eew?.defaultInterruptionLevel,
        startLiveActivity: true,
        collapseNotification: eew?.collapseNotification,
        warningEnabled: eew?.warningEnabled,
      );
      await earthquakeNotifier.updateSettings(
        enabled: true,
        defaultSound: earthquake?.defaultSound,
        defaultInterruptionLevel: earthquake?.defaultInterruptionLevel,
        estimatedIntensityEnabled: earthquake?.estimatedIntensityEnabled,
        collapseNotification: earthquake?.collapseNotification,
      );
      return;
    }
    await eewNotifier.updateSettings(
      enabled: true,
      startLiveActivity: preset != NotificationPreset.none,
      warningEnabled: preset == NotificationPreset.none ? null : true,
    );
    await earthquakeNotifier.updateSettings(enabled: true);
  }

  /// 「すべて」の EEW 警報を現在地 + 全国対象にする。
  Future<void> _applyNationwideWarning() async {
    await _ref
        .read(eewWarningConfigProvider.notifier)
        .updateConfig(
          target: EewWarningTarget.currentLocationAndNationwide,
          currentLocationInterruptionLevel:
              currentLocationEewWarningDefaultLevel,
          nationwideInterruptionLevel: nationwideEewWarningDefaultLevel,
        );
  }

  Future<void> _restoreExtras(NotificationCustomSnapshot snapshot) async {
    await _ref
        .read(eewWarningConfigProvider.notifier)
        .updateConfig(
          target: snapshot.eewWarning.target,
          currentLocationInterruptionLevel:
              snapshot.eewWarning.currentLocationInterruptionLevel,
          nationwideInterruptionLevel:
              snapshot.eewWarning.nationwideInterruptionLevel,
        );
  }
}
