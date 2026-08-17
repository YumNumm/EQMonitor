import 'package:pmtiles_v3/src/model/pmtiles_v3_exception.dart';

final class PmTilesV3RangeValidator {
  const new();

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
      throw PmTilesV3Exception.invalidRange(
        offset: offset,
        length: length,
        sizeBytes: sizeBytes,
      );
    }
  }
}
