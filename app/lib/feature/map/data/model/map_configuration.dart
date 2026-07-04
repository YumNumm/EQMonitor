import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_configuration.freezed.dart';
part 'map_configuration.g.dart';

@freezed
abstract class MapConfiguration with _$MapConfiguration {
  const factory MapConfiguration({
    required MapTheme theme,
    String? styleString,
  }) = _MapConfiguration;

  factory MapConfiguration.fromJson(Map<String, dynamic> json) =>
      _$MapConfigurationFromJson(json);
}

enum MapTheme { light, dark, system }
