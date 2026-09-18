import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_descriptor.dart';
import 'package:flutter_test/flutter_test.dart';

import 'estimated_intensity_archive_descriptor_test_support.dart';

void main() {
  const support = EstimatedIntensityArchiveDescriptorTestSupport();
  final eventId = EstimatedIntensityArchiveDescriptorTestSupport.eventId;
  final host = EstimatedIntensityArchiveDescriptorTestSupport.allowedHost;

  for (final invalidEventId in [
    '2026082302005',
    '202608230200500',
    '２０２６０８２３０２００５０',
    '2026082302005A',
  ]) {
    test('rejects non-ASCII-14 event ID $invalidEventId', () {
      final result = EstimatedIntensityArchiveDescriptorTestSupport.validator
          .validate(
            eventId: invalidEventId,
            input: support.input(),
            policy: support.policy,
          );

      expect(
        (result as EstimatedIntensityArchiveValidationInvalid).failure,
        EstimatedIntensityArchiveFailure.invalidEventId,
      );
    });
  }

  final hashCases =
      <
        ({
          String name,
          String url,
          String digest,
          EstimatedIntensityArchiveFailure failure,
        })
      >[
        (
          name: 'uppercase URL hash',
          url:
              'https://$host/ixac41/$eventId/${support.sha256.toUpperCase()}.pmtiles',
          digest: support.sha256,
          failure: EstimatedIntensityArchiveFailure.invalidSha256,
        ),
        (
          name: 'short URL hash',
          url: 'https://$host/ixac41/$eventId/${'a' * 63}.pmtiles',
          digest: support.sha256,
          failure: EstimatedIntensityArchiveFailure.invalidSha256,
        ),
        (
          name: 'uppercase descriptor hash',
          url: support.validUrl,
          digest: support.sha256.toUpperCase(),
          failure: EstimatedIntensityArchiveFailure.invalidSha256,
        ),
        (
          name: 'URL and descriptor hash mismatch',
          url: 'https://$host/ixac41/$eventId/${support.otherSha256}.pmtiles',
          digest: support.sha256,
          failure: EstimatedIntensityArchiveFailure.sha256Mismatch,
        ),
      ];

  for (final testCase in hashCases) {
    test('rejects ${testCase.name}', () {
      final result = EstimatedIntensityArchiveDescriptorTestSupport.validator
          .validate(
            eventId: eventId,
            input: support.input(url: testCase.url, digest: testCase.digest),
            policy: support.policy,
          );

      expect(
        (result as EstimatedIntensityArchiveValidationInvalid).failure,
        testCase.failure,
      );
    });
  }
}
