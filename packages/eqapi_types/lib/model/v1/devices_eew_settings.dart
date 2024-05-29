import 'package:eqapi_types/lib.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'devices_eew_settings.freezed.dart';
part 'devices_eew_settings.g.dart';

@freezed
class DevicesEewSettings with _$DevicesEewSettings {
  const factory DevicesEewSettings({
    required String id,
    required JmaForecastIntensity minJmaIntensity,
    required int regionId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _DevicesEewSettings;

  factory DevicesEewSettings.fromJson(Map<String, dynamic> json) =>
      _$DevicesEewSettingsFromJson(json);
}
