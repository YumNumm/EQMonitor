import 'package:eqapi_types/lib.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'devices_earthquake_settings.freezed.dart';
part 'devices_earthquake_settings.g.dart';

@freezed
class DevicesEarthquakeSettings with _$DevicesEarthquakeSettings {
  const factory DevicesEarthquakeSettings({
    required String id,
    required JmaForecastIntensity minJmaIntensity,
    required int regionId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _DevicesEarthquakeSettings;

  factory DevicesEarthquakeSettings.fromJson(Map<String, dynamic> json) =>
      _$DevicesEarthquakeSettingsFromJson(json);
}
