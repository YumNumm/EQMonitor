import 'dart:io';

import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_download.dart';
import 'package:flutter_test/flutter_test.dart';

import 'estimated_intensity_archive_download_test_support.dart';
import 'estimated_intensity_archive_transport_test_support.dart';

void main() {
  late Directory temporaryDirectory;

  setUp(() async {
    temporaryDirectory = await Directory.systemTemp.createTemp(
      'estimated_intensity_content_length_test_',
    );
  });

  tearDown(() async {
    if (temporaryDirectory.existsSync()) {
      await temporaryDirectory.delete(recursive: true);
    }
  });

  for (final contentLength in [10, 12, 2048]) {
    test('Content-Length $contentLengthをdescriptor不一致で拒否する', () async {
      final result = await downloadResponse(
        temporaryDirectory: temporaryDirectory,
        response: estimatedIntensityTestResponse(
          contentLength: contentLength,
        ),
      );

      expectEstimatedIntensityDownloadFailure(
        result: result,
        failure: EstimatedIntensityArchiveDownloadFailure.invalidContentLength,
      );
      expect(temporaryDirectory.listSync(recursive: true), isEmpty);
    });
  }
}
