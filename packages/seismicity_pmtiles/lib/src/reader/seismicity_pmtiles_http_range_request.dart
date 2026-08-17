import 'package:dio/dio.dart';
import 'package:pmtiles_v3/pmtiles_v3.dart';

final class SeismicityPmTilesHttpRangeRequestBuilder {
  const new();

  Options build({
    required int offset,
    required int length,
    required int sizeBytes,
    required String? strongEtag,
  }) {
    const rangeValidator = PmTilesV3RangeValidator();
    rangeValidator.validate(
      offset: offset,
      length: length,
      sizeBytes: sizeBytes,
    );
    final headers = <String, String>{
      'Range': 'bytes=$offset-${offset + length - 1}',
    };
    if (strongEtag != null) {
      headers['If-Match'] = strongEtag;
    }
    return Options(
      headers: headers,
      responseType: ResponseType.bytes,
      validateStatus: (status) =>
          status != null && status >= 200 && status < 500,
    );
  }
}

final class SeismicityPmTilesStrongEtagValidator {
  const new();

  bool isValid({required String value}) {
    final codeUnits = value.codeUnits;
    if (codeUnits.length < 2 ||
        codeUnits.first != 0x22 ||
        codeUnits.last != 0x22) {
      return false;
    }
    for (final codeUnit in codeUnits.sublist(1, codeUnits.length - 1)) {
      final isEtagCharacter =
          codeUnit == 0x21 ||
          (codeUnit >= 0x23 && codeUnit <= 0x7e) ||
          (codeUnit >= 0x80 && codeUnit <= 0xff);
      if (!isEtagCharacter) {
        return false;
      }
    }
    return true;
  }
}
