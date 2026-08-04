import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';

final class SeismicityRangeValidator {
  const SeismicityRangeValidator();

  void validate({
    required int offset,
    required int length,
    required int sizeBytes,
  }) {
    final isInvalid =
        offset < 0 ||
        length <= 0 ||
        sizeBytes < 0 ||
        length > sizeBytes ||
        offset > sizeBytes - length;
    if (isInvalid) {
      throw SeismicityPmTilesException.invalidRange(
        offset: offset,
        length: length,
        sizeBytes: sizeBytes,
      );
    }
  }
}
