import 'dart:io';

import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_download.dart';
import 'package:flutter_test/flutter_test.dart';

import 'estimated_intensity_archive_download_test_support.dart';
import 'estimated_intensity_archive_transport_test_support.dart';

void main() {
  late Directory temporaryDirectory;

  setUp(() async {
    temporaryDirectory = await Directory.systemTemp.createTemp(
      'estimated_intensity_response_test_',
    );
  });

  tearDown(() async {
    if (temporaryDirectory.existsSync()) {
      await temporaryDirectory.delete(recursive: true);
    }
  });

  for (final statusCode in [206, 301, 302, 404, 500]) {
    test('status $statusCodeをbodyをpublishせず拒否する', () async {
      final result = await downloadResponse(
        temporaryDirectory: temporaryDirectory,
        response: estimatedIntensityTestResponse(statusCode: statusCode),
      );

      expectEstimatedIntensityDownloadFailure(
        result: result,
        failure: EstimatedIntensityArchiveDownloadFailure.invalidStatus,
      );
      expect(temporaryDirectory.listSync(recursive: true), isEmpty);
    });
  }

  test('redirect responseはbodyを購読する前に拒否する', () async {
    var bodyListened = false;
    final body = Stream<List<int>>.multi(
      (controller) {
        bodyListened = true;
        controller.close();
      },
    );

    final result = await downloadResponse(
      temporaryDirectory: temporaryDirectory,
      response: estimatedIntensityTestResponse(
        statusCode: 302,
        body: body,
      ),
    );

    expectEstimatedIntensityDownloadFailure(
      result: result,
      failure: EstimatedIntensityArchiveDownloadFailure.invalidStatus,
    );
    expect(bodyListened, isFalse);
  });

  for (final encodings in [
    ['gzip'],
    ['br'],
    ['identity, gzip'],
    ['identity', 'gzip'],
  ]) {
    test('Content-Encoding $encodingsを拒否する', () async {
      final result = await downloadResponse(
        temporaryDirectory: temporaryDirectory,
        response: estimatedIntensityTestResponse(
          contentEncodings: encodings,
        ),
      );

      expectEstimatedIntensityDownloadFailure(
        result: result,
        failure:
            EstimatedIntensityArchiveDownloadFailure.invalidContentEncoding,
      );
      expect(temporaryDirectory.listSync(recursive: true), isEmpty);
    });
  }

  test('単一identity encodingは受理する', () async {
    final result = await downloadResponse(
      temporaryDirectory: temporaryDirectory,
      response: estimatedIntensityTestResponse(
        contentEncodings: const ['identity'],
      ),
    );

    expect(result, isA<EstimatedIntensityArchiveDownloadSuccess>());
  });
}
