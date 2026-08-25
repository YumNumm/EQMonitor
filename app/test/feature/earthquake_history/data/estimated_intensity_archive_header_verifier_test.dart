import 'dart:io';

import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_header_verifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_download.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_header_validation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pmtiles_v3/pmtiles_v3.dart';

import 'estimated_intensity_archive_download_test_support.dart';
import 'estimated_intensity_archive_header_test_support.dart';
import 'estimated_intensity_archive_header_verifier_test_support.dart';

void main() {
  late Directory temporaryDirectory;
  late VerifiedEstimatedIntensityArchiveDownload download;

  setUp(() async {
    temporaryDirectory = await Directory.systemTemp.createTemp(
      'estimated_intensity_header_verifier_test_',
    );
    final result = await downloadBody(
      temporaryDirectory: temporaryDirectory,
      contentLength: 11,
      body: 'hello world'.codeUnits,
    );
    download = switch (result) {
      EstimatedIntensityArchiveDownloadSuccess(:final archive) => archive,
      EstimatedIntensityArchiveDownloadRejected() => throw StateError(
        'fixture download failed',
      ),
    };
  });

  tearDown(() => temporaryDirectory.delete(recursive: true));

  test('正当なheaderを返しarchiveを1回closeする', () async {
    final archive = RecordingEstimatedIntensityArchive(
      header: validEstimatedIntensityArchiveHeader,
    );
    final result = await EstimatedIntensityArchiveHeaderVerifier(
      opener: ControlledEstimatedIntensityArchiveOpener(archive: archive),
    ).verify(download: download, limits: estimatedIntensityHeaderTestLimits);

    expect(result, isA<EstimatedIntensityArchiveHeaderAccepted>());
    expect(archive.closeCount, 1);
  });

  test('不正headerを分類しarchiveを1回closeする', () async {
    final archive = RecordingEstimatedIntensityArchive(
      header: validEstimatedIntensityArchiveHeader.copyWith(tileCompression: 1),
    );
    final result = await EstimatedIntensityArchiveHeaderVerifier(
      opener: ControlledEstimatedIntensityArchiveOpener(archive: archive),
    ).verify(download: download, limits: estimatedIntensityHeaderTestLimits);

    expect(
      result,
      isA<EstimatedIntensityArchiveHeaderRejected>().having(
        (value) => value.failure,
        'failure',
        EstimatedIntensityArchiveHeaderFailure.invalidTileCompression,
      ),
    );
    expect(archive.closeCount, 1);
  });

  test('archive openの非対応internal compressionを分類する', () async {
    final result = await EstimatedIntensityArchiveHeaderVerifier(
      opener: ControlledEstimatedIntensityArchiveOpener(
        failure: const PmTilesV3Exception.unsupportedCompression(
          compression: 3,
        ),
      ),
    ).verify(download: download, limits: estimatedIntensityHeaderTestLimits);

    expect(
      result,
      isA<EstimatedIntensityArchiveHeaderRejected>().having(
        (value) => value.failure,
        'failure',
        EstimatedIntensityArchiveHeaderFailure.invalidArchive,
      ),
    );
  });
}
