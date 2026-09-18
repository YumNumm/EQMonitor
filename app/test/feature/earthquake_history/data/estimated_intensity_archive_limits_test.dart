import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_download.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('archive capは正数をcallerが必ず指定する', () {
    expect(
      () => limits(maxArchiveBytes: 0),
      throwsArgumentError,
    );
    expect(
      () => limits(maxArchiveBytes: -1),
      throwsArgumentError,
    );
  });

  for (final field in ['connect', 'header', 'idle', 'total']) {
    test('$field timeoutは正のDurationをcallerが必ず指定する', () {
      expect(
        () => limits(zeroTimeoutField: field),
        throwsArgumentError,
      );
    });
  }
}

EstimatedIntensityArchiveDownloadLimits limits({
  int maxArchiveBytes = 1,
  String? zeroTimeoutField,
}) => EstimatedIntensityArchiveDownloadLimits(
  maxArchiveBytes: maxArchiveBytes,
  connectTimeout: zeroTimeoutField == 'connect'
      ? Duration.zero
      : const Duration(seconds: 1),
  headerTimeout: zeroTimeoutField == 'header'
      ? Duration.zero
      : const Duration(seconds: 1),
  idleTimeout: zeroTimeoutField == 'idle'
      ? Duration.zero
      : const Duration(seconds: 1),
  totalTimeout: zeroTimeoutField == 'total'
      ? Duration.zero
      : const Duration(seconds: 1),
);
