import 'package:eqmonitor/feature/intensity_history/data/model/highest_intensity_entry.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'highest_intensity_response.freezed.dart';
part 'highest_intensity_response.g.dart';

@freezed
abstract class HighestIntensityResponse with _$HighestIntensityResponse {
  const factory({
    required DateTime aggregatedAt,
    required List<HighestIntensityEntry> items,
  }) = _HighestIntensityResponse;

  factory fromJson(Map<String, dynamic> json) =>
      _$HighestIntensityResponseFromJson(json);
}

extension HighestIntensityItemApiExtension on api.HighestIntensityResponse {
  HighestIntensityResponse toAppResponse({
    required EarthquakeParameter parameter,
  }) => HighestIntensityResponse(
    aggregatedAt: aggregatedAt,
    items: items.map((e) => e.toAppEntry(parameter: parameter)).toList(),
  );
}
