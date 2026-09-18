import 'package:eqmonitor/feature/earthquake_history/data/logic/estimated_intensity_archive_header_validator.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_header_validation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pmtiles_v3/pmtiles_v3.dart';

import 'estimated_intensity_archive_header_test_support.dart';

void main() {
  const validator = EstimatedIntensityArchiveHeaderValidator();

  test('MVT gzipと有効なzoom boundsのheaderを受理する', () {
    expect(validator.validate(validEstimatedIntensityArchiveHeader), isNull);
  });

  test('MVT以外とgzip以外を分類して拒否する', () {
    final cases =
        <
          ({
            PmTilesV3Header header,
            EstimatedIntensityArchiveHeaderFailure failure,
          })
        >[
          (
            header: validEstimatedIntensityArchiveHeader.copyWith(tileType: 2),
            failure: EstimatedIntensityArchiveHeaderFailure.invalidTileType,
          ),
          (
            header: validEstimatedIntensityArchiveHeader.copyWith(
              tileCompression: 1,
            ),
            failure:
                EstimatedIntensityArchiveHeaderFailure.invalidTileCompression,
          ),
        ];
    for (final testCase in cases) {
      expect(validator.validate(testCase.header), testCase.failure);
    }
  });

  test('PMTiles範囲外または逆転したzoomを拒否する', () {
    for (final header in [
      validEstimatedIntensityArchiveHeader.copyWith(minZoom: 15),
      validEstimatedIntensityArchiveHeader.copyWith(
        maxZoom: PmTilesV3TileId.maxZoom + 1,
      ),
    ]) {
      expect(
        validator.validate(header),
        EstimatedIntensityArchiveHeaderFailure.invalidZoomRange,
      );
    }
  });

  test('有限なWGS84範囲外または逆転したboundsを拒否する', () {
    for (final header in [
      validEstimatedIntensityArchiveHeader.copyWith(minLongitude: -181),
      validEstimatedIntensityArchiveHeader.copyWith(maxLatitude: 91),
      validEstimatedIntensityArchiveHeader.copyWith(
        minLongitude: 155,
        maxLongitude: 154,
      ),
      validEstimatedIntensityArchiveHeader.copyWith(
        minLatitude: double.nan,
      ),
    ]) {
      expect(
        validator.validate(header),
        EstimatedIntensityArchiveHeaderFailure.invalidBounds,
      );
    }
  });
}
