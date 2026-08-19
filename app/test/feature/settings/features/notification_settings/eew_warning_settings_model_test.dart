import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_warning_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApiEewWarningConfigResponseConverter', () {
    test('converts current_location_only target', () {
      const response = api.EewWarningConfigResponse(
        target: api.Target.currentLocationOnly,
        currentLocationInterruptionLevel:
            api.CurrentLocationInterruptionLevel.critical,
        nationwideInterruptionLevel: null,
      );

      final settings = response.toEewWarningSettings();

      expect(settings.target, EewWarningTarget.currentLocationOnly);
      expect(settings.nationwideInterruptionLevel, isNull);
    });

    test('converts current_location_and_nationwide target', () {
      const response = api.EewWarningConfigResponse(
        target: api.Target.currentLocationAndNationwide,
        currentLocationInterruptionLevel:
            api.CurrentLocationInterruptionLevel.critical,
        nationwideInterruptionLevel: api.NationwideInterruptionLevel.active,
      );

      final settings = response.toEewWarningSettings();

      expect(settings.target, EewWarningTarget.currentLocationAndNationwide);
      expect(
        settings.nationwideInterruptionLevel,
        InterruptionLevel.active,
      );
    });
  });

  group('EewWarningTarget', () {
    test('toApiTarget roundtrips correctly', () {
      expect(
        EewWarningTarget.currentLocationOnly.toApiTarget,
        api.Target.currentLocationOnly,
      );
      expect(
        EewWarningTarget.currentLocationAndNationwide.toApiTarget,
        api.Target.currentLocationAndNationwide,
      );
    });
  });

  group('ApiTargetConverter', () {
    test('maps all API target values', () {
      expect(
        api.Target.currentLocationOnly.toAppTarget,
        EewWarningTarget.currentLocationOnly,
      );
      expect(
        api.Target.currentLocationAndNationwide.toAppTarget,
        EewWarningTarget.currentLocationAndNationwide,
      );
    });
  });

  group('interruptionLevelsFor', () {
    test('現在地は重大な通知を選べる', () {
      expect(
        interruptionLevelsFor(NotificationSlotType.currentLocation),
        contains(InterruptionLevel.critical),
      );
    });

    test('全国は重大な通知を選べない', () {
      expect(
        interruptionLevelsFor(NotificationSlotType.nationwide),
        isNot(contains(InterruptionLevel.critical)),
      );
      expect(interruptionLevelsFor(NotificationSlotType.nationwide), [
        InterruptionLevel.passive,
        InterruptionLevel.active,
        InterruptionLevel.timeSensitive,
      ]);
    });

    test('既定値はそれぞれの選択肢に含まれる', () {
      expect(
        interruptionLevelsFor(NotificationSlotType.currentLocation),
        contains(currentLocationEewWarningDefaultLevel),
      );
      expect(
        interruptionLevelsFor(NotificationSlotType.nationwide),
        contains(nationwideEewWarningDefaultLevel),
      );
    });
  });
}
