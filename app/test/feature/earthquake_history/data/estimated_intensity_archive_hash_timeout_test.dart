import 'dart:async';
import 'dart:io';

import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_http_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_stream_verifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_cleanup_diagnostic.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_descriptor.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_download.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_stop_reason.dart';
import 'package:flutter_test/flutter_test.dart';

import 'estimated_intensity_archive_transport_test_support.dart';

void main() {
  test('hash中のtotal timeoutはhashをcancelしてpartを消す', () async {
    final temporaryDirectory = await Directory.systemTemp.createTemp(
      'estimated_intensity_hash_timeout_test_',
    );
    addTearDown(() => temporaryDirectory.delete(recursive: true));
    final hashStarted = Completer<void>();
    final fileVerifier = PausedEstimatedIntensityArchiveFileVerifier(
      hashStarted: hashStarted,
    );
    final operation = TestEstimatedIntensityArchiveHttpOperation(
      openResponse: Future.value(estimatedIntensityTestResponse()),
    );
    final limits = EstimatedIntensityArchiveDownloadLimits(
      maxArchiveBytes: 1024,
      connectTimeout: const Duration(seconds: 1),
      headerTimeout: const Duration(seconds: 1),
      idleTimeout: const Duration(seconds: 1),
      totalTimeout: const Duration(milliseconds: 10),
    );
    final resultFuture =
        EstimatedIntensityArchiveHttpDataSource(
          operationFactory: () => operation,
          streamVerifier: EstimatedIntensityArchiveStreamVerifier(
            fileVerifier: fileVerifier,
          ),
        ).download(
          descriptor: estimatedIntensityTestDescriptor(),
          temporaryDirectory: temporaryDirectory,
          limits: limits,
        );
    await hashStarted.future;

    final result = await resultFuture.timeout(
      const Duration(milliseconds: 200),
    );

    expectEstimatedIntensityDownloadFailure(
      result: result,
      failure: EstimatedIntensityArchiveDownloadFailure.timeout,
    );
    expect(temporaryDirectory.listSync(recursive: true), isEmpty);
  });

  test('停止済みfile verifierはhashをpublishしない', () async {
    final temporaryDirectory = await Directory.systemTemp.createTemp(
      'estimated_intensity_stopped_hash_test_',
    );
    addTearDown(() => temporaryDirectory.delete(recursive: true));
    final file = File('${temporaryDirectory.path}/archive.part');
    await file.writeAsBytes('hello world'.codeUnits);

    final result = await const DartIoEstimatedIntensityArchiveFileVerifier()
        .verify(
          descriptor: estimatedIntensityTestDescriptor(),
          file: file,
          stopRequested: Future.value(
            EstimatedIntensityArchiveStopReason.cancelled,
          ),
          diagnosticReporter: ignoreEstimatedIntensityArchiveDiagnostic,
        );

    expectEstimatedIntensityDownloadFailure(
      result: result,
      failure: EstimatedIntensityArchiveDownloadFailure.cancelled,
    );
  });

  test('file length待機中の停止は取得の収束後に戻る', () async {
    final temporaryDirectory = await Directory.systemTemp.createTemp(
      'estimated_intensity_length_timeout_test_',
    );
    addTearDown(() => temporaryDirectory.delete(recursive: true));
    final file = File('${temporaryDirectory.path}/archive.part');
    await file.writeAsBytes('hello world'.codeUnits);
    final lengthStarted = Completer<void>();
    final releaseLength = Completer<int>();
    final stopRequested = Completer<EstimatedIntensityArchiveStopReason>();
    final verifier = DartIoEstimatedIntensityArchiveFileVerifier(
      fileLengthReader: PausedEstimatedIntensityArchiveFileLengthReader(
        started: lengthStarted,
        release: releaseLength,
      ),
    );

    final resultFuture = verifier.verify(
      descriptor: estimatedIntensityTestDescriptor(),
      file: file,
      stopRequested: stopRequested.future,
      diagnosticReporter: ignoreEstimatedIntensityArchiveDiagnostic,
    );
    await lengthStarted.future;
    stopRequested.complete(EstimatedIntensityArchiveStopReason.timeout);
    final earlyResult = await Future.any([
      resultFuture.then((_) => 'completed'),
      Future<void>.delayed(Duration.zero).then((_) => 'waiting'),
    ]);
    expect(earlyResult, 'waiting');

    releaseLength.complete(11);
    final result = await resultFuture;
    expectEstimatedIntensityDownloadFailure(
      result: result,
      failure: EstimatedIntensityArchiveDownloadFailure.timeout,
    );
  });
}

final class PausedEstimatedIntensityArchiveFileLengthReader
    implements EstimatedIntensityArchiveFileLengthReader {
  const new({required this.started, required this.release});

  final Completer<void> started;
  final Completer<int> release;

  @override
  Future<int> read({required File file}) {
    started.complete();
    return release.future;
  }
}

final class PausedEstimatedIntensityArchiveFileVerifier
    implements EstimatedIntensityArchiveFileVerifier {
  new({required this.hashStarted});

  final Completer<void> hashStarted;

  @override
  Future<EstimatedIntensityArchiveDownloadResult> verify({
    required EstimatedIntensityArchiveDescriptor descriptor,
    required File file,
    required Future<EstimatedIntensityArchiveStopReason> stopRequested,
    required EstimatedIntensityArchiveDiagnosticReporter diagnosticReporter,
  }) async {
    hashStarted.complete();
    final stopped = await stopRequested;
    return const EstimatedIntensityArchiveStopResultMapper().map(stopped);
  }
}
