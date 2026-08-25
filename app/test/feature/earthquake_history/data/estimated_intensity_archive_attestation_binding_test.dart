import 'dart:io';

import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_http_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_stream_verifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_descriptor.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_download.dart';
import 'package:flutter_test/flutter_test.dart';

import 'estimated_intensity_archive_transport_test_support.dart';

void main() {
  late Directory temporaryDirectory;

  setUp(() async {
    temporaryDirectory = await Directory.systemTemp.createTemp(
      'estimated_intensity_attestation_test_',
    );
  });

  tearDown(() async {
    if (temporaryDirectory.existsSync()) {
      await temporaryDirectory.delete(recursive: true);
    }
  });

  test('別downloadのverified resultを現在のpartとしてreplayできない', () async {
    final first = await downloadWithVerifier(
      temporaryDirectory: temporaryDirectory,
      fileVerifier: const DartIoEstimatedIntensityArchiveFileVerifier(),
    );
    expect(first, isA<EstimatedIntensityArchiveDownloadSuccess>());
    final beforeReplay = temporaryDirectory
        .listSync(recursive: true)
        .map((entity) => entity.path)
        .toSet();

    final replay = await downloadWithVerifier(
      temporaryDirectory: temporaryDirectory,
      fileVerifier: ReplayEstimatedIntensityArchiveFileVerifier(first),
    );

    expectEstimatedIntensityDownloadFailure(
      result: replay,
      failure: EstimatedIntensityArchiveDownloadFailure.requestFailed,
    );
    expect(
      temporaryDirectory
          .listSync(recursive: true)
          .map((entity) => entity.path)
          .toSet(),
      beforeReplay,
    );
  });
}

Future<EstimatedIntensityArchiveDownloadResult> downloadWithVerifier({
  required Directory temporaryDirectory,
  required EstimatedIntensityArchiveFileVerifier fileVerifier,
}) =>
    EstimatedIntensityArchiveHttpDataSource(
      operationFactory: () => TestEstimatedIntensityArchiveHttpOperation(
        openResponse: Future.value(estimatedIntensityTestResponse()),
      ),
      streamVerifier: EstimatedIntensityArchiveStreamVerifier(
        fileVerifier: fileVerifier,
      ),
    ).download(
      descriptor: estimatedIntensityTestDescriptor(),
      temporaryDirectory: temporaryDirectory,
      limits: estimatedIntensityTransportTestLimits,
    );

final class ReplayEstimatedIntensityArchiveFileVerifier
    implements EstimatedIntensityArchiveFileVerifier {
  const new(this.result);

  final EstimatedIntensityArchiveDownloadResult result;

  @override
  Future<EstimatedIntensityArchiveDownloadResult> verify({
    required EstimatedIntensityArchiveDescriptor descriptor,
    required File file,
  }) async => result;
}
