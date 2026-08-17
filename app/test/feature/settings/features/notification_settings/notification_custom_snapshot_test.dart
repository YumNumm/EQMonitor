import 'dart:convert';

import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/notification/data/model/general_notification_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/earthquake_global_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_global_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_warning_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_custom_snapshot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot_draft.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('スナップショットは JSON 往復で同値になる', () {
    const snapshot = NotificationCustomSnapshot(
      schemaVersion: notificationCustomSnapshotSchemaVersion,
      slots: [
        NotificationSlotDraft(
          slotType: NotificationSlotType.currentLocation,
          eewEnabled: true,
          eewMinIntensity: JmaIntensity.four,
          earthquakeEnabled: true,
          earthquakeMinIntensity: JmaIntensity.one,
        ),
        NotificationSlotDraft(
          slotType: NotificationSlotType.region,
          regionId: 10,
          regionName: '東京都',
          eewEnabled: true,
          eewMinIntensity: JmaIntensity.zero,
          earthquakeEnabled: false,
          earthquakeOverrides: [
            NotificationOverride(
              minJmaIntensity: JmaIntensity.fiveLower,
              sound: 'default',
              interruptionLevel: InterruptionLevel.critical,
            ),
          ],
        ),
      ],
      eewWarning: EewWarningSettings(
        target: EewWarningTarget.currentLocationAndNationwide,
        nationwideInterruptionLevel: InterruptionLevel.active,
      ),
      eewGlobal: EewGlobalSettings(
        enabled: true,
        defaultSound: 'default',
        defaultInterruptionLevel: InterruptionLevel.timeSensitive,
        startLiveActivity: true,
        collapseNotification: false,
        warningEnabled: true,
      ),
      earthquakeGlobal: EarthquakeGlobalSettings(
        enabled: true,
        defaultSound: 'default',
        defaultInterruptionLevel: InterruptionLevel.active,
        estimatedIntensityEnabled: true,
        collapseNotification: false,
      ),
      general: GeneralNotificationSettings(
        notificationEnabled: true,
        tsunamiEnabled: false,
        trainingEnabled: false,
        nankaiExtraordinaryEnabled: true,
        nankaiRegularEnabled: true,
        vyse60Enabled: true,
        earthquakeNoticeEnabled: true,
      ),
    );

    final restored = NotificationCustomSnapshot.fromJson(
      jsonDecode(jsonEncode(snapshot.toJson())) as Map<String, dynamic>,
    );
    expect(restored, snapshot);
  });
}
