import 'dart:async';
import 'dart:io';

import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_http_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_stream_verifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_descriptor.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_download.dart';
import 'package:flutter_test/flutter_test.dart';

import 'estimated_intensity_archive_transport_test_support.dart';

void main() {
  test('hash中のtotal timeoutはhash終了後にrejectしてからpartを消す', () async {
    final temporaryDirectory = await Directory.systemTemp.createTemp(
      'estimated_intensity_hash_timeout_test_',
    );
    addTearDown(() => temporaryDirectory.delete(recursive: true));
    final hashStarted = Completer<void>();
    final releaseHash = Completer<void>();
    final fileVerifier = GatedEstimatedIntensityArchiveFileVerifier(
      delegate: const DartIoEstimatedIntensityArchiveFileVerifier(),
      hashStarted: hashStarted,
      releaseHash: releaseHash,
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

    final firstCompletion = await Future.any<String>([
      resultFuture.then((_) => 'completed'),
      Future.delayed(const Duration(milliseconds: 30), () => 'pending'),
    ]);
    expect(firstCompletion, 'pending');
    expect(temporaryDirectory.listSync(recursive: true), isNotEmpty);

    releaseHash.complete();
    final result = await resultFuture;

    expectEstimatedIntensityDownloadFailure(
      result: result,
      failure: EstimatedIntensityArchiveDownloadFailure.timeout,
    );
    expect(temporaryDirectory.listSync(recursive: true), isEmpty);
  });
}

final class GatedEstimatedIntensityArchiveFileVerifier
    implements EstimatedIntensityArchiveFileVerifier {
  new({
    required this.delegate,
    required this.hashStarted,
    required this.releaseHash,
  });

  final EstimatedIntensityArchiveFileVerifier delegate;
  final Completer<void> hashStarted;
  final Completer<void> releaseHash;

  @override
  Future<EstimatedIntensityArchiveDownloadResult> verify({
    required EstimatedIntensityArchiveDescriptor descriptor,
    required File file,
  }) async {
    hashStarted.complete();
    await releaseHash.future;
    return delegate.verify(descriptor: descriptor, file: file);
  }
}
