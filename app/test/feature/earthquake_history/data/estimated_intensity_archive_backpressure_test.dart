import 'dart:async';
import 'dart:io';

import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_http_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_part_writer.dart';
import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_stream_verifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_download.dart';
import 'package:flutter_test/flutter_test.dart';

import 'estimated_intensity_archive_transport_test_support.dart';

void main() {
  test('chunk write完了まで次のbody chunkを消費しない', () async {
    final temporaryDirectory = await Directory.systemTemp.createTemp(
      'estimated_intensity_backpressure_test_',
    );
    addTearDown(() => temporaryDirectory.delete(recursive: true));
    final firstWriteStarted = Completer<void>();
    final releaseFirstWrite = Completer<void>();
    PausedEstimatedIntensityArchivePartWriter? writer;
    final verifier = EstimatedIntensityArchiveStreamVerifier(
      partWriterFactory: (file) async {
        final delegate = await DartIoEstimatedIntensityArchivePartWriter.open(
          file,
        );
        final created = PausedEstimatedIntensityArchivePartWriter(
          delegate: delegate,
          firstWriteStarted: firstWriteStarted,
          releaseFirstWrite: releaseFirstWrite,
        );
        writer = created;
        return created;
      },
    );
    final operation = TestEstimatedIntensityArchiveHttpOperation(
      openResponse: Future.value(
        estimatedIntensityTestResponse(
          body: Stream.fromIterable([
            'hello'.codeUnits,
            ' world'.codeUnits,
          ]),
        ),
      ),
    );
    final resultFuture =
        EstimatedIntensityArchiveHttpDataSource(
          operationFactory: () => operation,
          streamVerifier: verifier,
        ).download(
          descriptor: estimatedIntensityTestDescriptor(),
          temporaryDirectory: temporaryDirectory,
          limits: estimatedIntensityTransportTestLimits,
        );
    await firstWriteStarted.future;
    expect(writer?.writeCount, 1);
    releaseFirstWrite.complete();
    final result = await resultFuture;

    expect(result, isA<EstimatedIntensityArchiveDownloadSuccess>());
    expect(writer?.writeCount, 2);
    expect(writer?.maxConcurrentWrites, 1);
  });

  test('total timeoutは待機中のwrite収束後にpartをcleanupする', () async {
    final temporaryDirectory = await Directory.systemTemp.createTemp(
      'estimated_intensity_write_timeout_test_',
    );
    addTearDown(() => temporaryDirectory.delete(recursive: true));
    final writeStarted = Completer<void>();
    final releaseWrite = Completer<void>();
    final stopNotified = Completer<void>();
    addTearDown(() {
      if (!releaseWrite.isCompleted) {
        releaseWrite.complete();
      }
    });
    PausedEstimatedIntensityArchivePartWriter? writer;
    final verifier = EstimatedIntensityArchiveStreamVerifier(
      partWriterFactory: (file) async {
        final created = PausedEstimatedIntensityArchivePartWriter(
          delegate: await DartIoEstimatedIntensityArchivePartWriter.open(file),
          firstWriteStarted: writeStarted,
          releaseFirstWrite: releaseWrite,
        );
        writer = created;
        return created;
      },
    );
    final operation =
        TestEstimatedIntensityArchiveHttpOperation(
            openResponse: Future.value(estimatedIntensityTestResponse()),
          )
          ..onAbort = () {
            if (!stopNotified.isCompleted) {
              stopNotified.complete();
            }
          };
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
          streamVerifier: verifier,
        ).download(
          descriptor: estimatedIntensityTestDescriptor(),
          temporaryDirectory: temporaryDirectory,
          limits: limits,
        );
    await writeStarted.future;
    await stopNotified.future;
    await Future<void>.delayed(Duration.zero);
    final closeOverlappedWrite = writer?.closeOverlappedWrite;
    releaseWrite.complete();
    final result = await resultFuture.timeout(
      const Duration(milliseconds: 200),
    );

    expectEstimatedIntensityDownloadFailure(
      result: result,
      failure: EstimatedIntensityArchiveDownloadFailure.timeout,
    );
    expect(closeOverlappedWrite, isFalse);
    expect(writer?.writeCount, 1);
    expect(writer?.maxConcurrentWrites, 1);
    expect(writer?.closeCount, 1);
    expect(temporaryDirectory.listSync(recursive: true), isEmpty);
  });
}

final class PausedEstimatedIntensityArchivePartWriter
    implements EstimatedIntensityArchivePartWriter {
  new({
    required this.delegate,
    required this.firstWriteStarted,
    required this.releaseFirstWrite,
  });

  final EstimatedIntensityArchivePartWriter delegate;
  final Completer<void> firstWriteStarted;
  final Completer<void> releaseFirstWrite;
  var writeCount = 0;
  var concurrentWrites = 0;
  var maxConcurrentWrites = 0;
  var closeCount = 0;
  var closeOverlappedWrite = false;
  var closed = false;

  @override
  Future<void> write(List<int> bytes) async {
    writeCount += 1;
    concurrentWrites += 1;
    maxConcurrentWrites = maxConcurrentWrites < concurrentWrites
        ? concurrentWrites
        : maxConcurrentWrites;
    if (writeCount == 1) {
      firstWriteStarted.complete();
      await releaseFirstWrite.future;
    }
    await delegate.write(bytes);
    concurrentWrites -= 1;
  }

  @override
  Future<void> flushAndClose() => delegate.flushAndClose();

  @override
  Future<void> close() async {
    if (closed) {
      return;
    }
    closeCount += 1;
    if (concurrentWrites > 0) {
      closeOverlappedWrite = true;
      return;
    }
    closed = true;
    await delegate.close();
  }
}
