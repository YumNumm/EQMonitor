import 'dart:io';

import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_http_operation.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_descriptor.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_download.dart';

final class EstimatedIntensityArchiveResponseValidator {
  const new();

  EstimatedIntensityArchiveDownloadFailure? validate({
    required EstimatedIntensityArchiveHttpResponse response,
    required EstimatedIntensityArchiveDescriptor descriptor,
    required int maxArchiveBytes,
  }) {
    if (response.statusCode != HttpStatus.ok) {
      return EstimatedIntensityArchiveDownloadFailure.invalidStatus;
    }
    final encodings = response.contentEncodings;
    if (encodings.length > 1) {
      return EstimatedIntensityArchiveDownloadFailure.invalidContentEncoding;
    }
    if (encodings case [final encoding]) {
      if (encoding.trim().toLowerCase() != 'identity') {
        return EstimatedIntensityArchiveDownloadFailure.invalidContentEncoding;
      }
    }
    final contentLength = response.contentLength;
    if (contentLength >= 0 &&
        (contentLength != descriptor.sizeBytes ||
            contentLength > maxArchiveBytes)) {
      return EstimatedIntensityArchiveDownloadFailure.invalidContentLength;
    }
    return null;
  }
}
