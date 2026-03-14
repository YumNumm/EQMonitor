import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:eqmonitor_api/export.dart' as api;

part 'earthquake_list_response.freezed.dart';
part 'earthquake_list_response.g.dart';

@freezed
abstract class EarthquakeListResponse with _$EarthquakeListResponse {
  const factory EarthquakeListResponse({
    required List<EarthquakePartial> items,
    required String? nextToken,
    required String? nextPooling,
  }) = _EarthquakeListResponse;

  factory EarthquakeListResponse.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeListResponseFromJson(json);
}

extension EarthquakeListResponseApiExtension on api.EarthquakeListResponse {
  EarthquakeListResponse get toEarthquakeListResponse => EarthquakeListResponse(
    items: items.map((e) => e.toEarthquakePartial).toList(),
    nextToken: nextToken,
    nextPooling: nextPooling,
  );
}
