import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_warning_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApiEewWarningConfigResponseConverter', () {
    test('converts current_location_only target', () {
      const response = api.EewWarningConfigResponse(
        target: api.Target.currentLocationOnly,
        nationwideInterruptionLevel: null,
      );

      final settings = response.toEewWarningSettings();

      expect(settings.target, EewWarningTarget.currentLocationOnly);
      expect(settings.nationwideInterruptionLevel, isNull);
    });

    test('converts current_location_and_nationwide target', () {
      const response = api.EewWarningConfigResponse(
        target: api.Target.currentLocationAndNationwide,
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
}
