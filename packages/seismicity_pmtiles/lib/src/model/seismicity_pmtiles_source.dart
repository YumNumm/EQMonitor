import 'package:freezed_annotation/freezed_annotation.dart';

part 'seismicity_pmtiles_source.freezed.dart';
part 'seismicity_pmtiles_source.g.dart';

@freezed
sealed class SeismicityPmTilesSource with _$SeismicityPmTilesSource {
  const factory network({required Uri archiveUri}) =
      SeismicityPmTilesNetworkSource;

  const factory file({required String path}) =
      SeismicityPmTilesFileSource;

  const factory asset({required String assetKey}) =
      SeismicityPmTilesAssetSource;

  factory fromJson(Map<String, dynamic> json) =>
      _$SeismicityPmTilesSourceFromJson(json);
}
