import 'dart:async';
import 'dart:io';

import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_attestation_binder.dart';
import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_download_guard.dart';
import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_http_operation.dart';
import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_part_writer.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_cleanup_diagnostic.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_descriptor.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_download.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_stop_reason.dart';

final class EstimatedIntensityArchiveStreamVerifier {
  const new({
    this.stopResultMapper = const EstimatedIntensityArchiveStopResultMapper(),
    this.fileVerifier = const DartIoEstimatedIntensityArchiveFileVerifier(),
    this.partWriterFactory = EstimatedIntensityArchivePartWriterFactory.create,
    this.attestationBinder = const EstimatedIntensityArchiveAttestationBinder(),
  });

  final EstimatedIntensityArchiveStopResultMapper stopResultMapper;
  final EstimatedIntensityArchiveFileVerifier fileVerifier;
  final EstimatedIntensityArchivePartWriterCreator partWriterFactory;
  final EstimatedIntensityArchiveAttestationBinder attestationBinder;

  Future<EstimatedIntensityArchiveDownloadResult> verify({
    required EstimatedIntensityArchiveHttpResponse response,
    required EstimatedIntensityArchiveDescriptor descriptor,
    required EstimatedIntensityArchiveDownloadLimits limits,
    required File partFile,
    required EstimatedIntensityArchiveDownloadGuard guard,
    required EstimatedIntensityArchiveDiagnosticReporter diagnosticReporter,
  }) async {
    EstimatedIntensityArchivePartWriter? output;
    StreamIterator<List<int>>? bodyIterator;
    try {
      output = await partWriterFactory(partFile);
      var receivedBytes = 0;
      bodyIterator = StreamIterator(response.body.timeout(limits.idleTimeout));
      while (await guard.settle(
        pending: bodyIterator.moveNext(),
        abort: () async {
          try {
            await bodyIterator?.cancel();
          } catch (_) {
            reportEstimatedIntensityArchiveDiagnostic(
              reporter: diagnosticReporter,
              diagnostic: .bodyCancellationFailed,
            );
          }
        },
      )) {
        final stopped = guard.stopReason;
        if (stopped != EstimatedIntensityArchiveStopReason.none) {
          return stopResultMapper.map(stopped);
        }
        final chunk = bodyIterator.current;
        final nextBytes = receivedBytes + chunk.length;
        if (nextBytes > limits.maxArchiveBytes) {
          return const EstimatedIntensityArchiveDownloadRejected(
            .archiveTooLarge,
          );
        }
        if (nextBytes > descriptor.sizeBytes) {
          return const EstimatedIntensityArchiveDownloadRejected(
            EstimatedIntensityArchiveDownloadFailure.sizeMismatch,
          );
        }
        await guard.settle(
          pending: output.write(chunk),
          abort: () async {
            try {
              await output?.close();
            } catch (_) {
              reportEstimatedIntensityArchiveDiagnostic(
                reporter: diagnosticReporter,
                diagnostic: .partWriterCloseFailed,
              );
            }
          },
        );
        receivedBytes = nextBytes;
      }

      final stopped = guard.stopReason;
      if (stopped != EstimatedIntensityArchiveStopReason.none) {
        return stopResultMapper.map(stopped);
      }
      await guard.settle(
        pending: output.flushAndClose(),
        abort: () async {
          try {
            await output?.close();
          } catch (_) {
            reportEstimatedIntensityArchiveDiagnostic(
              reporter: diagnosticReporter,
              diagnostic: .partWriterCloseFailed,
            );
          }
        },
      );
      if (receivedBytes != descriptor.sizeBytes) {
        return const EstimatedIntensityArchiveDownloadRejected(
          EstimatedIntensityArchiveDownloadFailure.sizeMismatch,
        );
      }
      final verified = await fileVerifier.verify(
        descriptor: descriptor,
        file: partFile,
        stopRequested: guard.stopRequested,
        diagnosticReporter: diagnosticReporter,
      );
      final finalStop = guard.stopReason;
      if (finalStop != EstimatedIntensityArchiveStopReason.none) {
        return stopResultMapper.map(finalStop);
      }
      return attestationBinder.bind(
        result: verified,
        descriptor: descriptor,
        partFile: partFile,
      );
    } on TimeoutException {
      final stopped = guard.stopReason;
      if (stopped != EstimatedIntensityArchiveStopReason.none) {
        return stopResultMapper.map(stopped);
      }
      return const EstimatedIntensityArchiveDownloadRejected(
        EstimatedIntensityArchiveDownloadFailure.timeout,
      );
    } on FileSystemException {
      return const EstimatedIntensityArchiveDownloadRejected(
        EstimatedIntensityArchiveDownloadFailure.storageFailure,
      );
    } catch (_) {
      final stopped = guard.stopReason;
      if (stopped != EstimatedIntensityArchiveStopReason.none) {
        return stopResultMapper.map(stopped);
      }
      return const EstimatedIntensityArchiveDownloadRejected(
        EstimatedIntensityArchiveDownloadFailure.requestFailed,
      );
    } finally {
      try {
        await bodyIterator?.cancel();
      } catch (_) {
        reportEstimatedIntensityArchiveDiagnostic(
          reporter: diagnosticReporter,
          diagnostic: .bodyCancellationFailed,
        );
      }
      try {
        await output?.close();
      } catch (_) {
        reportEstimatedIntensityArchiveDiagnostic(
          reporter: diagnosticReporter,
          diagnostic: .partWriterCloseFailed,
        );
      }
    }
  }
}
