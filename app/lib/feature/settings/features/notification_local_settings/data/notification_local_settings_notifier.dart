import 'dart:convert';

import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/feature/settings/features/notification_local_settings/data/notification_local_settings_model.dart';
import 'package:notification_setting_types/notification_payload.pbenum.dart'
    as pb_enum;
import 'package:notification_setting_types/notification_settings.pb.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preference_app_group/shared_preference_app_group.dart';

part 'notification_local_settings_notifier.g.dart';

@Riverpod(keepAlive: true)
class NotificationLocalSettingsNotifier
    extends _$NotificationLocalSettingsNotifier {
  @override
  Future<NotificationLocalSettingsModel> build() async {
    final value =
        await SharedPreferenceAppGroup.getString('notification_settings');
    if (value == null) {
      return const NotificationLocalSettingsModel();
    }
    // base64でdecode
    final buffer = base64Decode(value);
    final savedState = NotificationSettings.fromBuffer(buffer);
    return NotificationLocalSettingsModel(
      earthquake: EarthquakeSettings(
        emergencyIntensity:
            savedState.earthquakeSettings.emergencyIntensity.jmaIntensity,
        silentIntensity:
            savedState.earthquakeSettings.silentIntensity.jmaIntensity,
        regions: savedState.earthquakeSettings.regions
            .map(
              (e) => Region(
                code: e.code,
                name: e.name,
                emergencyIntensity: e.emergencyIntensity.jmaIntensity,
                silentIntensity: e.silentIntensity.jmaIntensity,
                isMain: e.isMain,
              ),
            )
            .toList(),
      ),
      eew: EewSettings(
        emergencyIntensity:
            savedState.eewSettings.emergencyIntensity.jmaIntensity,
        silentIntensity: savedState.eewSettings.silentIntensity.jmaIntensity,
        regions: savedState.eewSettings.regions
            .map(
              (e) => Region(
                code: e.code,
                name: e.name,
                emergencyIntensity: e.emergencyIntensity.jmaIntensity,
                silentIntensity: e.silentIntensity.jmaIntensity,
                isMain: e.isMain,
              ),
            )
            .toList(),
      ),
    );
  }

  Future<void> save(NotificationLocalSettingsModel state) async {
    final pb = NotificationSettings(
      earthquakeSettings: NotificationSettings_EarthquakeSettings(
        emergencyIntensity: state.earthquake.emergencyIntensity?.toPb,
        silentIntensity: state.earthquake.silentIntensity?.toPb,
        regions: state.earthquake.regions
            .map(
              (e) => NotificationSettings_EarthquakeSettings_Region(
                code: e.code,
                name: e.name,
                emergencyIntensity: e.emergencyIntensity.toPb,
                silentIntensity: e.silentIntensity.toPb,
                isMain: e.isMain,
              ),
            )
            .toList(),
      ),
      eewSettings: NotificationSettings_EewSettings(
        emergencyIntensity: state.eew.emergencyIntensity?.toPb,
        silentIntensity: state.eew.silentIntensity?.toPb,
        regions: state.eew.regions
            .map(
              (e) => NotificationSettings_EewSettings_Region(
                code: e.code,
                name: e.name,
                emergencyIntensity: e.emergencyIntensity.toPb,
                silentIntensity: e.silentIntensity.toPb,
                isMain: e.isMain,
              ),
            )
            .toList(),
      ),
    );
    final buffer = pb.writeToBuffer();
    // base64でencode
    final value = base64Encode(buffer);
    await SharedPreferenceAppGroup.setString('notification_settings', value);
  }
}

extension PbEnumEx on pb_enum.JmaIntensity {
  JmaForecastIntensity get jmaIntensity => switch (this) {
        pb_enum.JmaIntensity.JMA_INTENSITY_0 => JmaForecastIntensity.zero,
        pb_enum.JmaIntensity.JMA_INTENSITY_1 => JmaForecastIntensity.one,
        pb_enum.JmaIntensity.JMA_INTENSITY_2 => JmaForecastIntensity.two,
        pb_enum.JmaIntensity.JMA_INTENSITY_3 => JmaForecastIntensity.three,
        pb_enum.JmaIntensity.JMA_INTENSITY_4 => JmaForecastIntensity.four,
        pb_enum.JmaIntensity.JMA_INTENSITY_5_MINUS =>
          JmaForecastIntensity.fiveLower,
        pb_enum.JmaIntensity.JMA_INTENSITY_5_PLUS =>
          JmaForecastIntensity.fiveUpper,
        pb_enum.JmaIntensity.JMA_INTENSITY_6_MINUS =>
          JmaForecastIntensity.sixLower,
        pb_enum.JmaIntensity.JMA_INTENSITY_6_PLUS =>
          JmaForecastIntensity.sixUpper,
        pb_enum.JmaIntensity.JMA_INTENSITY_7 => JmaForecastIntensity.seven,
        pb_enum.JmaIntensity.JMA_INTENSITY_UNSPECIFIED =>
          JmaForecastIntensity.unknown,
        pb_enum.JmaIntensity() => throw UnimplementedError(),
      };
}

extension JmaIntensity on JmaForecastIntensity {
  pb_enum.JmaIntensity get toPb => switch (this) {
        JmaForecastIntensity.zero => pb_enum.JmaIntensity.JMA_INTENSITY_0,
        JmaForecastIntensity.one => pb_enum.JmaIntensity.JMA_INTENSITY_1,
        JmaForecastIntensity.two => pb_enum.JmaIntensity.JMA_INTENSITY_2,
        JmaForecastIntensity.three => pb_enum.JmaIntensity.JMA_INTENSITY_3,
        JmaForecastIntensity.four => pb_enum.JmaIntensity.JMA_INTENSITY_4,
        JmaForecastIntensity.fiveLower =>
          pb_enum.JmaIntensity.JMA_INTENSITY_5_MINUS,
        JmaForecastIntensity.fiveUpper =>
          pb_enum.JmaIntensity.JMA_INTENSITY_5_PLUS,
        JmaForecastIntensity.sixLower =>
          pb_enum.JmaIntensity.JMA_INTENSITY_6_MINUS,
        JmaForecastIntensity.sixUpper =>
          pb_enum.JmaIntensity.JMA_INTENSITY_6_PLUS,
        JmaForecastIntensity.seven => pb_enum.JmaIntensity.JMA_INTENSITY_7,
        JmaForecastIntensity.unknown =>
          pb_enum.JmaIntensity.JMA_INTENSITY_UNSPECIFIED,
      };
}
