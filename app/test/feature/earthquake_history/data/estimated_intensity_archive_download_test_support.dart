import 'dart:io';

import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_http_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_http_operation.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_download.dart';

import 'estimated_intensity_archive_transport_test_support.dart';

Future<EstimatedIntensityArchiveDownloadResult> downloadResponse({
  required Directory temporaryDirectory,
  required EstimatedIntensityArchiveHttpResponse response,
}) =>
    EstimatedIntensityArchiveHttpDataSource(
      operationFactory: () => TestEstimatedIntensityArchiveHttpOperation(
        openResponse: Future.value(response),
      ),
    ).download(
      descriptor: estimatedIntensityTestDescriptor(),
      temporaryDirectory: temporaryDirectory,
      limits: estimatedIntensityTransportTestLimits,
    );

Future<EstimatedIntensityArchiveDownloadResult> downloadBody({
  required Directory temporaryDirectory,
  required int contentLength,
  required List<int> body,
}) => downloadResponse(
  temporaryDirectory: temporaryDirectory,
  response: estimatedIntensityTestResponse(
    contentLength: contentLength,
    body: Stream.value(body),
  ),
);
