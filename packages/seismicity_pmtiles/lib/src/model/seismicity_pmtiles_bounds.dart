import 'package:freezed_annotation/freezed_annotation.dart';

part 'seismicity_pmtiles_bounds.freezed.dart';
part 'seismicity_pmtiles_bounds.g.dart';

@freezed
abstract class SeismicityPmTilesBounds with _$SeismicityPmTilesBounds {
  const factory SeismicityPmTilesBounds({
    required double minLongitude,
    required double minLatitude,
    required double maxLongitude,
    required double maxLatitude,
  }) = _SeismicityPmTilesBounds;

  factory SeismicityPmTilesBounds.fromJson(Map<String, dynamic> json) =>
      _$SeismicityPmTilesBoundsFromJson(json);
}
