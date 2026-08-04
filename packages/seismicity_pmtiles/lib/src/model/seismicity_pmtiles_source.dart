import 'package:freezed_annotation/freezed_annotation.dart';

part 'seismicity_pmtiles_source.freezed.dart';
part 'seismicity_pmtiles_source.g.dart';

@freezed
sealed class SeismicityPmTilesSource with _$SeismicityPmTilesSource {
  const factory SeismicityPmTilesSource.network({required Uri archiveUri}) =
      SeismicityPmTilesNetworkSource;

  const factory SeismicityPmTilesSource.file({required String path}) =
      SeismicityPmTilesFileSource;

  const factory SeismicityPmTilesSource.asset({required String assetKey}) =
      SeismicityPmTilesAssetSource;

  factory SeismicityPmTilesSource.fromJson(Map<String, dynamic> json) =>
      _$SeismicityPmTilesSourceFromJson(json);
}
