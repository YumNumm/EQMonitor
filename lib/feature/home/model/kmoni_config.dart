import 'package:freezed_annotation/freezed_annotation.dart';
part 'kmoni_config.freezed.dart';
part 'kmoni_config.g.dart';

@freezed
class KmoniConfig with _$KmoniConfig {
  const factory KmoniConfig({
    @Default(0) int counter, // Add your fields here
  }) = _KmoniConfig;

  factory KmoniConfig.fromJson(Map<String, dynamic> json) =>
      _$KmoniConfigFromJson(json);
}
