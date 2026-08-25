import 'dart:async';
import 'dart:io';

import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_http_operation.dart';
import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_part_writer.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_descriptor.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_download.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_stop_reason.dart';

final class EstimatedIntensityArchiveStreamVerifier {
  const new({
    this.stopResultMapper = const EstimatedIntensityArchiveStopResultMapper(),
    this.fileVerifier = const DartIoEstimatedIntensityArchiveFileVerifier(),
    this.partWriterFactory = EstimatedIntensityArchivePartWriterFactory.create,
  });

  final EstimatedIntensityArchiveStopResultMapper stopResultMapper;
  final EstimatedIntensityArchiveFileVerifier fileVerifier;
  final EstimatedIntensityArchivePartWriterCreator partWriterFactory;

  Future<EstimatedIntensityArchiveDownloadResult> verify({
    required EstimatedIntensityArchiveHttpResponse response,
    required EstimatedIntensityArchiveDescriptor descriptor,
    required EstimatedIntensityArchiveDownloadLimits limits,
    required File partFile,
    required EstimatedIntensityArchiveStopReasonReader stopReason,
  }) async {
    EstimatedIntensityArchivePartWriter? output;
    StreamIterator<List<int>>? bodyIterator;
    try {
      output = await partWriterFactory(partFile);
      var receivedBytes = 0;
      bodyIterator = StreamIterator(response.body.timeout(limits.idleTimeout));
      while (await bodyIterator.moveNext()) {
        final stopped = stopReason();
        if (stopped != EstimatedIntensityArchiveStopReason.none) {
          return stopResultMapper.map(stopped);
        }
        final chunk = bodyIterator.current;
        final nextBytes = receivedBytes + chunk.length;
        if (nextBytes > limits.maxArchiveBytes) {
          return const EstimatedIntensityArchiveDownloadRejected(.archiveTooLarge);
        }
        if (nextBytes > descriptor.sizeBytes) {
          return const EstimatedIntensityArchiveDownloadRejected(
            EstimatedIntensityArchiveDownloadFailure.sizeMismatch,
          );
        }
        await output.write(chunk);
        receivedBytes = nextBytes;
      }

      final stopped = stopReason();
      if (stopped != EstimatedIntensityArchiveStopReason.none) {
        return stopResultMapper.map(stopped);
      }
      await output.flushAndClose();
      if (receivedBytes != descriptor.sizeBytes) {
        return const EstimatedIntensityArchiveDownloadRejected(
          EstimatedIntensityArchiveDownloadFailure.sizeMismatch,
        );
      }
      final verified = await fileVerifier.verify(
        descriptor: descriptor,
        file: partFile,
      );
      final finalStop = stopReason();
      if (finalStop != EstimatedIntensityArchiveStopReason.none) {
        return stopResultMapper.map(finalStop);
      }
      return verified;
    } on TimeoutException {
      final stopped = stopReason();
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
      final stopped = stopReason();
      if (stopped != EstimatedIntensityArchiveStopReason.none) {
        return stopResultMapper.map(stopped);
      }
      return const EstimatedIntensityArchiveDownloadRejected(
        EstimatedIntensityArchiveDownloadFailure.requestFailed,
      );
    } finally {
      await bodyIterator?.cancel();
      try {
        await output?.close();
      } catch (_) {}
    }
  }
}
