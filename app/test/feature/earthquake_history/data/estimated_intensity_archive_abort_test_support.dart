import 'dart:io';

import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_http_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_http_operation.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_download.dart';

import 'estimated_intensity_archive_io_test_support.dart';
import 'estimated_intensity_archive_transport_test_support.dart';

Future<EstimatedIntensityArchiveDownloadResult> downloadWithCancellation({
  required Directory temporaryDirectory,
  required RecordingEstimatedIntensityHttpClient client,
  required EstimatedIntensityArchiveDownloadCancellation cancellation,
}) =>
    EstimatedIntensityArchiveHttpDataSource(
      operationFactory: () =>
          DartIoEstimatedIntensityArchiveHttpOperation(client: client),
    ).download(
      descriptor: estimatedIntensityTestDescriptor(),
      temporaryDirectory: temporaryDirectory,
      limits: EstimatedIntensityArchiveDownloadLimits(
        maxArchiveBytes: estimatedIntensityTransportTestLimits.maxArchiveBytes,
        connectTimeout: const Duration(seconds: 10),
        headerTimeout: const Duration(seconds: 10),
        idleTimeout: const Duration(seconds: 10),
        totalTimeout: const Duration(seconds: 20),
      ),
      cancellation: cancellation,
    );
