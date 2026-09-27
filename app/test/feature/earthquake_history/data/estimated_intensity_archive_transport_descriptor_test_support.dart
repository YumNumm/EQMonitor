import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_descriptor.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_download.dart';
import 'package:flutter_test/flutter_test.dart';

const estimatedIntensityTestEventId = '20260823020050';
const estimatedIntensityTestHost = 'tiles.example.test';
const helloWorldSha256 =
    'b94d27b9934d3e08a52e52d7da7dabfac484efe37a5380ee9088f7ace2efcde9';
final estimatedIntensityTransportTestLimits =
    EstimatedIntensityArchiveDownloadLimits(
      maxArchiveBytes: 1024,
      connectTimeout: const Duration(milliseconds: 100),
      headerTimeout: const Duration(milliseconds: 100),
      idleTimeout: const Duration(milliseconds: 100),
      totalTimeout: const Duration(seconds: 1),
    );

EstimatedIntensityArchiveDescriptor estimatedIntensityTestDescriptor({
  int sizeBytes = 11,
  String sha256 = helloWorldSha256,
}) {
  final input = EstimatedIntensityArchiveDescriptorInput(
    url:
        'https://$estimatedIntensityTestHost/ixac41/'
        '$estimatedIntensityTestEventId/$sha256.pmtiles',
    sizeBytes: sizeBytes,
    sha256: sha256,
  );
  final result = const EstimatedIntensityArchiveDescriptorValidator().validate(
    eventId: estimatedIntensityTestEventId,
    input: input,
    policy: EstimatedIntensityArchiveUrlPolicy(
      allowedHosts: const {estimatedIntensityTestHost},
      maxArchiveBytes: 4096,
    ),
  );
  return switch (result) {
    EstimatedIntensityArchiveValidationValid(:final descriptor) => descriptor,
    EstimatedIntensityArchiveValidationMissing() => throw TestFailure(
      'descriptor must not be missing',
    ),
    EstimatedIntensityArchiveValidationInvalid(:final failure) =>
      throw TestFailure('unexpected descriptor failure: $failure'),
  };
}
