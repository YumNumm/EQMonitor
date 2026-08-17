import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_magnitude.freezed.dart';
part 'earthquake_magnitude.g.dart';

@freezed
sealed class EarthquakeMagnitude with _$EarthquakeMagnitude {
  const factory value({
    required double value,
  }) = EarthquakeMagnitudeValue;

  const factory unknown() = EarthquakeMagnitudeUnknown;

  const factory overM8() = EarthquakeMagnitudeOverM8;

  factory fromJson(Map<String, dynamic> json) =>
      _$EarthquakeMagnitudeFromJson(json);
}

extension EarthquakeMagnitudeApiExtension on api.Magnitude {
  EarthquakeMagnitude get toEarthquakeMagnitude => switch (type) {
    .normal => .value(
      value:
          value?.toDouble() ??
          (throw CheckedFromJsonException(
            toJson(),
            'value',
            'EarthquakeMagnitude',
            'value',
          )),
    ),
    .overM8 => const .overM8(),
    .unknown => const .unknown(),
  };
}
