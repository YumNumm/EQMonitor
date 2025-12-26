import 'package:freezed_annotation/freezed_annotation.dart';

part 'sound_settings.freezed.dart';
part 'sound_settings.g.dart';

/// 通知音モード
@JsonEnum(valueField: 'value')
enum IntensitySoundMode {
  @JsonValue('max_intensity')
  maxIntensity('max_intensity'),
  @JsonValue('location_intensity')
  locationIntensity('location_intensity'),
  @JsonValue('registered_max')
  registeredMax('registered_max');

  const IntensitySoundMode(this.value);
  final String value;
}

/// 通知音設定
@freezed
abstract class SoundSettings with _$SoundSettings {
  const factory SoundSettings({
    required IntensitySoundMode mode,
    Map<String, String>? map,
  }) = _SoundSettings;

  factory SoundSettings.fromJson(Map<String, dynamic> json) =>
      _$SoundSettingsFromJson(json);
}
