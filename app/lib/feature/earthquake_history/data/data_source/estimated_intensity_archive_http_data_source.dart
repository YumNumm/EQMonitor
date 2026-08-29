import 'dart:async' show TimeoutException;
import 'dart:io';

import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_download_guard.dart';
import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_http_operation.dart';
import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_response_validator.dart';
import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_stream_verifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_descriptor.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_cleanup_diagnostic.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_download.dart';

final class EstimatedIntensityArchiveHttpDataSource {
  const new({
    this.operationFactory =
        EstimatedIntensityArchiveHttpOperationFactory.create,
    this.responseValidator = const EstimatedIntensityArchiveResponseValidator(),
    this.streamVerifier = const EstimatedIntensityArchiveStreamVerifier(),
    this.diagnosticReporter = EstimatedIntensityArchiveDiagnostics.ignore,
  });
  final EstimatedIntensityArchiveHttpOperationCreator operationFactory;
  final EstimatedIntensityArchiveResponseValidator responseValidator;
  final EstimatedIntensityArchiveStreamVerifier streamVerifier;
  final EstimatedIntensityArchiveDiagnosticReporter diagnosticReporter;
  Future<EstimatedIntensityArchiveDownloadResult> download({
    required EstimatedIntensityArchiveDescriptor descriptor,
    required Directory temporaryDirectory,
    required EstimatedIntensityArchiveDownloadLimits limits,
    EstimatedIntensityArchiveDownloadCancellation? cancellation,
  }) async {
    if (descriptor.sizeBytes > limits.maxArchiveBytes) {
      return const EstimatedIntensityArchiveDownloadRejected(
        EstimatedIntensityArchiveDownloadFailure.archiveTooLarge,
      );
    }
    if (cancellation?.isCancelled ?? false) {
      return const EstimatedIntensityArchiveDownloadRejected(
        EstimatedIntensityArchiveDownloadFailure.cancelled,
      );
    }
    final operation = operationFactory();
    Directory? stagingDirectory;
    var succeeded = false;
    final guard = EstimatedIntensityArchiveDownloadGuard(
      operation: operation,
      totalTimeout: limits.totalTimeout,
      cancellation: cancellation,
    );
    try {
      stagingDirectory = await temporaryDirectory.createTemp(
        'estimated-intensity-',
      );
      final response = await operation.open(
        url: descriptor.url,
        connectTimeout: limits.connectTimeout,
        headerTimeout: limits.headerTimeout,
      );
      final responseFailure = responseValidator.validate(
        response: response,
        descriptor: descriptor,
        maxArchiveBytes: limits.maxArchiveBytes,
      );
      if (responseFailure case final failure?) {
        return EstimatedIntensityArchiveDownloadRejected(failure);
      }
      final result = await streamVerifier.verify(
        response: response,
        descriptor: descriptor,
        limits: limits,
        partFile: File('${stagingDirectory.path}/archive.part'),
        guard: guard,
        diagnosticReporter: diagnosticReporter,
      );
      succeeded = result is EstimatedIntensityArchiveDownloadSuccess;
      return result;
    } on TimeoutException {
      return const EstimatedIntensityArchiveDownloadRejected(
        EstimatedIntensityArchiveDownloadFailure.timeout,
      );
    } on FileSystemException {
      return const EstimatedIntensityArchiveDownloadRejected(
        EstimatedIntensityArchiveDownloadFailure.storageFailure,
      );
    } catch (_) {
      return EstimatedIntensityArchiveDownloadRejected(
        guard.cancelled
            ? EstimatedIntensityArchiveDownloadFailure.cancelled
            : guard.timedOut
            ? EstimatedIntensityArchiveDownloadFailure.timeout
            : EstimatedIntensityArchiveDownloadFailure.requestFailed,
      );
    } finally {
      try {
        await guard.close();
      } catch (_) {
        EstimatedIntensityArchiveDiagnostics.report(
          reporter: diagnosticReporter,
          diagnostic: .guardCloseFailed,
        );
      }
      if (!succeeded) {
        try {
          operation.abort();
        } catch (_) {
          EstimatedIntensityArchiveDiagnostics.report(
            reporter: diagnosticReporter,
            diagnostic: .httpAbortFailed,
          );
        }
        if (stagingDirectory case final directory?) {
          try {
            await directory.delete(recursive: true);
          } catch (_) {
            EstimatedIntensityArchiveDiagnostics.report(
              reporter: diagnosticReporter,
              diagnostic: .stagingDirectoryDeleteFailed,
            );
          }
        }
      }
      try {
        operation.close();
      } catch (_) {
        EstimatedIntensityArchiveDiagnostics.report(
          reporter: diagnosticReporter,
          diagnostic: .httpCloseFailed,
        );
      }
    }
  }
}
